DELIMITER $$

CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total_sin_iva DECIMAL(10,2);

    SELECT SUM(subtotal)
    INTO v_total_sin_iva
    FROM detalle_pedido
    WHERE id_pedido = p_id_pedido;

    RETURN v_total_sin_iva * 1.19;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_stock_actual INT;

    SELECT stock_actual
    INTO v_stock_actual
    FROM productos
    WHERE id_producto = p_id_producto;

    IF v_stock_actual >= p_cantidad THEN
        RETURN 'Stock suficiente';
    ELSE
        RETURN 'Stock insuficiente';
    END IF;
END $$

DELIMITER ;

SELECT fn_validar_stock(1, 5) AS validacion_stock;
SELECT fn_validar_stock(2, 20) AS validacion_stock;

delimiter $$

DELIMITER $$

CREATE FUNCTION verificar_stock_producto(p_id_producto INT, p_cantidad INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_stock INT;

    SELECT stock_actual
    INTO v_stock
    FROM productos
    WHERE id_producto = p_id_producto;

    IF v_stock IS NULL THEN
        RETURN 'Producto no encontrado';
    ELSEIF v_stock >= p_cantidad THEN
        RETURN 'Suficiente';
    ELSE
        RETURN 'Insuficiente';
    END IF;

END $$

DELIMITER ;






