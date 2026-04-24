create database if not exists proyecto;
use proyecto;

DELIMITER $$

CREATE TRIGGER tr_auditar_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (
            id_producto,
            fecha_cambio,
            precio_anterior,
            precio_nuevo
        )
        VALUES (
            NEW.id_producto,
            NOW(),
            OLD.precio,
            NEW.precio
        );
    END IF;
END $$

DELIMITER ;

UPDATE productos
SET precio = 8500.00
WHERE id_producto = 1;