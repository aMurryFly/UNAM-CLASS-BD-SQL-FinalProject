--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Consultas para mostrar datos y verificar el correcto funcionamiento de los scripts previos 

column vivienda_id clear
column longitud clear
column latitud clear
column nombre_usuario clear
column email clear 
set linesize 200 

prompt CONSULTA 1 | DE TABLA EXTERNA | son probables hoteles pequeños cerca de la playa 
select * from dataGlobalHome
where capacidad > 30 and latitud < 27; 


PROMPT CONSULTA 2 |  JOIN y  SINONIMO  | clientes que no son dueños de alguna vivienda de globalHome
col email format a30
col nombre_usuario a10

select cl.email, cl.nombre_usuario from clientes cl   
left join vivienda v
on cl.usuario_id = v.usuario_id
where vivienda_id is null;
--clientes -> sinonimo de usuario


PROMPT CONSULTA 3 |  VISTA, SUBCONSULTA  Y FUNCIONES DE AGREGACIÓN | promedios de ganancias 
 
select r.vivienda_id, r.fecha_contrato, r.renta_mensual, (select avg(renta_mensual)
from vivienda_rentar) as promedio 
from rentas r
group by r.vivienda_id, r.fecha_contrato, r.renta_mensual ;


PROMPT CONSULTA 4 |  JOINS   | Datos de todas las casas 
col fecha_status format a20

select v.vivienda_id, v.fecha_status, vr.renta_mensual, vv.dias_renta, vve.precio_inicial
from vivienda v 
left join vivienda_vacacionar vv
on v.vivienda_id = vv.vivienda_id
left join vivienda_rentar vr
on v.vivienda_id = vr.vivienda_id
left join vivienda_venta vve
on v.vivienda_id = vve.vivienda_id
where to_char(fecha_status,'mm') in ('06');


PROMPT CONSULTA 5 |  ALGEBRA  | casas a comprar o rentar para familiar que apenar se están formando 

col direccion format a25

select vivienda_id, capacidad_maxima, direccion from vivienda
where es_venta = 1
union
select vivienda_id, capacidad_maxima, direccion  from vivienda
where es_renta = 1
minus
select vivienda_id, capacidad_maxima, direccion  from vivienda
where capacidad_maxima > 2 and capacidad_maxima < 4 ;



PROMPT CONSULTA 6 |  TEMPORAL | Cuantas personas estuvieron interesadas en comprar la casa


select usuario_id, vivienda_id, nombre_usuario, email 
from carrito_temp 
where es_venta = 1;


