USE Test
GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260623
--Descripcion:TRUNCATE TABLE - CONTINCENCIA
--P20R01_BD_CDQV: CONTINGENCIA
--============================================= 1 Gestores_bd

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Gestores_bd'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Datos de Gestores_bd
             TRUNCATE TABLE dbo.Gestores_bd;
             

             PRINT 'Datos de la tabla Gestores_bd limpiando correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de [dbo].[Gestores_bd] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO
