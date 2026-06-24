USE Test
GO

--============================================
--Autor:Carlos David Quintero Villegas
--Created:20260622
--Descripcion:Creacion de la base de datos
--P10R01_NCAPAS_02_CreateDataTables:
--============================================
--============================================
--CREATE TABLE 01 Gestores
--============================================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Gestores_bd'
      AND TABLE_SCHEMA='dbo')
      BEGIN
          CREATE TABLE dbo.Gestores_bd(
            IdGestores INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
            Nombre VARCHAR (50) NOT NULL,
            Lazamiento INT NOT NULL,
            Desarrollador NVARCHAR (50)NOT NULL );

            PRINT 'Tabla Gestores_bd creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[Gestores_bd] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO