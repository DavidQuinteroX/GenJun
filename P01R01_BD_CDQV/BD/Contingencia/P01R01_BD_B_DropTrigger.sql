USE GenJun
Go

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:DropTriger - CONTINGENCIA
--P01R01_BD_CDQV:B CONTINGENCIA
--============================================= 1

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'trAuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger trAuditoriaCambioPrecio

             DROP TRIGGER dbo.trAuditoriaCambioPrecio;

             PRINT 'Trigger trAuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[trAuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--=============================================2
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'tr_After_Insert_AuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger tr_After_Insert_AuditoriaCambioPrecio

             DROP TRIGGER dbo.tr_After_Insert_AuditoriaCambioPrecio;

             PRINT 'Trigger tr_After_Insert_AuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[tr_After_Insert_AuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--=============================================3
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'tr_After_Delete_AuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger tr_After_Delete_AuditoriaCambioPrecio

             DROP TRIGGER dbo.tr_After_Delete_AuditoriaCambioPrecio;

             PRINT 'Trigger tr_After_Delete_AuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[tr_After_Delete_AuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--=============================================4
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'tr_Instead_Update_AuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger tr_Instead_Update_AuditoriaCambioPrecio

             DROP TRIGGER dbo.tr_Instead_Update_AuditoriaCambioPrecio;

             PRINT 'Trigger tr_Instead_Update_AuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[tr_Instead_Update_AuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--=============================================5
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'tr_Instead_Insert_AuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger tr_Instead_Insert_AuditoriaCambioPrecio

             DROP TRIGGER dbo.tr_Instead_Insert_AuditoriaCambioPrecio;

             PRINT 'Trigger tr_Instead_Insert_AuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[tr_Instead_Insert_AuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--=============================================6

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.objects WHERE name= 'tr_Instead_Delete_AuditoriaCambioPrecio'
                AND type = 'TR'
                AND SCHEMA_NAME(schema_id) = 'dbo')

        BEGIN
        --ELIMINAR:Trigger tr_Instead_Delete_AuditoriaCambioPrecio

             DROP TRIGGER dbo.tr_Instead_Delete_AuditoriaCambioPrecio;

             PRINT 'Trigger tr_Instead_Delete_AuditoriaCambioPrecio eliminado correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El trigger [dbo].[tr_Instead_Delete_AuditoriaCambioPrecio] no existe.';
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

