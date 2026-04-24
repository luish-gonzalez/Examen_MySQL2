create database if not exists proyecto;
use proyecto;

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