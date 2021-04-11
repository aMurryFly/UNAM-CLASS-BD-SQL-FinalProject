--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Creación de vistas 


prompt VISTAS DEL USUARIO ADMIN
prompt VISTA DE PAGOS POR CADA CASA
create or replace view pagos_casa(
  id_usuario,id_vivienda, id_pago, fecha, importe
) as select vu.usuario_id, vu.vivienda_id, p.pago_id,p.fecha_pago, p.importe_pago
from venta_usuario vu
join pago p 
on p.venta_usuario_id = vu.venta_usuario_id


prompt VISTA DE TODA LA INFO DE RENTAS
create or replace view rentas(
  folio,fecha_contrato ,vivienda_id , direccion, renta_mensual,
  nombre, ape_paterno , correo
) as select 
ru.folio, ru.fecha_contrato, v.vivienda_id, v.direccion, vr.renta_mensual, u.nombre, u.apellido_paterno, u.email
from renta_usuario ru
join vivienda_rentar  vr on vr.vivienda_id = ru.vivienda_id
join vivienda v on v.vivienda_id = vr.vivienda_id
join usuario u on u.usuario_id = ru.usuario_id;
--Información asociada a las casasrentadas junto con los datos del usuario o usuarios que las rentaron

prompt VISTAS DEL USUARIO INVITADO
prompt VISTA DATOS USUARIO Y VIVIENDA
create or replace view dueños_vivienda(
  nickname, correo, direccion, capacidad, es_renta, es_venta, es_vaca
) as select u.nombre_usuario, u.email, v.direccion, v.capacidad_maxima, v.es_renta, v.es_venta, v.es_vaca 
from usuario u 
left join vivienda v 
on v.usuario_id = u.usuario_id;
-- También podría agregarse el join a imagen 


prompt VISTA GENERAL DE USUARIO y TARJETA
create or replace view datos_usaurio(
  usuario_id,nombre, password, tarjeta
) as select u.usuario_id, u.nombre,
substr(u.password,0,2)||'*********',
'****/****/****/'||substr(to_char(tc.num_tarjeta),13,4)
from usuario u
join tarjeta_credito tc
on tc.usuario_id = u.usuario_id;
--Muestra todas las tarjetas de cŕedito junto con los datos su propietario



prompt PERMISO VISTAS DEL USUARIO INVITADO
grant select on muva_proy_admin.dueños_vivienda to muva_proy_invitado;
grant select on muva_proy_admin.datos_usaurio to muva_proy_invitado;   


prompt DONE S-08!



