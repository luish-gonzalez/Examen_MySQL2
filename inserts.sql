INSERT INTO productos (nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo)
VALUES
('Coca-Cola', 'Gaseosa', 4500.00, 1500, 40, 10),
('Pepsi', 'Gaseosa', 4300.00, 1500, 8, 10),
('Colombiana', 'Gaseosa', 4000.00, 1500, 25, 8);

INSERT INTO clientes (nombre_completo, identificacion, direccion, telefono, correo_electronico)
VALUES
('Juan Pérez', '1001', 'Calle 1 #10-20', '3001234567', 'juan@example.com'),
('María Gómez', '1002', 'Carrera 5 #20-30', '3007654321', 'maria@example.com'),
('Carlos Ruiz', '1003', 'Av 3 #15-40', '3011111111', 'carlos@example.com');

INSERT INTO sedes (nombre_sede, ubicacion, capacidad_almacenamiento, encargado)
VALUES
('Sede Girón', 'Girón, Santander', 500, 'Laura Martínez'),
('Sede Bucaramanga', 'Bucaramanga, Santander', 800, 'Andrés Rojas'),
('Sede Piedecuesta', 'Piedecuesta, Santander', 600, 'Diana Torres');

INSERT INTO pedidos (fecha_pedido, id_cliente, id_sede, total_sin_iva, total_con_iva)
VALUES
('2026-04-01 10:00:00', 1, 1, 10000.00, 11900.00),
('2026-04-02 14:30:00', 2, 2, 8000.00, 9520.00),
('2026-04-03 09:15:00', 1, 3, 12000.00, 14280.00);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES
(1, 1, 2, 9000.00),
(1, 2, 1, 4300.00),
(2, 3, 2, 8000.00),
(3, 1, 1, 4500.00),
(3, 3, 2, 8000.00);