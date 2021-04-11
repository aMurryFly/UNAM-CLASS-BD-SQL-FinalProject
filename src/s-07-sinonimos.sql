--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Creación de sinonimos 


--PL/SQL
--Finalmente, suponer que un software necesita que todas las tablas del proyecto tengan un prefijo formado por 2 caracteres: XX_<nombre_tabla>. 
--Para implementar este requerimiento se creará un sinónimo privado para cada tabla. Se recomienda realizar un
--programa anónimo PL/SQL empleando SQL dinámico para evitar escribir manualmente los sinónimos.


-- Ya tenemos permisos para el usuario admin 

Prompt CREATE SYNONIMS FOR ADMIN
create or replace public synonym clientes for muva_proy_admin.usuario;
create or replace public synonym historico for muva_proy_admin.historico_status_vivienda;
create or replace public synonym vendidas for muva_proy_admin.venta_usuario;



Prompt CREATE SYNONIMS FOR INVITADO
Prompt GRANTS ON TABLES
--Para conocer datos de las casas sin conocer los usuarios asociados
grant select on muva_proy_admin.vivienda to muva_proy_invitado; 
grant select on muva_proy_admin.vivienda_venta to muva_proy_invitado;
grant select on muva_proy_admin.vivienda_rentar to muva_proy_invitado;
grant select on muva_proy_admin.vivienda_vacacionar to muva_proy_invitado;
grant select on muva_proy_admin.imagen to muva_proy_invitado;


Prompt SYNONIMS WITH INVITADO
create or replace synonym muva_proy_invitado.vivienda  for muva_proy_admin.vivienda;
create or replace synonym muva_proy_invitado.venta     for muva_proy_admin.vivienda_venta;
create or replace synonym muva_proy_invitado.renta     for muva_proy_admin.vivienda_rentar;
create or replace synonym muva_proy_invitado.vacaciona  for muva_proy_admin.vivienda_vacacionar;
create or replace synonym muva_proy_invitado.fotos  for muva_proy_admin.imagen;


prompt DONE S-07!









