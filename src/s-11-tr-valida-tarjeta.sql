--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Trigger 1 | REQUISITO DEL CASO DE ESTUDIO: 
--   El sistema solicitará (en caso de no existir) los datos de una tarjeta de crédito para realizar el pago por los días que va a permanecer el cliente en la vivienda , verificar si existe una tarjeta por parte del usuario, ademas verificar la vigencia 
set serveroutput on

prompt TRIGGER
--connect muva_proy_admin/muva;

create or replace trigger trg_tarjeta_alquilar
  before insert on alquilar
  for each row

declare
  cursor cur_tarjetas is
    select mes_expiracion, anio_expiracion
    from tarjeta_credito
    where usuario_id = :new.usuario_id;
    
    
    v_mes_expiracion tarjeta_credito.mes_expiracion%type;
    v_anio_expiracion tarjeta_credito.anio_expiracion%type;
    
    
    v_validacion number;
    v_anio_actual number;
    v_mes_actual number;
    
begin
    v_validacion := 0;
    v_anio_actual := extract(YEAR from sysdate);
    v_mes_actual  := extract(MONTH from sysdate);

open cur_tarjetas;

loop
    fetch cur_tarjetas into v_mes_expiracion, v_anio_expiracion;
    dbms_output.put_line('date'|| v_mes_actual || ','	|| v_anio_actual ||'/ mes: ' || v_mes_expiracion || ' año:'|| 		v_anio_expiracion);	
    if v_anio_actual <= (v_anio_expiracion + 2000) and v_mes_actual < v_mes_expiracion then
      v_validacion := 1;
    end if;
        exit when cur_tarjetas%notfound or v_validacion = 1;
    end loop;

  if v_validacion = 1 then

        update vivienda
        set status_vivienda_id = 3
        where vivienda_id = :new.vivienda_id;    
  else
      raise_application_error (-20001 ,'ERROR 20001| Es necesario registrar al menos una tarjeta para proceder con la operación');
  end if;


    close cur_tarjetas;
  end trg_tarjeta_alquilar;
  /
  show errors;







