use clinica;

-- NO CYCLE

-- 1. Secuencia de Identificación de Pacientes

create table pacienteseq (
    id int primary key,
    nombre varchar(50),
    edad int
);

create sequence pacienteseq1
    start with 1
    increment by 1
    no cycle;

insert into pacienteseq (id, nombre, edad)
values (next value for pacienteseq1, 'Juan Pérez', 30);

select * from pacienteseq;


-- 2.  Codigo de Procedimiento Medico

create sequence procedimientoIdSeq
    start with 1000
    increment by 1
    no cycle;

create table Procedimientos (
    codigo int primary key,
    nombre varchar(100),
    costo decimal(10, 2)
);

insert into Procedimientos (codigo, nombre, costo)
values (next value for procedimientoIdSeq, 'Radiografía', 150.00);

select * from Procedimientos;

-- 3. numero de historia clinica para pacientes con prefijo por año 

create sequence historiaClinicaSeq
    start with 1
    increment by 1
    no cycle;

create table HistoriasClinicas (
    id varchar(10) primary key,
    idPaciente int,
    descripcion varchar(255),
    fecha date
);

insert into HistoriasClinicas (id, idPaciente, descripcion, fecha)
values (
    concat(year(getdate()), '-', format(next value for historiaClinicaSeq, 'D5')),
    1,
    'Consulta general',
    getdate()
);
select * from HistoriasClinicas;

-- 4. numero de cita por especialidad medica
create sequence citaSeq
    start with 1
    increment by 1
    no cycle;

create table Citas (
    id varchar(20) primary key,
    idPaciente int,
    especialidad varchar(50),
    fecha date
);


insert into Citas (id, idPaciente, especialidad, fecha)
values (
    concat('CITA-CARD-', format(next value for citaSeq, 'D3')),
    1,
    'Cardiología',
    getdate()
);

select * from Citas;

-- 5. numeros de recetas medicas
create table recetasSeq (
    numero int primary key,
    idPaciente int,
    descripcion varchar(255),
    fechaEmision date,
    foreign key (idPaciente) references pacienteseq(id)
);

create sequence recetaNumeroSeq
    start with 1
    increment by 1
    no cycle;

insert into recetasSeq (numero, idPaciente, descripcion, fechaEmision)
values (next value for recetaNumeroSeq, 1, 'Amoxicilina 500mg, tomar cada 8 horas durante 7 días', '2024-11-05');

select  * from recetasSeq;


-- CYCLE

-- 1. Numero de Factura para Consultas con Secuencia 
create sequence facturaNumSeq
    start with 1
    increment by 1
    maxvalue 9999
    cycle;

create table Facturas (
    numero int primary key,
    fecha date,
    monto decimal(10, 2),
    descripcion varchar(255)
);

insert into Facturas (numero, fecha, monto, descripcion)
values (next value for facturaNumSeq, getdate(), 250.50, 'Consulta de cardiología');

select * from Facturas;


-- 2. numeros de consulta
create sequence consultaNumeroSeq
    start with 1
    increment by 1
    maxvalue 100
    cycle;

create table consultasSeq (
    numero int primary key,
    idPaciente int,
    fecha date,
    descripcion varchar(255),
    foreign key (idPaciente) references  pacienteseq(id)
);

insert into consultasSeq (numero, idPaciente, fecha, descripcion)
values (next value for consultaNumeroSeq, 1, '2024-01-10', 'Consulta general');
	
select * from consultasSeq;


-- 3. Secuencia de Procedimientos Medicos
create table procedimientosseq (
    id int primary key,
    nombre varchar(100)
);

create sequence procedimientosseq1
    start with 1
    increment by 1
    minvalue 1
    maxvalue 5000
    cycle;

insert into procedimientosseq (id, nombre)
values (next value for procedimientosseq1, 'Consulta General'),
       (next value for procedimientosseq1, 'Radiografía');

select * from procedimientosseq;


-- 4. Secuencia de Tratamientos
create table tratamientosseq (
    codigo int primary key,
    descripcion varchar(100)
);

create sequence tratamientosseq1
    start with 2000
    increment by 5
    minvalue 2000
    maxvalue 10000
    cycle;

insert into tratamientosseq (codigo, descripcion)
values (next value for tratamientosseq1, 'Terapia Física'),
       (next value for tratamientosseq1, 'Tratamiento Dental');

select * from tratamientosseq;

-- 5. Secuencia de Numeros de Factura
create table facturasseq (
    numero int primary key,
    id_paciente int,
    fecha date,
    total decimal(10, 2),
    foreign key (id_paciente) references pacienteseq(id)
);

create sequence facturasseq1
    start with 10001
    increment by 1
    minvalue 10001
    maxvalue 99999
    cycle;

insert into facturasseq (numero, id_paciente, fecha, total)
values (next value for facturasseq1, 1, '2024-02-10', 150.00);

select * from facturasseq;


