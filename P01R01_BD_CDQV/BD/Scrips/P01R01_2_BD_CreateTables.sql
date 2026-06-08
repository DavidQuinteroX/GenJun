USE GenJun
GO
--=============================================
--Autor:Carlos David Quintero Villegas
--Creacion de BD:P01R01_BD_DQ
--Fecha :202606201
--=============================================
--PRODUCTOS
--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Productos'
      AND TABLE_SCHEMA='dbo')
      BEGIN
           CREATE TABLE Productos(
                                   ProductoId INT IDENTITY(1,1)PRIMARY KEY,
                                   Nombre NVarchar(100)NOT NULL,
                                   Categoria NVarchar (50) NOT NULL,
                                   Precio DECIMAL(10,2)NOT NULL,
                                   Stock INT DEFAULT 0,
                                   FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
                                   );
            PRINT 'Tabla Productos creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[Productos] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO

  --===================CLIENTES==========================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Clientes'
      AND TABLE_SCHEMA='dbo')
      BEGIN
           CREATE TABLE Clientes(
                                   ClienteId INT IDENTITY(1,1)PRIMARY KEY,
                                   Nombre NVarchar(100)NOT NULL,
                                   Email NVarchar (100) ,
                                   Telefono NVarchar(15)
                                   
                                   );
            PRINT 'Tabla Clientes creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[Clientes] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO

    --====================PEDIDOS=========================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Pedidos'
      AND TABLE_SCHEMA='dbo')
      BEGIN
           CREATE TABLE Pedidos(
                                   PedidoId INT IDENTITY(1,1)PRIMARY KEY,
                                   ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteId),
                                   Fecha DATETIME DEFAULT GETDATE(),
                                   Total DECIMAL(10,2)NOT NULL,
                                   Estado NVarchar(20) DEFAULT 'Pendiente'
                                   
                                   );
            PRINT 'Tabla Pedidos creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[Pedidos] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO


    --=================DETALLES===PEDIDOS=========================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='DetallesPedido'
      AND TABLE_SCHEMA='dbo')
      BEGIN
           CREATE TABLE DetallesPedido(
                                   DetallePedidoId INT IDENTITY(1,1)PRIMARY KEY,
                                   PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
                                   ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
                                   Cantidad INT NOT NULL,
                                   PrecioUnitario DECIMAL(10,2) NOT NULL
                                   
                                   );
           --Agregar Foreign key a tabla existente
           ALTER TABLE Pedidos
           ADD CONSTRAINT FK_Pedidos_Clientes
           FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID);

            PRINT 'Tabla DetallesPedido creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[DetallesPedido] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO



    --=================AUDITORIA===PRODUCTOS=========================

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
      BEGIN TRY 
      --VALIDAVIONES
      IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='AuditoriaProductos'
      AND TABLE_SCHEMA='dbo')
      BEGIN
           CREATE TABLE AuditoriaProductos(
                                   AuditoriaID INT IDENTITY(1,1)PRIMARY KEY,                                   
                                   ProductoID INT ,
                                   Accion NVARCHAR(20),
                                   PrecioAnterior DECIMAL (10,2),
                                   PrecioNuevo DECIMAL(10,2),
                                   Usuario NVARCHAR(100),
                                   Fecha DATETIME DEFAULT GETDATE()
                                   
                                   );          

            PRINT 'Tabla AuditoriaProductos creada correctamente.';
      END
  ELSE
      BEGIN
            PRINT 'La tabla [dbo].[AuditoriaProductos] ya existe.';
      END
  COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO