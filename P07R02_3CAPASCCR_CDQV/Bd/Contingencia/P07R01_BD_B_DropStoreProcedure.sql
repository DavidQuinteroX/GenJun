USE GenJunCCR
GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:StoreProcedure - 
--P07R01_BD_CDQV:B CONTINGENCIA
--============================================= 1

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'Insert_Camion'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE Insert_Camion

             DROP PROCEDURE dbo.Insert_Camion;

             PRINT 'EL Insert_Camion eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[Insert_Camion] no existe'
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
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Select_Camion'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Select_Camion

             DROP PROCEDURE dbo.sp_Select_Camion;

             PRINT 'El sp_Select_Camion eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Select_Camion] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO


--============================================= 3

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Update_Camion'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Update_Camion

             DROP PROCEDURE dbo.sp_Update_Camion;

             PRINT 'El sp_Update_Camion eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Update_Camion] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO


--============================================= 4

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Insert_Choferes'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Insert_Choferes

             DROP PROCEDURE dbo.sp_Insert_Choferes;

             PRINT 'El sp_Insert_Choferes eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Insert_Choferes] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO


--============================================= 5

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Select_Chofer'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Select_Chofer

             DROP PROCEDURE dbo.sp_Select_Chofer;

             PRINT 'El sp_Select_Chofer eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Select_Chofer] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 6

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Update_Choferes'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Update_Choferes

             DROP PROCEDURE dbo.sp_Update_Choferes;

             PRINT 'El sp_Update_Choferes eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Update_Choferes] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 7

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Delete_Chofer'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Delete_Chofer

             DROP PROCEDURE dbo.sp_Delete_Chofer;

             PRINT 'El sp_Delete_Chofer eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Delete_Chofer] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 8

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Insert_Rutas'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Insert_Rutas

             DROP PROCEDURE dbo.sp_Insert_Rutas;

             PRINT 'El sp_Insert_Rutas eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Insert_Rutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 9

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Select_Rutas'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Select_Rutas

             DROP PROCEDURE dbo.sp_Select_Rutas;

             PRINT 'El sp_Select_Rutas eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Select_Rutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 10

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Update_Rutas'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Update_Rutas

             DROP PROCEDURE dbo.sp_Update_Rutas;

             PRINT 'El sp_Update_Rutas eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Update_Rutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 11

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Insert_Rutas'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Insert_Rutas

             DROP PROCEDURE dbo.sp_Insert_Rutas;

             PRINT 'El sp_Insert_Rutas eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Insert_Rutas] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 12

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Existe_Licencia'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Existe_Licencia

             DROP PROCEDURE dbo.sp_Existe_Licencia;

             PRINT 'El sp_Existe_Licencia eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Existe_Licencia] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 13

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Obtener_Camion_ID'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Obtener_Camion_ID

             DROP PROCEDURE dbo.sp_Obtener_Camion_ID;

             PRINT 'El sp_Obtener_Camion_ID eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Obtener_Camion_ID] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 14

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Delete_Camion'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Delete_Camion

             DROP PROCEDURE dbo.sp_Delete_Camion;

             PRINT 'El sp_Delete_Camion eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Delete_Camion] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 15

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Existe_Matricula'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Existe_Matricula

             DROP PROCEDURE dbo.sp_Existe_Matricula;

             PRINT 'El sp_Existe_Matricula eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Existe_Matricula] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 16

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Listar_Camiones'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Listar_Camiones

             DROP PROCEDURE dbo.sp_Listar_Camiones;

             PRINT 'El sp_Listar_Camiones eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Listar_Camiones] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 17

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME= 'sp_Delete_Ruta'
                AND ROUTINE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR:STORE PROCEDURE sp_Delete_Ruta

             DROP PROCEDURE dbo.sp_Delete_Ruta;

             PRINT 'El sp_Delete_Ruta eliminado Correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El Store Procedure [dbo].[sp_Delete_Ruta] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO