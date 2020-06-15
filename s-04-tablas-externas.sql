--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 09/12/2019
--@Descripción: Tablas externas 

-- Tabla con datos relevantes para ciencia de Datos 
create table dataGlobalHome(
    vivienda_id number(10,0),
    longitud number(30, 15),
    latitud number(30, 15),
    capacidad number(4,0),

    status varchar2(30), -- de otra tabla                                                   <- JOIN
    tipo varchar2(30),   --es_renta number(1,0), es_vaca number(1,0), es_venta number(1,0), <- con PL/SQL
 
    fecha date --fecha_status
)
organization external (
    type oracle_loader 
    default directory extTables 
    access parameters (
        records delimited by newline 
        badfile extTables:'dataGlobalHome_logs_obsoleta_bad.log'
        logfile extTables:'dataGlobalHome_logs.log'
        fields terminated by ','
        lrtrim
        missing field values are null (
            vivienda_id, longitud, latitud, capacidad, status,tipo, fecha date mask "dd/mm/yyyy"
        )
    )
    location ('dataGlobalHome.csv')
)
reject limit unlimited;





prompt DONE S-04!