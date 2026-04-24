create database proyecto;
use proyecto;

CREATE TABLE `productos`(
    `id_producto` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(100) NOT NULL,
    `categoria` VARCHAR(50) NOT NULL,
    `precio` DECIMAL(10, 2) NOT NULL,
    `volumen_ml` INT NOT NULL,
    `stock_actual` INT NOT NULL,
    `stock_minimo` INT NOT NULL
);

CREATE TABLE `clientes`(
    `id_cliente` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_completo` VARCHAR(120) NOT NULL,
    `identificacion` VARCHAR(30) NOT NULL UNIQUE,
    `direccion` VARCHAR(150) NULL,
    `telefono` VARCHAR(30) NULL,
    `correo_electronico` VARCHAR(100) NULL
);
   
CREATE TABLE `sedes`(
    `id_sede` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre_sede` VARCHAR(100) NOT NULL,
    `ubicacion` VARCHAR(150) NOT NULL,
    `capacidad_almacenamiento` INT NOT NULL,
    `encargado` VARCHAR(100) NULL
);

CREATE TABLE `pedidos`(
    `id_pedido` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fecha_pedido` DATETIME NOT NULL,
    `id_cliente` INT NOT NULL,
    `id_sede` INT NOT NULL,
    `total_sin_iva` DECIMAL(10, 2) NOT NULL,
    `total_con_iva` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(`id_sede`) REFERENCES `sedes`(`id_sede`),
    FOREIGN KEY(`id_cliente`) REFERENCES `clientes`(`id_cliente`)
);

CREATE TABLE `detalle_pedido`(
    `id_pedido` INT NOT NULL,
    `id_producto` INT NOT NULL,
    `cantidad` INT NOT NULL,
    `subtotal` DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(`id_pedido`, `id_producto`),
    FOREIGN KEY(`id_pedido`) REFERENCES `pedidos`(`id_pedido`),
    FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`)
);

CREATE TABLE `auditoria_precios`(
    `id_auditoria` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_producto` INT NOT NULL,
    `fecha_cambio` DATETIME NOT NULL,
    `precio_anterior` DECIMAL(10, 2) NOT NULL,
    `precio_nuevo` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`)    
);  

ALTER TABLE productos
ADD id_sede INT;

ALTER TABLE productos
ADD FOREIGN KEY (id_sede) REFERENCES sedes(id_sede);