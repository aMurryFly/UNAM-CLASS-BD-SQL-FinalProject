--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Tablas externas 

-- Tabla con datos relevantes para ciencia de Datos 
create table dataGlobalHome(
    vivienda_id number(10,0),
    longitud number(30, 15),
    latitud number(30, 15),
    capacidad number(4,0), 
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
            vivienda_id, longitud, latitud, capacidad, fecha date mask "dd/mm/yyyy"
        )
    )
    location ('dataGlobalHome.csv')
)
reject limit unlimited;


prompt DONE S-04!