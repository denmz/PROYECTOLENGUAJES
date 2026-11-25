-- Ejecutar como script (F5) tras instalar los procedimientos.
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type IN ('TABLE', 'PROCEDURE', 'FUNCTION', 'TRIGGER', 'VIEW')
ORDER BY object_type, object_name;

SELECT name, type, line, position, text
FROM user_errors
ORDER BY name, sequence;

SELECT object_type, object_name, status
FROM user_objects
WHERE status != 'VALID'
ORDER BY object_type, object_name;

SELECT object_type, COUNT(*) AS total
FROM user_objects
GROUP BY object_type
ORDER BY object_type;

SELECT object_type, object_name, status
FROM user_objects
ORDER BY object_type, object_name;


