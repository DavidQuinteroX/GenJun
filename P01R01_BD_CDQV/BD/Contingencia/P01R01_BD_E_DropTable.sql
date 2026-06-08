USE GenJun 
GO

--=============================================
--Autor:Carlos David Quintero  Villegas
--Created:20260603
--Descripcion:DROP TABLE - CONTINGENCIA
--P01R01_BD_CDQV:E CONTINGENCIA
--============================================= 1 DetallesPedido

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'DetallesPedido'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
        --ELIMINAR: Tabla DetallesPedido 

             DROP TABLE dbo.DetallesPedido;

             PRINT 'La tabla DetallesPedido eliminadaCorrectamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[DetallesPedido] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO
--============================================= 2 AuditoriaProductos

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'AuditoriaProductos'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Tabla AuditoriaProductos
             DROP TABLE dbo.AuditoriaProductos;
             

             PRINT 'La tabla AuditoriaProductos eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[AuditoriaProductos] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 3 Pedidos
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Pedidos'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:TABLA Pedidos
             DROP TABLE dbo.Pedidos;
             

             PRINT 'La tabla Pedidos eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Pedidos] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 4 Clientes
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Clientes'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Datos de Clientes
             DROP TABLE dbo.Clientes;
             

             PRINT 'La tabla Clientes eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Clientes] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO

--============================================= 5 Productos
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'Productos'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Datos de Productos
             DROP TABLE dbo.Productos;
             

             PRINT 'La tabla Productos eliminados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'La tabla [dbo].[Productos] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO