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



