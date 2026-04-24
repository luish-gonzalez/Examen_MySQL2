use proyecto;

# 1. -----------------------------------------------------------------------------------------------
drop function calcular_promedio_pedidos_cliente; 

delimiter $$ 

create function calcular_promedio_pedidos_cliente(p_id_cliente int)
returns decimal(10,2)
deterministic
begin
	declare avg_total_sin_iva decimal(10,2);

	SELECT avg(p.total_sin_iva) 
	INTO avg_total_sin_iva
	from pedidos as p
	inner join clientes as c
	on p.id_cliente = c.id_cliente
	where p.id_cliente = p_id_cliente;

	if avg_total_sin_iva is null then
		return '0';
	else
		return avg_total_sin_iva;
	end if;
end $$

delimiter ;

select calcular_promedio_pedidos_cliente(2);

SELECT * from pedidos;

# 2. -----------------------------------------------------------------------------------------------

CREATE view vista_resumen_sedes as
select
	s.nombre_sede,
	sum(s.id_sede),
	sum(p.total_sin_iva),
	avg(p.total_sin_iva)
FROM sedes as s
inner join pedidos as p
on s.id_sede = p.id_sede
group by s.id_sede;

SELECT * from vista_resumen_sedes;

# 3. -----------------------------------------------------------------------------------------------

SELECT
	nombre,
	categoria,
	stock_actual,
	precio 
FROM productos
group by id_producto  
having precio > (
	select avg(precio)
	from productos)
order by nombre;

# 4. -----------------------------------------------------------------------------------------------

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

# 5. -----------------------------------------------------------------------------------------------

CREATE TABLE `auditoria_precios`(
    `id_auditoria` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_producto` INT NOT NULL,
    `fecha_cambio` DATETIME NOT NULL,
    `precio_anterior` DECIMAL(10, 2) NOT NULL,
    `precio_nuevo` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY(`id_producto`) REFERENCES `productos`(`id_producto`)    
);  




