create database if not exists proyecto;
use proyecto;

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