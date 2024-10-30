-- GUIA 2
use clinica;

-- PARTE 1

-- EJERCICIO 1
-- Crea un INSTEAD OF INSERT Trigger en la tabla citas de la base de datos clinica, 
-- que verifique si un paciente tiene al menos 2 horas de diferencia entre las citas
-- programadas antes de permitir la inserción de una nueva cita. Si el paciente ya tiene una 
-- cita programada en las 2 horas previas a la nueva, el trigger debe evitar la inserción y lanzar 
-- un mensaje de error indicando que el paciente ya tiene una cita en ese horario.


create or alter trigger trgverificaciondisponibilidadpaciente
on clinica.citas
instead of insert
as 
begin
    declare @idpaciente int;
    declare @fechacita datetime;

   
    select @fechacita = i.fechahoracita, @idpaciente = i.idpaciente
    from inserted i;

    if not exists (
        select 1 
        from clinica.citas 
        where idpaciente = @idpaciente 
        and abs(datediff(minute, fechahoracita, @fechacita)) < 120
    )
    begin
        insert into clinica.citas (idpaciente, idtipocita, fechahoracita) 
        select idpaciente, idtipocita, fechahoracita 
        from inserted;
    end
    else
    begin
        raiserror('el paciente ya tiene una cita programada en las 2 horas previas a esta.', 16, 1);
    end
end;


--	EJERCICIO 2
-- Prevenir Actualización de Factura/Reservación: Crea un INSTEAD OF 
-- UPDATE Trigger que impida cambiar el estado de un pedido o reservación 
-- que ya ha sido completado o cerrado. 

select * from clinica.consultas;

create or alter trigger clinica.trgBloqueoEstadoConsulta
on clinica.consultas
instead of update
as begin 
	
	declare @estado varchar(55);
	declare @id int;

	select @estado = d.estadoConsulta, @id = d.idConsulta
	from deleted d;

	if @estado = 'Finalizada'
	begin 
		print 'No se puede actualizar la consulta'
	end
	else 
	begin 
		update clinica.consultas  
		set estadoConsulta =  @estado
		where idConsulta = @id;
	end
end;

update clinica.consultas  
set estadoConsulta =  'Cancelada'
where idConsulta = 1;


--	EJERCICIO 3
--	Validar Edad del Cliente: Crea un INSTEAD OF INSERT Trigger de un 
--	cliente y que valide que la edad sea mayor a 18 años antes de permitir la 
--	inserción. 
	
create or alter trigger clinica.trgMayorEdad
on clinica.empleados
instead of insert
as begin 
	declare @fechaNacimiento Date;
	select @fechaNacimiento = i.fechaNacimiento from inserted i;
	
	if datediff(year, @fechaNacimiento, getdate()) >= 18
	begin
		insert into clinica.empleados(	nombreEmpleado,
										apellidoEmpleado,
										emailEmpleado,
										telefonoEmpleado,
										fechaContratacion, 
										fechaNacimiento, 
										duiEmpleado,
										idDireccion,
										idTipoCargo
									)
		select  i.nombreEmpleado,
				i.apellidoEmpleado,
				i.emailEmpleado,
				i.telefonoEmpleado,
				i.fechaContratacion,
				i.fechaNacimiento,
				i.duiEmpleado,
				i.idDireccion,
				i.idTipoCargo
		from inserted i;
	end
	else 
	begin 
		print'Es menor de edad'
	end
end;

-- menor
insert into clinica.empleados 
    (nombreEmpleado, apellidoEmpleado, emailEmpleado, telefonoEmpleado, fechaContratacion, fechaNacimiento, duiEmpleado, idDireccion, idTipoCargo)
values 
    ('PALIZO', 'Pérez', 'juan.perez@example.com', '555-1234', '2023-01-15', '2010-05-10', '01234567-8', 1, 2);



-- EJERCICIO 4
-- Prevenir la Eliminación de Productos/Libros/Medicamentos Asignados 
-- a Usuarios: Crea un INSTEAD OF DELETE Trigger que impida la 
-- eliminación de libros (en una biblioteca), medicamentos (en una farmacia), o 
-- productos (para quien manejen productos) que ya están asignados o 
-- reservados para un cliente. 


select  * from clinica.consultas;

create or alter trigger validacionElimincacion
on clinica.consultas
instead of delete
as begin
	
	declare @estado varchar(55);
	declare @id int;

	select @estado = d.estadoConsulta, @id = d.idConsulta
	from deleted d;

	if @estado = 'Finalizada'
	begin 
		print 'No se puede eliminar ya que la consulta esta finalizada'
	end
	else 
	begin 
		delete from clinica.consultas
		where idConsulta = @id;
	end
end


delete from clinica.consultas where idConsulta = 1;

-- EJERCICIO 5
-- Prevenir Actualización de Precios en Productos Antiguos: Crea un 
-- INSTEAD OF UPDATE Trigger que impida actualizar los precios de productos 
-- o tarifas que ya tienen más de 30 días en el sistema.

-- EN ESTE CASO LA BD NO TIENE UN SOPORTE CLARO PARA ESTE EJERCICIO


select * from clinica.citas;
select * from clinica.procedimientosmedicos;
-- no va a permitir que se realize ningun cambio pasando los 30 dias
create or alter trigger clinica.validacionActualizacion
on clinica.procedimientosmedicos
instead of update 
as begin 
	declare @fecha datetime
	declare @id int

	select @fecha = d.fechaHoraProcedimiento, @id = d.idProcedimiento
	from deleted d;

	if datediff(day, @fecha, getdate()) > 30
	begin 
		print 'No se puede actualizar el precio. El procedimiento tiene más de 30 días de antigüedad. ID de procedimiento: ' + cast(@id as varchar);
	end
	else 
	begin
		update clinica.procedimientosmedicos
        set duracion = i.duracion
        from inserted i
        Where i.idProcedimiento = @id;
	end
end

update clinica.procedimientosmedicos
set duracion = '01:00:00'
where idProcedimiento =1;


-- PARTE 2


-- EJERCICIO 1 

-- Registrar Historial de Cambios en los Precios: Crea un AFTER UPDATE 
-- Trigger que registre cada vez que se actualice el precio de un producto o 
-- tarifa (en una aerolínea). 

use clinica;

create table facturasConsultasReporte(
	idReporte int primary key identity(1,1),
	idFacturaConsulta int,
	consulta nvarchar(100),
	paciente nvarchar(100),
	precioViejo decimal(10,2),
	precioNuevo decimal(10,2),
	tipoPago nvarchar(100),
	fechaRegistro date
);

create or alter trigger clinica.trgActualizarPrecio
on clinica.facturasconsultas
after update 
as begin
	insert into dbo.facturasConsultasReporte(idFacturaConsulta, consulta, paciente, precioViejo,PrecioNuevo, tipoPago, fechaRegistro)
	select  i.idFacturaConsulta, 
			cc.diagnosticoConsulta, 
			cp.nombrePaciente,
			d.total,
			i.total,
			ctp.tipoPago,
			GETDATE()
	from inserted i
	inner join deleted d on d.idFacturaConsulta = i.idFacturaConsulta
	inner join clinica.consultas cc on cc.idConsulta = i.idConsulta
	inner join clinica.pacientes cp on cp.idPaciente = i.idPaciente
	inner join clinica.tipospago ctp on ctp.idTipoPago = i.idTipoPago;
	print 'Actualizacion de factura consulta registrada!!';
end

update clinica.facturasconsultas 
set total = 30
where idFacturaConsulta = 1;

select * from facturasConsultasReporte;

drop trigger clinica.trgActualizarPrecio;
drop table facturasConsultasReporte;

-- EjJERCICIO 2

-- Crea un AFTER UPDATE Trigger en la tabla de consultas que registre la información de la 
-- última consulta de cada paciente en una tabla ultimas_consultas. Este registro debe incluir 
-- la fecha de la última consulta, el doctor que lo atendió y el identificador de la consulta.

create table ultimaConsulta(
	idUltimaConsulta int primary key identity(1,1),
	idPaciente int,
	idConsulta int,
	fecha date
)

create or alter trigger trgUltimaConsulta
on clinica.consultas
after insert
as begin 
	insert into ultimaConsulta(idPaciente, idConsulta, fecha) 
	select	ci.idPaciente,
			i.idConsulta,
			getdate()
	from inserted i
	inner join clinica.citas  ci on ci.idCita = i.idCita
end;


-- EJERCICIO 3

-- Registrar Cambios en Información del Cliente/Paciente: Crea un AFTER 
-- UPDATE Trigger en una tabla de clientes o pacientes que registre cualquier 
-- cambio de información (nombre, dirección, teléfono) en una tabla de 
-- auditoría. 

select * from clinica.pacientes;

create table registroCambiosPacientes(
	idRegistro int primary key identity(1,1),
	idPaciente int,
	nombrePaciente varchar(50),
	apellidoPaciente varchar(50),
	generoPaciente varchar(50),
	email varchar(50),
	ocuapacion varchar(50),
	alteracion varchar(50),
	fechaRegistro datetime
);

create or alter trigger trgActualizarPaciente
on clinica.pacientes
after update 
as begin

	insert into dbo.registroCambiosPacientes(idPaciente, nombrePaciente, apellidoPaciente, generoPaciente, email, ocuapacion, alteracion, fechaRegistro)
	select  i.idPaciente,
			i.nombrePaciente,
			i.apellidoPaciente,
			i.generoPaciente,
			i.emailPaciente,
			i.ocupacionPaciente,
			'Campo Nombre',
			getdate()
	from inserted i
	inner join deleted d on d.idPaciente = i.idPaciente
	where i.nombrePaciente <> d.nombrePaciente;

	insert into dbo.registroCambiosPacientes(idPaciente, nombrePaciente, apellidoPaciente, generoPaciente, email, ocuapacion, alteracion, fechaRegistro)
	select  i.idPaciente,
			i.nombrePaciente,
			i.apellidoPaciente,
			i.generoPaciente,
			i.emailPaciente,
			i.ocupacionPaciente,
			'Campo email',
			getdate()
	from inserted i
	inner join deleted d on d.idPaciente = i.idPaciente
	where i.emailPaciente <> d.emailPaciente;

	insert into dbo.registroCambiosPacientes(idPaciente, nombrePaciente, apellidoPaciente, generoPaciente, email, ocuapacion, alteracion, fechaRegistro)
	select  i.idPaciente,
			i.nombrePaciente,
			i.apellidoPaciente,
			i.generoPaciente,
			i.emailPaciente,
			i.ocupacionPaciente,
			'Campo Telefono',
			getdate()
	from inserted i
	inner join deleted d on d.idPaciente = i.idPaciente
	where i.ocupacionPaciente <> d.ocupacionPaciente;
end;

drop trigger clinica.trgActualizarPaciente;


select * from clinica.pacientes

select * from dbo.registroCambiosPacientes;

update clinica.pacientes
set nombrePaciente = 'Saboteur'
where idPaciente = 1;

update clinica.pacientes
set emailPaciente = 'franquiZumaya@gmail.com'
where idPaciente = 1;

update clinica.pacientes
set ocupacionPaciente = 'mandilon'
where idPaciente = 1;



-- EEJERCICO 4

-- Crea un AFTER INSERT Trigger en la tabla consultas que, después de insertar un 
-- registro de consulta médica, actualice automáticamente una tabla historialconsultas para registrar 
-- el id del paciente, el id de la consulta y la fecha en la que se realizó la consulta. 
-- Esta tabla servirá como un historial de consultas para cada paciente.

create table clinica.historialconsultas (
    idhistorial int primary key identity(1,1),
    idpaciente int,
    idconsulta int,
    fechaconsulta datetime
);


create or alter trigger trgregistrarhistorialconsulta
on clinica.consultas
after insert
as  
begin
    insert into clinica.historialconsultas (idpaciente, idconsulta, fechaconsulta)
    select ci.idpaciente, i.idConsulta, getdate()
	from inserted i
	inner join clinica.citas  ci on ci.idCita = i.idCita
end;


-- EJERCICIO 5

-- Crea un AFTER UPDATE Trigger en la tabla citas que, después de
-- actualizar el estado de una consulta médica (por ejemplo, de "pendiente" 
-- a "completada"), registre este cambio en una tabla historialestadocitas. 
-- Esta tabla servirá para llevar un control de los cambios de estado de cada cita.


create table clinica.historialEstadoConsulta (
    idhistorial int primary key identity(1,1),
    idcita int,
    estadoanterior varchar(50),
    estadonuevo varchar(50),
    fechacambio datetime
);

create or alter trigger trgregistrarcambeestado
on clinica.consultas
after update
as begin
    insert into clinica.historialEstadoConsulta (idcita, estadoanterior, estadonuevo, fechacambio)
    select i.idcita, d.estadoConsulta as estadoanterior, i.estadoConsulta as estadonuevo, getdate()
    from inserted i
    inner join deleted d on i.idcita = d.idcita
    where d.estadoConsulta <> i.estadoConsulta; 
end;
