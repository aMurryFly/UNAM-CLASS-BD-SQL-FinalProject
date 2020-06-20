--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: PROCEDIMIENTO 2 | PRUEBA EVENTO CORONAVIRUS 

create or replace procedure registros_rapidos(
--p_vivienda_id  out number,
p_longitud number,
p_latitud  number,
p_direccion varchar2,
p_capacidad number,
p_descripcion varchar2,
--fecha
p_es_renta number ,
p_es_vaca number ,
p_es_venta number ,
p_usuario_id number,
--subtipos
p_num_catastral number default null,
p_precio_inicial number default null,
--para vaca
p_dias_renta number default null,
p_precio_fijo number default null
)is
v_vivienda_id number;
v_precio_dia number;
v_numero_dias number;
total_pagar number;
v_usuario_id number;
v_fx_nearRentaCasas number;
v_folio vivienda_venta.folio%type;
begin

  -- REGISTRO RESPECTO A VIVIENDA
  v_vivienda_id := vivienda_seq.nextval; 
  v_usuario_id := p_usuario_id;
  if LENGTH(p_descripcion) < 5 then 
    insert into vivienda (vivienda_id, longitud, latitud, capacidad_maxima, direccion, descripcion,es_renta, es_vaca, es_venta, fecha_status,usuario_id,  status_vivienda_id)
    values (v_vivienda_id, p_longitud, p_latitud, p_capacidad, p_direccion, 'Descripción pendiente ...', p_es_renta, p_es_vaca, p_es_venta, to_date(sysdate, 'dd/mm/yyyy'), v_usuario_id, 1);

  elsif LENGTH(p_direccion) < 10 then
    insert into vivienda (vivienda_id, longitud, latitud, capacidad_maxima, direccion, descripcion,es_renta, es_vaca, es_venta, fecha_status,usuario_id,  status_vivienda_id)
    values (v_vivienda_id, p_longitud, p_latitud, p_capacidad, ' Dirección a agregar...', p_descripcion, p_es_renta, p_es_vaca, p_es_venta, to_date(sysdate, 'dd/mm/yyyy'), v_usuario_id, 1);
    dbms_output.put_line('NOTA | Corrija en cuanto sea posible su dirección');

  else 
    insert into vivienda (vivienda_id, longitud, latitud, capacidad_maxima, direccion, descripcion,es_renta, es_vaca, es_venta, fecha_status,usuario_id,  status_vivienda_id)
    values (v_vivienda_id, p_longitud, p_latitud, p_capacidad, p_direccion, p_descripcion, p_es_renta, p_es_vaca, p_es_venta, to_date(sysdate, 'dd/mm/yyyy'), v_usuario_id, 1);
  end if;
  
  dbms_output.put_line('Vivienda '|| v_vivienda_id || ' registrada correctamente. ');



  -- REGISTRO RESPECTO AL SUBTIPO QUE SE TIENE 

  if p_es_renta = 1 then
    v_fx_nearRentaCasas:= nearRentaCasas(v_vivienda_id);
    insert into vivienda_rentar (vivienda_id, renta_mensual)
    values (v_vivienda_id,v_fx_nearRentaCasas);--LLAMARFUNCION -> Parabuenas ganancias y un valor competitivo y atractivo
    dbms_output.put_line('REGISTRO CONCLUIDO! ');

  elsif p_es_venta = 1 then
    v_folio:= SUBSTR( to_char(v_vivienda_id, '099') ,1 ,2) ||  SUBSTR( to_char(p_num_catastral, '9900') ,1 ,10) ||  to_char(sysdate, 'yyyy') ||  to_char(sysdate, 'MONTH') ;  --folio =18
    insert into vivienda_venta (vivienda_id, num_catastral, folio, precio_inicial,pdf_avaluo)
    values (v_vivienda_id, p_num_catastral, v_folio, p_precio_inicial, EMPTY_BLOB());
    dbms_output.put_line('REGISTRO CONCLUIDO! ');

  elsif p_es_vaca = 1 then
    v_numero_dias:= p_dias_renta;
    if v_numero_dias > 7 then -- Rentarla por más de una semana

      insert into vivienda_vacacionar (vivienda_id, dias_renta, precio_fijo )
      values (v_vivienda_id, p_dias_renta, p_precio_fijo);
        v_precio_dia := p_precio_fijo;
        v_numero_dias := p_dias_renta;
        total_pagar := round(v_precio_dia * v_numero_dias); 
        dbms_output.put_line('REGISTRO CONCLUIDO! | la cantidad total a pagar es de : '|| total_pagar);
    else
      raise_application_error ( -20302 ,'ERROR | La vivienda no puede ser rentada por menos de 7 días');
    end if;
  else
      raise_application_error ( -20301 ,'ERROR | La vivienda no puede ser registrada, verifique los datos proporcionados');  
  end if;

end registros_rapidos;
/
show errors

-- commit;