DELIMITER $$

CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock_actual = stock_actual - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END $$

DELIMITER ;

SELECT id_producto, nombre, stock_actual
FROM productos
WHERE id_producto = 1;

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES (2, 1, 3, 13500.00);

SELECT id_producto, nombre, stock_actual
FROM productos
WHERE id_producto = 1;

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

SELECT id_producto, nombre, precio
FROM productos
WHERE id_producto = 1;

UPDATE productos
SET precio = 4800.00
WHERE id_producto = 1;


DELIMITER $$

CREATE TRIGGER control_stock_negativo
BEFORE INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT;

    SELECT stock_actual
    INTO v_stock_actual
    FROM productos
    WHERE id_producto = NEW.id_producto;

    IF v_stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para procesar el pedido';
    END IF;

END $$

DELIMITER ;






