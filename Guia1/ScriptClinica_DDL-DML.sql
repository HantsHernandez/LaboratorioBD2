USE [master]
GO
/****** Object:  Database [clinica]    Script Date: 13/10/2024 09:57:01 ******/
CREATE DATABASE [clinica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'clinica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\clinica.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'clinica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\clinica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [clinica] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [clinica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [clinica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [clinica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [clinica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [clinica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [clinica] SET ARITHABORT OFF 
GO
ALTER DATABASE [clinica] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [clinica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [clinica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [clinica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [clinica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [clinica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [clinica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [clinica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [clinica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [clinica] SET  ENABLE_BROKER 
GO
ALTER DATABASE [clinica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [clinica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [clinica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [clinica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [clinica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [clinica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [clinica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [clinica] SET RECOVERY FULL 
GO
ALTER DATABASE [clinica] SET  MULTI_USER 
GO
ALTER DATABASE [clinica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [clinica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [clinica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [clinica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [clinica] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [clinica] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'clinica', N'ON'
GO
ALTER DATABASE [clinica] SET QUERY_STORE = ON
GO
ALTER DATABASE [clinica] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [clinica]
GO
/****** Object:  Schema [clinica]    Script Date: 13/10/2024 09:57:01 ******/
CREATE SCHEMA [clinica]
GO
/****** Object:  UserDefinedFunction [clinica].[enum2str$consultas$estadoConsulta]    Script Date: 13/10/2024 09:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [clinica].[enum2str$consultas$estadoConsulta] 
( 
   @setval tinyint
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 1 THEN 'Finalizada'
            WHEN 2 THEN 'Pendiente'
            WHEN 3 THEN 'Cancelada'
            ELSE ''
         END
   END
GO
/****** Object:  UserDefinedFunction [clinica].[norm_enum$consultas$estadoConsulta]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [clinica].[norm_enum$consultas$estadoConsulta] 
( 
   @setval nvarchar(max)
)
RETURNS nvarchar(max)
AS 
   BEGIN
      RETURN clinica.enum2str$consultas$estadoConsulta(clinica.str2enum$consultas$estadoConsulta(@setval))
   END
GO
/****** Object:  UserDefinedFunction [clinica].[str2enum$consultas$estadoConsulta]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [clinica].[str2enum$consultas$estadoConsulta] 
( 
   @setval nvarchar(max)
)
RETURNS tinyint
AS 
   BEGIN
      RETURN 
         CASE @setval
            WHEN 'Finalizada' THEN 1
            WHEN 'Pendiente' THEN 2
            WHEN 'Cancelada' THEN 3
            ELSE 0
         END
   END
GO
/****** Object:  Table [clinica].[asignacionrolesopciones]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[asignacionrolesopciones](
	[idAsignacion] [int] IDENTITY(123,1) NOT NULL,
	[idRol] [int] NOT NULL,
	[idOpcion] [int] NOT NULL,
 CONSTRAINT [PK_asignacionrolesopciones_idAsignacion] PRIMARY KEY CLUSTERED 
(
	[idAsignacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[cargos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[cargos](
	[idTipoCargo] [int] IDENTITY(14,1) NOT NULL,
	[tipoCargo] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_cargos_idTipoCargo] PRIMARY KEY CLUSTERED 
(
	[idTipoCargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[citas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[citas](
	[idCita] [int] IDENTITY(11,1) NOT NULL,
	[fechaHoraCita] [datetime2](6) NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idTipoCita] [int] NOT NULL,
 CONSTRAINT [PK_citas_idCita] PRIMARY KEY CLUSTERED 
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[consultas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[consultas](
	[idConsulta] [int] IDENTITY(12,1) NOT NULL,
	[diagnosticoConsulta] [nvarchar](255) NOT NULL,
	[estadoConsulta] [nvarchar](10) NOT NULL,
	[fechaConsulta] [date] NOT NULL,
	[idTipoConsulta] [int] NOT NULL,
	[idExamenFisico] [int] NOT NULL,
	[idDoctor] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
	[idCita] [int] NOT NULL,
	[idConsultorio] [int] NOT NULL,
	[idExpediente] [int] NOT NULL,
 CONSTRAINT [PK_consultas_idConsulta] PRIMARY KEY CLUSTERED 
(
	[idConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[consultorios]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[consultorios](
	[idConsultorio] [int] IDENTITY(6,1) NOT NULL,
	[nombreConsultorio] [nvarchar](45) NOT NULL,
	[seccionConsultorio] [nvarchar](45) NOT NULL,
	[pisoConsultorio] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_consultorios_idConsultorio] PRIMARY KEY CLUSTERED 
(
	[idConsultorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[departamentos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[departamentos](
	[idDepartamento] [nchar](2) NOT NULL,
	[departamento] [nvarchar](25) NOT NULL,
	[pais] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_departamentos_idDepartamento] PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[detallesfacturasexamenes]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[detallesfacturasexamenes](
	[idDetalleFacturaExamen] [int] IDENTITY(11,1) NOT NULL,
	[precioUnitario] [decimal](6, 2) NOT NULL,
	[idFacturaProcedimiento] [int] NOT NULL,
	[idProcedimiento] [int] NOT NULL,
 CONSTRAINT [PK_detallesfacturasexamenes_idDetalleFacturaExamen] PRIMARY KEY CLUSTERED 
(
	[idDetalleFacturaExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[detallesfacturasprocedimientos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[detallesfacturasprocedimientos](
	[idDetalleFacturaProcedimiento] [int] IDENTITY(11,1) NOT NULL,
	[precioUnitario] [decimal](6, 2) NOT NULL,
	[idFacturaProcedimiento] [int] NOT NULL,
	[idProcedimiento] [int] NOT NULL,
 CONSTRAINT [PK_detallesfacturasprocedimientos_idDetalleFacturaProcedimiento] PRIMARY KEY CLUSTERED 
(
	[idDetalleFacturaProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[direcciones]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[direcciones](
	[idDireccion] [int] IDENTITY(38,1) NOT NULL,
	[linea1] [nvarchar](100) NULL,
	[linea2] [nvarchar](100) NULL,
	[codigoPostal] [nvarchar](5) NULL,
	[idDistrito] [nchar](5) NOT NULL,
 CONSTRAINT [PK_direcciones_idDireccion] PRIMARY KEY CLUSTERED 
(
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[distritos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[distritos](
	[idDistrito] [nchar](5) NOT NULL,
	[distrito] [nvarchar](50) NOT NULL,
	[idMunicipio] [nchar](3) NOT NULL,
 CONSTRAINT [PK_distritos_idDistrito] PRIMARY KEY CLUSTERED 
(
	[idDistrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[doctores]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[doctores](
	[idDoctor] [int] IDENTITY(9,1) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[JVPM] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
 CONSTRAINT [PK_doctores_idDoctor] PRIMARY KEY CLUSTERED 
(
	[idDoctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[doctorespecialidades]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[doctorespecialidades](
	[idDoctor] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
 CONSTRAINT [PK_doctorespecialidades_idDoctor] PRIMARY KEY CLUSTERED 
(
	[idDoctor] ASC,
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[empleados]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[empleados](
	[idEmpleado] [int] IDENTITY(26,1) NOT NULL,
	[nombreEmpleado] [nvarchar](45) NOT NULL,
	[apellidoEmpleado] [nvarchar](45) NOT NULL,
	[emailEmpleado] [nvarchar](90) NOT NULL,
	[telefonoEmpleado] [nvarchar](45) NOT NULL,
	[fechaContratacion] [nvarchar](45) NOT NULL,
	[fechaNacimiento] [date],
	[duiEmpleado] [nchar](10) NOT NULL,
	[idDireccion] [int] NOT NULL,
	[idTipoCargo] [int] NOT NULL,
 CONSTRAINT [PK_empleados_idEmpleado] PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[enfermeros]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[enfermeros](
	[idEnfermero] [int] IDENTITY(4,1) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[JVPE] [int] NOT NULL,
 CONSTRAINT [PK_enfermeros_idEnfermero] PRIMARY KEY CLUSTERED 
(
	[idEnfermero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[equiposmedicos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[equiposmedicos](
	[idEquipoMedico] [int] IDENTITY(16,1) NOT NULL,
	[nombreEquipo] [nvarchar](45) NOT NULL,
	[marcaEquipo] [nvarchar](45) NULL,
	[fechaAdquision] [date] NOT NULL,
	[idTipoEquipoMedico] [int] NOT NULL,
	[idProveedor] [int] NOT NULL,
	[idInventario] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_equiposmedicos_idEquipoMedico] PRIMARY KEY CLUSTERED 
(
	[idEquipoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[especialidades]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[especialidades](
	[idEspecialidad] [int] IDENTITY(13,1) NOT NULL,
	[nombreEspecialidad] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_especialidades_idEspecialidad] PRIMARY KEY CLUSTERED 
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[especialidadeslaboratorista]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[especialidadeslaboratorista](
	[idLaboratorista] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
 CONSTRAINT [PK_especialidadeslaboratorista_idLaboratorista] PRIMARY KEY CLUSTERED 
(
	[idLaboratorista] ASC,
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[examenes]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[examenes](
	[idExamen] [int] IDENTITY(11,1) NOT NULL,
	[fechaHoraExamen] [datetime2](6) NOT NULL,
	[muestraBiologica] [nvarchar](45) NOT NULL,
	[unidadMedida] [nvarchar](5) NOT NULL,
	[idTipoExamen] [int] NOT NULL,
	[idLaboratorista] [int] NOT NULL,
	[idCita] [int] NOT NULL,
 CONSTRAINT [PK_examenes_idExamen] PRIMARY KEY CLUSTERED 
(
	[idExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[examenesfisicos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[examenesfisicos](
	[idExamenFisico] [int] IDENTITY(12,1) NOT NULL,
	[pulso] [nvarchar](45) NOT NULL,
	[presionArterial] [nvarchar](45) NOT NULL,
	[temperatura] [nvarchar](45) NOT NULL,
	[estadoPiel] [nvarchar](45) NOT NULL,
	[comportamiento] [nvarchar](45) NOT NULL,
	[inspeccionOjos] [nvarchar](45) NULL,
	[inspeccionOidos] [nvarchar](45) NULL,
	[inspeccionCabeza] [nvarchar](45) NULL,
	[inspeccionAbdomen] [nvarchar](45) NOT NULL,
	[inspeccionExtremidades] [nvarchar](45) NOT NULL,
	[funcionSensorial] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_examenesfisicos_idExamenFisico] PRIMARY KEY CLUSTERED 
(
	[idExamenFisico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[expediente]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[expediente](
	[idExpediente] [int] IDENTITY(11,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[padecimiento] [nvarchar](max) NULL,
	[alergia] [nvarchar](max) NULL,
	[tratamiento] [nvarchar](max) NULL,
	[notaAdicional] [nvarchar](100) NULL,
	[idPaciente] [int] NOT NULL,
 CONSTRAINT [PK_expediente_idExpediente] PRIMARY KEY CLUSTERED 
(
	[idExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [clinica].[facturasconsultas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[facturasconsultas](
	[idFacturaConsulta] [int] IDENTITY(11,1) NOT NULL,
	[idConsulta] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[total] [decimal](6, 2) NOT NULL,
	[idTipoPago] [int] NOT NULL,
 CONSTRAINT [PK_facturasconsultas_idFacturaConsulta] PRIMARY KEY CLUSTERED 
(
	[idFacturaConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[facturasexamenes]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[facturasexamenes](
	[idFacturaExamen] [int] IDENTITY(11,1) NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fechaFE] [datetime2](2) NOT NULL,
	[totalFE] [decimal](6, 2) NOT NULL,
	[idTipoPago] [int] NOT NULL,
 CONSTRAINT [PK_facturasexamenes_idFacturaExamen] PRIMARY KEY CLUSTERED 
(
	[idFacturaExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[facturasprocedimientos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[facturasprocedimientos](
	[idFacturaProcedimiento] [int] IDENTITY(11,1) NOT NULL,
	[idPaciente] [int] NOT NULL,
	[fechaFP] [datetime2](2) NOT NULL,
	[totalFP] [decimal](6, 2) NOT NULL,
	[idTipoPago] [int] NOT NULL,
 CONSTRAINT [PK_facturasprocedimientos_idFacturaProcedimiento] PRIMARY KEY CLUSTERED 
(
	[idFacturaProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[insumosmedicos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[insumosmedicos](
	[idInsumoMedico] [int] IDENTITY(6,1) NOT NULL,
	[idMedicamento] [int] NOT NULL,
	[idEquipoMedico] [int] NOT NULL,
	[idProcedimiento] [int] NOT NULL,
 CONSTRAINT [PK_insumosmedicos_idInsumoMedico] PRIMARY KEY CLUSTERED 
(
	[idInsumoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[inventario]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[inventario](
	[idInventario] [int] IDENTITY(16,1) NOT NULL,
	[bodega] [nvarchar](45) NOT NULL,
	[seccion] [nvarchar](45) NOT NULL,
	[pasillo] [nvarchar](45) NOT NULL,
	[estante] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_inventario_idInventario] PRIMARY KEY CLUSTERED 
(
	[idInventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[laboratorios]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[laboratorios](
	[idLaboratorio] [int] IDENTITY(11,1) NOT NULL,
	[nombreLaboratorio] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_laboratorios_idLaboratorio] PRIMARY KEY CLUSTERED 
(
	[idLaboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[laboratorista]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[laboratorista](
	[idLaboratorista] [int] IDENTITY(4,1) NOT NULL,
	[idEmpleado] [int] NOT NULL,
	[JVPLC] [int] NOT NULL,
 CONSTRAINT [PK_laboratorista_idLaboratorista] PRIMARY KEY CLUSTERED 
(
	[idLaboratorista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[medicamentos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[medicamentos](
	[idMedicamento] [int] IDENTITY(11,1) NOT NULL,
	[nombreMedicamento] [nvarchar](45) NOT NULL,
	[formulaActiva] [nvarchar](50) NOT NULL,
	[idTipoMedicamento] [int] NOT NULL,
	[idLaboratorio] [int] NOT NULL,
 CONSTRAINT [PK_medicamentos_idMedicamento] PRIMARY KEY CLUSTERED 
(
	[idMedicamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[medicamentosrecetados]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[medicamentosrecetados](
	[idMedicamento] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
	[dosis] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_medicamentosrecetados_idMedicamento] PRIMARY KEY CLUSTERED 
(
	[idMedicamento] ASC,
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[municipios]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[municipios](
	[idMunicipio] [nchar](3) NOT NULL,
	[municipio] [nvarchar](50) NOT NULL,
	[idDepartamento] [nchar](2) NOT NULL,
 CONSTRAINT [PK_municipios_idMunicipio] PRIMARY KEY CLUSTERED 
(
	[idMunicipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[opciones]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[opciones](
	[idOpcion] [int] IDENTITY(46,1) NOT NULL,
	[opcion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_opciones_idOpcion] PRIMARY KEY CLUSTERED 
(
	[idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[pacientes]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[pacientes](
	[idPaciente] [int] IDENTITY(11,1) NOT NULL,
	[nombrePaciente] [nvarchar](45) NOT NULL,
	[apellidoPaciente] [nvarchar](45) NOT NULL,
	[generoPaciente] [nvarchar](45) NOT NULL,
	[fechaNacPaciente] [nvarchar](45) NULL,
	[emailPaciente] [nvarchar](45) NULL,
	[duiPaciente] [nvarchar](45) NOT NULL,
	[ocupacionPaciente] [nvarchar](45) NULL,
	[estadoCivil] [nvarchar](45) NULL,
	[idDireccion] [int] NOT NULL,
 CONSTRAINT [PK_pacientes_idPaciente] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[personalprocedimientos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[personalprocedimientos](
	[idPersonalProcedimiento] [int] IDENTITY(7,1) NOT NULL,
	[idEnfermero] [int] NOT NULL,
	[idDoctor] [int] NOT NULL,
	[idProcedimiento] [int] NOT NULL,
 CONSTRAINT [PK_personalprocedimientos_idPersonalProcedimiento] PRIMARY KEY CLUSTERED 
(
	[idPersonalProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[procedimientosmedicos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[procedimientosmedicos](
	[idProcedimiento] [int] IDENTITY(11,1) NOT NULL,
	[fechaHoraProcedimiento] [datetime2](6) NOT NULL,
	[duracion] [time](7) NOT NULL,
	[idTipoProcedimiento] [int] NOT NULL,
	[idConsulta] [int] NOT NULL,
 CONSTRAINT [PK_procedimientosmedicos_idProcedimiento] PRIMARY KEY CLUSTERED 
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[proveedores]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[proveedores](
	[idProveedor] [int] IDENTITY(11,1) NOT NULL,
	[nombre] [nvarchar](45) NOT NULL,
	[direccion] [nvarchar](45) NOT NULL,
	[telefono] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_proveedores_idProveedor] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[recetas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[recetas](
	[idReceta] [int] IDENTITY(11,1) NOT NULL,
	[idExpediente] [int] NOT NULL,
	[fechaReceta] [date] NOT NULL,
	[duracionReceta] [int] NOT NULL,
 CONSTRAINT [PK_recetas_idReceta] PRIMARY KEY CLUSTERED 
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[roles]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[roles](
	[idRol] [int] IDENTITY(9,1) NOT NULL,
	[rol] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_roles_idRol] PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposcitas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposcitas](
	[idTipoCita] [int] IDENTITY(10,1) NOT NULL,
	[tipoCita] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_tiposcitas_idTipoCita] PRIMARY KEY CLUSTERED 
(
	[idTipoCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposconsultas]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposconsultas](
	[idTipoConsulta] [int] IDENTITY(10,1) NOT NULL,
	[tipoConsulta] [nvarchar](45) NOT NULL,
	[precioConsulta] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_tiposconsultas_idTipoConsulta] PRIMARY KEY CLUSTERED 
(
	[idTipoConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposequiposmedicos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposequiposmedicos](
	[idTipoEquipoMedico] [int] IDENTITY(11,1) NOT NULL,
	[tipoEquipoMedico] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_tiposequiposmedicos_idTipoEquipoMedico] PRIMARY KEY CLUSTERED 
(
	[idTipoEquipoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposexamenes]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposexamenes](
	[idTipoExamen] [int] IDENTITY(12,1) NOT NULL,
	[TipoExamen] [nvarchar](45) NOT NULL,
	[descripcionExamen] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_tiposexamenes_idTipoExamen] PRIMARY KEY CLUSTERED 
(
	[idTipoExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposmedicamentos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposmedicamentos](
	[idTipoMedicamento] [int] IDENTITY(12,1) NOT NULL,
	[tipoMedicamento] [nvarchar](45) NOT NULL,
 CONSTRAINT [PK_tiposmedicamentos_idTipoMedicamento] PRIMARY KEY CLUSTERED 
(
	[idTipoMedicamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tipospago]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tipospago](
	[idTipoPago] [int] IDENTITY(7,1) NOT NULL,
	[tipoPago] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tipospago_idTipoPago] PRIMARY KEY CLUSTERED 
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[tiposprocedimientos]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[tiposprocedimientos](
	[idTipoProcedimiento] [int] IDENTITY(11,1) NOT NULL,
	[tipoProcedimiento] [nvarchar](45) NOT NULL,
	[descripcionProcedimiento] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_tiposprocedimientos_idTipoProcedimiento] PRIMARY KEY CLUSTERED 
(
	[idTipoProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [clinica].[usuarios]    Script Date: 13/10/2024 09:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [clinica].[usuarios](
	[idUsuario] [int] IDENTITY(9,1) NOT NULL,
	[usuario] [nvarchar](45) NULL,
	[contraseña] [nvarchar](45) NULL,
	[idRol] [int] NOT NULL,
	[idEmpleado] [int] NOT NULL,
 CONSTRAINT [PK_usuarios_idUsuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [clinica].[asignacionrolesopciones] ON 

INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (1, 8, 1)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (2, 8, 2)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (3, 8, 3)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (4, 8, 4)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (5, 8, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (6, 8, 6)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (7, 8, 7)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (8, 8, 8)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (9, 8, 9)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (10, 8, 10)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (11, 8, 11)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (12, 8, 12)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (13, 8, 13)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (14, 8, 14)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (15, 8, 15)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (16, 8, 16)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (17, 8, 17)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (18, 8, 18)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (19, 8, 19)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (20, 8, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (21, 8, 21)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (22, 8, 22)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (23, 8, 23)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (24, 8, 24)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (25, 8, 25)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (26, 8, 26)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (27, 8, 27)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (28, 8, 28)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (29, 8, 29)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (30, 8, 30)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (31, 8, 31)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (32, 8, 32)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (33, 8, 33)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (34, 8, 34)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (35, 8, 35)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (36, 8, 36)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (37, 8, 37)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (38, 8, 38)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (39, 8, 39)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (40, 8, 40)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (41, 8, 41)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (42, 8, 42)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (43, 8, 43)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (44, 8, 44)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (45, 8, 45)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (46, 4, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (47, 4, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (48, 4, 21)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (49, 4, 17)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (50, 4, 31)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (51, 5, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (52, 5, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (53, 5, 27)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (54, 5, 28)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (55, 7, 1)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (56, 7, 2)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (57, 7, 3)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (58, 7, 4)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (59, 7, 7)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (60, 7, 12)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (61, 7, 25)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (62, 2, 1)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (63, 2, 2)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (64, 2, 3)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (65, 2, 4)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (66, 2, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (67, 2, 6)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (68, 2, 7)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (69, 2, 12)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (70, 2, 14)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (71, 2, 15)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (72, 2, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (73, 2, 21)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (74, 2, 27)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (75, 2, 28)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (76, 2, 30)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (77, 2, 32)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (78, 2, 33)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (79, 2, 35)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (80, 2, 34)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (81, 2, 37)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (82, 2, 39)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (83, 2, 40)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (84, 2, 41)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (85, 2, 42)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (86, 2, 43)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (87, 2, 44)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (88, 6, 27)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (89, 6, 28)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (90, 6, 32)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (91, 6, 33)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (92, 6, 34)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (93, 6, 35)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (94, 6, 36)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (95, 6, 39)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (96, 6, 40)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (97, 6, 41)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (98, 6, 42)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (99, 6, 43)
GO
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (100, 6, 44)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (101, 4, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (102, 4, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (103, 4, 21)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (104, 1, 1)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (105, 1, 2)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (106, 1, 3)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (107, 1, 4)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (108, 1, 5)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (109, 1, 14)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (110, 1, 15)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (111, 1, 20)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (112, 1, 27)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (113, 1, 28)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (114, 1, 38)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (115, 1, 37)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (116, 1, 23)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (117, 1, 21)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (118, 1, 18)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (119, 1, 30)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (120, 1, 29)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (121, 1, 31)
INSERT [clinica].[asignacionrolesopciones] ([idAsignacion], [idRol], [idOpcion]) VALUES (122, 1, 19)
SET IDENTITY_INSERT [clinica].[asignacionrolesopciones] OFF
GO
SET IDENTITY_INSERT [clinica].[cargos] ON 

INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (1, N'Doctor')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (2, N'Secretaria')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (3, N'Conductor')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (4, N'Cocinera')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (5, N'Vigilancia')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (6, N'Ordenanza')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (7, N'Enfermero')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (8, N'Laboratorista')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (9, N'Contador')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (10, N'Administrador de Sistemas')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (11, N'Recusrsos Humanos')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (12, N'Recepcionista')
INSERT [clinica].[cargos] ([idTipoCargo], [tipoCargo]) VALUES (13, N'Administrativo')
SET IDENTITY_INSERT [clinica].[cargos] OFF
GO
SET IDENTITY_INSERT [clinica].[citas] ON 

INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (1, CAST(N'2024-04-10T10:00:00.0000000' AS DateTime2), 1, 1)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (2, CAST(N'2024-04-11T14:30:00.0000000' AS DateTime2), 2, 2)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (3, CAST(N'2024-04-12T09:15:00.0000000' AS DateTime2), 3, 3)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (4, CAST(N'2024-04-13T11:45:00.0000000' AS DateTime2), 4, 4)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (5, CAST(N'2024-04-14T08:00:00.0000000' AS DateTime2), 5, 5)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (6, CAST(N'2024-05-01T10:00:00.0000000' AS DateTime2), 6, 1)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (7, CAST(N'2024-05-10T13:00:00.0000000' AS DateTime2), 7, 9)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (8, CAST(N'2024-05-15T07:00:00.0000000' AS DateTime2), 8, 6)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (9, CAST(N'2024-06-21T14:45:00.0000000' AS DateTime2), 9, 7)
INSERT [clinica].[citas] ([idCita], [fechaHoraCita], [idPaciente], [idTipoCita]) VALUES (10, CAST(N'2024-09-30T15:35:00.0000000' AS DateTime2), 10, 5)
SET IDENTITY_INSERT [clinica].[citas] OFF
GO
SET IDENTITY_INSERT [clinica].[consultas] ON 

INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (1, N'Dolor de cabeza', N'Finalizada', CAST(N'2024-04-10' AS Date), 1, 1, 1, 1, 1, 1, 1)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (2, N'Dolor abdominal', N'Pendiente', CAST(N'2024-04-23' AS Date), 2, 2, 2, 2, 2, 2, 2)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (3, N'Fiebre', N'Cancelada', CAST(N'2024-03-12' AS Date), 3, 3, 3, 3, 3, 3, 3)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (4, N'Problemas respiratorios', N'Finalizada', CAST(N'2024-09-10' AS Date), 4, 4, 1, 4, 4, 4, 4)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (5, N'Examen de rutina', N'Pendiente', CAST(N'2024-10-10' AS Date), 5, 5, 2, 5, 5, 5, 5)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (6, N'Presión arterial alta', N'Finalizada', CAST(N'2024-11-11' AS Date), 5, 5, 3, 5, 5, 5, 5)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (7, N'Dolor de cabeza severo', N'Finalizada', CAST(N'2024-04-29' AS Date), 1, 6, 4, 6, 6, 1, 6)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (8, N'Lesión en la rodilla', N'Finalizada', CAST(N'2024-04-15' AS Date), 9, 7, 5, 7, 7, 2, 7)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (9, N'Resfriado leve', N'Finalizada', CAST(N'2024-12-23' AS Date), 6, 8, 6, 8, 8, 3, 8)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (10, N'Consulta de seguimiento', N'Finalizada', CAST(N'2024-01-10' AS Date), 7, 9, 7, 9, 9, 4, 9)
INSERT [clinica].[consultas] ([idConsulta], [diagnosticoConsulta], [estadoConsulta], [fechaConsulta], [idTipoConsulta], [idExamenFisico], [idDoctor], [idReceta], [idCita], [idConsultorio], [idExpediente]) VALUES (11, N'Consulta preventiva', N'Finalizada', CAST(N'2024-07-24' AS Date), 5, 10, 8, 10, 10, 5, 10)
SET IDENTITY_INSERT [clinica].[consultas] OFF
GO
SET IDENTITY_INSERT [clinica].[consultorios] ON 

INSERT [clinica].[consultorios] ([idConsultorio], [nombreConsultorio], [seccionConsultorio], [pisoConsultorio]) VALUES (1, N'Consultorio A', N'Sección A', N'Primer Piso')
INSERT [clinica].[consultorios] ([idConsultorio], [nombreConsultorio], [seccionConsultorio], [pisoConsultorio]) VALUES (2, N'Consultorio B', N'Sección B', N'Segundo Piso')
INSERT [clinica].[consultorios] ([idConsultorio], [nombreConsultorio], [seccionConsultorio], [pisoConsultorio]) VALUES (3, N'Consultorio C', N'Sección C', N'Tercer Piso')
INSERT [clinica].[consultorios] ([idConsultorio], [nombreConsultorio], [seccionConsultorio], [pisoConsultorio]) VALUES (4, N'Consultorio D', N'Sección D', N'Cuarto Piso')
INSERT [clinica].[consultorios] ([idConsultorio], [nombreConsultorio], [seccionConsultorio], [pisoConsultorio]) VALUES (5, N'Consultorio E', N'Sección E', N'Quinto Piso')
SET IDENTITY_INSERT [clinica].[consultorios] OFF
GO
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'AH', N'Ahuachapán', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'CA', N'Cabañas', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'CH', N'Chalatenango', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'CU', N'Cuscatlán', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'LL', N'La Libertad', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'LP', N'La Paz', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'LU', N'La Unión', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'MO', N'Morazán', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'SA', N'Santa Ana', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'SM', N'San Miguel', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'SO', N'Sonsonate', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'SS', N'San Salvador', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'SV', N'San Vicente', N'El Salvador')
INSERT [clinica].[departamentos] ([idDepartamento], [departamento], [pais]) VALUES (N'US', N'Usulután', N'El Salvador')
GO
SET IDENTITY_INSERT [clinica].[detallesfacturasexamenes] ON 

INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (1, CAST(5.00 AS Decimal(6, 2)), 1, 1)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (2, CAST(5.00 AS Decimal(6, 2)), 2, 2)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (3, CAST(5.00 AS Decimal(6, 2)), 3, 3)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (4, CAST(5.00 AS Decimal(6, 2)), 4, 4)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (5, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (6, CAST(70.00 AS Decimal(6, 2)), 6, 6)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (7, CAST(110.00 AS Decimal(6, 2)), 7, 7)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (8, CAST(130.00 AS Decimal(6, 2)), 8, 8)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (9, CAST(180.00 AS Decimal(6, 2)), 9, 9)
INSERT [clinica].[detallesfacturasexamenes] ([idDetalleFacturaExamen], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (10, CAST(160.00 AS Decimal(6, 2)), 10, 10)
SET IDENTITY_INSERT [clinica].[detallesfacturasexamenes] OFF
GO
SET IDENTITY_INSERT [clinica].[detallesfacturasprocedimientos] ON 

INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (1, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (2, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (3, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (4, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (5, CAST(5.00 AS Decimal(6, 2)), 5, 5)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (6, CAST(550.00 AS Decimal(6, 2)), 6, 6)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (7, CAST(400.00 AS Decimal(6, 2)), 7, 7)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (8, CAST(900.00 AS Decimal(6, 2)), 8, 8)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (9, CAST(750.00 AS Decimal(6, 2)), 9, 9)
INSERT [clinica].[detallesfacturasprocedimientos] ([idDetalleFacturaProcedimiento], [precioUnitario], [idFacturaProcedimiento], [idProcedimiento]) VALUES (10, CAST(650.00 AS Decimal(6, 2)), 10, 10)
SET IDENTITY_INSERT [clinica].[detallesfacturasprocedimientos] OFF
GO
SET IDENTITY_INSERT [clinica].[direcciones] ON 

INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (1, N'Col Madera, Calle 1, #1N', N'Frente al parque', N'02311', N'SON02')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (2, N'Barrio El Caldero, Av 2, #2I', N'Frente al amate', N'02306', N'SOE01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (3, N'Res El Cangrejo, Av 3, #3A', N'Frente a la playa', N'02302', N'SOO01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (4, N'Barrio El Centro, Av 4, #4S', N'Frente a catedral', N'02301', N'SOC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (5, N'Col La Frontera, Calle 5, #5G', N'Km 10', N'02113', N'AHS03')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (6, N'Res Buenavista, Calle 6, #6A', N'Contiguo a Alcaldia', N'02201', N'SAC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (7, N'Res Altavista, Av 7, #7S', N'Contiguo al ISSS', N'01101', N'SSC03')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (8, N'Col Las Margaritas, Pje 20, #2-4', N'Junto a ANDA', N'02114', N'AHS01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (9, N'Urb Las Magnolias, Pol 21, #2-6', N'Casa de esquina', N'01115', N'LLO01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (10, N'Caserio Florencia, 3era Calle, #5', N'Casa rosada', N'02305', N'SON01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (11, N'Col Las Ranas, 5ta calle, #34', NULL, N'87871', N'USO04')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (12, N'Res El Mango, Apt #45', NULL, N'56482', N'SVS01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (13, N'Urb Amesterdam, Blvd Holanda, casa #89', NULL, N'03425', N'MOS05')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (14, N'Col Vista Del Mar, Calle Alta Mira, #67', NULL, N'45647', N'SMN08')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (15, N'Res Machu Picchu, Apt 345', NULL, N'67432', N'LUN05')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (16, N'Col Madera, Calle 13, #121N', N'Frente al fereteria', N'02311', N'SON02')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (17, N'Barrio El Caldero, Av 6, #25I', N'Frente escuela', N'02305', N'SOE01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (18, N'Res El Cangrejo, Blvd Vaquero, #30A', N'Frente a estacion policia', N'02302', N'SOO01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (19, N'Barrio El Centro, Calle 44, #78', N'Atras de catedral', N'02301', N'SOC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (20, N'Col La Frontera, Calle 56, #54G', N'Frente taller mecanico', N'02113', N'AHS03')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (21, N'Res Buenavista, Calle 6, #7A', N'Contiguo a Alcaldia', N'02201', N'SAC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (22, N'Res Altavista, Av 7, #10S', N'Contiguo al ISSS', N'01101', N'SSC03')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (23, N'Col El Bosque, Calle A, #1', N'Junto al parque', N'04201', N'LLC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (24, N'Barrio El Centro, Av 8, #12', N'Cerca del mercado', N'06101', N'CHS01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (25, N'Residencial Las Palmas, Calle B, #3', N'Frente a la piscina', N'01123', N'SSN01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (26, N'Colonia La Montaña, Calle C, #45', N'Al lado del campo de fútbol', N'04789', N'LLT03')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (27, N'Residencial Los Pinos, Av 10, #25', N'Cerca de la plaza central', N'08123', N'CAE01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (28, N'Barrio San José, Calle D, #7', N'Frente a la escuela', N'04123', N'SAN02')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (29, N'Colonia Los Almendros, Av 15, #30', N'Al lado del supermercado', N'05123', N'SMC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (30, N'Barrio El Carmen, Calle E, #9', N'Cerca del centro de salud', N'07123', N'USE01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (31, N'Colonia La Primavera, Calle F, #18', N'Junto al parque infantil', N'02123', N'SSO01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (32, N'Residencial Las Flores, Av 20, #5', N'Frente a la iglesia', N'07123', N'CHN01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (33, N'Colonia Los Robles, Calle G, #12', N'Cerca del polideportivo', N'03123', N'MOS01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (34, N'Barrio El Rosario, Calle H, #23', N'Junto a la estación de bomberos', N'08123', N'AHC01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (35, N'Residencial La Ceiba, Av 25, #45', N'Frente al parque acuático', N'09123', N'CUS01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (36, N'Colonia Los Cedros, Calle I, #8', N'Cerca del centro comercial', N'02123', N'SAO01')
INSERT [clinica].[direcciones] ([idDireccion], [linea1], [linea2], [codigoPostal], [idDistrito]) VALUES (37, N'Barrio San Juan, Av 30, #12', N'Al lado del campo de baloncesto', N'06123', N'SVN01')
SET IDENTITY_INSERT [clinica].[direcciones] OFF
GO
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHC01', N'Ahuachapán', N'AHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHC02', N'Apaneca', N'AHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHC03', N'Concepción de Ataco', N'AHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHC04', N'Tacuba', N'AHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHN01', N'Atiquizaya', N'AHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHN02', N'El Refugio', N'AHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHN03', N'San Lorenzo', N'AHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHN04', N'Turín', N'AHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHS01', N'Guaymango', N'AHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHS02', N'Jujutla', N'AHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHS03', N'San Francisco Menéndez', N'AHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'AHS04', N'San Pedro Puxtla', N'AHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAE01', N'Sensuntepeque', N'CAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAE02', N'Victoria', N'CAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAE03', N'Dolores', N'CAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAE04', N'Guacotecti', N'CAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAE05', N'San Isidro', N'CAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAO01', N'Ilobasco', N'CAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAO02', N'Tejutepeque', N'CAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAO03', N'Jutiapa', N'CAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CAO04', N'Cinquera', N'CAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC01', N'Nueva Concepción', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC02', N'Tejutla', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC03', N'La Reina', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC04', N'Agua Caliente', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC05', N'Dulce Nombre de María', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC06', N'El Paraíso', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC07', N'San Fernando', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC08', N'San Francisco Morazán', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC09', N'San Rafael', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHC10', N'Santa Rita', N'CHC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHN01', N'La Palma', N'CHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHN02', N'Citalá', N'CHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHN03', N'San Ignacio', N'CHN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS01', N'Chalatenango', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS02', N'Arcatao', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS03', N'Azacualpa', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS04', N'Comalapa', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS05', N'Concepción Quezaltepeque', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS06', N'El Carrizal', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS07', N'La Laguna', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS08', N'Las Vueltas', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS09', N'Nombre de Jesús', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS10', N'Nueva Trinidad', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS11', N'Ojos de Agua', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS12', N'Potonico', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS13', N'San Antonio de La Cruz', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS14', N'San Antonio Los Ranchos', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS15', N'San Francisco Lempa', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS16', N'San Isidro Labrador', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS17', N'San José Cancasque', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS18', N'San Miguel de Mercedes', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS19', N'San José Las Flores', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CHS20', N'San Luis del Carmen', N'CHS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUN01', N'Suchitoto', N'CUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUN02', N'San José Guayabal', N'CUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUN03', N'Oratorio de Concepción', N'CUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUN04', N'San Bartolomé Perulapía', N'CUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUN05', N'San Pedro Perulapán', N'CUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS01', N'Cojutepeque', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS02', N'San Rafael Cedros', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS03', N'Candelaria', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS04', N'Monte San Juan', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS05', N'El Carmen', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS06', N'San Cristobal', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS07', N'Santa Cruz Michapa', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS08', N'San Ramón', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS09', N'El Rosario', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS10', N'Santa Cruz Analquito', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'CUS11', N'Tenancingo', N'CUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLC01', N'San Juan Opico', N'LLC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLC02', N'Ciudad Arce', N'LLC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLE01', N'Antiguo Cuscatlán', N'LLE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLE02', N'Huizúcar', N'LLE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLE03', N'Nuevo Cuscatlán', N'LLE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLE04', N'San José Villanueva', N'LLE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLE05', N'Zaragoza', N'LLE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLN01', N'Quezaltepeque', N'LLN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLN02', N'San Matías', N'LLN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLN03', N'San Pablo Tacachico', N'LLN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLO01', N'Colón', N'LLO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLO02', N'Jayaque', N'LLO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLO03', N'Sacacoyo', N'LLO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLO04', N'Tepecoyo', N'LLO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLO05', N'Talnique', N'LLO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLS01', N'Comasagua', N'LLS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLS02', N'Santa Tecla', N'LLS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLT01', N'Chiltiupán', N'LLT')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLT02', N'Jicalapa', N'LLT')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLT03', N'La Libertad', N'LLT')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLT04', N'Tamanique', N'LLT')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LLT05', N'Teotepeque', N'LLT')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC01', N'El Rosario', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC02', N'Jerusalén', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC03', N'Mercedes La Ceiba', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC04', N'Paraíso de Osorio', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC05', N'San Antonio Masahuat', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC06', N'San Emigdio', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC07', N'San Juan Tepezontes', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC08', N'San Luís La Herradura', N'LPC')
GO
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC09', N'San Miguel Tepezontes', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC10', N'San Pedro Nonualco', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC11', N'Santa María Ostuma', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPC12', N'Santiago Nonualco', N'LPC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPE01', N'San Juan Nonualco', N'LPE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPE02', N'San Rafael Obrajuelo', N'LPE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPE03', N'Zacatecoluca', N'LPE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO01', N'Cuyultitan', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO02', N'Olocuilta', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO03', N'San Juan Talpa', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO04', N'San Luis Talpa', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO05', N'San Pedro Masahuat', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO06', N'Tapalhuaca', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LPO07', N'San Francisco Chinameca', N'LPO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN01', N'Anamorós', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN02', N'Bolivar', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN03', N'Concepción de Oriente', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN04', N'El Sauce', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN05', N'Lislique', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN06', N'Nueva Esparta', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN07', N'Pasaquina', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN08', N'Polorós', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN09', N'San José La Fuente', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUN10', N'Santa Rosa de Lima', N'LUN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS01', N'Conchagua', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS02', N'El Carmen', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS03', N'Intipucá', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS04', N'La Unión', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS05', N'Meanguera del Golfo', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS06', N'San Alejo', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS07', N'Yayantique', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'LUS08', N'Yucuaiquín', N'LUS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON01', N'Arambala', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON02', N'Cacaopera', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON03', N'Corinto', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON04', N'El Rosario', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON05', N'Joateca', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON06', N'Jocoaitique', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON07', N'Meanguera', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON08', N'Perquín', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON09', N'San Fernando', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON10', N'San Isidro', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MON11', N'Torola', N'MON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS01', N'Chilanga', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS02', N'Delicias de Concepción', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS03', N'El Divisadero', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS04', N'Gualococti', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS05', N'Guatajiagua', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS06', N'Jocoro', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS07', N'Lolotiquillo', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS08', N'Osicala', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS09', N'San Carlos', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS10', N'San Francisco Gotera', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS11', N'San Simón', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS12', N'Sensembra', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS13', N'Sociedad', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS14', N'Yamabal', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'MOS15', N'Yoloaiquín', N'MOS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAC01', N'Santa Ana', N'SAC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAE01', N'Coatepeque', N'SAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAE02', N'El Congo', N'SAE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAN01', N'Masahuat', N'SAN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAN02', N'Metapán', N'SAN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAN03', N'Santa Rosa Guachipilín', N'SAN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAN04', N'Texistepeque', N'SAN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO01', N'Candelaria de la Frontera', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO02', N'Chalchuapa', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO03', N'El Porvenir', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO04', N'San Antonio Pajonal', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO05', N'San Sebastián Salitrillo', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SAO06', N'Santiago de La Frontera', N'SAO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC01', N'San Miguel', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC02', N'Comacarán', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC03', N'Uluazapa', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC04', N'Moncagua', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC05', N'Quelepa', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMC06', N'Chirilagua', N'SMC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN01', N'Ciudad Barrios', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN02', N'Sesori', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN03', N'Nuevo Edén de San Juan', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN04', N'San Gerardo', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN05', N'San Luis de La Reina', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN06', N'Carolina', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN07', N'San Antonio del Mosco', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMN08', N'Chapeltique', N'SMN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO01', N'Chinameca', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO02', N'Nueva Guadalupe', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO03', N'Lolotique', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO04', N'San Jorge', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO05', N'San Rafael Oriente', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SMO06', N'El Tránsito', N'SMO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOC01', N'Sonsonate', N'SOC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOC02', N'Sonzacate', N'SOC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOC03', N'Nahulingo', N'SOC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOC04', N'San Antonio del Monte', N'SOC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOC05', N'Santo Domingo de Guzmán', N'SOC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE01', N'Izalco', N'SOE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE02', N'Armenia', N'SOE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE03', N'Caluco', N'SOE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE04', N'San Julián', N'SOE')
GO
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE05', N'Cuisnahuat', N'SOE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOE06', N'Santa Isabel Ishuatán', N'SOE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SON01', N'Juayúa', N'SON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SON02', N'Nahuizalco', N'SON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SON03', N'Salcoatitán', N'SON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SON04', N'Santa Catarina Masahuat', N'SON')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SOO01', N'Acajutla', N'SOO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSC01', N'Ayutuxtepeque', N'SSC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSC02', N'Mejicanos', N'SSC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSC03', N'San Salvador', N'SSC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSC04', N'Cuscatancingo', N'SSC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSC05', N'Ciudad Delgado', N'SSC')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSE01', N'Ilopango', N'SSE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSE02', N'San Martín', N'SSE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSE03', N'Soyapango', N'SSE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSE04', N'Tonacatepeque', N'SSE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSN01', N'Aguilares', N'SSN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSN02', N'El Paisnal', N'SSN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSN03', N'Guazapa', N'SSN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSO01', N'Apopa', N'SSO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSO02', N'Nejapa', N'SSO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSS01', N'Panchimalco', N'SSS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSS02', N'Rosario de Mora', N'SSS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSS03', N'San Marcos', N'SSS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSS04', N'Santo Tomás', N'SSS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SSS05', N'Santiago Texacuangos', N'SSS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN01', N'Apastepeque', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN02', N'Santa Clara', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN03', N'San Ildefonso', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN04', N'San Esteban Catarina', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN05', N'San Sebastián', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN06', N'San Lorenzo', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVN07', N'Santo Domingo', N'SVN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS01', N'San Vicente', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS02', N'Guadalupe', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS03', N'Verapaz', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS04', N'Tepetitán', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS05', N'Tecoluca', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'SVS06', N'San Cayetano Istepeque', N'SVS')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE01', N'Usulután', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE02', N'Jucuarán', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE03', N'San Dionisio', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE04', N'Concepción Batres', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE05', N'Santa María', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE06', N'Ozatlán', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE07', N'Tecapán', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE08', N'Santa Elena', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE09', N'California', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USE10', N'Ereguayquín', N'USE')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN01', N'Santiago de María', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN02', N'Alegría', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN03', N'Berlín', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN04', N'Mercedes Umaña', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN05', N'Jucuapa', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN06', N'El triunfo', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN07', N'Estanzuelas', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN08', N'San Buenaventura', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USN09', N'Nueva Granada', N'USN')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USO01', N'Jiquilisco', N'USO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USO02', N'Puerto El Triunfo', N'USO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USO03', N'San Agustín', N'USO')
INSERT [clinica].[distritos] ([idDistrito], [distrito], [idMunicipio]) VALUES (N'USO04', N'San Francisco Javier', N'USO')
GO
SET IDENTITY_INSERT [clinica].[doctores] ON 

INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (1, 1, 1234567, 1)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (2, 3, 2345678, 2)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (3, 6, 3456789, 3)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (4, 15, 6674358, 4)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (5, 16, 1541239, 5)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (6, 17, 8793451, 10)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (7, 18, 1237891, 7)
INSERT [clinica].[doctores] ([idDoctor], [idEmpleado], [JVPM], [idEspecialidad]) VALUES (8, 19, 3450989, 9)
SET IDENTITY_INSERT [clinica].[doctores] OFF
GO
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (1, 1)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (2, 2)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (3, 3)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (4, 4)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (5, 5)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (7, 7)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (8, 9)
INSERT [clinica].[doctorespecialidades] ([idDoctor], [idEspecialidad]) VALUES (6, 10)
GO
SET IDENTITY_INSERT [clinica].[empleados] ON 

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo])
VALUES (1, N'Juan Carlos', N'Rodas Gonzalez', N'juancarlos@email.com', N'6532-4526', N'1995-01-01', N'1985-05-15', N'12345678-0', 1, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo])
VALUES (2, N'Carlos José', N'Martínez López', N'carlos@email.com', N'9632-7412', N'1993-04-15', N'1990-08-22', N'23456789-0', 2, 2);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo])
VALUES (3, N'Pedro Manuel', N'Orellana Mendez', N'juanmanuel@email.com', N'1478-8523', N'1985-06-20', N'1982-11-30', N'12345678-9', 3, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo])
VALUES (4, N'Diego Francisco', N'Sanchez Castro', N'diegofrancisco@email.com', N'7895-5698', N'1990-02-02', N'1988-12-05', N'13456524-1', 4, 5);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo])
VALUES (5, N'Raul Edgardo', N'Del Valle Garcia', N'rauledgardo@email.com', N'6598-2548', N'1980-03-03', N'1977-09-20', N'19624716-2', 5, 3);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (6, N'Mary Carmen', N'Perez de Hernandez', N'marycarmen@email.com', N'7965-2526', N'1985-04-04', N'1982-09-15', N'67825193-3', 6, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (7, N'María Fernanda', N'Gómez Martínez', N'mariafernanda@email.com', N'3698-1478', N'1991-12-10', N'1990-05-10', N'98765432-1', 8, 8);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (8, N'Ana Gabriela', N'Pérez Rodríguez', N'anagabriela@email.com', N'6112-5421', N'1994-08-05', N'1992-11-25', N'87654321-0', 9, 6);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (9, N'Diego Alex', N'Castillo Pérez', N'alexperez12@email.com', N'6576-7728', N'1989-10-13', N'1984-04-12', N'05553329-6', 10, 7);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (10, N'Angela Maria', N'Escobar Torres', N'escobarAmaria@email.com', N'7576-3428', N'1996-02-01', N'1990-03-29', N'04213589-5', 7, 7);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (11, N'Vivian Aurora', N'Gildan Perez', N'vagp@email.com', N'8790-0005', N'2000-03-24', N'1990-11-11', N'67842234-9', 9, 11);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (12, N'Lilian Diana', N'Smith Contreras', N'ldsc@email.com', N'4565-7780', N'1990-12-24', N'1980-07-01', N'44456756-2', 12, 8);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (13, N'Liam Chris', N'Doe Stevens', N'lchds@email.com', N'6766-4500', N'1997-06-06', N'1994-02-14', N'55678898-4', 13, 9);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (14, N'Susan Margaret', N'Valdez', N'smv@email.com', N'7884-3256', N'2000-08-11', N'1992-09-19', N'33334576-1', 14, 10);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (15, N'Jaimie Jimmy', N'Dutton', N'jj2d@email.com', N'6892-2367', N'1989-10-23', N'1987-03-04', N'55569823-5', 15, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (16, N'Scott Jona', N'Miller Brown', N'sjmb@email.com', N'7776-9012', N'1984-11-01', N'1981-12-30', N'88772213-0', 16, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (17, N'Mitch Dave', N'Planko Lockwood', N'mdpl@email.com', N'6565-2333', N'1990-07-28', N'1986-09-05', N'99917231-8', 17, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (18, N'Logan Hugh', N'Acosta', N'lha@email.com', N'8823-4512', N'1996-02-29', N'1990-08-10', N'89885643-3', 18, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (19, N'Amanda Stacy', N'Barnes McKay', N'asbm@email.com', N'6534-7612', N'1991-09-21', N'1987-03-18', N'99888121-4', 19, 1);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (20, N'Mathew Alexander', N'Rojas Dunn', N'mard@email.com', N'4323-3498', N'1995-07-27', N'1990-05-16', N'88881234-4', 20, 11);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (21, N'Juliet Margaret', N'Lewis Price', N'jmlp@email.com', N'9809-2322', N'1980-05-05', N'1983-07-25', N'00991234-1', 21, 4);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (22, N'Katherine Johana', N'Fuentes Duarte', N'kjfd@email.com', N'3000-1234', N'1991-01-11', N'1990-04-01', N'78978911-1', 22, 12);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (23, N'Laura Elena', N'Garcia Fuentes', N'lauragf@email.com', N'2873-5561', N'1998-03-30', N'1991-12-05', N'11122323-1', 23, 13);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (24, N'Carlos Antonio', N'Torres Hernández', N'catorres@email.com', N'7456-8903', N'1982-05-15', N'1980-11-05', N'67890123-4', 24, 5);

INSERT [clinica].[empleados] ([idEmpleado], [nombreEmpleado], [apellidoEmpleado], [emailEmpleado], [telefonoEmpleado], [fechaContratacion], [fechaNacimiento], [duiEmpleado], [idDireccion], [idTipoCargo]) 
VALUES (25, N'José Manuel', N'Gutiérrez Rivas', N'josemanuel@email.com', N'5678-9032', N'1988-11-22', N'1983-02-17', N'22334455-6', 25, 4);


SET IDENTITY_INSERT [clinica].[empleados] OFF
GO
SET IDENTITY_INSERT [clinica].[enfermeros] ON 

INSERT [clinica].[enfermeros] ([idEnfermero], [idEmpleado], [JVPE]) VALUES (1, 9, 123456)
INSERT [clinica].[enfermeros] ([idEnfermero], [idEmpleado], [JVPE]) VALUES (2, 10, 234567)
INSERT [clinica].[enfermeros] ([idEnfermero], [idEmpleado], [JVPE]) VALUES (3, 23, 112123)
SET IDENTITY_INSERT [clinica].[enfermeros] OFF
GO
SET IDENTITY_INSERT [clinica].[equiposmedicos] ON 

INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (1, N'Tomógrafo 3D', N'XYZ Medical', CAST(N'2024-01-15' AS Date), 1, 1, 1, 1)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (2, N'Resonancia Magnética', N'ABC Healthcare', CAST(N'2023-09-20' AS Date), 2, 2, 2, 1)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (3, N'Ecógrafo Portátil', N'MedTech Inc.', CAST(N'2024-03-05' AS Date), 3, 3, 3, 5)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (4, N'Monitor de Signos Vitales', N'VitalTech', CAST(N'2023-11-10' AS Date), 4, 4, 4, 15)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (5, N'Desfibrilador Automático', N'Rescue Medical', CAST(N'2024-02-28' AS Date), 5, 5, 5, 10)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (6, N'Equipo de Rayos X', N'Marca X', CAST(N'2022-01-15' AS Date), 1, 1, 1, 3)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (7, N'Desfibrilador', N'Marca Z', CAST(N'2022-03-25' AS Date), 3, 3, 3, 2)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (8, N'Ecógrafo', N'Marca B', CAST(N'2022-05-10' AS Date), 5, 5, 5, 4)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (9, N'Tomógrafo', N'Marca C', CAST(N'2022-06-15' AS Date), 6, 6, 6, 2)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (10, N'Ventilador Mecánico', N'Marca E', CAST(N'2022-08-25' AS Date), 8, 8, 8, 3)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (11, N'Electrocardiograma', N'Marca F', CAST(N'2022-09-30' AS Date), 9, 9, 9, 2)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (12, N'Máquina de Anestesia', N'Marca G', CAST(N'2022-10-15' AS Date), 10, 10, 10, 1)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (13, N'Equipo de Rayos X', N'Marca H', CAST(N'2022-11-20' AS Date), 1, 1, 11, 4)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (14, N'Monitor de Signos Vitales', N'Marca I', CAST(N'2022-12-25' AS Date), 2, 2, 12, 5)
INSERT [clinica].[equiposmedicos] ([idEquipoMedico], [nombreEquipo], [marcaEquipo], [fechaAdquision], [idTipoEquipoMedico], [idProveedor], [idInventario], [cantidad]) VALUES (15, N'Endoscopio', N'Marca K', CAST(N'2023-02-15' AS Date), 4, 4, 14, 1)
SET IDENTITY_INSERT [clinica].[equiposmedicos] OFF
GO
SET IDENTITY_INSERT [clinica].[especialidades] ON 

INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (1, N'Medicina Interna')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (2, N'Cirugía General')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (3, N'Pediatría')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (4, N'Obstetricia y Ginecología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (5, N'Cardiología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (6, N'Neurología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (7, N'Dermatología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (8, N'Psiquiatría')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (9, N'Oftalmología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (10, N'Otorrinolaringología')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (11, N'Analista de Laboratorio Clínico')
INSERT [clinica].[especialidades] ([idEspecialidad], [nombreEspecialidad]) VALUES (12, N'Analista de Laboratorio Forense')
SET IDENTITY_INSERT [clinica].[especialidades] OFF
GO
INSERT [clinica].[especialidadeslaboratorista] ([idLaboratorista], [idEspecialidad]) VALUES (1, 11)
INSERT [clinica].[especialidadeslaboratorista] ([idLaboratorista], [idEspecialidad]) VALUES (2, 11)
INSERT [clinica].[especialidadeslaboratorista] ([idLaboratorista], [idEspecialidad]) VALUES (3, 12)
GO
SET IDENTITY_INSERT [clinica].[examenes] ON 

INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (1, CAST(N'2024-04-10T09:00:00.0000000' AS DateTime2), N'Sangre', N'ml', 1, 1, 1)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (2, CAST(N'2024-04-11T10:30:00.0000000' AS DateTime2), N'Orina', N'ml', 2, 1, 2)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (3, CAST(N'2024-04-12T11:45:00.0000000' AS DateTime2), N'Tejido', N'mg', 3, 1, 3)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (4, CAST(N'2024-04-13T13:00:00.0000000' AS DateTime2), N'Líquido cefalorraquídeo', N'ml', 4, 1, 4)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (5, CAST(N'2024-04-14T14:15:00.0000000' AS DateTime2), N'Heces', N'g', 5, 3, 5)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (6, CAST(N'2024-04-27T16:30:00.0000000' AS DateTime2), N'Sangre', N'ml', 6, 3, 6)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (7, CAST(N'2024-04-28T08:00:00.0000000' AS DateTime2), N'Orina', N'ml', 7, 2, 7)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (8, CAST(N'2024-04-28T09:45:00.0000000' AS DateTime2), N'Tejido', N'mg', 8, 2, 8)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (9, CAST(N'2024-04-29T10:30:00.0000000' AS DateTime2), N'Orina', N'ml', 9, 2, 9)
INSERT [clinica].[examenes] ([idExamen], [fechaHoraExamen], [muestraBiologica], [unidadMedida], [idTipoExamen], [idLaboratorista], [idCita]) VALUES (10, CAST(N'2024-04-29T12:15:00.0000000' AS DateTime2), N'Sangre', N'ml', 10, 3, 10)
SET IDENTITY_INSERT [clinica].[examenes] OFF
GO
SET IDENTITY_INSERT [clinica].[examenesfisicos] ON 

INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (1, N'75 bpm', N'120/80 mmHg', N'37.2°C', N'Normal', N'Alerta', N'Sin anormalidades', N'Sin anormalidades', N'Normal', N'Suave', N'Normal', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (2, N'80 bpm', N'130/85 mmHg', N'36.9°C', N'Normal', N'Tranquilo', N'Sin anormalidades', N'Sin anormalidades', N'Normal', N'Suave', N'Normal', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (3, N'72 bpm', N'118/78 mmHg', N'37.0°C', N'Normal', N'Alerta', N'Sin anormalidades', N'Sin anormalidades', N'Normal', N'Suave', N'Normal', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (4, N'78 bpm', N'122/82 mmHg', N'37.1°C', N'Normal', N'Tranquilo', N'Sin anormalidades', N'Sin anormalidades', N'Normal', N'Suave', N'Normal', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (5, N'85 bpm', N'126/80 mmHg', N'36.8°C', N'Normal', N'Alerta', N'Sin anormalidades', N'Sin anormalidades', N'Normal', N'Suave', N'Normal', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (6, N'80 bpm', N'120/80 mmHg', N'37.5°C', N'Normal', N'Normal', N'Sin alteraciones', N'Audición normal', N'Cabeza simétrica', N'Sin distensión abdominal', N'Sin edema en extremidades', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (7, N'88 bpm', N'120/80 mmHg', N'37.3°C', N'Normal', N'Tranquilo', N'Pupilas normales y reactivas', N'Audición normal', N'Cabeza simétrica', N'Ruidos intestinales presentes', N'Sin edema en extremidades', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (8, N'82 bpm', N'130/85 mmHg', N'36.9°C', N'Normal', N'Inquieto', N'Pupilas isocóricas y reactivas', N'Audición normal', N'Cabeza simétrica', N'Sin dolor a la palpación', N'Sin edema en extremidades', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (9, N'90 bpm', N'125/80 mmHg', N'37.1°C', N'Normal', N'Activo', N'Pupilas normales y reactivas', N'Audición normal', N'Cabeza simétrica', N'Ruidos intestinales presentes', N'Sin edema en extremidades', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (10, N'95 bpm', N'115/75 mmHg', N'36.7°C', N'Normal', N'Tranquilo', N'Pupilas iguales y reactivas', N'Audición normal', N'Cabeza simétrica', N'Sin distensión abdominal', N'Sin edema en extremidades', N'Normal')
INSERT [clinica].[examenesfisicos] ([idExamenFisico], [pulso], [presionArterial], [temperatura], [estadoPiel], [comportamiento], [inspeccionOjos], [inspeccionOidos], [inspeccionCabeza], [inspeccionAbdomen], [inspeccionExtremidades], [funcionSensorial]) VALUES (11, N'80 bpm', N'120/80 mmHg', N'37.0°C', N'Normal', N'Inquieto', N'Sin alteraciones', N'Audición normal', N'Cabeza simétrica', N'Sin dolor a la palpación', N'Sin edema en extremidades', N'Normal')
SET IDENTITY_INSERT [clinica].[examenesfisicos] OFF
GO
SET IDENTITY_INSERT [clinica].[expediente] ON 

INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (1, 1, N'Hipertensión arterial', N'Ninguna', N'Losartán 50mg diario', N'N/A', 1)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (2, 2, N'Diabetes tipo 2', N'Penicilina', N'Metformina 1000mg diario', N'N/A', 2)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (3, 3, N'Asma', N'Aspirina', N'Salbutamol inhalador según necesidad', N'N/A', 3)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (4, 4, N'Sin padecimientos conocidos', N'Ninguna', N'N/A', N'N/A', 4)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (5, 5, N'Dolor de espalda crónico', N'Ninguna', N'Fisioterapia', N'N/A', 5)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (6, 6, N'Fractura de brazo', N'Ninguna', N'Férula y reposo', N'Revisión mensual de la evolución', 6)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (7, 7, N'Dolor crónico de espalda', N'Ninguna', N'Terapia física', N'Ejercicios recomendados para mejorar la postura', 7)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (8, 8, N'Lesión en la rodilla', N'Ninguna', N'Rehabilitación', N'Evitar actividades de alto impacto', 8)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (9, 9, N'Gastritis', N'Ninguna', N'Antiácidos y dieta', N'Evitar comidas muy condimentadas', 9)
INSERT [clinica].[expediente] ([idExpediente], [idReceta], [padecimiento], [alergia], [tratamiento], [notaAdicional], [idPaciente]) VALUES (10, 10, N'Intoxicación alimentaria', N'Alimentos contaminados', N'Hidratación y dieta suave', N'Reposo y evitar alimentos no cocidos', 10)
SET IDENTITY_INSERT [clinica].[expediente] OFF
GO
SET IDENTITY_INSERT [clinica].[facturasconsultas] ON 

INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (1, 1, 1, CAST(N'2024-04-01' AS Date), CAST(5.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (2, 2, 2, CAST(N'2024-04-02' AS Date), CAST(15.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (3, 3, 3, CAST(N'2024-04-03' AS Date), CAST(8.00 AS Decimal(6, 2)), 2)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (4, 4, 4, CAST(N'2024-04-04' AS Date), CAST(100.00 AS Decimal(6, 2)), 4)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (5, 5, 5, CAST(N'2024-04-05' AS Date), CAST(20.00 AS Decimal(6, 2)), 5)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (6, 6, 6, CAST(N'2024-04-06' AS Date), CAST(300.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (7, 7, 7, CAST(N'2024-04-07' AS Date), CAST(175.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (8, 8, 8, CAST(N'2024-04-08' AS Date), CAST(190.00 AS Decimal(6, 2)), 3)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (9, 9, 9, CAST(N'2024-04-09' AS Date), CAST(210.00 AS Decimal(6, 2)), 3)
INSERT [clinica].[facturasconsultas] ([idFacturaConsulta], [idConsulta], [idPaciente], [fecha], [total], [idTipoPago]) VALUES (10, 10, 10, CAST(N'2024-04-10' AS Date), CAST(220.00 AS Decimal(6, 2)), 6)
SET IDENTITY_INSERT [clinica].[facturasconsultas] OFF
GO
SET IDENTITY_INSERT [clinica].[facturasexamenes] ON 

INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (1, 1, CAST(N'2024-04-01T08:30:00.0000000' AS DateTime2), CAST(5.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (2, 2, CAST(N'2024-04-02T09:45:00.0000000' AS DateTime2), CAST(15.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (3, 3, CAST(N'2024-04-03T10:15:00.0000000' AS DateTime2), CAST(8.00 AS Decimal(6, 2)), 2)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (4, 4, CAST(N'2024-04-04T11:20:00.0000000' AS DateTime2), CAST(100.00 AS Decimal(6, 2)), 2)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (5, 5, CAST(N'2024-04-05T12:00:00.0000000' AS DateTime2), CAST(20.00 AS Decimal(6, 2)), 3)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (6, 6, CAST(N'2024-04-06T13:00:00.0000000' AS DateTime2), CAST(90.00 AS Decimal(6, 2)), 5)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (7, 7, CAST(N'2024-04-07T14:00:00.0000000' AS DateTime2), CAST(110.00 AS Decimal(6, 2)), 6)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (8, 8, CAST(N'2024-04-08T15:00:00.0000000' AS DateTime2), CAST(130.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (9, 9, CAST(N'2024-04-09T16:00:00.0000000' AS DateTime2), CAST(180.00 AS Decimal(6, 2)), 2)
INSERT [clinica].[facturasexamenes] ([idFacturaExamen], [idPaciente], [fechaFE], [totalFE], [idTipoPago]) VALUES (10, 10, CAST(N'2024-04-10T17:00:00.0000000' AS DateTime2), CAST(160.00 AS Decimal(6, 2)), 3)
SET IDENTITY_INSERT [clinica].[facturasexamenes] OFF
GO
SET IDENTITY_INSERT [clinica].[facturasprocedimientos] ON 

INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (1, 1, CAST(N'2024-04-01T08:30:00.0000000' AS DateTime2), CAST(5.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (2, 2, CAST(N'2024-04-02T09:45:00.0000000' AS DateTime2), CAST(15.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (3, 3, CAST(N'2024-04-03T10:15:00.0000000' AS DateTime2), CAST(8.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (4, 4, CAST(N'2024-04-04T11:20:00.0000000' AS DateTime2), CAST(100.00 AS Decimal(6, 2)), 2)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (5, 5, CAST(N'2024-04-05T12:00:00.0000000' AS DateTime2), CAST(20.00 AS Decimal(6, 2)), 3)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (6, 6, CAST(N'2024-04-06T13:00:00.0000000' AS DateTime2), CAST(550.00 AS Decimal(6, 2)), 3)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (7, 7, CAST(N'2024-04-07T14:00:00.0000000' AS DateTime2), CAST(400.00 AS Decimal(6, 2)), 6)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (8, 8, CAST(N'2024-04-08T15:00:00.0000000' AS DateTime2), CAST(900.00 AS Decimal(6, 2)), 1)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (9, 9, CAST(N'2024-04-09T16:00:00.0000000' AS DateTime2), CAST(750.00 AS Decimal(6, 2)), 4)
INSERT [clinica].[facturasprocedimientos] ([idFacturaProcedimiento], [idPaciente], [fechaFP], [totalFP], [idTipoPago]) VALUES (10, 10, CAST(N'2024-04-10T17:00:00.0000000' AS DateTime2), CAST(650.00 AS Decimal(6, 2)), 2)
SET IDENTITY_INSERT [clinica].[facturasprocedimientos] OFF
GO
SET IDENTITY_INSERT [clinica].[insumosmedicos] ON 

INSERT [clinica].[insumosmedicos] ([idInsumoMedico], [idMedicamento], [idEquipoMedico], [idProcedimiento]) VALUES (1, 1, 1, 1)
INSERT [clinica].[insumosmedicos] ([idInsumoMedico], [idMedicamento], [idEquipoMedico], [idProcedimiento]) VALUES (2, 2, 2, 2)
INSERT [clinica].[insumosmedicos] ([idInsumoMedico], [idMedicamento], [idEquipoMedico], [idProcedimiento]) VALUES (3, 3, 3, 3)
INSERT [clinica].[insumosmedicos] ([idInsumoMedico], [idMedicamento], [idEquipoMedico], [idProcedimiento]) VALUES (4, 4, 4, 4)
INSERT [clinica].[insumosmedicos] ([idInsumoMedico], [idMedicamento], [idEquipoMedico], [idProcedimiento]) VALUES (5, 5, 5, 5)
SET IDENTITY_INSERT [clinica].[insumosmedicos] OFF
GO
SET IDENTITY_INSERT [clinica].[inventario] ON 

INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (1, N'Bodega Principal', N'Sección A', N'Pasillo 1', N'Estante 1')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (2, N'Bodega Secundaria', N'Sección B', N'Pasillo 2', N'Estante 2')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (3, N'Bodega de Almacenamiento', N'Sección C', N'Pasillo 3', N'Estante 3')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (4, N'Bodega de Suministros', N'Sección D', N'Pasillo 4', N'Estante 4')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (5, N'Bodega de Emergencia', N'Sección E', N'Pasillo 5', N'Estante 5')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (6, N'Bodega Principal', N'Sección F', N'Pasillo 6', N'Estante 6')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (7, N'Bodega Secundaria', N'Sección G', N'Pasillo 7', N'Estante 7')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (8, N'Bodega de Almacenamiento', N'Sección H', N'Pasillo 8', N'Estante 8')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (9, N'Bodega de Suministros', N'Sección I', N'Pasillo 9', N'Estante 9')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (10, N'Bodega de Emergencia', N'Sección J', N'Pasillo 10', N'Estante 10')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (11, N'Bodega Principal', N'Sección K', N'Pasillo 11', N'Estante 11')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (12, N'Bodega Secundaria', N'Sección L', N'Pasillo 12', N'Estante 12')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (13, N'Bodega de Almacenamiento', N'Sección M', N'Pasillo 13', N'Estante 13')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (14, N'Bodega de Suministros', N'Sección N', N'Pasillo 14', N'Estante 14')
INSERT [clinica].[inventario] ([idInventario], [bodega], [seccion], [pasillo], [estante]) VALUES (15, N'Bodega de Emergencia', N'Sección O', N'Pasillo 15', N'Estante 15')
SET IDENTITY_INSERT [clinica].[inventario] OFF
GO
SET IDENTITY_INSERT [clinica].[laboratorios] ON 

INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (1, N'LabMedic')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (2, N'LabAnalítica')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (3, N'LabGenético')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (4, N'LabBiomed')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (5, N'LabMicrobio')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (6, N'LabBioquímica')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (7, N'LabImágenes')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (8, N'LabSaludTotal')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (9, N'LabVitalis')
INSERT [clinica].[laboratorios] ([idLaboratorio], [nombreLaboratorio]) VALUES (10, N'LabDiagnósticoMédico')
SET IDENTITY_INSERT [clinica].[laboratorios] OFF
GO
SET IDENTITY_INSERT [clinica].[laboratorista] ON 

INSERT [clinica].[laboratorista] ([idLaboratorista], [idEmpleado], [JVPLC]) VALUES (1, 7, 123456)
INSERT [clinica].[laboratorista] ([idLaboratorista], [idEmpleado], [JVPLC]) VALUES (2, 12, 12345)
INSERT [clinica].[laboratorista] ([idLaboratorista], [idEmpleado], [JVPLC]) VALUES (3, 24, 123889)
SET IDENTITY_INSERT [clinica].[laboratorista] OFF
GO
SET IDENTITY_INSERT [clinica].[medicamentos] ON 

INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (1, N'Paracetamol', N'Paracetamol', 1, 1)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (2, N'Amoxicilina', N'Amoxicilina', 2, 1)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (3, N'Ibuprofeno', N'Ibuprofeno', 3, 2)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (4, N'Acetaminofén', N'Acetaminofén', 4, 4)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (5, N'Omeprazol', N'Omeprazol', 1, 3)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (6, N'Diazepam', N'Diazepam', 3, 6)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (7, N'Aspirina', N'Ácido acetilsalicílico', 1, 7)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (8, N'Atorvastatina', N'Atorvastatina', 2, 8)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (9, N'Metformina', N'Metformina', 3, 9)
INSERT [clinica].[medicamentos] ([idMedicamento], [nombreMedicamento], [formulaActiva], [idTipoMedicamento], [idLaboratorio]) VALUES (10, N'Ciprofloxacino', N'Ciprofloxacino', 2, 10)
SET IDENTITY_INSERT [clinica].[medicamentos] OFF
GO
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (1, 1, N'Tomar 1 tableta cada 8 horas con alimentos')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (2, 2, N'Tomar 1 cápsula cada 12 horas con agua')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (3, 3, N'Aplicar una capa delgada sobre la piel afectada cada noche')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (4, 4, N'Tomar 2 tabletas cada 6 horas después de las comidas')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (5, 5, N'Tomar 1 tableta al día antes de dormir')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (6, 6, N'500mg cada 8 horas')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (7, 7, N'200mg cada 12 horas')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (8, 8, N'500mg cada 6 horas')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (9, 9, N'10mg una vez al día')
INSERT [clinica].[medicamentosrecetados] ([idMedicamento], [idReceta], [dosis]) VALUES (10, 10, N'20mg una vez al día')
GO
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'AHC', N'Ahuachapán Centro', N'AH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'AHN', N'Ahuachapán Norte', N'AH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'AHS', N'Ahuachapán Sur', N'AH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CAE', N'Cabañas Este', N'CA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CAO', N'Cabañas Oeste', N'CA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CHC', N'Chalatenango Centro', N'CH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CHN', N'Chalatenango Norte', N'CH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CHS', N'Chalatenango Sur', N'CH')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CUN', N'Cuscatlán Norte', N'CU')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'CUS', N'Cuscatlán Sur', N'CU')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLC', N'La Libertad Centro', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLE', N'La Libertad Este', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLN', N'La Libertad Norte', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLO', N'La Libertad Oeste', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLS', N'La Libertad Sur', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LLT', N'La Libertad Costa', N'LL')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LPC', N'La Paz Centro', N'LP')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LPE', N'La Paz Este', N'LP')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LPO', N'La Paz Oeste', N'LP')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LUN', N'La Unión Norte', N'LU')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'LUS', N'La Unión Sur', N'LU')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'MON', N'Morazán Norte', N'MO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'MOS', N'Morazán Sur', N'MO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SAC', N'Santa Ana Centro', N'SA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SAE', N'Santa Ana Este', N'SA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SAN', N'Santa Ana Norte', N'SA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SAO', N'Santa Ana Oeste', N'SA')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SMC', N'San Miguel Centro', N'SM')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SMN', N'San Miguel Norte', N'SM')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SMO', N'San Miguel Oeste', N'SM')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SOC', N'Sonsonate Centro', N'SO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SOE', N'Sonsonate Este', N'SO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SON', N'Sonsonate Norte', N'SO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SOO', N'Sonsonate Oeste', N'SO')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SSC', N'San Salvador Centro', N'SS')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SSE', N'San Salvador Este', N'SS')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SSN', N'San Salvador Norte', N'SS')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SSO', N'San Salvador Oeste', N'SS')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SSS', N'San Salvador Sur', N'SS')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SVN', N'San Vicente Norte', N'SV')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'SVS', N'San Vicente Sur', N'SV')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'USE', N'Usulután Este', N'US')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'USN', N'Usulután Norte', N'US')
INSERT [clinica].[municipios] ([idMunicipio], [municipio], [idDepartamento]) VALUES (N'USO', N'Usulután Oeste', N'US')
GO
SET IDENTITY_INSERT [clinica].[opciones] ON 

INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (1, N'Gestionar departamentos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (2, N'Gestionar municipios')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (3, N'Gestionar distritos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (4, N'Gestionar direcciones')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (5, N'Gestionar pacientes')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (6, N'Gestionar cargos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (7, N'Gestionar empleados')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (8, N'Gestionar roles')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (9, N'Gestionar opciones')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (10, N'Gestionar asignacionRolesOpciones')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (11, N'Gestionar usuarios')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (12, N'Gestionar doctores')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (13, N'Gestionar especialidades')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (14, N'Gestionar tiposCitas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (15, N'Gestionar citas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (16, N'Gestionar consultorios')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (17, N'Gestionar tiposConsultas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (18, N'Gestionar examenesFisicos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (19, N'Gestionar recetas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (20, N'Gestionar expediente')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (21, N'Gestionar consultas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (22, N'Gestionar tiposProcedimientos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (23, N'Gestionar procedimientosMedicos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (24, N'Gestionar doctorEspecialidades')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (25, N'Gestionar laboratorista')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (26, N'Gestionar especialidadesLaboratorista')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (27, N'Gestionar tiposExamenes')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (28, N'Gestionar examenes')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (29, N'Gestionar tiposMedicamentos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (30, N'Gestionar laboratorios')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (31, N'Gestionar medicamentos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (32, N'Gestionar tiposEquiposMedicos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (33, N'Gestionar proveedores')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (34, N'Gestionar inventario')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (35, N'Gestionar equiposMedicos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (36, N'Gestionar medicamentosRecetados')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (37, N'Gestionar enfermeros')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (38, N'Gestionar personalProcedimientos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (39, N'Gestionar tiposPago')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (40, N'Gestionar facturasConsultas')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (41, N'Gestionar facturasExamenes')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (42, N'Gestionar facturasProcedimientos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (43, N'Gestionar detallesFacturasExamenes')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (44, N'Gestionar detallesFacturasProcedimientos')
INSERT [clinica].[opciones] ([idOpcion], [opcion]) VALUES (45, N'Gestionar insumosMedicos')
SET IDENTITY_INSERT [clinica].[opciones] OFF
GO
SET IDENTITY_INSERT [clinica].[pacientes] ON 

INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (1, N'María José', N'García Pérez', N'Femenino', N'1990-01-01', N'Mariajose.garcia@email.com', N'16234857-3', N'Abogada', N'Soltera', 26)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (2, N'Juan Carlos', N'Martínez López', N'Masculino', N'1985-05-15', N'juancarlos.martinez@email.com', N'12345678-9', N'Ingeniero', N'Casado', 27)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (3, N'Ana María', N'González Ramírez', N'Femenino', N'1988-09-23', N'anamaria.gr@email.com', N'87654321-0', N'Doctora', N'Casada', 28)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (4, N'Dolores Antonia', N'Santos Santos', N'Femenino', N'1993-11-04', N'doloresSS@email.com', N'02342232-1', N'Piloto', N'Soltera', 29)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (5, N'Pedro Antonio', N'Fernández Díaz', N'Masculino', N'1983-06-07', N'pedrofd@email.com', N'98765432-0', N'Arquitecto', N'Soltero', 30)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (6, N'Marta Nancy', N'Fernandez Duran', N'Femenino', N'1990-03-30', N'2mFD@email.com', N'68565535-1', N'Contador', N'Casada', 31)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (7, N'Henry Moises', N'Quan Cruise', N'Masculino', N'2001-01-01', N'hmqc@email.com', N'09834562-0', N'Atleta', N'Casado', 32)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (8, N'Cedric Benjamin', N'Walsh Bonn', N'Masculino', N'1992-04-01', N'cbwb@email.com', N'23459876-3', N'Profesor', N'Soltero', 33)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (9, N'Alice Milly', N'Cooper White', N'Femenino', N'1999-01-30', N'amcw@email.com', N'66775444-7', N'Policia', N'Soltera', 34)
INSERT [clinica].[pacientes] ([idPaciente], [nombrePaciente], [apellidoPaciente], [generoPaciente], [fechaNacPaciente], [emailPaciente], [duiPaciente], [ocupacionPaciente], [estadoCivil], [idDireccion]) VALUES (10, N'Bob Joshua', N'Lasso', N'Masculino', N'1993-08-14', N'bjl@email.com', N'92111672-3', N'Biologo', N'Casado', 35)
SET IDENTITY_INSERT [clinica].[pacientes] OFF
GO
SET IDENTITY_INSERT [clinica].[personalprocedimientos] ON 

INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (1, 1, 1, 1)
INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (2, 2, 5, 2)
INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (3, 1, 3, 3)
INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (4, 3, 2, 4)
INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (5, 2, 8, 5)
INSERT [clinica].[personalprocedimientos] ([idPersonalProcedimiento], [idEnfermero], [idDoctor], [idProcedimiento]) VALUES (6, 3, 8, 8)
SET IDENTITY_INSERT [clinica].[personalprocedimientos] OFF
GO
SET IDENTITY_INSERT [clinica].[procedimientosmedicos] ON 

INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (1, CAST(N'2024-04-10T09:00:00.0000000' AS DateTime2), CAST(N'01:30:00' AS Time), 1, 1)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (2, CAST(N'2024-04-11T11:30:00.0000000' AS DateTime2), CAST(N'01:15:00' AS Time), 2, 2)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (3, CAST(N'2024-04-12T14:00:00.0000000' AS DateTime2), CAST(N'02:00:00' AS Time), 3, 3)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (4, CAST(N'2024-04-13T10:45:00.0000000' AS DateTime2), CAST(N'00:45:00' AS Time), 4, 4)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (5, CAST(N'2024-04-14T13:30:00.0000000' AS DateTime2), CAST(N'01:00:00' AS Time), 5, 5)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (6, CAST(N'2024-04-25T16:30:00.0000000' AS DateTime2), CAST(N'00:45:00' AS Time), 6, 6)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (7, CAST(N'2024-04-26T09:00:00.0000000' AS DateTime2), CAST(N'01:30:00' AS Time), 7, 7)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (8, CAST(N'2024-04-26T10:30:00.0000000' AS DateTime2), CAST(N'01:00:00' AS Time), 8, 8)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (9, CAST(N'2024-04-26T12:00:00.0000000' AS DateTime2), CAST(N'01:45:00' AS Time), 9, 9)
INSERT [clinica].[procedimientosmedicos] ([idProcedimiento], [fechaHoraProcedimiento], [duracion], [idTipoProcedimiento], [idConsulta]) VALUES (10, CAST(N'2024-04-26T14:00:00.0000000' AS DateTime2), CAST(N'00:45:00' AS Time), 10, 10)
SET IDENTITY_INSERT [clinica].[procedimientosmedicos] OFF
GO
SET IDENTITY_INSERT [clinica].[proveedores] ON 

INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (1, N'Proveedor A', N'Calle Principal 123', N'12345678')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (2, N'Proveedor B', N'Avenida Central 456', N'23456789')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (3, N'Proveedor C', N'Calle Secundaria 789', N'34567890')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (4, N'Proveedor D', N'Avenida Norte 321', N'45678901')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (5, N'Proveedor E', N'Calle Este 654', N'56789012')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (6, N'Proveedor F', N'Boulevard Sur #987, Lugar', N'77771209')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (7, N'Proveedor G', N'Calle Este #246, Localidad', N'22231144')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (8, N'Proveedor H', N'Avenida Oeste #135, Paraje', N'23230912')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (9, N'Proveedor I', N'Camino Real #357, Sector', N'33418231')
INSERT [clinica].[proveedores] ([idProveedor], [nombre], [direccion], [telefono]) VALUES (10, N'Proveedor J', N'Ruta Rápida #579, Zona', N'55122211')
SET IDENTITY_INSERT [clinica].[proveedores] OFF
GO
SET IDENTITY_INSERT [clinica].[recetas] ON 

INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (1, 1, CAST(N'2024-04-10' AS Date), 7)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (2, 2, CAST(N'2024-04-11' AS Date), 10)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (3, 3, CAST(N'2024-04-12' AS Date), 4)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (4, 4, CAST(N'2024-04-13' AS Date), 5)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (5, 5, CAST(N'2024-04-14' AS Date), 1)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (6, 6, CAST(N'2024-04-29' AS Date), 3)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (7, 7, CAST(N'2024-04-30' AS Date), 7)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (8, 8, CAST(N'2024-05-01' AS Date), 14)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (9, 9, CAST(N'2024-05-02' AS Date), 10)
INSERT [clinica].[recetas] ([idReceta], [idExpediente], [fechaReceta], [duracionReceta]) VALUES (10, 10, CAST(N'2024-05-03' AS Date), 5)
SET IDENTITY_INSERT [clinica].[recetas] OFF
GO
SET IDENTITY_INSERT [clinica].[roles] ON 

INSERT [clinica].[roles] ([idRol], [rol]) VALUES (1, N'Doctor')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (2, N'Secretaria')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (3, N'Cocinera')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (4, N'Enfermero')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (5, N'Laboratorista')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (6, N'Contador')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (7, N'Recursos Humanos')
INSERT [clinica].[roles] ([idRol], [rol]) VALUES (8, N'SysAdmin')
SET IDENTITY_INSERT [clinica].[roles] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposcitas] ON 

INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (1, N'Consulta General')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (2, N'Consulta Especializada')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (3, N'Chequeo Médico Anual')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (4, N'Consulta de Emergencia')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (5, N'Procedimiento Médico')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (6, N'Consulta Preoperatoria')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (7, N'Consulta Postoperatoria')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (8, N'Consulta de Seguimiento')
INSERT [clinica].[tiposcitas] ([idTipoCita], [tipoCita]) VALUES (9, N'Vacunación')
SET IDENTITY_INSERT [clinica].[tiposcitas] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposconsultas] ON 

INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (1, N'Consulta General', CAST(5.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (2, N'Consulta Especializada', CAST(15.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (3, N'Chequeo Médico Anual', CAST(8.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (4, N'Consulta de Emergencia', CAST(50.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (5, N'Procedimiento Médico', CAST(100.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (6, N'Consulta Preoperatoria', CAST(20.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (7, N'Consulta Postoperatoria', CAST(20.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (8, N'Consulta de Seguimiento', CAST(8.00 AS Decimal(6, 2)))
INSERT [clinica].[tiposconsultas] ([idTipoConsulta], [tipoConsulta], [precioConsulta]) VALUES (9, N'Vacunación', CAST(5.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [clinica].[tiposconsultas] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposequiposmedicos] ON 

INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (5, N'Desfibrilador')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (3, N'Ecógrafo')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (9, N'Electrocardiograma')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (7, N'Endoscopio')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (6, N'Equipo de Rayos X')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (10, N'Máquina de Anestesia')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (4, N'Monitor de Signos Vitales')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (2, N'Resonancia Magnética')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (1, N'Tomógrafo')
INSERT [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico], [tipoEquipoMedico]) VALUES (8, N'Ventilador Mecánico')
SET IDENTITY_INSERT [clinica].[tiposequiposmedicos] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposexamenes] ON 

INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (1, N'Análisis de sangre', N'Evaluación de la sangre.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (2, N'Radiografía de tórax', N'Visión de los órganos del tórax.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (3, N'Ecografía abdominal', N'Visualización de órganos abdominales.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (4, N'Resonancia magnética cerebral', N'Detalles del cerebro.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (5, N'Colonoscopia', N'Examen del colon y recto.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (6, N'Endoscopia', N'Visualización interna de órganos con un endoscopio para diagnóstico o tratamiento.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (7, N'Tomografía computarizada', N'Imágenes detalladas de cortes transversales del cuerpo para diagnóstico.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (8, N'Resonancia magnética', N'Imágenes detalladas de estructuras internas del cuerpo mediante campos magnéticos.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (9, N'Electrocardiograma', N'Registro de la actividad eléctrica del corazón para evaluar su funcionamiento.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (10, N'Hematología', N'Examen de sangre para evaluar la composición y función de las células sanguíneas.')
INSERT [clinica].[tiposexamenes] ([idTipoExamen], [TipoExamen], [descripcionExamen]) VALUES (11, N'Orina', N'Análisis de la orina para detectar problemas renales, infecciones u otros trastornos.')
SET IDENTITY_INSERT [clinica].[tiposexamenes] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposmedicamentos] ON 

INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (1, N'Analgésico')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (4, N'Antidepresivo')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (5, N'Antihipertensivo')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (2, N'Antiinflamatorio')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (3, N'Antipirético')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (6, N'Broncodilatador')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (7, N'Digestivo')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (8, N'Expectorante')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (9, N'Hipoglucemiante')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (10, N'Inmunosupresor')
INSERT [clinica].[tiposmedicamentos] ([idTipoMedicamento], [tipoMedicamento]) VALUES (11, N'Laxante')
SET IDENTITY_INSERT [clinica].[tiposmedicamentos] OFF
GO
SET IDENTITY_INSERT [clinica].[tipospago] ON 

INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (1, N'Efectivo')
INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (2, N'Tarjeta')
INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (3, N'Cheque')
INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (4, N'Transferencia bancaria')
INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (5, N'Pago en cuotas')
INSERT [clinica].[tipospago] ([idTipoPago], [tipoPago]) VALUES (6, N'Pago por seguro medico')
SET IDENTITY_INSERT [clinica].[tipospago] OFF
GO
SET IDENTITY_INSERT [clinica].[tiposprocedimientos] ON 

INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (1, N'Extracción de sangre', N'Obtención de muestra de sangre.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (2, N'Colonoscopia', N'Examen del colon y recto.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (3, N'Cirugía de cataratas', N'Extracción de cataratas del ojo.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (4, N'Artroscopia de rodilla', N'Examen y tratamiento de la rodilla.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (5, N'Biopsia de piel', N'Extracción de muestra de piel para diagnóstico.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (6, N'Artroscopia', N'Procedimiento para examinar y tratar problemas en las articulaciones.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (7, N'Laparoscopia', N'Procedimiento quirúrgico realizado a través de pequeñas incisiones en la cavidad abdominal.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (8, N'Biopsia', N'Procedimiento para obtener y examinar muestras de tejido o células.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (9, N'Cesárea', N'Procedimiento quirúrgico para el parto de un bebé a través de una incisión en el abdomen y útero.')
INSERT [clinica].[tiposprocedimientos] ([idTipoProcedimiento], [tipoProcedimiento], [descripcionProcedimiento]) VALUES (10, N'Amniocentesis', N'Procedimiento para obtener líquido amniótico para diagnóstico prenatal.')
SET IDENTITY_INSERT [clinica].[tiposprocedimientos] OFF
GO
SET IDENTITY_INSERT [clinica].[usuarios] ON 

INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (1, N'user1', N'123456789', 1, 1)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (2, N'user2', N'123456789', 2, 2)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (3, N'user3', N'123456789', 3, 21)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (4, N'user4', N'123456789', 4, 9)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (5, N'user5', N'123456789', 5, 7)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (6, N'user6', N'123456789', 6, 13)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (7, N'user7', N'123456789', 7, 11)
INSERT [clinica].[usuarios] ([idUsuario], [usuario], [contraseña], [idRol], [idEmpleado]) VALUES (8, N'user8', N'123456789', 8, 14)
SET IDENTITY_INSERT [clinica].[usuarios] OFF
GO
/****** Object:  Index [idOpcion]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idOpcion] ON [clinica].[asignacionrolesopciones]
(
	[idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idRol]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idRol] ON [clinica].[asignacionrolesopciones]
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idPaciente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idPaciente] ON [clinica].[citas]
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoCita]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoCita] ON [clinica].[citas]
(
	[idTipoCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [consultas$idConsulta]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[consultas] ADD  CONSTRAINT [consultas$idConsulta] UNIQUE NONCLUSTERED 
(
	[idConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idCita]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idCita] ON [clinica].[consultas]
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idConsultorio]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idConsultorio] ON [clinica].[consultas]
(
	[idConsultorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idDoctor]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDoctor] ON [clinica].[consultas]
(
	[idDoctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idExamenFisico]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idExamenFisico] ON [clinica].[consultas]
(
	[idExamenFisico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idExpediente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idExpediente] ON [clinica].[consultas]
(
	[idExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idReceta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idReceta] ON [clinica].[consultas]
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoConsulta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoConsulta] ON [clinica].[consultas]
(
	[idTipoConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [departamentos$idDepartamento]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[departamentos] ADD  CONSTRAINT [departamentos$idDepartamento] UNIQUE NONCLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idFacturaProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idFacturaProcedimiento] ON [clinica].[detallesfacturasexamenes]
(
	[idFacturaProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idProcedimiento] ON [clinica].[detallesfacturasexamenes]
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idFacturaProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idFacturaProcedimiento] ON [clinica].[detallesfacturasprocedimientos]
(
	[idFacturaProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idProcedimiento] ON [clinica].[detallesfacturasprocedimientos]
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idDistrito]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDistrito] ON [clinica].[direcciones]
(
	[idDistrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [distritos$idDistrito]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[distritos] ADD  CONSTRAINT [distritos$idDistrito] UNIQUE NONCLUSTERED 
(
	[idDistrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idMunicipio]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idMunicipio] ON [clinica].[distritos]
(
	[idMunicipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEmpleado]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEmpleado] ON [clinica].[doctores]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEspecialidad]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEspecialidad] ON [clinica].[doctores]
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEspecialidad]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEspecialidad] ON [clinica].[doctorespecialidades]
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idDireccion]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDireccion] ON [clinica].[empleados]
(
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoCargo]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoCargo] ON [clinica].[empleados]
(
	[idTipoCargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEmpleado]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEmpleado] ON [clinica].[enfermeros]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idInventario]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idInventario] ON [clinica].[equiposmedicos]
(
	[idInventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idProveedor]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idProveedor] ON [clinica].[equiposmedicos]
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoEquipoMedico]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoEquipoMedico] ON [clinica].[equiposmedicos]
(
	[idTipoEquipoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEspecialidad]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEspecialidad] ON [clinica].[especialidadeslaboratorista]
(
	[idEspecialidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idCita]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idCita] ON [clinica].[examenes]
(
	[idCita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idLaboratorista]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idLaboratorista] ON [clinica].[examenes]
(
	[idLaboratorista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoExamen]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoExamen] ON [clinica].[examenes]
(
	[idTipoExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idPaciente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idPaciente] ON [clinica].[expediente]
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idReceta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idReceta] ON [clinica].[expediente]
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idConsulta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idConsulta] ON [clinica].[facturasconsultas]
(
	[idConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idPaciente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idPaciente] ON [clinica].[facturasconsultas]
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoPago]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoPago] ON [clinica].[facturasconsultas]
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idPaciente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idPaciente] ON [clinica].[facturasexamenes]
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoPago]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoPago] ON [clinica].[facturasexamenes]
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idPaciente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idPaciente] ON [clinica].[facturasprocedimientos]
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoPago]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoPago] ON [clinica].[facturasprocedimientos]
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEquipoMedico]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEquipoMedico] ON [clinica].[insumosmedicos]
(
	[idEquipoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idMedicamento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idMedicamento] ON [clinica].[insumosmedicos]
(
	[idMedicamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idProcedimiento] ON [clinica].[insumosmedicos]
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEmpleado]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEmpleado] ON [clinica].[laboratorista]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idLaboratorio]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idLaboratorio] ON [clinica].[medicamentos]
(
	[idLaboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoMedicamento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoMedicamento] ON [clinica].[medicamentos]
(
	[idTipoMedicamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idReceta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idReceta] ON [clinica].[medicamentosrecetados]
(
	[idReceta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [municipios$idMunicipio]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[municipios] ADD  CONSTRAINT [municipios$idMunicipio] UNIQUE NONCLUSTERED 
(
	[idMunicipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idDepartamento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDepartamento] ON [clinica].[municipios]
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idDireccion]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDireccion] ON [clinica].[pacientes]
(
	[idDireccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idDoctor]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idDoctor] ON [clinica].[personalprocedimientos]
(
	[idDoctor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEnfermero]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEnfermero] ON [clinica].[personalprocedimientos]
(
	[idEnfermero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idProcedimiento] ON [clinica].[personalprocedimientos]
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [procedimientosmedicos$idProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[procedimientosmedicos] ADD  CONSTRAINT [procedimientosmedicos$idProcedimiento] UNIQUE NONCLUSTERED 
(
	[idProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idConsulta]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idConsulta] ON [clinica].[procedimientosmedicos]
(
	[idConsulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idTipoProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idTipoProcedimiento] ON [clinica].[procedimientosmedicos]
(
	[idTipoProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idExpediente]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idExpediente] ON [clinica].[recetas]
(
	[idExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tiposequiposmedicos$tipoEquipoMedico]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[tiposequiposmedicos] ADD  CONSTRAINT [tiposequiposmedicos$tipoEquipoMedico] UNIQUE NONCLUSTERED 
(
	[tipoEquipoMedico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tiposexamenes$TipoExamen]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[tiposexamenes] ADD  CONSTRAINT [tiposexamenes$TipoExamen] UNIQUE NONCLUSTERED 
(
	[TipoExamen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tiposmedicamentos$tipoMedicamento]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[tiposmedicamentos] ADD  CONSTRAINT [tiposmedicamentos$tipoMedicamento] UNIQUE NONCLUSTERED 
(
	[tipoMedicamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [tiposprocedimientos$tipoProcedimiento]    Script Date: 13/10/2024 09:57:02 ******/
ALTER TABLE [clinica].[tiposprocedimientos] ADD  CONSTRAINT [tiposprocedimientos$tipoProcedimiento] UNIQUE NONCLUSTERED 
(
	[tipoProcedimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idEmpleado]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idEmpleado] ON [clinica].[usuarios]
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idRol]    Script Date: 13/10/2024 09:57:02 ******/
CREATE NONCLUSTERED INDEX [idRol] ON [clinica].[usuarios]
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [clinica].[direcciones] ADD  DEFAULT (NULL) FOR [linea1]
GO
ALTER TABLE [clinica].[direcciones] ADD  DEFAULT (NULL) FOR [linea2]
GO
ALTER TABLE [clinica].[direcciones] ADD  DEFAULT (NULL) FOR [codigoPostal]
GO
ALTER TABLE [clinica].[equiposmedicos] ADD  DEFAULT (NULL) FOR [marcaEquipo]
GO
ALTER TABLE [clinica].[examenesfisicos] ADD  DEFAULT (NULL) FOR [inspeccionOjos]
GO
ALTER TABLE [clinica].[examenesfisicos] ADD  DEFAULT (NULL) FOR [inspeccionOidos]
GO
ALTER TABLE [clinica].[examenesfisicos] ADD  DEFAULT (NULL) FOR [inspeccionCabeza]
GO
ALTER TABLE [clinica].[expediente] ADD  DEFAULT (NULL) FOR [notaAdicional]
GO
ALTER TABLE [clinica].[pacientes] ADD  DEFAULT (NULL) FOR [fechaNacPaciente]
GO
ALTER TABLE [clinica].[pacientes] ADD  DEFAULT (NULL) FOR [emailPaciente]
GO
ALTER TABLE [clinica].[pacientes] ADD  DEFAULT (NULL) FOR [ocupacionPaciente]
GO
ALTER TABLE [clinica].[pacientes] ADD  DEFAULT (NULL) FOR [estadoCivil]
GO
ALTER TABLE [clinica].[usuarios] ADD  DEFAULT (NULL) FOR [usuario]
GO
ALTER TABLE [clinica].[usuarios] ADD  DEFAULT (NULL) FOR [contraseña]
GO
ALTER TABLE [clinica].[asignacionrolesopciones]  WITH NOCHECK ADD  CONSTRAINT [asignacionrolesopciones$asignacionrolesopciones_ibfk_1] FOREIGN KEY([idRol])
REFERENCES [clinica].[roles] ([idRol])
GO
ALTER TABLE [clinica].[asignacionrolesopciones] CHECK CONSTRAINT [asignacionrolesopciones$asignacionrolesopciones_ibfk_1]
GO
ALTER TABLE [clinica].[asignacionrolesopciones]  WITH NOCHECK ADD  CONSTRAINT [asignacionrolesopciones$asignacionrolesopciones_ibfk_2] FOREIGN KEY([idOpcion])
REFERENCES [clinica].[opciones] ([idOpcion])
GO
ALTER TABLE [clinica].[asignacionrolesopciones] CHECK CONSTRAINT [asignacionrolesopciones$asignacionrolesopciones_ibfk_2]
GO
ALTER TABLE [clinica].[citas]  WITH NOCHECK ADD  CONSTRAINT [citas$citas_ibfk_1] FOREIGN KEY([idPaciente])
REFERENCES [clinica].[pacientes] ([idPaciente])
GO
ALTER TABLE [clinica].[citas] CHECK CONSTRAINT [citas$citas_ibfk_1]
GO
ALTER TABLE [clinica].[citas]  WITH NOCHECK ADD  CONSTRAINT [citas$citas_ibfk_2] FOREIGN KEY([idTipoCita])
REFERENCES [clinica].[tiposcitas] ([idTipoCita])
GO
ALTER TABLE [clinica].[citas] CHECK CONSTRAINT [citas$citas_ibfk_2]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_1] FOREIGN KEY([idTipoConsulta])
REFERENCES [clinica].[tiposconsultas] ([idTipoConsulta])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_1]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_2] FOREIGN KEY([idExamenFisico])
REFERENCES [clinica].[examenesfisicos] ([idExamenFisico])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_2]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_3] FOREIGN KEY([idDoctor])
REFERENCES [clinica].[doctores] ([idDoctor])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_3]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_4] FOREIGN KEY([idReceta])
REFERENCES [clinica].[recetas] ([idReceta])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_4]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_5] FOREIGN KEY([idCita])
REFERENCES [clinica].[citas] ([idCita])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_5]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_6] FOREIGN KEY([idConsultorio])
REFERENCES [clinica].[consultorios] ([idConsultorio])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_6]
GO
ALTER TABLE [clinica].[consultas]  WITH NOCHECK ADD  CONSTRAINT [consultas$consultas_ibfk_7] FOREIGN KEY([idExpediente])
REFERENCES [clinica].[expediente] ([idExpediente])
GO
ALTER TABLE [clinica].[consultas] CHECK CONSTRAINT [consultas$consultas_ibfk_7]
GO
ALTER TABLE [clinica].[detallesfacturasexamenes]  WITH NOCHECK ADD  CONSTRAINT [detallesfacturasexamenes$detallesfacturasexamenes_ibfk_1] FOREIGN KEY([idFacturaProcedimiento])
REFERENCES [clinica].[facturasprocedimientos] ([idFacturaProcedimiento])
GO
ALTER TABLE [clinica].[detallesfacturasexamenes] CHECK CONSTRAINT [detallesfacturasexamenes$detallesfacturasexamenes_ibfk_1]
GO
ALTER TABLE [clinica].[detallesfacturasexamenes]  WITH NOCHECK ADD  CONSTRAINT [detallesfacturasexamenes$detallesfacturasexamenes_ibfk_2] FOREIGN KEY([idProcedimiento])
REFERENCES [clinica].[procedimientosmedicos] ([idProcedimiento])
GO
ALTER TABLE [clinica].[detallesfacturasexamenes] CHECK CONSTRAINT [detallesfacturasexamenes$detallesfacturasexamenes_ibfk_2]
GO
ALTER TABLE [clinica].[detallesfacturasprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [detallesfacturasprocedimientos$detallesfacturasprocedimientos_ibfk_1] FOREIGN KEY([idFacturaProcedimiento])
REFERENCES [clinica].[facturasprocedimientos] ([idFacturaProcedimiento])
GO
ALTER TABLE [clinica].[detallesfacturasprocedimientos] CHECK CONSTRAINT [detallesfacturasprocedimientos$detallesfacturasprocedimientos_ibfk_1]
GO
ALTER TABLE [clinica].[detallesfacturasprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [detallesfacturasprocedimientos$detallesfacturasprocedimientos_ibfk_2] FOREIGN KEY([idProcedimiento])
REFERENCES [clinica].[procedimientosmedicos] ([idProcedimiento])
GO
ALTER TABLE [clinica].[detallesfacturasprocedimientos] CHECK CONSTRAINT [detallesfacturasprocedimientos$detallesfacturasprocedimientos_ibfk_2]
GO
ALTER TABLE [clinica].[direcciones]  WITH NOCHECK ADD  CONSTRAINT [direcciones$direcciones_ibfk_1] FOREIGN KEY([idDistrito])
REFERENCES [clinica].[distritos] ([idDistrito])
GO
ALTER TABLE [clinica].[direcciones] CHECK CONSTRAINT [direcciones$direcciones_ibfk_1]
GO
ALTER TABLE [clinica].[distritos]  WITH NOCHECK ADD  CONSTRAINT [distritos$distritos_ibfk_1] FOREIGN KEY([idMunicipio])
REFERENCES [clinica].[municipios] ([idMunicipio])
GO
ALTER TABLE [clinica].[distritos] CHECK CONSTRAINT [distritos$distritos_ibfk_1]
GO
ALTER TABLE [clinica].[doctores]  WITH NOCHECK ADD  CONSTRAINT [doctores$doctores_ibfk_1] FOREIGN KEY([idEmpleado])
REFERENCES [clinica].[empleados] ([idEmpleado])
GO
ALTER TABLE [clinica].[doctores] CHECK CONSTRAINT [doctores$doctores_ibfk_1]
GO
ALTER TABLE [clinica].[doctores]  WITH NOCHECK ADD  CONSTRAINT [doctores$doctores_ibfk_2] FOREIGN KEY([idEspecialidad])
REFERENCES [clinica].[especialidades] ([idEspecialidad])
GO
ALTER TABLE [clinica].[doctores] CHECK CONSTRAINT [doctores$doctores_ibfk_2]
GO
ALTER TABLE [clinica].[doctorespecialidades]  WITH NOCHECK ADD  CONSTRAINT [doctorespecialidades$doctorespecialidades_ibfk_1] FOREIGN KEY([idDoctor])
REFERENCES [clinica].[doctores] ([idDoctor])
GO
ALTER TABLE [clinica].[doctorespecialidades] CHECK CONSTRAINT [doctorespecialidades$doctorespecialidades_ibfk_1]
GO
ALTER TABLE [clinica].[doctorespecialidades]  WITH NOCHECK ADD  CONSTRAINT [doctorespecialidades$doctorespecialidades_ibfk_2] FOREIGN KEY([idEspecialidad])
REFERENCES [clinica].[especialidades] ([idEspecialidad])
GO
ALTER TABLE [clinica].[doctorespecialidades] CHECK CONSTRAINT [doctorespecialidades$doctorespecialidades_ibfk_2]
GO
ALTER TABLE [clinica].[empleados]  WITH NOCHECK ADD  CONSTRAINT [empleados$empleados_ibfk_1] FOREIGN KEY([idDireccion])
REFERENCES [clinica].[direcciones] ([idDireccion])
GO
ALTER TABLE [clinica].[empleados] CHECK CONSTRAINT [empleados$empleados_ibfk_1]
GO
ALTER TABLE [clinica].[empleados]  WITH NOCHECK ADD  CONSTRAINT [empleados$empleados_ibfk_2] FOREIGN KEY([idTipoCargo])
REFERENCES [clinica].[cargos] ([idTipoCargo])
GO
ALTER TABLE [clinica].[empleados] CHECK CONSTRAINT [empleados$empleados_ibfk_2]
GO
ALTER TABLE [clinica].[enfermeros]  WITH NOCHECK ADD  CONSTRAINT [enfermeros$enfermeros_ibfk_1] FOREIGN KEY([idEmpleado])
REFERENCES [clinica].[empleados] ([idEmpleado])
GO
ALTER TABLE [clinica].[enfermeros] CHECK CONSTRAINT [enfermeros$enfermeros_ibfk_1]
GO
ALTER TABLE [clinica].[equiposmedicos]  WITH NOCHECK ADD  CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_1] FOREIGN KEY([idTipoEquipoMedico])
REFERENCES [clinica].[tiposequiposmedicos] ([idTipoEquipoMedico])
GO
ALTER TABLE [clinica].[equiposmedicos] CHECK CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_1]
GO
ALTER TABLE [clinica].[equiposmedicos]  WITH NOCHECK ADD  CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_2] FOREIGN KEY([idProveedor])
REFERENCES [clinica].[proveedores] ([idProveedor])
GO
ALTER TABLE [clinica].[equiposmedicos] CHECK CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_2]
GO
ALTER TABLE [clinica].[equiposmedicos]  WITH NOCHECK ADD  CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_3] FOREIGN KEY([idInventario])
REFERENCES [clinica].[inventario] ([idInventario])
GO
ALTER TABLE [clinica].[equiposmedicos] CHECK CONSTRAINT [equiposmedicos$equiposmedicos_ibfk_3]
GO
ALTER TABLE [clinica].[especialidadeslaboratorista]  WITH NOCHECK ADD  CONSTRAINT [especialidadeslaboratorista$especialidadeslaboratorista_ibfk_1] FOREIGN KEY([idLaboratorista])
REFERENCES [clinica].[laboratorista] ([idLaboratorista])
GO
ALTER TABLE [clinica].[especialidadeslaboratorista] CHECK CONSTRAINT [especialidadeslaboratorista$especialidadeslaboratorista_ibfk_1]
GO
ALTER TABLE [clinica].[especialidadeslaboratorista]  WITH NOCHECK ADD  CONSTRAINT [especialidadeslaboratorista$especialidadeslaboratorista_ibfk_2] FOREIGN KEY([idEspecialidad])
REFERENCES [clinica].[especialidades] ([idEspecialidad])
GO
ALTER TABLE [clinica].[especialidadeslaboratorista] CHECK CONSTRAINT [especialidadeslaboratorista$especialidadeslaboratorista_ibfk_2]
GO
ALTER TABLE [clinica].[examenes]  WITH NOCHECK ADD  CONSTRAINT [examenes$examenes_ibfk_1] FOREIGN KEY([idTipoExamen])
REFERENCES [clinica].[tiposexamenes] ([idTipoExamen])
GO
ALTER TABLE [clinica].[examenes] CHECK CONSTRAINT [examenes$examenes_ibfk_1]
GO
ALTER TABLE [clinica].[examenes]  WITH NOCHECK ADD  CONSTRAINT [examenes$examenes_ibfk_2] FOREIGN KEY([idLaboratorista])
REFERENCES [clinica].[laboratorista] ([idLaboratorista])
GO
ALTER TABLE [clinica].[examenes] CHECK CONSTRAINT [examenes$examenes_ibfk_2]
GO
ALTER TABLE [clinica].[examenes]  WITH NOCHECK ADD  CONSTRAINT [examenes$examenes_ibfk_3] FOREIGN KEY([idCita])
REFERENCES [clinica].[citas] ([idCita])
GO
ALTER TABLE [clinica].[examenes] CHECK CONSTRAINT [examenes$examenes_ibfk_3]
GO
ALTER TABLE [clinica].[expediente]  WITH NOCHECK ADD  CONSTRAINT [expediente$expediente_ibfk_1] FOREIGN KEY([idPaciente])
REFERENCES [clinica].[pacientes] ([idPaciente])
GO
ALTER TABLE [clinica].[expediente] CHECK CONSTRAINT [expediente$expediente_ibfk_1]
GO
ALTER TABLE [clinica].[expediente]  WITH NOCHECK ADD  CONSTRAINT [expediente$expediente_ibfk_2] FOREIGN KEY([idReceta])
REFERENCES [clinica].[recetas] ([idReceta])
GO
ALTER TABLE [clinica].[expediente] CHECK CONSTRAINT [expediente$expediente_ibfk_2]
GO
ALTER TABLE [clinica].[facturasconsultas]  WITH NOCHECK ADD  CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_1] FOREIGN KEY([idConsulta])
REFERENCES [clinica].[consultas] ([idConsulta])
GO
ALTER TABLE [clinica].[facturasconsultas] CHECK CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_1]
GO
ALTER TABLE [clinica].[facturasconsultas]  WITH NOCHECK ADD  CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_2] FOREIGN KEY([idPaciente])
REFERENCES [clinica].[pacientes] ([idPaciente])
GO
ALTER TABLE [clinica].[facturasconsultas] CHECK CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_2]
GO
ALTER TABLE [clinica].[facturasconsultas]  WITH NOCHECK ADD  CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_3] FOREIGN KEY([idTipoPago])
REFERENCES [clinica].[tipospago] ([idTipoPago])
GO
ALTER TABLE [clinica].[facturasconsultas] CHECK CONSTRAINT [facturasconsultas$facturasconsultas_ibfk_3]
GO
ALTER TABLE [clinica].[facturasexamenes]  WITH NOCHECK ADD  CONSTRAINT [facturasexamenes$facturasexamenes_ibfk_1] FOREIGN KEY([idPaciente])
REFERENCES [clinica].[pacientes] ([idPaciente])
GO
ALTER TABLE [clinica].[facturasexamenes] CHECK CONSTRAINT [facturasexamenes$facturasexamenes_ibfk_1]
GO
ALTER TABLE [clinica].[facturasexamenes]  WITH NOCHECK ADD  CONSTRAINT [facturasexamenes$facturasexamenes_ibfk_2] FOREIGN KEY([idTipoPago])
REFERENCES [clinica].[tipospago] ([idTipoPago])
GO
ALTER TABLE [clinica].[facturasexamenes] CHECK CONSTRAINT [facturasexamenes$facturasexamenes_ibfk_2]
GO
ALTER TABLE [clinica].[facturasprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [facturasprocedimientos$facturasprocedimientos_ibfk_1] FOREIGN KEY([idPaciente])
REFERENCES [clinica].[pacientes] ([idPaciente])
GO
ALTER TABLE [clinica].[facturasprocedimientos] CHECK CONSTRAINT [facturasprocedimientos$facturasprocedimientos_ibfk_1]
GO
ALTER TABLE [clinica].[facturasprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [facturasprocedimientos$facturasprocedimientos_ibfk_2] FOREIGN KEY([idTipoPago])
REFERENCES [clinica].[tipospago] ([idTipoPago])
GO
ALTER TABLE [clinica].[facturasprocedimientos] CHECK CONSTRAINT [facturasprocedimientos$facturasprocedimientos_ibfk_2]
GO
ALTER TABLE [clinica].[insumosmedicos]  WITH NOCHECK ADD  CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_1] FOREIGN KEY([idMedicamento])
REFERENCES [clinica].[medicamentos] ([idMedicamento])
GO
ALTER TABLE [clinica].[insumosmedicos] CHECK CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_1]
GO
ALTER TABLE [clinica].[insumosmedicos]  WITH NOCHECK ADD  CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_2] FOREIGN KEY([idEquipoMedico])
REFERENCES [clinica].[equiposmedicos] ([idEquipoMedico])
GO
ALTER TABLE [clinica].[insumosmedicos] CHECK CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_2]
GO
ALTER TABLE [clinica].[insumosmedicos]  WITH NOCHECK ADD  CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_3] FOREIGN KEY([idProcedimiento])
REFERENCES [clinica].[procedimientosmedicos] ([idProcedimiento])
GO
ALTER TABLE [clinica].[insumosmedicos] CHECK CONSTRAINT [insumosmedicos$insumosmedicos_ibfk_3]
GO
ALTER TABLE [clinica].[laboratorista]  WITH NOCHECK ADD  CONSTRAINT [laboratorista$laboratorista_ibfk_1] FOREIGN KEY([idEmpleado])
REFERENCES [clinica].[empleados] ([idEmpleado])
GO
ALTER TABLE [clinica].[laboratorista] CHECK CONSTRAINT [laboratorista$laboratorista_ibfk_1]
GO
ALTER TABLE [clinica].[medicamentos]  WITH NOCHECK ADD  CONSTRAINT [medicamentos$medicamentos_ibfk_1] FOREIGN KEY([idTipoMedicamento])
REFERENCES [clinica].[tiposmedicamentos] ([idTipoMedicamento])
GO
ALTER TABLE [clinica].[medicamentos] CHECK CONSTRAINT [medicamentos$medicamentos_ibfk_1]
GO
ALTER TABLE [clinica].[medicamentos]  WITH NOCHECK ADD  CONSTRAINT [medicamentos$medicamentos_ibfk_2] FOREIGN KEY([idLaboratorio])
REFERENCES [clinica].[laboratorios] ([idLaboratorio])
GO
ALTER TABLE [clinica].[medicamentos] CHECK CONSTRAINT [medicamentos$medicamentos_ibfk_2]
GO
ALTER TABLE [clinica].[medicamentosrecetados]  WITH NOCHECK ADD  CONSTRAINT [medicamentosrecetados$medicamentosrecetados_ibfk_1] FOREIGN KEY([idMedicamento])
REFERENCES [clinica].[medicamentos] ([idMedicamento])
GO
ALTER TABLE [clinica].[medicamentosrecetados] CHECK CONSTRAINT [medicamentosrecetados$medicamentosrecetados_ibfk_1]
GO
ALTER TABLE [clinica].[medicamentosrecetados]  WITH NOCHECK ADD  CONSTRAINT [medicamentosrecetados$medicamentosrecetados_ibfk_2] FOREIGN KEY([idReceta])
REFERENCES [clinica].[recetas] ([idReceta])
GO
ALTER TABLE [clinica].[medicamentosrecetados] CHECK CONSTRAINT [medicamentosrecetados$medicamentosrecetados_ibfk_2]
GO
ALTER TABLE [clinica].[municipios]  WITH NOCHECK ADD  CONSTRAINT [municipios$municipios_ibfk_1] FOREIGN KEY([idDepartamento])
REFERENCES [clinica].[departamentos] ([idDepartamento])
GO
ALTER TABLE [clinica].[municipios] CHECK CONSTRAINT [municipios$municipios_ibfk_1]
GO
ALTER TABLE [clinica].[pacientes]  WITH NOCHECK ADD  CONSTRAINT [pacientes$pacientes_ibfk_1] FOREIGN KEY([idDireccion])
REFERENCES [clinica].[direcciones] ([idDireccion])
GO
ALTER TABLE [clinica].[pacientes] CHECK CONSTRAINT [pacientes$pacientes_ibfk_1]
GO
ALTER TABLE [clinica].[personalprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_1] FOREIGN KEY([idEnfermero])
REFERENCES [clinica].[enfermeros] ([idEnfermero])
GO
ALTER TABLE [clinica].[personalprocedimientos] CHECK CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_1]
GO
ALTER TABLE [clinica].[personalprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_2] FOREIGN KEY([idDoctor])
REFERENCES [clinica].[doctores] ([idDoctor])
GO
ALTER TABLE [clinica].[personalprocedimientos] CHECK CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_2]
GO
ALTER TABLE [clinica].[personalprocedimientos]  WITH NOCHECK ADD  CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_3] FOREIGN KEY([idProcedimiento])
REFERENCES [clinica].[procedimientosmedicos] ([idProcedimiento])
GO
ALTER TABLE [clinica].[personalprocedimientos] CHECK CONSTRAINT [personalprocedimientos$personalprocedimientos_ibfk_3]
GO
ALTER TABLE [clinica].[procedimientosmedicos]  WITH NOCHECK ADD  CONSTRAINT [procedimientosmedicos$procedimientosmedicos_ibfk_1] FOREIGN KEY([idTipoProcedimiento])
REFERENCES [clinica].[tiposprocedimientos] ([idTipoProcedimiento])
GO
ALTER TABLE [clinica].[procedimientosmedicos] CHECK CONSTRAINT [procedimientosmedicos$procedimientosmedicos_ibfk_1]
GO
ALTER TABLE [clinica].[procedimientosmedicos]  WITH NOCHECK ADD  CONSTRAINT [procedimientosmedicos$procedimientosmedicos_ibfk_2] FOREIGN KEY([idConsulta])
REFERENCES [clinica].[consultas] ([idConsulta])
GO
ALTER TABLE [clinica].[procedimientosmedicos] CHECK CONSTRAINT [procedimientosmedicos$procedimientosmedicos_ibfk_2]
GO
ALTER TABLE [clinica].[recetas]  WITH NOCHECK ADD  CONSTRAINT [recetas$recetas_ibfk_1] FOREIGN KEY([idExpediente])
REFERENCES [clinica].[expediente] ([idExpediente])
GO
ALTER TABLE [clinica].[recetas] CHECK CONSTRAINT [recetas$recetas_ibfk_1]
GO
ALTER TABLE [clinica].[usuarios]  WITH NOCHECK ADD  CONSTRAINT [usuarios$usuarios_ibfk_1] FOREIGN KEY([idRol])
REFERENCES [clinica].[roles] ([idRol])
GO
ALTER TABLE [clinica].[usuarios] CHECK CONSTRAINT [usuarios$usuarios_ibfk_1]
GO
ALTER TABLE [clinica].[usuarios]  WITH NOCHECK ADD  CONSTRAINT [usuarios$usuarios_ibfk_2] FOREIGN KEY([idEmpleado])
REFERENCES [clinica].[empleados] ([idEmpleado])
GO
ALTER TABLE [clinica].[usuarios] CHECK CONSTRAINT [usuarios$usuarios_ibfk_2]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.consultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'FUNCTION',@level1name=N'enum2str$consultas$estadoConsulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.consultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'FUNCTION',@level1name=N'norm_enum$consultas$estadoConsulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.consultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'FUNCTION',@level1name=N'str2enum$consultas$estadoConsulta'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.asignacionrolesopciones' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'asignacionrolesopciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.cargos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'cargos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.citas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'citas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.consultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'consultas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.consultorios' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'consultorios'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.departamentos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'departamentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.detallesfacturasexamenes' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'detallesfacturasexamenes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.detallesfacturasprocedimientos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'detallesfacturasprocedimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.direcciones' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'direcciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.distritos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'distritos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.doctores' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'doctores'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.doctorespecialidades' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'doctorespecialidades'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.empleados' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'empleados'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.enfermeros' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'enfermeros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.equiposmedicos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'equiposmedicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.especialidades' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'especialidades'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.especialidadeslaboratorista' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'especialidadeslaboratorista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.examenes' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'examenes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.examenesfisicos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'examenesfisicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.expediente' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'expediente'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.facturasconsultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'facturasconsultas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.facturasexamenes' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'facturasexamenes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.facturasprocedimientos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'facturasprocedimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.insumosmedicos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'insumosmedicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.inventario' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'inventario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.laboratorios' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'laboratorios'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.laboratorista' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'laboratorista'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.medicamentos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'medicamentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.medicamentosrecetados' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'medicamentosrecetados'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.municipios' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'municipios'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.opciones' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'opciones'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.pacientes' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'pacientes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.personalprocedimientos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'personalprocedimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.procedimientosmedicos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'procedimientosmedicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.proveedores' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'proveedores'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.recetas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'recetas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.roles' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposcitas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposcitas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposconsultas' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposconsultas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposequiposmedicos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposequiposmedicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposexamenes' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposexamenes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposmedicamentos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposmedicamentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tipospago' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tipospago'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.tiposprocedimientos' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'tiposprocedimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'clinica.usuarios' , @level0type=N'SCHEMA',@level0name=N'clinica', @level1type=N'TABLE',@level1name=N'usuarios'
GO
USE [master]
GO
ALTER DATABASE [clinica] SET  READ_WRITE 
GO



