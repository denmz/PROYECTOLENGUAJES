
SELECT id_cliente, nombre_cliente, correo
FROM clientes
WHERE REGEXP_LIKE(correo, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

SELECT id_producto, codigo_producto, nombre_producto, stock_actual
FROM productos
WHERE REGEXP_LIKE(codigo_producto, '^[A-Za-z0-9_-]{2,20}$');

SELECT id_empleado, nombre, primer_apellido, cedula
FROM empleados
WHERE REGEXP_LIKE(REGEXP_REPLACE(cedula, '[^0-9]', ''), '^[0-9]{9,12}$');

SELECT id_factura, numero_factura, estado, monto_total
FROM facturas
WHERE REGEXP_LIKE(numero_factura, '^[A-Za-z0-9_-]{1,30}$');


