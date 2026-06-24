USE Test 
GO

--=============================================
--Autor:Carlos David Quintero  Villegas
--Created:20260623
--Descripcion:DROP TABLE - CONTINGENCIA
--P20R01_BD_CDQV:E CONTINGENCIA
--============================================= 1 DetallesPedido

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Gestores_bd'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR: Tabla Gestores_bd 

             DROP TABLE dbo.Gestores_bd;

             PRINT 'La tabla Gestores_bd eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Gestores_bd] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO
