--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: FUNCION 3 | PROMEDIO DE LAS RENTAS DE CASAS CERCANAS AL DE LA VIVIENDA DEL PARAMETRO
-- Servirá como auxiliar para el quick registro

set serveroutput on

create or replace function nearRentaCasas(
  p_vivienda_id vivienda_rentar.vivienda_id%type
)
return number is

v_renta_sugerida number;
v_latitud number;
v_longitud number;

begin
    select round(latitud, 4) into v_latitud
    from vivienda 
    where vivienda_id = p_vivienda_id;

    select round(longitud, 4) into v_longitud
    from vivienda 
    where vivienda_id = p_vivienda_id;

    select avg(renta_mensual) into v_renta_sugerida
    from vivienda_rentar vr
    join vivienda v
    on vr.vivienda_id = v.vivienda_id
    where v.latitud <= v_latitud +2 and v.latitud >= v_latitud  -2 
    and  v.longitud <= v_longitud +2 and v.longitud >= v_longitud  -2;

  if v_renta_sugerida > 0 then
        dbms_output.put_line('Dado el análisis de viviendas cercanas, sugerimos que el valor de renta sea de '|| v_renta_sugerida);
  else
    raise_application_error ( -20531 ,'ERROR | Probable error al momento de hacer la búsqueda de su vivienda, verifique su dirección y coordenadas geográficas');
  end if;

  return v_renta_sugerida;

end nearRentaCasas;
/

show errors

-- commit;