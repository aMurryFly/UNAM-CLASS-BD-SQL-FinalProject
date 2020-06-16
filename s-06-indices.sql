--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Creación de indices 


Prompt INDICES GENERALES
create index tarjeta_ix on tarjeta_credito(num_tarjeta); -- consultas recurrentes en pagos
create index venta_usuario_clabe_ix on venta_usuario(CLABE); --CLABES USADAS PARA PAGOS
create index clabe_ix on clabe(CLABE); --consulta sobre lista de claves usadas en rentas


Prompt INDICES DATOS DE VIVIENDAS
create index vivienda_lg_lt_ix on vivienda(longitud,latitud);
create index vivienda_direccion_ix  on vivienda(direccion);
create index vivienda_capacidad_ix  on vivienda(capacidad_maxima);
create index vivienda_precio_ix on vivienda_venta(precio_inicial);


Prompt INDICES PARA JOINS
create index vivienda_servicio_vivienda_ix on vivienda_servicio(vivienda_id);
create index vivienda_status_ix on vivienda(status_vivienda_id);
create index vivienda_servicio_servicio_ix on vivienda_servicio(servicio_id);
create index tarjeta_credito_usuario_ix on tarjeta_credito(usuario_id);
create index mensaje_vivienda_ix on mensaje(vivienda_id);
create index alquilar_vivienda_ix on alquilar(vivienda_id);
create index alquilar_usuario_ix on alquilar(usuario_id);


Prompt INDICES PARA FUNCIONES
create index usuario_nombre_apellidos_ix on usuario(LOWER(nombre||apellido_paterno||apellido_materno));
create index vacacion_anio_ix  on vivienda_vacacionar(extract(YEAR from fecha_inicio));
create index vacacion_mes_ix   on vivienda_vacacionar(extract(MONTH from fecha_inicio));
create index vacacion_dia_ix   on vivienda_vacacionar(extract(DAY from fecha_inicio));


prompt DONE S-06!
