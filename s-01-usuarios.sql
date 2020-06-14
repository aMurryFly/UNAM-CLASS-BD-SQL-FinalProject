--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 09/12/2019
--@Descripción: Creación de usuario s y asignación de permisos-privilegios


whenever sqlerror exit rollback;

prompt Proporcionar el password del usuario sys:
connect sys as sysdba

set serveroutput on;

-- Para REINICAR TODO 
declare 
  cursor cur_usuarios is
    select username from dba_users where username like '%_PROY_INVITADO';
begin
  for r in cur_usuarios loop
    execute immediate 'drop user ' ||r.username||' cascade';
  end loop;
end;
/

declare 
  cursor cur_usuarios is
    select username from dba_users where username like '%_PROY_ADMIN';
begin
  for r in cur_usuarios loop
    execute immediate 'drop user ' ||r.username||' cascade';
  end loop;
end;
/

prompt CREACION Y PERMISOS | USUARIOS


prompt USUARIO ADMIN
create user muva_proy_admin identified by muva quota unlimited on users;
grant create table, create sequence, create session, create procedure, create synonym, create view,
      create public synonym, create any synonym, create trigger to muva_proy_admin;

prompt ROL ADMIN
create role rol_admin;
grant rol_admin to muva_proy_admin;



prompt USUARIO INVITADO
create user muva_proy_invitado identified by muva quota 1024m on users;
grant create session to muva_proy_invitado;

prompt ROL INVITADO
create role rol_invitado;
grant rol_invitado to muva_proy_invitado;



prompt CRACION Y PERMISOS | FOTOS CASAS 
!cp -r fotosCasa /tmp/
!chmod 777 /tmp/fotosCasa

create directory fotosCasa as '/tmp/fotosCasa';
grant read, write on directory fotosCasa to muva_proy_admin;
grant read, write on directory fotosCasa to muva_proy_invitado;



prompt CRACION Y PERMISOS | FOTOS ICONOS 
!cp -r iconos /tmp/
!chmod 777 /tmp/iconos

create directory iconos as '/tmp/iconos';
grant read, write on directory iconos to muva_proy_admin;
grant read, write on directory iconos to muva_proy_invitado;



prompt CRACION Y PERMISOS | FOTOS PDF 
!cp -r pdf /tmp/
!chmod 777 /tmp/pdf

create directory pdf as '/tmp/pdf';
grant read, write on directory pdf to muva_proy_admin;
grant read, write on directory pdf to muva_proy_invitado;




prompt DONE - 01!

