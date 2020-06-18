--status

insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'DISPONIBLE', 'La vivienda se encuntra disponible para rentarse o alquilarse');
insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'EN RENTA', 'La vivienda se encuntra rentada por alguien');
insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'ALQUILADA', 'La vivienda se encuntra alquilada por alguien');
insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'EN VENTA', 'La vivienda se encuentra en disponible para venta');
insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'VENDIDA', 'La vivienda fue vendida a alguien');
insert into status_vivienda (status_vivienda_id, status, descripcion) values (status_vivienda_seq.nextval, 'INACTIVA', 'La vivienda no se encuentra más disponible');

prompt STATUS VIVIENDA
