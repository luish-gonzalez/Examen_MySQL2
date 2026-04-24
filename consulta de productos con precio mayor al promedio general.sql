create database if not exists proyecto;
use proyecto;

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
