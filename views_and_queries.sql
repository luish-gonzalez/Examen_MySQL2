SELECT 
    p.id_pedido,
    p.fecha_pedido,
    c.nombre_completo,
    s.nombre_sede
FROM pedidos AS p
INNER JOIN clientes AS c
    ON p.id_cliente = c.id_cliente
INNER JOIN sedes AS s
    ON p.id_sede = s.id_sede;

SELECT
    dp.id_pedido,
    pr.nombre AS producto,
    dp.cantidad,
    dp.subtotal
FROM detalle_pedido AS dp
INNER JOIN productos AS pr
    ON dp.id_producto = pr.id_producto
ORDER BY dp.id_pedido;

SELECT
    id_producto,
    nombre,
    stock_actual,
    stock_minimo
FROM productos
WHERE stock_actual < stock_minimo;

SELECT nombre, stock_actual, stock_minimo
FROM productos;

SELECT
    p.id_pedido,
    p.fecha_pedido,
    c.nombre_completo,
    s.nombre_sede
FROM pedidos AS p
INNER JOIN clientes AS c
    ON p.id_cliente = c.id_cliente
INNER JOIN sedes AS s
    ON p.id_sede = s.id_sede
WHERE p.fecha_pedido BETWEEN '2026-04-01 00:00:00' AND '2026-04-02 23:59:59';

SELECT
    pr.nombre AS producto,
    SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido AS dp
INNER JOIN productos AS pr
    ON dp.id_producto = pr.id_producto
GROUP BY pr.nombre
ORDER BY total_vendido DESC;

SELECT
    c.nombre_completo,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes AS c
INNER JOIN pedidos AS p
    ON c.id_cliente = p.id_cliente
GROUP BY c.nombre_completo
ORDER BY cantidad_pedidos DESC;

SELECT
    id_cliente,
    nombre_completo,
    identificacion
FROM clientes
WHERE nombre_completo LIKE '%ar%';

SELECT
    id_producto,
    nombre,
    categoria,
    precio
FROM productos
WHERE categoria IN ('Gaseosa');

SELECT
    c.nombre_completo,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes AS c
INNER JOIN pedidos AS p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo
HAVING COUNT(p.id_pedido) = (
    SELECT MAX(total_pedidos)
    FROM (
        SELECT COUNT(id_pedido) AS total_pedidos
        FROM pedidos
        GROUP BY id_cliente
    ) AS sub
);

SELECT
    s.nombre_sede,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    SUM(p.total_con_iva) AS total_ventas
FROM sedes AS s
INNER JOIN pedidos AS p
    ON s.id_sede = p.id_sede
GROUP BY s.nombre_sede
ORDER BY total_ventas DESC;

CREATE VIEW vista_resumen_pedidos_por_sede AS
SELECT
    s.nombre_sede,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    SUM(p.total_con_iva) AS total_ventas
FROM sedes AS s
INNER JOIN pedidos AS p
    ON s.id_sede = p.id_sede
GROUP BY s.nombre_sede;

SELECT * FROM vista_resumen_pedidos_por_sede;

CREATE VIEW vista_productos_bajo_stock AS
SELECT
    id_producto,
    nombre,
    categoria,
    stock_actual,
    stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;

SELECT * FROM vista_productos_bajo_stock;

CREATE VIEW vista_clientes_activos AS
SELECT DISTINCT
    c.id_cliente,
    c.nombre_completo,
    c.identificacion
FROM clientes AS c
INNER JOIN pedidos AS p
    ON c.id_cliente = p.id_cliente;

SELECT * FROM vista_clientes_activos;

SELECT
    c.nombre_completo,
    SUM(p.total_con_iva) AS total_gastado
FROM clientes c
INNER JOIN pedidos p
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_completo
HAVING SUM(p.total_con_iva) > (
    SELECT AVG(total_cliente)
    FROM (
        SELECT SUM(total_con_iva) AS total_cliente
        FROM pedidos
        GROUP BY id_cliente
    ) sub
)
ORDER BY total_gastado DESC;

CREATE VIEW vista_productos_bajo_stock_examen AS
SELECT
    p.nombre,
    p.categoria,
    p.stock_actual,
    s.nombre_sede
FROM productos p
INNER JOIN sedes s
    ON p.id_sede = s.id_sede
WHERE p.stock_actual <= 10;





