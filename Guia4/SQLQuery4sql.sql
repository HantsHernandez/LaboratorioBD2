use clinica;



-- 1. vista empleados Cargos
create view vEmpleadosCargos as
select ce.idEmpleado, ce.nombreEmpleado, ce.apellidoEmpleado, ce.emailEmpleado, cc.tipoCargo
from clinica.empleados ce
inner join clinica.cargos cc on cc.idTipoCargo =  ce.idTipoCargo;

select * from vEmpleadosCargos;


-- 2. vista empleados Direccion
create view vEmpleadoDireccion as
select ce.idEmpleado, ce.nombreEmpleado, ce.apellidoEmpleado, ce.emailEmpleado, cd.linea1, cd.linea2
from clinica.empleados ce
inner join clinica.direcciones cd on cd.idDireccion =  ce.idDireccion;

select * from vEmpleadoDireccion;


-- 3. empleado cargos direcciones
create view vEmpleadosCargosDireccion as
select ce.idEmpleado, ce.nombreEmpleado, ce.apellidoEmpleado, ce.emailEmpleado, cc.tipoCargo, cd.linea1, cd.linea2
from clinica.empleados ce
inner join clinica.cargos cc on cc.idTipoCargo =  ce.idTipoCargo
inner join clinica.direcciones cd on cd.idDireccion =  ce.idDireccion;

select * from vEmpleadosCargosDireccion;

-- 4. usuarios roles
create view vUsuarioRol as
select cu.usuario, cr.rol
from clinica.usuarios cu
inner join clinica.roles cr on cr.idRol = cu.idRol;

select * from vUsuarioRol;

-- 5. paciente direccion
create view vPacienteDireccion as
select cp.nombrePaciente, cp.emailPaciente, cp.generoPaciente, cd.linea1, cd.linea2
from clinica.pacientes cp
inner join clinica.direcciones cd on cd.idDireccion =  cp.idDireccion;

select * from vPacienteDireccion;
-- 6. paciente expendinte
create view vPacienteExpendiente as 
select cp.nombrePaciente, cp.emailPaciente, cp.generoPaciente, ce.padecimiento, ce.alergia, ce.notaAdicional
from clinica.pacientes cp
inner join clinica.expediente ce on ce.idPaciente =  cp.idPaciente;

select * from vPacienteExpendiente;

-- 7. paciente expediente direccion
create view vPacienteExpendienteDireccion as
select cp.nombrePaciente, cp.emailPaciente, cp.generoPaciente, cd.linea1, cd.linea2, ce.padecimiento, ce.alergia, ce.notaAdicional
from clinica.pacientes cp
inner join clinica.direcciones cd on cd.idDireccion =  cp.idDireccion
inner join clinica.expediente ce on ce.idPaciente =  cp.idPaciente;

select * from vPacienteExpendienteDireccion;

--  8. procedimientosMedicos tiposProcedimientos
create view vProcedimientosMeciosYTipos as
select cpm.fechaHoraProcedimiento, cpm.duracion, ctp.tipoProcedimiento
from clinica.procedimientosMedicos cpm
inner join clinica.tiposprocedimientos ctp on ctp.idTipoProcedimiento = cpm.idTipoProcedimiento;

select * 
from vProcedimientosMeciosYTipos;

-- 9. doctores Especialidad

create view vDoctoresEspecialidad as
select cd.JVPM, ce.nombreEspecialidad, cem.nombreEmpleado, cem.emailEmpleado
from clinica.doctores cd
inner join clinica.empleados cem on cem.idEmpleado = cd.idEmpleado
inner join clinica.especialidades ce on ce.idEspecialidad = cd.idEspecialidad; 

select * from vDoctoresEspecialidad;


-- 10.Consultas por consultorio
create view vConsultasConsultorio as
select cc.diagnosticoConsulta, cc.estadoConsulta, cco.nombreConsultorio, cco.pisoConsultorio
from clinica.consultas cc
inner join clinica.consultorios cco on cco.idConsultorio = cc.idConsultorio;

select * from vConsultasConsultorio;

-- 11. Examenes y Tipos
create view vExamenesyTipos as
select ce.muestraBiologica, ct.TipoExamen, ct.descripcionExamen
from clinica.examenes ce
inner join clinica.tiposexamenes ct on  ct.idTipoExamen = ce.idTipoExamen;

select * from vExamenesyTipos;

-- 12. ProveedoresDeEquipos
create view vProveedorDeEquipo as
select cp.nombre, ce.nombreEquipo, ce.fechaAdquision 
from clinica.proveedores cp
inner join clinica.equiposmedicos ce on ce.idProveedor = cp.idProveedor;

select * from vProveedorDeEquipo;

-- 13. DosisMedicamentosRectados
create view vDosisMedicamentos as
select cm.nombreMedicamento, cm.formulaActiva, cmr.dosis
from clinica.medicamentos cm
inner join clinica.medicamentosRecetados cmr on cmr.idMedicamento = cm.idMedicamento;


select * from vDosisMedicamentos;

-- 14. FacturasConMetodoPago
create view vFacturaConTipoPago as
select cf.totalFP, cf.fechaFP, ctp.tipoPago
from clinica.facturasprocedimientos cf
inner join clinica.tipospago ctp on ctp.idTipoPago = cf.idTipoPago;

select * from vFacturaConTipoPago;

-- 15. direccion paciente
create view vDireccionPaciente as
select cp.nombrePaciente, cp.emailPaciente, cp.generoPaciente, cd.linea1, cd.linea2
from clinica.pacientes cp
inner join clinica.direcciones cd on cd.idDireccion =  cp.idDireccion;

select * from vDireccionPaciente;