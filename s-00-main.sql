--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: main code para creación de todo el entorno

whenever sqlerror exit rollback

prompt SYSTEM USER

connect sys as sysdba;

prompt DROP USERS AND DATA


set serveroutput on;

-- Para REINICAR TODO 
declare 
  cursor cur_usuarios is
    select username from dba_users where username like 'MUVA_PROY_INVITADO';
begin
  for r in cur_usuarios loop
    execute immediate 'drop user ' ||r.username||' cascade';
  end loop;
end;
/

declare 
  cursor cur_usuarios is
    select username from dba_users where username like 'MUVA_PROY_ADMIN';
begin
  for r in cur_usuarios loop
    execute immediate 'drop user ' ||r.username||' cascade';
  end loop;
end;
/


--drop user muva_proy_invitado cascade;
--drop user muva_proy_admin cascade;
drop role rol_admin;
drop role rol_invitado;

drop directory fotosCasa;
drop directory iconos;
drop directory pdf;
drop directory extTables;


prompt CREACIÓN USUARIOS

start s-01-usuarios.sql

prompt CREACIÓN DEL AMBIENTE
connect muva_proy_admin/muva

--primero las secuencias 
start s-05-secuencias.sql
 
start s-02-entidades.sql
start s-03-tablas-temporales.sql
start s-04-tablas-externas.sql
start s-06-indices.sql
start s-07-sinonimos.sql
start s-08-vistas.sql
--start s-09-carga-inicial.sql
--start s-10-consultas.sql


prompt DONE ALL!
disconnect