--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Trigger 1| REQUISITO DEL CASO DE ESTUDIO -> VALIDACION



PROMPT SI TIENE TARJETA
insert into alquilar(alquiler_id, folio, usuario_id, vivienda_id) values (alquiler_seq.nextval, 'AS123AFDS1S1F4DA127',41, 23);


PROMPT NO TIENE TARJETA 
insert into usuario (usuario_id, nombre_usuario, nombre, apellido_paterno, apellido_materno, password, email) 
values (usuario_seq.nextval, 'ldevany0', 'Layton', 'Ribbon', 'Devany', 'S2uZhwJnFh8', 'ldevany0@i2i.jp');

insert into alquilar(alquiler_id, folio, usuario_id, vivienda_id) values (alquiler_seq.nextval, 'AS123AFDS14D1F4H57',101, 38)










