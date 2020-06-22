--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: FUNCION 1 | DESCUENTO A USUARIO DADO SUS COMPRAS 

set serveroutput on

create or replace function descuento_usuario(
  p_usuario_id usuario.usuario_id%type
) 
return number is

v_primer_alquiler date;
v_alquileres number;
v_ingreso number;
v_alquileres_total number;
v_desc number;
v_cupon number;

begin
  v_desc := 0;
  --si ha rentado el usuario 
  select count(*) into v_alquileres_total
  from alquilar
  where usuario_id = p_usuario_id;
  --entonces verificamos los alquileres a partir del año pasado y los ingresos generados por esas compras 
  if v_alquileres_total > 0 then
    select count(*), sum(vc.precio_fijo) into v_alquileres, v_ingreso
    from alquilar a
    join vivienda_vacacionar vc
    on a.vivienda_id = vc.vivienda_id
    where a.usuario_id = p_usuario_id and vc.fecha_inicio >= sysdate -365;

    --maximo podemos dar un 50% de descuento 
    if v_ingreso > 6000 and v_ingreso <12000 then
      v_desc := 1 + v_desc;
    elsif v_ingreso > 12000 then 
      v_desc := 3+v_desc;
    end if;

    if  v_alquileres>= 3 then
      v_desc := 2 + v_desc;
    end if;

  end if;
  
  v_desc := v_desc * 10;
  
  return v_desc;

end descuento_usuario;
/
show errors

