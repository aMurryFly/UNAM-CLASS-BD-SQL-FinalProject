--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 18/06/2020
--@Descripción: Trigger 2 | EVENTO CORONAVIRUS
--	Debido al COVID-19 se ha decidido que todas las viviendas con estatus dispobible pasen a inactivas hasta nuevo aviso
--	NOTAS:
--	1) Los casos de compra no se ven afectados 
--	2) Por ada registro actualizado se añade un registro al histórico. 

PROMPT ACTUALIZANDO 

create or replace trigger tg_coranavirus_update
for update of status_vivienda_id on vivienda
compound trigger

type status_actualizado_type is record (
	historico_status_vivienda_id historico_status_vivienda.historico_status_vivienda_id%type,
	fecha_status historico_status_vivienda.fecha_status%type,
	vivienda_id historico_status_vivienda.vivienda_id%type,
	status_vivienda_id historico_status_vivienda.historico_status_vivienda_id%type
);
--Crea un objeto tipo collection para almacenar los productos
type status_list_type is table of status_actualizado_type;

--Crea una colección y la inicializa.
status_list status_list_type := status_list_type();

	before each row is
		v_fecha date := sysdate;
		v_index number;

	begin
		status_list.extend;--asigna espacio a la colección

		--obtiene el índice siguiente para guardar el objeto modificado
		v_index := status_list.last;
		--guarda el nuevo registro cuyo status ha cambiado.
		status_list(v_index).historico_status_vivienda_id := historico_status_vivienda_seq.nextval;
		status_list(v_index).fecha_status := v_fecha;
		status_list(v_index).vivienda_id := :new.vivienda_id;
		status_list(v_index).status_vivienda_id := :new.status_vivienda_id;

	end before each row;

	after statement is
		begin
		forall i in status_list.first .. status_list.last
			insert into historico_status_vivienda(historico_status_vivienda_id,fecha_status, vivienda_id,status_vivienda_id)
			values(status_list(i).historico_status_vivienda_id, status_list(i).fecha_status, status_list(i).vivienda_id,status_list(i).status_vivienda_id );
			dbms_output.put_line(' .... registrada correctamente. ');
		end after statement; 
end;
/
show errors;