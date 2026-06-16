USE GenJunCCR
GO

--Autor:Carlos David Quintero Villegas
--Created:20260610
--Descripcion:Vistas
--P07R01_3CAPASCCR_04_VIEWS
--sp_help 'Rutas'

/*=====================================
 VIEW CAMIONES
=====================================*/

CREATE OR ALTER VIEW dbo.VWCamiones
AS
SELECT 
     IdCamion,
     Matricula,
     TipoCamion,
     Modelo,
     Marca,
     Capacidad,
     Kilometraje,
     UrlFoto
FROM dbo.Camiones
WHERE Disponibilidad = 1;
GO

SELECT * FROM dbo.VWCamiones;-----TEST THE VIEW
GO

--============================================
--VIEW CHOFERES
--===========================================
CREATE OR ALTER VIEW dbo.VWChoferes
AS
SELECT 
      IdChofer,
      Nombre,
      ApPaterno,
      ApMaterno,
      Telefono,
      FechaNacimiento,
      Licencia,
      UrlFoto,
      Disponibilidad,
      FechaRegistro

FROM dbo.Choferes
WHERE Disponibilidad =1;
GO

SELECT * FROM dbo.VWChoferes
GO
--sp_help 'Rutas'


--=====================================
--Views Vistas
--=====================================
CREATE OR ALTER VIEW dbo.VWRutas 
AS
SELECT
      IdRuta,
      IdChofer,
      IdCamion,
      Origen,
      Destino,
      FechaSalida,
      FechaLlegada,
      ATiempo,
      Distancia,
      FechaRegistro

FROM dbo.Rutas
WHERE ATiempo = 1;
GO

SELECT * FROM dbo.VWRutas
GO