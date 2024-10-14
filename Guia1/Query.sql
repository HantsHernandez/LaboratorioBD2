use clinica;

-- Primer Ejercicio Calcular la Edad de un Empleado
create or alter function clinica.obtenerEdadEmpleado(@FechaNacimiento date)
returns int
as begin
	return dateDiff(year,@FechaNacimiento,getDate());
end;

select  clinica.obtenerEdadEmpleado(e.fechaNacimiento) as Edad, e.nombreEmpleado
from clinica.empleados e;


-- Segundo Ejercicio Convertir Texto a Minúsculas

create or alter function clinica.textoMiniscula(@Texto Nvarchar(500))
returns NVarchar(500)
as begin
	return LOWER(@Texto);
end;	

select clinica.textoMiniscula(e.Tratamiento) as tratamiento,clinica.textoMiniscula(e.Padecimiento) as padecimiento  
from clinica.expediente e;

-- Tercer Ejercicio Productos por Categoría

create or alter function clinica.tipoMedicamento(@idTipoMedicamento int)
returns table
as return
	select m.nombreMedicamento, m.formulaActiva, tp.tipoMedicamento
	from clinica.medicamentos m
	inner join clinica.tiposmedicamentos tp on tp.idTipoMedicamento = m.idTipoMedicamento
	where tp.idTipoMedicamento = @idTipoMedicamento;

select *
from clinica.tipoMedicamento(1);

-- Cuarto Ejercicio Listar las Ventas de un Cliente  

create or alter function consultasCliente(@idCliente int)
returns table 
as return
	select p.nombrePaciente, p.apellidoPaciente, p.generoPaciente, cfc.total, ctc.tipoConsulta as costo 
	from clinica.facturasconsultas cfc
	inner join clinica.pacientes p on p.idPaciente = cfc.idPaciente
	inner join clinica.consultas cc on cc.idConsulta = cfc.idConsulta
	inner join clinica.tiposconsultas ctc on ctc.idTipoConsulta = cc.idTipoConsulta
	where p.idPaciente = @idCliente;

select * 
from  consultasCliente(1);

-- Procedimiento almacenados CRUD

-- post
create or alter procedure clinica.insertarTipoMedicamento 
	@tipoMedicamento nvarchar(45)
as begin
	insert into clinica.tiposmedicamentos(tipoMedicamento) 
	values(@tipoMedicamento);
end;

exec clinica.insertarTipoMedicamento 'Viral';

-- update
create or alter procedure clinica.actualizarTipoMedicamento
	@idTipoMedicamento int,
	@NombreMedicamento nvarchar(50)
as begin
	update clinica.tiposmedicamentos
	set tipoMedicamento = @NombreMedicamento
	where idTipoMedicamento =  @idTipoMedicamento
end;

exec clinica.actualizarTipoMedicamento 12,'Viral2';

-- delete
create or alter procedure clinica.eliminarTipoMedicamento
	@idTipoMedicamento int
as begin
	delete clinica.tiposmedicamentos
	where idTipoMedicamento =  @idTipoMedicamento
end;

exec clinica.eliminarTipoMedicamento 12;

-- get
create or alter procedure clinica.obtenerTipoMedicamento
	@tipoMedicamento nvarchar(50)
as begin
	select * 
	from clinica.tiposmedicamentos ctm
	where ctm.tipoMedicamento like '%' + @tipoMedicamento + '%'
end;

exec clinica.obtenerTipoMedicamento 'Lax';

select * from clinica.tiposmedicamentos;





