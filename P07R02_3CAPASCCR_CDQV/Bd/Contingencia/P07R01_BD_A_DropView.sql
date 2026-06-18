USE GenJunCCR
GO

--===============================================
--Autor:Carlos David Quintero Villegas
--Created:20260616
--Descripcion:Vistas
--P07R01_3CAPASCCR_04_VIEWS
--===============================================
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VWCamiones'
                AND TABLE_SCHEMA = 'dbo')
        BEGIN
        --ELIMINAR:VISTA RESUMEN VENTAS

             DROP VIEW dbo.VWCamiones;

             PRINT 'Vista VWCamiones eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La vista [dbo].[VWCamiones] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--==============================================
--VWChoferes
--==============================================
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VWChoferes'
                AND TABLE_SCHEMA = 'dbo')
        BEGIN
        --ELIMINAR:VISTA RESUMEN VENTAS

             DROP VIEW dbo.VWChoferes;

             PRINT 'Vista VWChoferes eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La vista [dbo].[VWChoferes] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--==============================================
--VWRutas
--==============================================
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VWRutas'
                AND TABLE_SCHEMA = 'dbo')
        BEGIN
        --ELIMINAR:VISTA RESUMEN VENTAS

             DROP VIEW dbo.VWRutas;

             PRINT 'Vista VWRutas eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La vista [dbo].[VWRutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO