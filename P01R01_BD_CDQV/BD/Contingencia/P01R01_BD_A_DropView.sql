USE GenJun
GO
--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:DropView - CONTINGENCIA
--P01R01_BD_CDQV:A CONTINGENCIA
--=============================================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VistaResumenVentas'
                AND TABLE_SCHEMA = 'dbo')
        BEGIN
        --ELIMINAR:VISTA RESUMEN VENTAS

             DROP VIEW dbo.VistaResumenVentas;

             PRINT 'Vista VistaResumenVentas eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La vista [dbo].[VistaResumenVentas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO
