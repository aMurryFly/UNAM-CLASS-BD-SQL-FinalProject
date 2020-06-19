--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: PROCEDURE 1 | Exportación de datos a un csv 

-- Reference: https://oracle-base.com/articles/9i/generating-csv-files
-- Reference: https://docs.oracle.com/database/121/ARPLS/u_file.htm#ARPLS70903

prompt CONECTANDO A SYSTEM  
connect sys as sysdba;

!mkdir /tmp/csvDir
!chmod 777 /tmp/csvDir

create directory csvDir as '/tmp/csvDir';
grant read, write on directory csvDir to muva_proy_admin;
GRANT EXECUTE ON UTL_FILE TO muva_proy_admin;


connect muva_proy_admin/muva;

create or replace procedure vivienda_export_csv as
cursor cur_data is
    select vivienda_id, longitud, latitud, direccion, capacidad_maxima,
        --to_char(fecha_status,'DD-MON-YYYY') AS 
        fecha_status,
        es_renta,es_vaca, es_venta
    from vivienda
    order by vivienda_id;
    
v_file  utl_file.FILE_TYPE;

begin
  v_file := utl_file.FOPEN(location     => 'csvDir',
                           filename     => 'generalData.csv',
                           open_mode    => 'W');

  for r in cur_data loop

    utl_file.PUT_LINE(v_file,
                      r.vivienda_id       || ',' ||
                      r.longitud          || ',' ||
                      r.latitud           || ',' ||
                      r.direccion         || ',' ||
                      r.capacidad_maxima  || ',' ||
                      r.fecha_status      || ',' ||
                      r.es_renta          || ',' ||
                      r.es_vaca           || ',' ||
                      r.es_venta);
  end loop;

  utl_file.fclose(v_file);
  
EXCEPTION

  WHEN utl_file.INVALID_PATH THEN
    utl_file.fclose(v_file); 
    RAISE_APPLICATION_ERROR(-20010, 'La localización del archivo es inválida');
    
  WHEN utl_file.INVALID_MODE THEN
    utl_file.fclose(v_file);
    RAISE_APPLICATION_ERROR(-20011, 'El modo en el que se encuentra el archivo no es válido');

  WHEN utl_file.INVALID_OPERATION THEN
    utl_file.fclose(v_file);
    RAISE_APPLICATION_ERROR(-20012, 'El archivo no se ha podido abrir u operar');

  WHEN OTHERS THEN
    utl_file.fclose(v_file);
    RAISE;
    rollback;
END;
/
show errors







