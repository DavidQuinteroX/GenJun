USE GenJun
GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:TRUNCATE TABLE - CONTINCENCIA
--P01R01_BD_CDQV:D CONTINGENCIA
--============================================= 1 DetallesPedido

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
     BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME= 'DetallesPedido'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Datos de DetallesPedidos
             TRUNCATE TABLE dbo.DetallesPedido;
             

             PRINT 'Datos de la tabla DetallesPedido limpiando correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de [dbo].[DetallesPedido] no existe'
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
             --ELIMINAR:Datos de AuditoriaProductos
             TRUNCATE TABLE dbo.AuditoriaProductos;
             

             PRINT 'Datos de la tabla AuditoriaProductos limpiando correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de  [dbo].[AuditoriaProductos] no existe'
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
             --ELIMINAR:Datos de Pedidos
             TRUNCATE TABLE dbo.Pedidos;
             

             PRINT 'Datos de la tabla Pedidos limpiados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de  [dbo].[Pedidos] no existe'
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
             TRUNCATE TABLE dbo.Clientes;
             

             PRINT 'Datos de la tabla Clientes limpiados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de [dbo].[Clientes] no existe';
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
     IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.Tables WHERE TABLE_NAME= 'Productos'
                AND TABLE_SCHEMA = 'dbo')

        BEGIN
             --ELIMINAR:Datos de Productos
             TRUNCATE TABLE dbo.Productos;
             

             PRINT 'Datos de la tabla Productos limpiados correctamente.';
        END
    ELSE
        BEGIN
             PRINT 'El contenido de [dbo].[Productos] no existe'
        END
      COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
GO