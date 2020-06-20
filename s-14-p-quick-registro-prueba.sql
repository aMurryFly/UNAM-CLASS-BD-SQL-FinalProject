--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: PROCEDIMIENTO 2 | PRUEBA EVENTO CORONAVIRUS 

prompt PRUEBA DE CASA RENTA  
begin
registros_rapidos(
    p_longitud => 24.21,
    p_latitud  => 110.76290,
    p_direccion => '298 Groove Street and Center',
    p_capacidad => 3,
    p_descripcion => 'a',
    p_es_renta => 0 ,
    p_es_vaca => 1 ,
    p_es_venta => 0,
    p_usuario_id => 30,
    p_dias_renta => 10,
    p_precio_fijo => 13000
);
end;
/

select *
from vivienda v  
left join vivienda_vacacionar vc
on vc.vivienda_id = v.vivienda_id
where direccion = '298 Groove Street and Center';

-- Mostrar la función del promedio 