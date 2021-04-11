--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: LLamada de todos los archivos de datos para su inserción en la BD 

--connect muva_proy_admin/muva

whenever sqlerror exit rollback;

start dataFiles/s-09-usuario.sql

start dataFiles/s-09-status_vivienda.sql

start dataFiles/s-09-vivienda.sql

start dataFiles/s-09-historico_status_vivienda.sql

start dataFiles/s-09-servicio.sql

start dataFiles/s-09-vivienda_servicio.sql

start dataFiles/s-09-mensaje.sql

start dataFiles/s-09-tarjeta_credito.sql

start dataFiles/s-09-imagen.sql

start dataFiles/s-09-vivienda_rentar.sql
start dataFiles/s-09-vivienda_vacacionar.sql 
start dataFiles/s-09-vivienda_venta.sql

-- Acciones por cada subtipo

start dataFiles/s-09-clabe_renta.sql

start dataFiles/s-09-renta.sql

start dataFiles/s-09-alquilar.sql

start dataFiles/s-09-apartada_vivienda.sql

start dataFiles/s-09-venta_usuario.sql

start dataFiles/s-09-pago.sql

start dataFiles/s-09-carrito_temp.sql


prompt DONE S-09!


