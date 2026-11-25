-- 1. Empleados de ejemplo

INSERT INTO empleados (cedula, nombre, primer_apellido, segundo_apellido, correo, telefono)
VALUES ('1-1234-0567', 'Marcela', 'Valverde', 'Rojas', 'mvalverde@favesa.cr', '8811-2233');

INSERT INTO empleados (cedula, nombre, primer_apellido, segundo_apellido, correo, telefono)
VALUES ('3-0456-0789', 'Carlos', 'Mora', 'Jiménez', 'cmora@favesa.cr', '8744-5566');

INSERT INTO empleados (cedula, nombre, primer_apellido, segundo_apellido, correo, telefono)
VALUES ('2-0987-0321', 'Valeria', 'Solís', 'Chaves', 'vsolis@favesa.cr', '8699-1122');

-- 2. Lista de los roles

INSERT INTO roles (nombre_rol) VALUES ('ADMINISTRADOR');
INSERT INTO roles (nombre_rol) VALUES ('VENTAS');
INSERT INTO roles (nombre_rol) VALUES ('INVENTARIO');

-- 3. Lista de los usuarios (Esto es una relación  1:1 siendo EMPLEADOS: id_empleado es UNIQUE)

INSERT INTO usuarios (id_empleado, username, password_hash, estado)
VALUES(1, 'mvalverde','123', 'ACTIVO');

INSERT INTO usuarios (id_empleado, username, password_hash, estado)
VALUES(2, 'cmora', '456', 'ACTIVO');

INSERT INTO usuarios (id_empleado, username, password_hash, estado)
VALUES(3, 'vsolis', '789', 'ACTIVO');

-- 4. Aquí se insertan los roles

INSERT INTO usuario_rol (id_usuario, id_rol) VALUES(4,1);
INSERT INTO usuario_rol (id_usuario, id_rol) VALUES(2,2);
INSERT INTO usuario_rol (id_usuario, id_rol) VALUES(3,3);

-- 5. Categorias de los objetos

INSERT INTO categorias (nombre_categoria) VALUES ('Líquidos Automotrices');
INSERT INTO categorias (nombre_categoria) VALUES ('Cajas y Presentaciones');
INSERT INTO categorias (nombre_categoria) VALUES ('Empaques y Envases');

-- 6. Datos de proveedores
INSERT INTO proveedores (cedula_juridica, nombre_proveedor, telefono, correo, direccion)
VALUES ('3-101-456789', 'Químicos del Valle S.A.', '2250-1010', 'ventas@quimicosvalle.cr', 'San José, Pavas');

INSERT INTO proveedores (cedula_juridica, nombre_proveedor, telefono, correo, direccion)
VALUES ('3-101-789123', 'Envases Industriales CR S.A.', '2291-3344', 'contacto@envasescr.cr', 'Heredia, San Joaquín');

-- 7. Unos cuantos productos de prueba

INSERT INTO productos (
    codigo_producto, nombre_producto, id_categoria, id_proveedor,
    precio_venta, stock_actual, stock_minimo
) VALUES (
    'FAVE-LIQ-001', 'Limpiador de inyectores 500ml', 1, 1,
    6500.00, 40, 10
);

INSERT INTO productos (
    codigo_producto, nombre_producto, id_categoria, id_proveedor,
    precio_venta, stock_actual, stock_minimo
) VALUES (
    'FAVE-LIQ-002', 'Refrigerante radiador verde galón', 1,1,
    8900.00, 8, 12
);

INSERT INTO productos (
    codigo_producto, nombre_producto, id_categoria, id_proveedor,
    precio_venta, stock_actual, stock_minimo
) VALUES (
    'FAVE-CAJ-003', 'Caja de cartón de 12 unidades 500ml', 2, 2,
    2400.00, 50, 15
);

-- 9. Clientes de ejemplo 

INSERT INTO clientes (identificacion, nombre_cliente, telefono, correo, direccion)
VALUES ('3-101-223344', 'Taller Automotriz Coronado S.A.', '2229-4455', 'compras@tallerconomado.cr', 'Coronado, San José');

INSERT INTO clientes (identificacion, nombre_cliente, telefono, correo, direccion)
VALUES ('1-0888-0444', 'Luis Fernando Quesada', '8512-3456', 'lfquesada@correo.cr', 'Desamparados, San José');


-- 10. Metodos de pago

INSERT INTO metodos_pago (nombre_metodo) VALUES ('Efectivo');
INSERT INTO metodos_pago (nombre_metodo) VALUES ('Transferencia Bancaria');
INSERT INTO metodos_pago (nombre_metodo) VALUES ('Tarjeta');


-- 11. Sistema de factura

INSERT INTO facturas (
    numero_factura, id_cliente, id_usuario, id_metodo_pago,
    subtotal, impuesto, monto_total, estado
) VALUES (
    'FAC_0001', 1, 2, 2,
    13000.00, 1690.00, 14690.00, 'EMITIDA'
);

-- 12. Los detalles de la factura

INSERT INTO detalle_factura (
    id_factura, id_producto, cantidad, precio_unitario, subtotal_linea
) VALUES (
    1, 1, 2, 6500.00, 13000.00
);

COMMIT;

CREATE USER fave_db IDENTIFIED BY "123";
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO fave_db;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER TO fave_db

SELECT USER AS usuario_actual, SYSTIMESTAMP FROM dual;

SELECT granted_role, admin_option, default_role
FROM user_role_privs
ORDER BY granted_role;

SELECT table_name
FROM user_tables
ORDER BY table_name

GRANT CONNECT, RESOURCE,
UNLIMITED TABLESPACE TO PROYECTO_NUEVO;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER TO PROYECTO_NUEVO;
