--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Creación de tablas temporales 

--union entre vivienda y usuario (opciones)

prompt TTem. BUSCANDO CASA
create global temporary table carrito_temp(
    usuario_id number(10,0) not null,
    nombre_usuario varchar2(40) not null,
    email   varchar2(40) not null,
    vivienda_id number(10,0) not null,
    es_renta number(1,0) not null,
    es_vacacion number(1,0) not null,
    es_venta number(1,0) not null
) on commit preserve rows;

prompt DONE S-03!








