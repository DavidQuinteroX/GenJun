USE GenJun
GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:StoreProcedure - 
--P01R01_BD_CDQV:C CONTINGENCIA
--============================================= 1

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'spObtenerClientePorId'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE spObtenerClientePorId

             DROP PROCEDURE dbo.spObtenerClientePorId;

             PRINT 'EL spObtenerClientePorId eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[spObtenerClientePorId] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 2

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'spInsertarPedido'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE spInsertarPedido

             DROP PROCEDURE dbo.spInsertarPedido;

             PRINT 'El spInsertarPedido eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[spInsertarPedido] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

