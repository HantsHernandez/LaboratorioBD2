use clinica;

-- Tarea: 
-- Crear en su base de datos 6 excepciones Usado Procedimientos Almacenados y 
-- Triggers y Crear 9 Transacciones de en base a sus tablas


--- PROCEDIMIENTOS ALMACENADOS

-- 1.
create or alter procedure clinica.insertartipomedicamento 
	@tipomedicamento nvarchar(45)
as 
begin
    begin try
        insert into clinica.tiposmedicamentos(tipomedicamento) 
        values(@tipomedicamento);

        select 'tipo de medicamento insertado correctamente' as mensaje;
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'error al insertar tipo de medicamento: ' + @errormensaje as mensaje_error;
    end catch
end;

exec clinica.insertartipomedicamento 'viral';


-- 2.

create or alter procedure clinica.actualizartipomedicamento
	@idtipomedicamento int,
	@nombremedicamento nvarchar(50)
as 
begin
    begin try
        update clinica.tiposmedicamentos
        set tipomedicamento = @nombremedicamento
        where idtipomedicamento = @idtipomedicamento;

        if @@rowcount = 0
        begin
            throw 50001, 'no se encontró el tipo de medicamento con el id proporcionado.', 1;
        end

        select 'tipo de medicamento actualizado correctamente' as mensaje;
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'error al actualizar tipo de medicamento: ' + @errormensaje as mensaje_error;
    end catch
end;

exec clinica.actualizartipomedicamento 12,'viral2';


-- 3.

create or alter procedure clinica.eliminartipomedicamento
	@idtipomedicamento int
as 
begin
    begin try
        delete clinica.tiposmedicamentos
        where idtipomedicamento = @idtipomedicamento;

        if @@rowcount = 0
        begin
            throw 50002, 'no se encontró el tipo de medicamento con el id proporcionado.', 1;
        end

        select 'tipo de medicamento eliminado correctamente' as mensaje;
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'error al eliminar tipo de medicamento: ' + @errormensaje as mensaje_error;
    end catch
end;

exec clinica.eliminartipomedicamento 12;


-- 4.

create or alter procedure clinica.obtenertipomedicamento
	@tipomedicamento nvarchar(50)
as 
begin
    begin try
        select * 
        from clinica.tiposmedicamentos ctm
        where ctm.tipomedicamento like '%' + @tipomedicamento + '%';

        if @@rowcount = 0
        begin
            throw 50003, 'no se encontraron resultados para el tipo de medicamento buscado.', 1;
        end
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'error al obtener tipo de medicamento: ' + @errormensaje as mensaje_error;
    end catch
end;

exec clinica.obtenertipomedicamento 'lax';



-- TRIGGER

-- 1.
-- Crea un AFTER UPDATE Trigger en la tabla citas que, después de
-- actualizar el estado de una consulta médica (por ejemplo, de "pendiente" 
-- a "completada"), registre este cambio en una tabla historialestadocitas. 
-- Esta tabla servirá para llevar un control de los cambios de estado de cada cita.

create or alter trigger trgRegistrarcambioEstado
on clinica.consultas
after update
as 
begin
    begin try
        insert into clinica.historialEstadoConsulta (idcita, estadoanterior, estadonuevo, fechacambio)
        select i.idcita, d.estadoConsulta as estadoanterior, i.estadoConsulta as estadonuevo, getdate()
        from inserted i
        inner join deleted d on i.idcita = d.idcita
        where d.estadoConsulta <> i.estadoConsulta; 
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'Error en el trigger trgregistrarcambeestado: ' + @errormensaje as mensaje_error;
    end catch
end;


-- 2.
-- Crea un AFTER INSERT Trigger en la tabla consultas que, después de insertar un 
-- registro de consulta médica, actualice automáticamente una tabla historialconsultas para registrar 
-- el id del paciente, el id de la consulta y la fecha en la que se realizó la consulta. 
-- Esta tabla servirá como un historial de consultas para cada paciente.
create or alter trigger trgRegistrarHistorialConsultaV2
on clinica.consultas
after insert
as  
begin
    begin try
        insert into clinica.historialconsultas (idpaciente, idconsulta, fechaconsulta)
        select ci.idpaciente, i.idConsulta, getdate()
        from inserted i
        inner join clinica.citas ci on ci.idCita = i.idCita;
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        select 'Error en el trigger trgregistrarhistorialconsulta: ' + @errormensaje as mensaje_error;
    end catch
end;

-- 3.
-- Crea un AFTER UPDATE Trigger en la tabla de consultas que registre la información de la 
-- última consulta de cada paciente en una tabla ultimas_consultas. Este registro debe incluir 
-- la fecha de la última consulta, el doctor que lo atendió y el identificador de la consulta.

create or alter trigger trgUltimaConsultaV2
on clinica.consultas
after update
as 
begin
    begin try
        insert into ultimaConsulta(idPaciente, idConsulta, fecha)
        select ci.idPaciente, i.idConsulta, getdate()
        from inserted i
        inner join clinica.citas ci on ci.idCita = i.idCita;
    end try
    begin catch
        declare @errormensaje nvarchar(4000);
        set @errormensaje = error_message();
        
        select 'Error en el trigger trgUltimaConsulta: ' + @errormensaje as mensaje_error;
    end catch
end;



-- 4.
-- Prevenir Actualización de Factura/Reservación: Crea un INSTEAD OF 
-- UPDATE Trigger que impida cambiar el estado de un pedido o reservación 
-- que ya ha sido completado o cerrado. 


create or alter trigger clinica.trgBloqueoEstadoConsulta
on clinica.consultas
instead of update
as 
begin
    begin try
        declare @estado varchar(55);
        declare @id int;

        select @estado = d.estadoConsulta, @id = d.idConsulta
        from deleted d;

        if @estado = 'Finalizada'
        begin
            print 'No se puede actualizar la consulta, ya está finalizada.';
        end
        else 
        begin
            update clinica.consultas  
            set estadoConsulta = @estado
            where idConsulta = @id;
        end
    end try
    begin catch
        declare @mensajeError nvarchar(4000);
        declare @codigoError int;

        select @mensajeError = error_message(), @codigoError = error_number();

        raiserror('Error al intentar actualizar el estado de la consulta: %s. Código de error: %d', 16, 1, @mensajeError, @codigoError);
    end catch
end;



-- Transacciones

-- 1.

select * from clinica.pacientes;
select * from clinica.consultas;

begin transaction;

begin try
    insert into clinica.pacientes (nombrePaciente, apellidoPaciente, generoPaciente, fechaNacPaciente, emailPaciente, duiPaciente, ocupacionPaciente, estadoCivil, idDireccion)
    values ('juan', 'pérez', 'masculino', '1980-05-15', 'juan.perez@example.com', '12345678-9', 'ingeniero', 'soltero', 1);  

    declare @idPaciente int = scope_identity();

    insert into clinica.consultas (diagnosticoConsulta, estadoConsulta, fechaConsulta, idTipoConsulta, idExamenFisico, idDoctor, idCita, idConsultorio, idExpediente)
    values ('Diagnóstico preliminar', 'pendiente', '2024-11-20', 1, 2, 10, 5, 3, 7);  

    commit;
end try
begin catch
    rollback;
    print error_message();
end catch;

-- 2.


select * from clinica.consultas;
select * from clinica.facturasconsultas;

begin transaction;

begin try
    update clinica.consultas
    set estadoConsulta = 'Finalizada', fechaConsulta = getdate()
    where idConsulta = 10;

    
    insert into clinica.facturasconsultas (idConsulta, idPaciente, fecha, total, idTipoPago)
    values (10, 2, getdate(), 100.00, 1);  

    commit;
end try

begin catch
    rollback;
    print error_message();
end catch;

-- 3.

select * from clinica.citas;
select * from clinica.expediente;
select * from clinica.recetas;
select * from clinica.consultas;
select * from clinica.facturasconsultas;


begin transaction;
begin try
    insert into clinica.pacientes (nombrePaciente, apellidoPaciente, generoPaciente, fechaNacPaciente, emailPaciente, duiPaciente, ocupacionPaciente, estadoCivil, idDireccion)
    values ('juan', 'pérez', 'masculino', '1980-05-15', 'juan.perez@example.com', '12345678-9', 'ingeniero', 'soltero', 1);  

	declare @idPaciente int = scope_identity();

    insert into clinica.citas (idPaciente, fechaHoraCita, idTipoCita)
    values (@idPaciente, GETDATE(),1); 

    declare @idCita int = scope_identity();

	insert into clinica.facturasconsultas (idConsulta, idPaciente, fecha, total, idTipoPago)
    values (@idCita, 2, getdate(), 100.00, 1);  
    commit;
end try

begin catch
    rollback;
    print error_message();
end catch;


-- 4.
begin transaction;
begin try
    
    insert into clinica.pacientes (nombrePaciente, apellidoPaciente, generoPaciente, fechaNacPaciente, emailPaciente, duiPaciente, ocupacionPaciente, estadoCivil, idDireccion)
    values ('Maria', 'Lopez', 'Femenino', '1990-06-25', 'maria.lopez@example.com', '12345678-0', 'Estudiante', 'Soltera', 1);  

    declare @idPaciente int = scope_identity();

    insert into clinica.citas (idPaciente, fechaHoraCita, idTipoCita)
    values (@idPaciente, '2024-12-01 10:00:00', 1); 

    commit;
end try
begin catch
    rollback;
    print error_message();
end catch;


-- 5.
select * from clinica.expediente;
select * from clinica.citas;

begin transaction;
begin try
    insert into clinica.pacientes (nombrePaciente, apellidoPaciente, generoPaciente, fechaNacPaciente, emailPaciente, duiPaciente, ocupacionPaciente, estadoCivil, idDireccion)
    values ('Carlos', 'Ruiz', 'Masculino', '1992-03-15', 'carlos.ruiz@example.com', '12345678-9', 'Ingeniero', 'Soltero', 2);

    declare @idPaciente int = scope_identity();

    insert into clinica.expediente(idPaciente, padecimiento, alergia, tratamiento, notaAdicional)
    values (@idPaciente, 'Sin padecimientos', 'Ninguna', 'Ninguno', 'Expediente inicial.');

    insert into clinica.citas (idPaciente, fechaHoraCita, idTipoCita)
    values (@idPaciente, '2024-12-01 10:00:00', 1);

    commit;
end try
begin catch
    rollback;
    print error_message();
end catch;








