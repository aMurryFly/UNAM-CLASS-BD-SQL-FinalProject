--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Trigger 2 | PRUEBA EVENTO CORONAVIRUS 

select vivienda_id from vivienda 
where status_vivienda_id = 1;

select historico_status_vivienda_id, fecha_status from historico_status_vivienda
where status_vivienda_id = 6;

PROMPT actualizamos valores de status

update vivienda
set status_vivienda_id  = 6 
where status_vivienda_id = 1; 

commit;

select vivienda_id from vivienda 
where status_vivienda_id = 1;

select historico_status_vivienda_id, fecha_status from historico_status_vivienda
where status_vivienda_id = 6;

PROMPT Finalizado 





