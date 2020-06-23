--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: FUNCION 1 PRUEBA |  DESCUENTO A USUARIO DADO SUS COMPRAS 

insert into alquilar (alquilar_id, folio, usuario_id, vivienda_id) values (alquilar_seq.nextval, '2N7DFVU861U32GK5I4', 89, 21);
insert into alquilar (alquilar_id, folio, usuario_id, vivienda_id) values (alquilar_seq.nextval, '6DASDFVU86P83GF5I4', 89, 33);

commit;

select descuento_usuario(89) from dual;


