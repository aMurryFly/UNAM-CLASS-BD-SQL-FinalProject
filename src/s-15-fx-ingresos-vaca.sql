--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: FUNCION 2 | CALCULO DE LOS INGRESOS AL VACACIONAR EN UNA VIVIENDA
-- Sólo hace del último registro
set serveroutput on

create or replace function calculaIngresosAlquiler(
  --p_fecha_inicio date,
  p_vivienda_id vivienda_vacacionar.vivienda_id%type
)
return number is

v_ganacias number;
v_numero_dias number;
begin

  v_ganacias := 0;
  --uso de la columna virtual
  select dias_renta into v_numero_dias 
  from vivienda_vacacionar 
  where vivienda_id = p_vivienda_id;

  if v_numero_dias > 0 then
    select round(( precio_fijo * v_numero_dias), 1) into v_ganacias
    from vivienda_vacacionar 
    where vivienda_id = p_vivienda_id;
  else
    raise_application_error ( -20501 ,'ERROR | No se han generado ingresos todavía, apenas se empezó a vacacionar');
  end if;

  return v_ganacias;

end calculaIngresosAlquiler;
/

show errors


