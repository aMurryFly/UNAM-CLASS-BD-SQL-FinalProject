--@Autores: Alfonso Murrieta Villegas | Joaquin Valdespino Mendieta
--@Fecha creación: 09/12/2019
--@Descripción: DDL CODE | Creación 


prompt  T.USUARIOS
create table usuario(
    usuario_id number(10,0) default usuario_seq.nextval constraint usuario_pk primary key,
    nombre_usuario varchar2(40) not null, -- nickname
    nombre varchar2 (40) not null,
    apellido_paterno varchar2(40) not null,
    apellido_materno varchar2(40),
    password varchar2(15) not null,
    email varchar2(40) not null,
    es_dueño number(1,0) not null,
    constraint usuario_email_uk unique (email),
    constraint usuario_nombre_usuario_uk unique(nombre_usuario),
    constraint usuario_password_chk check(LENGTH(password)>=8 and LENGTH(password)<=15)
);


prompt T.STATUS_VIVIENDA
create table status_vivienda(
    status_vivienda_id number(10,0) default status_vivienda_seq.nextval constraint status_vivienda_pk primary key,
    status varchar2(30) not null,
    descripcion varchar2(2000) not null,
    constraint status_vivienda_status_chk check( 
        status in('DISPONIBLE','EN RENTA','ALQUILADA', 'EN VENTA', 'VENDIDA', 'INACTIVA')
    )
);


prompt T.VIVIENDA
create table vivienda(
    vivienda_id number(10,0) default vivienda_seq.nextval constraint vivienda_pk primary key,
    longitud number(30, 15) not null,
    latitud number(30, 15) not null,
    capacidad_maxima number(4,0) not null,
    direccion varchar2(100) not null,
    descripcion varchar2(2000) not null,
    es_renta number(1,0) not null,
    es_vaca number(1,0) not null,
    es_venta number(1,0) not null,
    fecha_status date default sysdate not null,
    --FK's
    usuario_id number(10,0) not null,
    status_vivienda_id number(10,0) not null,
    constraint vivienda_status_vivienda_id_fk foreign key (status_vivienda_id) references status_vivienda(status_vivienda_id),
    constraint vivienda_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint vivienda_es_subtipo_chk check (
       (es_renta = 0 and es_vaca = 0 and es_venta = 1) or ((es_renta = 1 or es_vaca = 1) and es_venta = 0)
    )
);


prompt T.HISTORICO_STATUS_VIVIENDA  
create table historico_status_vivienda(
    historico_status_vivienda_id number(10,0) default historico_status_vivienda_seq.nextval 
    constraint historico_status_vivienda_pk primary key,
    fecha_status date default sysdate not null,
    --FK's
    vivienda_id number(10,0) not null,
    status_vivienda_id number(10,0) not null,
    constraint h_status_vivienda_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id),
    constraint h_status_vivienda_status_vivienda_id_fk foreign key (status_vivienda_id) references status_vivienda(status_vivienda_id)
);



prompt T.MENSAJE
create table mensaje(
    mensaje_id number(10,0) default mensaje_seq.nextval constraint mensaje_pk primary key,
    texto varchar2(2000) not null,
    fecha date default sysdate not null,
    es_leido number(1,0) not null,
    --FK's
    respuesta_id number(10,0),
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint mensaje_respuesta_id_fk foreign key (respuesta_id) references mensaje(mensaje_id),
    constraint mensaje_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint mensaje_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id),
    constraint mensaje_visto_chk check(es_leido=1 or es_leido=0)
);


prompt T.TARJETA_CREDITO
create table tarjeta_credito(
    tarjeta_credito_id number(10,0) default tarjeta_credito_seq.nextval constraint tarjeta_credito_pk primary key,
    num_tarjeta number(16,0) not null,
    mes_expiracion number(2,0) not null,
    anio_expiracion number(2,0) not null,
    --FK
    usuario_id number(10,0) not null,
    constraint tarjeta_cred_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint tarjeta_cred_mes_expiracion_chk check(mes_expiracion > 0 and mes_expiracion <= 12),
    constraint tarjeta_cred_num_tarjeta_chk check (LENGTH(num_tarjeta) = 16),
    constraint tarjeta_cred_anio_expiracion_chk check(anio_expiracion >= 21 )
);




prompt T.SERVICIO
create table servicio(
    servicio_id number(10,0) default servicio_seq.nextval constraint servicio_pk primary key,
    nombre varchar2(100) not null,
    descripcion varchar2(2000) not null,
    icono blob not null,
    constraint servicio_nombre_uk unique(nombre)
);

prompt T.VIVIENDA_SERVICIO
create table vivienda_servicio(    
    servicio_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint vivienda_servicio_pk primary key (servicio_id, vivienda_id),
    --FK's
    constraint vivienda_servicio_servicio_id_fk foreign key (servicio_id) references servicio(servicio_id),
    constraint vivienda_servicio_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id)
);



prompt T.IMAGEN
create table imagen(
    imagen_id number(2,0),
    vivienda_id number(10,0),
    imagen blob not null,
    constraint imagen_pk primary key ( imagen_id,vivienda_id),
    --FK
    constraint imagen_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id)
);


prompt TABLAS DE LOS SUBTIPOS

prompt T.VIVIENDA_RENTAR
create table vivienda_rentar(
    vivienda_id number(10, 0) constraint vivienda_rentar_pk primary key,
    renta_mensual number(20,2) not null,
    fecha_deposito number(2,0) not null,
    constraint vivienda_rentar_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id),
    constraint vivienda_rentar_fecha_deposito_chk check (fecha_deposito > 0 and fecha_deposito <=31),
    constraint vivienda_rentar_renta_mensual_chk check(renta_mensual>0)
);


prompt T.VIVIENDA_VACACIONAR

--Precio fijo por solo un dia <-Atributo dado por nosotros 
--Para probablemente una aplicación 
--precio considerando los días y/o descuentos
--precio_final number(24,4) not null, 

create table vivienda_vacacionar(
    vivienda_id number(10,0) constraint vivienda_vacacionar_pk primary key,
    fecha_inicio date default sysdate not null ,
    dias_renta number(10, 0) not null,
    precio_fijo number(24,4) not null,
    fecha_fin as (fecha_inicio + dias_renta) virtual, 
    constraint vivienda_vacacionar_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id),
    constraint vivienda_vacacionar_precio_fijo_chk check (precio_fijo >0)
);




prompt T.VIVIENDA_VENTA
create table vivienda_venta(
    vivienda_id number(10,0) constraint vivienda_venta_pk primary key,
    num_catastral number(20,0) not null,
    folio varchar2(18) not null,
    precio_inicial number(24,4) not null,
    pdf_avaluo blob not null,
    constraint vivienda_venta_vivienda_id_fk foreign key (vivienda_id) references vivienda(vivienda_id),
    constraint vivienda_venta_folio_uk unique (folio),
    constraint vivienda_venta_num_catastral_uk unique(num_catastral)
);


prompt OPERACIONES SUBTIPOS


prompt T.CLABE
create table  clabe_renta(
    clabe_id number(10,0) default clabe_seq.nextval constraint clabe_pk primary key,
    vivienda_id number(10,0) not null,
    clabe number(18,0) not null,
    constraint clabe_vivienda_id_fk foreign key (vivienda_id) references vivienda_rentar(vivienda_id)
);


prompt T.RENTA USUARIO
create table renta_usuario(
    renta_usuario_id number(10,0) default renta_usuario_seq.nextval constraint renta_usuario_pk primary key,
    folio varchar2(30) not null,
    fecha_contrato date not null,
    pdf_renta blob not null, --firmas
    --FK's
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint renta_usuario_vivienda_id_fk foreign key (vivienda_id) references vivienda_rentar(vivienda_id),
    constraint renta_usuario_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint renta_usuario_folio_uk unique (folio)
);


prompt T.ALQUILAR
create table alquilar(
    alquilar_id number(10,0) default alquilar_seq.nextval constraint alquilar_pk primary key,
    folio varchar2(20) not null,
    --Fk's
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint alquilar_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint alquilar_vivienda_id_fk foreign key (vivienda_id) references vivienda_vacacionar(vivienda_id),
    constraint alquilar_folio_uk unique (folio)
);


prompt T.VENTA USUARIO
create table venta_usuario (
    venta_usuario_id number(10,0) default venta_usuario_seq.nextval constraint venta_usuario_pk primary key,
    comision number(24,4) not null,
    clabe number(18,0) not null,
    --Fk's
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint venta_usuario_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint venta_usuario_vivienda_id_fk foreign key (vivienda_id) references vivienda_venta(vivienda_id),
    constraint venta_usuario_comision_chk check(comision>0)
);




prompt T. PAGO
create table pago(
    venta_usuario_id number(10,0),
    pago_id number(2,0) not null,
    fecha_pago date default sysdate not null,
    importe_pago number(24,4) not null,
    pdf_pago blob not null,
    constraint pago_pk primary key(venta_usuario_id, pago_id),
    constraint pago_venta_usuario_fk foreign key (venta_usuario_id) references venta_usuario(venta_usuario_id),
    constraint pago_importe_chk check(importe_pago > 0)
);



prompt T. APARTA VIVIENDA
create table aparta_vivienda(
    aparta_vivienda_id number(10,0) default aparta_vivienda_seq.nextval constraint aparta_vivienda_pk primary key,
    num_celular number(15,0) not null,
    notificacion_enviada number(1,0) not null,
    usuario_id number(10,0) not null,
    vivienda_id number(10,0) not null,
    constraint aparta_vivienda_usuario_id_fk foreign key (usuario_id) references usuario(usuario_id),
    constraint aparta_vivienda_vivienda_id_fk foreign key (vivienda_id) references vivienda_vacacionar(vivienda_id),
    constraint aparta_vivienda_notificacion_enviada_chk check(notificacion_enviada=1 or notificacion_enviada=0)
);




prompt DONE S-02!
disconnect








