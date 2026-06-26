USE DepositoBD
GO

--============================================
--Autor:Carlos David Quintero Villegas
--Created:20260617
--Descripcion:Creacion de la base de datos
--P10R01_NCAPAS_02_CreateDataTables:
--============================================
--============================================
--CREATE TABLE 01 CATEGORIAS
--============================================
BEGIN TRANSACTION ;
        BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categorias' AND TABLE_SCHEMA='dbo')
        BEGIN
             CREATE TABLE dbo.Categorias(
             IdCategoria INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
             Nombre NVARCHAR (100) NOT NULL,
             CONSTRAINT UQ_Categoria_Nombre UNIQUE(Nombre));
             PRINT 'Tabla creada correctamente'
          END
      ELSE
          BEGIN 
              PRINT 'La tabla Categorias ya existe'
          END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
   IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION;
   THROW
END CATCH
GO


--============================================
--CREATE TABLE 02 Marcas
--============================================
BEGIN TRANSACTION ;
        BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Marcas' AND TABLE_SCHEMA='dbo')
        BEGIN
             CREATE TABLE dbo.Marcas(
             IdMarca INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
             Nombre NVARCHAR (100) NOT NULL,
             CONSTRAINT UQ_Marcas_Nombre UNIQUE(Nombre));

             PRINT 'Tabla Marcas creada correctamente'
          END
      ELSE
          BEGIN 
              PRINT 'La tabla Marcas ya existe'
          END
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
   IF @@TRANCOUNT > 0
      ROLLBACK TRANSACTION;
   THROW
END CATCH
GO

--============================================
--CREATE TABLE 03 PRODUCTOS
--============================================    
BEGIN TRANSACTION;
        BEGIN TRY

        IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Productos' AND TABLE_SCHEMA = 'dbo' )
           BEGIN
                CREATE TABLE dbo.Productos (
                IdProducto INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                Nombre VARCHAR (100) NOT NULL,
                IdMarca INT NOT NULL,
                IdCategoria INT NOT NULL,
                ContenidoML INT NOT NULL,
                Activo BIT NOT NULL DEFAULT 1,
                CONSTRAINT UQ_Productos_Nombre UNIQUE(Nombre),
                CONSTRAINT FK_Productos_Marca FOREIGN KEY (IdMarca) REFERENCES Marcas(IdMarca),
                CONSTRAINT FK_Productos_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria));
                PRINT 'La tabla Productos creada CORRECTAMENTE';
          END
       ELSE
          BEGIN
              PRINT 'La tabla Productos ya EXISTE'
          END
COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO
--============================================
--CREATE TABLE 04 Presentaciones
--============================================   
 BEGIN TRANSACTION;
 BEGIN TRY
          IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME ='Presentaciones' AND TABLE_SCHEMA = 'dbo')
          BEGIN
               CREATE TABLE dbo.Presentaciones(
               IdPresentacion INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
               IdProducto INT NOT NULL,
               Nombre VARCHAR (50) NOT NULL,
               Cantidad INT NOT NULL,
               CONSTRAINT UQ_Presentacion UNIQUE(IdProducto,Nombre),
               CONSTRAINT FK_Presentaciones_IdProducto FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto));
               PRINT 'La tabla Presentaciones creada CORRECTAMENTE'
            END
         ELSE
            BEGIN
                PRINT 'La tabla Presentaciones YA EXISTE'
            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO           
 --============================================
--CREATE TABLE 05 Precios
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Precios' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Precios (
                                   IdPrecio INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdPresentacion INT NOT NULL,
                                   Precio  DECIMAL(10,2)  NOT NULL,
                                   FechaInicio DATETIME NOT NULL,
                                   FechaFin DATETIME  NULL,
                                   CONSTRAINT FK_Precio_IdPresentacion FOREIGN KEY (IdPresentacion) REFERENCES Presentaciones(IdPresentacion));
                                   PRINT 'La tabla Presentaciones creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Presentaciones YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO           
                                   

 --============================================
--CREATE TABLE 06 Inventario
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Inventario' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Inventario (
                                   IdInventario INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdPresentacion INT NOT NULL,
                                   Existencia INT NOT NULL,
                                   CONSTRAINT FK_Inventario_IdPresentacion FOREIGN KEY (IdPresentacion) REFERENCES Presentaciones(IdPresentacion));
                                   
                                   PRINT 'La tabla Inventario creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Inventario YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO    
 --============================================
--CREATE TABLE 07 Movimientos_Inventario
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Movimientos_Inventario' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Movimientos_Inventario (
                                   IdMovimientos_Inventario INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdPresentacion INT NOT NULL,
                                   TipoMovimiento VARCHAR (20) NOT NULL,
                                   Cantidad INT NOT NULL,
                                   Fecha DATETIME NOT NULL,
                                   Motivo VARCHAR (200) NOT NULL,
                                   CHECK(TipoMovimiento IN ('ENTRADA','SALIDA')),
                                   CONSTRAINT FK_Movimientos_Inventario_IdPresentacion FOREIGN KEY (IdPresentacion) REFERENCES Presentaciones(IdPresentacion));
                                   PRINT 'La tabla Movimientos_Inventario creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Movimientos_Inventario YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO

GO    
 --============================================
--CREATE TABLE 08 Clientes
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Clientes' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Clientes (
                                   IdCliente INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   Nombre VARCHAR (100));
                                   PRINT 'La tabla Clientes creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Clientes YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO  
 --============================================
--CREATE TABLE 09 Ventas
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ventas' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Ventas (
                                   IdVenta INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   Fecha DATETIME NOT NULL,
                                   Total DECIMAL(10,2) NOT NULL,
                                   IdCliente INT NOT NULL,
                                   CONSTRAINT FK_Ventas_IdCliente FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente));

                                   PRINT 'La tabla Ventas creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Ventas YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO     

 --============================================
--CREATE TABLE 10 Detalle_Venta
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Detalle_Venta' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Detalle_Venta (
                                   IdDetalle_Venta INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdVenta INT NOT NULL,
                                   IdPresentacion INT NOT NULL,
                                   Cantidad INT NOT NULL,
                                   PrecioUnitario DECIMAL(10,2) NOT NULL,
                                   SubTotal DECIMAL(10,2) NOT NULL,

                                   CONSTRAINT FK_Detalle_Venta_IdVenta FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
                                   CONSTRAINT FK_Detalle_Venta_IdPresentacion FOREIGN KEY (IdPresentacion) REFERENCES Presentaciones(IdPresentacion));

                                   PRINT 'La tabla Detalle_Venta creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Detalle_Venta YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO
 --============================================
--CREATE TABLE 11 Proveedores
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proveedores' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Proveedores (
                                   IdProveedor INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   Nombre VARCHAR (100) NOT NULL,
                                   Telefono VARCHAR (20) NOT NULL,  
                                   CONSTRAINT UQ_Proveedor_Nombre UNIQUE(Nombre)
                                  );

                                   PRINT 'La tabla Proveedores creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Proveedores YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO           
 --============================================
--CREATE TABLE 12 Compras
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Compras' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Compras (
                                   IdCompra INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdProveedor INT NOT NULL,
                                   Fecha DATETIME NOT NULL,
                                   Total DECIMAL(10,2) NOT NULL,
                                   CONSTRAINT FK_Compras_IdProveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor));

                                   PRINT 'La tabla Compras creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Compras YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO       
 --============================================
--CREATE TABLE 13 Detalle_Compra
--============================================    
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Detalle_Compra' AND TABLE_SCHEMA = 'dbo')
      BEGIN
          CREATE TABLE dbo.Detalle_Compra (
                                   IdDetalle_Compra INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                                   IdCompra INT NOT NULL,
                                   IdPresentacion INT NOT NULL,
                                   Cantidad INT NOT NULL,
                                   Costo DECIMAL(10,2) NOT NULL,

                                   CONSTRAINT FK_Detalle_Compra_IdCompra FOREIGN KEY (IdCompra) REFERENCES Compras(IdCompra),
                                   CONSTRAINT FK_Detalle_Compra_IdPresentacion FOREIGN KEY (IdPresentacion) REFERENCES Presentaciones(IdPresentacion)
                                  );

                                   PRINT 'La tabla Detalle_Compra creada CORRECTAMENTE'
                                   END
                               ELSE
                           BEGIN
                                 PRINT 'La tabla Detalle_Compra YA EXISTE'
                            END
 COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
       ROLLBACK TRANSACTION;
    THROW
END CATCH
GO       
                  


                  USE DepositoBD
GO


--=====================================
-- TOTAL PRODUCTOS
--=====================================

CREATE PROCEDURE sp_Dashboard_TotalProductos
AS
BEGIN

SELECT COUNT(*) Total
FROM Productos
WHERE Activo = 1

END
GO



--=====================================
-- TOTAL CLIENTES
--=====================================

CREATE PROCEDURE sp_Dashboard_TotalClientes
AS
BEGIN

SELECT COUNT(*) Total
FROM Clientes

END
GO




--=====================================
-- TOTAL VENTAS
--=====================================

CREATE PROCEDURE sp_Dashboard_TotalVentas
AS
BEGIN

SELECT COUNT(*) Total
FROM Ventas

END
GO




--=====================================
-- INVENTARIO
--=====================================

CREATE PROCEDURE sp_Dashboard_TotalInventario
AS
BEGIN


SELECT ISNULL(SUM(Existencia),0) Total
FROM Inventario


END
GO




--=====================================
-- VENTAS ULTIMOS MESES
--=====================================

CREATE PROCEDURE sp_Dashboard_VentasMes
AS
BEGIN


SELECT

DATENAME(MONTH,Fecha) Mes,

SUM(Total) Total


FROM Ventas

GROUP BY
DATENAME(MONTH,Fecha),
MONTH(Fecha)

ORDER BY MONTH(Fecha)


END
GO


CREATE PROCEDURE sp_DashboardResumen
AS
BEGIN

SELECT

(SELECT COUNT(*) 
 FROM Productos) AS TotalProductos,


(SELECT COUNT(*) 
 FROM Clientes) AS TotalClientes,


(SELECT COUNT(*) 
 FROM Ventas) AS TotalVentas,


(SELECT ISNULL(SUM(Existencia),0)
 FROM Inventario) AS TotalInventario

END
GO