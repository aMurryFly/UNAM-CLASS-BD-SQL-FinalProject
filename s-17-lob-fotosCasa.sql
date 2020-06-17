--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Creación de entidades en la Bases y redirección de datos 


--Ya está en el s-01-usuarios
--create directory fotosCasa as '/tmp/fotosCasa';
--grant read, write on directory fotosCasa to muva_proy_admin;

--create or replace directory data_dir as '/tmp/fotosCasa'; 
--grant read,write on directory data_dir to muva_p1302_biblio;

Prompt CONECTANDO A ADMIN
connect muva_p1302_biblio

Prompt PROCEDIMIENTO PARA INSERTAR FOTOS DE CASAS
set serveroutput on

create or replace procedure p_fotos_casa is
    v_bfile bfile;
    v_src_offset number := 1;
    v_dest_offset number := 1;
    v_dest_blob blob;
    v_src_length number;
    v_dest_length number;
    v_nombre_archivo varchar2(1000);


cursor cur_libro_imagen is
    select libro_id,imagen,nombre_archivo
    from libro_imagen;

begin
    for r in cur_libro_imagen loop
        v_src_offset := 1;
        v_dest_offset := 1;
        dbms_output.put_line('CARGANDO A '||r.nombre_archivo);
        v_bfile := bfilename('DATA_DIR', r.nombre_archivo);

        if dbms_lob.fileexists(v_bfile) = 1 and not dbms_lob.isopen(v_bfile) = 1 then 
            dbms_lob.open(v_bfile, dbms_lob.lob_readonly);
        else 
            raise_application_error(-20071, 'Archivo: ' || r.nombre_archivo ||' no existe en el directorio DATA_DIR'|| ' o se encuentra en uso');
        end if;

        select imagen into v_dest_blob
        from libro_imagen
        where libro_id = r.libro_id
        for update; -- bloquea el registro para que nada más acceda a la transaction


        dbms_lob.loadblobfromfile(
            dest_lob => v_dest_blob,
            src_bfile => v_bfile,
            amount => dbms_lob.getlength(v_bfile),
            dest_offset => v_dest_offset,
            src_offset => v_src_offset
        );
        dbms_lob.close(v_bfile);

        --PARTE DE VALIDACIÓN DE DATOS
        v_src_length := dbms_lob.getlength(v_bfile);
        v_dest_length := dbms_lob.getlength(v_dest_blob);

        if v_src_length = v_dest_length then
            dbms_output.put_line('Procedimiento realizado correctamente | Bytes escritos: ' || v_src_length);
        else 
            raise_application_error(-20072, 'ERROR | \n'
            || ' Datos a escribir = '
            || v_src_length
            || ' Datos escritos = '
            || v_dest_length);
        end if;
    end loop;
end;
/
show errors

Prompt CREACION DIRECTORIO y PERMISOS
!rm -rf /tmp/fotosCasa
!mkdir -p /tmp/fotosCasa
!chmod 777 /tmp/fotosCasa

Prompt EXPORTACIÓN DE DATOS
!cp imagenes/img-* /tmp/fotosCasa
!chmod 755 /tmp/fotosCasa/img-*

Prompt LLAMANDO AL PROCEDIMIENTO
exec p_fotos_casa
commit;

prompt DONE S-017!
