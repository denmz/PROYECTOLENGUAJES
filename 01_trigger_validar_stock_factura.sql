-- Trigger de validación de stock

CREATE OR REPLACE TRIGGER trg_validar_stock_factura
AFTER INSERT ON detalle_factura
FOR EACH ROW
DECLARE
    v_stock_actual NUMBER;
    v_id_usuario NUMBER;
    v_estado_factura VARCHAR2(10);
BEGIN
    SELECT id_usuario, estado
    INTO v_id_usuario, v_estado_factura
    FROM facturas
    WHERE id_factura = :NEW.id_factura;

    IF v_estado_factura <> 'EMITIDA' THEN
        RAISE_APPLICATION_ERROR(-20001,
            'No se pueden agregar productos a una factura anulada.');
    END IF;

    SELECT stock_actual
    INTO v_stock_actual
    FROM productos
    WHERE id_producto = :NEW.id_producto
    FOR UPDATE;

    IF v_stock_actual < :NEW.cantidad THEN
        RAISE_APPLICATION_ERROR(-20002,
            'Stock insuficiente para completar la factura.');
    END IF;

    UPDATE productos
    SET stock_actual = stock_actual - :NEW.cantidad
    WHERE id_producto = :NEW.id_producto;

    INSERT INTO movimientos_inventario
        (id_producto, id_usuario, tipo_movimiento, cantidad, motivo)
    VALUES
        (:NEW.id_producto, v_id_usuario, 'SALIDA', :NEW.cantidad,
         'Venta mediante factura ' || :NEW.id_factura);
END;
/

-- Trigger para evitar el stock negativo al intentar insertar o actualizar stock_actual

CREATE OR REPLACE TRIGGER trg_productos_stock_no_negativo
BEFORE INSERT OR UPDATE OF stock_actual ON productos
FOR EACH ROW
BEGIN
    IF :NEW.stock_actual < 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'El stock no puede ser un número negativo');
    END IF;
END;
/

-- Trigger para evitar que un producto sea eliminado si aún tiene un stock disponible

CREATE OR REPLACE TRIGGER trg_productos_bloquear_delete_stock
BEFORE DELETE ON productos
FOR EACH ROW
BEGIN
    IF :OLD.stock_actual > 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'No es posible eliminar un producto con un stock con productos dentro');
    END IF;
END;
/


-- Trigger para normalizar correo en minisculas y sin espacios en INSERT o UPDATE

CREATE OR REPLACE TRIGGER trg_clietes_normalizar_correo
BEFORE INSERT OR UPDATE OF correo ON clientes
FOR EACH ROW
BEGIN
    IF :NEW.correo IS NOT NULL THEN
        :NEW.correo := LOWER(TRIM(:NEW.correo));
    END IF;
END;
/

-- Trigger que impide modificar o eliminar una factura ya anulada

CREATE OR REPLACE TRIGGER trg_facturas_bloquear_anulada
BEFORE UPDATE OR DELETE ON facturas
FOR EACH ROW
BEGIN
    IF :OLD.estado = 'ANULADA' THEN
        RAISE_APPLICATION_ERROR(-20012, 'No se puede modificar ni eliminar una factura anulada');
    END IF;
END;
/

-- Trigger que impide eliminar el usuario ADMIN

CREATE OR REPLACE TRIGGER trg_usuarios_proteger_admin
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    IF UPPER(:OLD.username) = 'ADMIN' THEN
        RAISE_APPLICATION_ERROR(-20013, 'No se puede eliminar la cuenta administrador por ser la principal');
    END IF;
END;
/


SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
ORDER BY table_name, trigger_name;


SELECT name, type, line, position, text
FROM user_errors
ORDER BY name, sequence;

