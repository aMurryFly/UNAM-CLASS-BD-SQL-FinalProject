--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: FUNCION 3 PRUEBA | PROMEDIO DE LAS RENTAS DE CASAS CERCANAS AL DE LA VIVIENDA DEL PARAMETRO

-- USO GENERAL
select nearRentaCasas(10) from dual;

select nearRentaCasas(43) from dual; -- esta no esta cerca de nada xd 

-- FUNCIÓN y PROCEDIMIENTO 

begin
registros_rapidos(
    p_longitud => 20.2599325,
    p_latitud  => 63.827461,
    p_direccion => '298 Groove Street and Center',
    p_capacidad => 3,
    p_descripcion => 'a',
    p_es_renta => 1 ,
    p_es_vaca => 0 ,
    p_es_venta => 0,
    p_usuario_id => 10
);
end;
/

select *
from vivienda v  
join vivienda_rentar vr
on vr.vivienda_id = v.vivienda_id
where direccion = '298 Groove Street and Center';

commit;
