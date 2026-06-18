USE GenJunCCR
GO

--=============================================
--Autor:Carlos David Quintero  Villegas
--Created:20260616
--Descripcion:DROP TABLE - CONTINGENCIA
--P07R01_BD_CDQV:C CONTINGENCIA
--============================================= 1 Camiones

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Camiones'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR: Tabla Camiones 

             DROP TABLE dbo.Camiones;

             PRINT 'La tabla Camiones eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Camiones] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO
--============================================= 2 Choferes

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Choferes'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Tabla Choferes
             DROP TABLE dbo.Choferes;
             

             PRINT 'La tabla Choferes eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Choferes] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 3 Rutas
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Rutas'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:TABLA Rutas
             DROP TABLE dbo.Rutas;
             

             PRINT 'La tabla Rutas eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Rutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

