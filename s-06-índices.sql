--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 09/12/2019
--@Descripción: Creación de indices 



create index tarjeta_ix on tarjeta_credito(num_tarjeta); -- consultas recurrentes en pagos
create index venta_usuario_clabe_ix on venta_usuario(CLABE); --CLABES USADAS PARA PAGOS
create index clabe_ix on clabe(CLABE); --consulta sobre lista de claves usadas 
--datos de la vivienda
create index vivienda_lg_lt_ix on vivienda(LONGITUD,LATITUD);
create index vivienda_direccion_ix  on vivienda(DIRECCION);
create index vivienda_capacidad_ix  on vivienda(CAPACIDAD);
create index vivienda_precio_ix on vivienda_vender(PRECIO_INICIAL);

--para joins 





