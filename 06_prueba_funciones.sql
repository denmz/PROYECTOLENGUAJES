-- Prueba del ID de la factura

SELECT id_factura, numero_factura, estado
FROM facturas
ORDER BY id_factura;

-- Pureba de funciones

SELECT FN_CALCULAR_IVA(10000) AS iva_calculo FROM dual;

SELECT FN_CALCULAR_TOTAL_FACTURA(1) AS total_factura FROM dual;


-- Prueba de las vistas 

SELECT * FROM VW_DETALLE_FACTURAS;
SELECT * FROM VW_PRODUCTOS_BAJO_MINIMO;

-- Prueba de un procedimiento para comprobar la consulta de facturación

SELECT id_producto, nombre_producto, stock_actual, stock_minimo
FROM productos
ORDER BY id_producto;


-- Y prueba del limite del trigger de validación de factura

INSERT INTO detalle_factura (id_factura, id_producto, cantidad, precio_unitario, subtotal_linea)
VALUES(1,2, 999999, 1000, 999999000);


-- Verificar que el sistema de anulación funcione

BEGIN
    SP_ANULAR_FACTURA(1);
END;
/

-- Verificar el cambio de estado y el movimiento del stock tras anular

SELECT id_factura, numero_factura, estado
FROM facturas
WHERE id_factura = 1;

SELECT id_producto, stock_actual
FROM productos
ORDER BY id_producto;

SELECT *
FROM movimientos_inventario
ORDER BY id_movimiento DESC;

SELECT DISTINCT name, type
FROM user_source
WHERE REGEXP_LIKE(UPPER(text), '(SYS_REFCURSOR|\bCURSOR\b|REGEXP_)')
ORDER BY type, name;

SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
ORDER BY table_name, trigger_name;

SELECT DISTINCT name, type
FROM user_source
WHERE REGEXP_LIKE(UPPER(text), 'REGEXP_')
ORDER BY type, name;


