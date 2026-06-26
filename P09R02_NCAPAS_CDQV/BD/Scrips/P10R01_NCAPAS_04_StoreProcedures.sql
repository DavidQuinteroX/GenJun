USE DepositoBD
GO

--============================================
--Autor:Carlos David Quintero Villegas
--Created:20260617
--Descripcion: Procedimientos almacenados
--P10R01_NCAPAS_03_StoreProcedure:
--============================================

--============================
-- 1. CATEGORIAS
--============================
-- 1. INSERTAR        
--============================
--sp_help 'CATEGORIAS'

CREATE OR ALTER PROCEDURE dbo.sp_Insert_Categoria
          @Nombre VARCHAR (200)
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
           BEGIN TRANSACTION;
           IF EXISTS(SELECT 1 FROM dbo.Categorias WHERE Nombre = @Nombre)
              THROW 50001,'Ya existe una Categoria con ese Nombre',1;
           INSERT INTO dbo.Categorias (Nombre)
           VALUES (@Nombre);

           COMMIT TRANSACTION;
           SELECT 'Categoria Insertada Correctamente' AS Mensaje;
      END TRY
      BEGIN CATCH
           IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
           THROW;
      END CATCH
END
GO
--============================
-- 2. LEER  GET CATEGORIA POR ID       
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetCategoriaById
                          @IdCategoria INT
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
              SELECT IdCategoria,
                      Nombre
              FROM dbo.Categorias
              WHERE IdCategoria =@IdCategoria;

              IF @@ROWCOUNT = 0
              PRINT 'No se encontro esa Categoria';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO

--============================
-- 2.1 LEER  GET CATEGORIA       
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetCategorias                          
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
              SELECT  
              IdCategoria,
              Nombre
              FROM dbo.Categorias              
              IF @@ROWCOUNT = 0
              PRINT 'No se encontro esa Categoria';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO
--============================
-- 3.UPDATE ACTUALIZAR CATEGORIA        
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Categoria
                          @IdCategoria INT,
                          @Nombre VARCHAR (200)
AS
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRY
          BEGIN TRANSACTION;
          UPDATE dbo.Categorias
          SET
             Nombre = @Nombre
          WHERE IdCategoria = @IdCategoria;
          
          IF @@ROWCOUNT = 0
          BEGIN
               THROW 5002,'No se encontro ninguna Categoria con ese ID',1;
          END 
          COMMIT TRANSACTION;
    END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    IF ERROR_NUMBER() IN (2601, 2627)
    BEGIN
        THROW 5003, 'Ya existe una categoría con ese nombre.', 1;
    END
    ELSE
    THROW;
END CATCH
END
GO
--============================
-- 4.DELETE ELIMINAR CATEGORIA        
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Categoria
                          @IdCategoria INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    -- VALIDAR SI ESTA USADA
        IF EXISTS(
            SELECT 1 
            FROM Productos
            WHERE IdCategoria = @IdCategoria
        )
        BEGIN
            THROW 50006,
            'No se puede eliminar porque esta categoría está siendo usada.',
            1;
        END
             DELETE FROM dbo.Categorias
             WHERE IdCategoria = @IdCategoria;

           IF @@ROWCOUNT = 0
           THROW 50005, 'No se encontró la categoría.', 1;
    END TRY
  BEGIN CATCH
    THROW;
  END CATCH
END
GO



--============================
-- 2.MARCAS
--============================
--============================
-- 1. INSERTAR         MARCAS
--============================
--  
CREATE OR ALTER PROCEDURE dbo.sp_Insert_marcas 
                          @Nombre VARCHAR (200)
AS 
BEGIN
     SET NOCOUNT ON ;
     BEGIN TRY
           BEGIN TRANSACTION;
           IF EXISTS(SELECT 1 FROM dbo.Marcas WHERE Nombre = @Nombre)
              THROW 50001,'Ya existe una Marca con ese Nombre',1;
           INSERT INTO dbo.Marcas(Nombre)
           VALUES(@Nombre)

           COMMIT TRANSACTION;
           SELECT 'Marca Insertada Correctamente' AS Mensaje;
      END TRY
      BEGIN CATCH
           IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
           THROW;
      END CATCH
END
GO
--============================
-- 2. Leer         MARCASporId
--============================
CREATE OR ALTER PROCEDURE dbo.spGetMarcaById
                         @IdMarca INT
AS
BEGIN 
     SET NOCOUNT ON;
         BEGIN TRY               
              SELECT IdMarca,Nombre
              FROM dbo.Marcas
              WHERE IdMarca=@IdMarca;
               IF @@ROWCOUNT = 0
              PRINT 'No se encontro esa Marca';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO

--============================
-- 2.1 Leer         MARCAS
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetMarcas
AS 
BEGIN 
    SET NOCOUNT ON;
        BEGIN TRY
           SELECT  
              IdMarca,
              Nombre
              FROM dbo.Marcas              
              IF @@ROWCOUNT = 0
              PRINT 'No se encontro esa Marca';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO

--============================
-- 3 Actualizar         MARCAS
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Marca
                          @IdMarca INT,
                          @Nombre VARCHAR (200)
As
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
          BEGIN TRANSACTION;
          UPDATE dbo.Marcas
          SET
             Nombre=@Nombre
          WHERE IdMarca = @IdMarca;
                    IF @@ROWCOUNT = 0
          BEGIN
               THROW 5002,'No se encontro ninguna Marca con ese ID',1;
          END 
          COMMIT TRANSACTION;
    END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    IF ERROR_NUMBER() IN (2601, 2627)
    BEGIN
        THROW 5003, 'Ya existe una Marca con ese nombre.', 1;
    END
    ELSE
    THROW;
    END CATCH
END 
GO

--============================
-- 4 DELETE         MARCAS
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Marca
                          @IdMarca INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
            DELETE FROM dbo.Marcas
            WHERE IdMarca = @IdMarca;

                       IF @@ROWCOUNT = 0
           THROW 50005, 'No se encontró la Marca.', 1;
    END TRY
  BEGIN CATCH
    THROW;
  END CATCH
END
GO



--============================
-- 3.PRODUCTOS 
--============================
--============================
-- 1. INSERTAR       PRODUCTOS 
--============================
--sp_help'Productos'


CREATE OR ALTER PROCEDURE dbo.sp_Insert_Productos
                         @Nombre VARCHAR (100),
                         @IdMarca INT,
                         @IdCategoria INT,
                         @ContenidoML INT,
                         @Activo Bit 
AS 
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
     BEGIN TRANSACTION;
     --VALIDAR QUE NO EXISTA
     IF EXISTS(SELECT 1 FROM dbo.Productos WHERE Nombre = @Nombre)
     THROW 50001,'Ya existe un Producto con ese Nombre',1;
           INSERT INTO dbo.Productos(Nombre,IdMarca,IdCategoria,ContenidoML,Activo)
           VALUES(@Nombre,
                  @IdMarca,
                  @IdCategoria,
                  @ContenidoML,
                  @Activo);
          COMMIT TRANSACTION;
     END TRY
      BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END
GO
--============================
-- 2. Leer  GET ID  PRODUCTOS 
--============================
--sp_help'Productos'
CREATE OR ALTER PROCEDURE dbo.sp_GetProductosById
@IdProducto INT
AS
BEGIN

SELECT
    p.IdProducto,
    p.Nombre,
    p.IdMarca,
    p.IdCategoria,
    m.Nombre AS Marca,
    c.Nombre AS Categoria,
    p.ContenidoML,
    p.Activo
FROM Productos p
INNER JOIN Marcas m
ON p.IdMarca=m.IdMarca
INNER JOIN Categorias c
ON p.IdCategoria=c.IdCategoria
WHERE p.IdProducto=@IdProducto;

END
GO

--============================
-- 2.1 Leer  GET  PRODUCTOS 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetProductos

AS
BEGIN
     SET NOCOUNT ON;
    SELECT
    p.IdProducto,
    p.Nombre,
    p.IdMarca,
    p.IdCategoria,
    m.Nombre AS Marca,
    c.Nombre AS Categoria,
    p.ContenidoML,
    p.Activo
FROM Productos p
INNER JOIN Marcas m
ON p.IdMarca=m.IdMarca
INNER JOIN Categorias c
ON p.IdCategoria=c.IdCategoria;

END
GO

--============================
-- 3 Actualizar UPDATE PRODUCTOS 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Producto
                          @IdProducto INT,
                          @Nombre VARCHAR (1000),
                          @IdMarca INT,
                          @IdCategoria INT,
                          @ContenidoML INT,
                          @Activo BIT
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
           BEGIN TRANSACTION;

           --VALIDAR QUE EXISTA

           IF NOT EXISTS(SELECT 1 FROM dbo.Productos WHERE IdProducto = @IdProducto)
              
             BEGIN
                  THROW 5001,'No existe ese Producto',1;
             END

             UPDATE dbo.Productos
             SET Nombre =@Nombre,
                 IdMarca = @IdMarca,
                 IdCategoria = @IdCategoria,
                 ContenidoML = @ContenidoML,
                 Activo = @Activo
                 WHERE IdProducto =@IdProducto;

                COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO
--============================
-- 4 Eliminar Delete PRODUCTOS 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Producto
                          @IdProducto INT
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
          DELETE FROM dbo.Productos 
          WHERE IdProducto = @IdProducto;
           
           IF @@ROWCOUNT = 0
           BEGIN
           THROW 50005, 'No se encontró el Producto.', 1;
           END
    END TRY
  BEGIN CATCH
    THROW;
  END CATCH
END
GO

--============================
-- 4.PRESENTACIONES 
--============================
--============================
-- 1. INSERTAR       PRESENTACIONS 
--============================
--sp_help 'Presentaciones'

CREATE OR ALTER PROCEDURE dbo.sp_Insert_Presentacion
                          @IdProducto INT,
                          @Nombre VARCHAR (50),
                          @Cantidad INT

AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
          BEGIN TRANSACTION;
          IF EXISTS (SELECT 1 FROM Presentaciones WHERE IdProducto=@IdProducto AND Nombre=@Nombre)
             THROW 5001,'Ya existe una Presentacion con ese Nombre',1;
          INSERT INTO dbo.Presentaciones (IdProducto,Nombre,Cantidad)
          VALUES (@IdProducto,@Nombre,@Cantidad)

          COMMIT TRANSACTION;
          SELECT 'Presentacion Agregada Correctamente' AS mensaje;
     END TRY
     BEGIN CATCH
       IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
           THROW;
      END CATCH
END
GO

--============================
-- 2. LEER  GET Presentacion POR ID       
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetPresentacionById
    @IdPresentacion INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Presentaciones
            WHERE IdPresentacion = @IdPresentacion
        )
        BEGIN
            THROW 50001, 'No existe la presentación.', 1;
        END

       SELECT
        pr.IdPresentacion,
        pr.IdProducto,
        p.Nombre AS Producto,
        pr.Nombre AS Presentacion,
        pr.Cantidad
        FROM Presentaciones pr
        INNER JOIN Productos p
        ON pr.IdProducto=p.IdProducto
        WHERE pr.IdPresentacion = @IdPresentacion;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
                      

--============================
-- 2.1 LEER  GET PRESENTACION       
--============================                   

CREATE OR ALTER PROCEDURE dbo.sp_GetPresentacion
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
              SELECT
pr.IdPresentacion,
pr.IdProducto,
p.Nombre AS Producto,
pr.Nombre AS Presentacion,
pr.Cantidad
FROM Presentaciones pr
INNER JOIN Productos p
ON pr.IdProducto=p.IdProducto

              IF @@ROWCOUNT = 0
              PRINT 'No se encontro esa Presentacion';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO


--============================
-- 3.UPDATE ACTUALIZAR CATEGORIA        
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Update_Presentacion
                          @IdPresentacion INT,
                          @IdProducto INT,
                          @Nombre VARCHAR (50),
                          @Cantidad INT

AS
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
              BEGIN TRANSACTION;
              UPDATE dbo.Presentaciones
              SET
                 IdProducto = @IdProducto,
                 Nombre = @Nombre,
                 Cantidad = @Cantidad

                 WHERE IdPresentacion = @IdPresentacion;

                 IF @@ROWCOUNT = 0
              BEGIN
               THROW 5002,'No se encontro ninguna Presentacion con ese ID',1;
               END
               COMMIT TRANSACTION;
               END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    IF ERROR_NUMBER() IN (2601, 2627)
    BEGIN
        THROW 5003, 'Ya existe una Presentacion con ese nombre.', 1;
    END
    ELSE
    THROW;
END CATCH
END
GO

--============================
-- 4.DELETE ELIMINAR Presentacion        
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Delete_Presentacion
                          @IdPresentacion INT
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
             DELETE FROM dbo.Presentaciones
             WHERE IdPresentacion =@IdPresentacion;

           IF @@ROWCOUNT = 0
           BEGIN
           THROW 50005, 'No se encontró la Presentacion.', 1;
           END
    END TRY
  BEGIN CATCH
    THROW;
  END CATCH
END
GO
--============================
-- 6.Presentacon Combo
--============================

CREATE OR ALTER PROCEDURE sp_GetPresentacionesCombo
AS
BEGIN

SELECT

p.IdPresentacion,

pr.Nombre AS Producto,

p.Nombre AS Presentacion


FROM Presentaciones p

INNER JOIN Productos pr
ON p.IdProducto = pr.IdProducto


ORDER BY pr.Nombre,p.Nombre

END
GO

--============================
-- 5.PRECIOS 
--============================
--============================
-- 1. INSERTAR       PRECIOS 
--============================
--sp_help 'Precios'

CREATE OR ALTER PROCEDURE dbo.sp_Insertar_Precios     
                          @IdPresentacion INT,
                          @Precio DECIMAL(10,2),
                          @FechaInicio DATETIME,
                          @FechaFin DATETIME
AS
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
              BEGIN TRANSACTION;
              IF EXISTS(SELECT 1 FROM dbo.Precios WHERE IdPresentacion = @IdPresentacion)
                 THROW 50001,'Ya esa presentacion ya cuenta con precio',1;
              INSERT INTO dbo.Precios (IdPresentacion,Precio,FechaInicio,FechaFin)
              VALUES (@IdPresentacion,@Precio,@FechaInicio,@FechaFin);

              COMMIT TRANSACTION;
           SELECT 'Precio Insertado Correctamente' AS Mensaje;
      END TRY
      BEGIN CATCH
           IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
           THROW;
      END CATCH
END
GO
--============================
-- 2. GET Obtener por Id PRECIOS 
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetPreciosbyId
                         @IdPrecio INT 
AS 
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY 
               SELECT
               pc.IdPrecio,
               p.Nombre AS Producto,
               pr.Nombre AS Presentacion,
               pc.Precio,
               pc.FechaInicio,
               pc.FechaFin
               FROM Precios pc
               INNER JOIN Presentaciones pr
               ON pc.IdPresentacion = pr.IdPresentacion
               INNER JOIN Productos p
               ON pr.IdProducto = p.IdProducto
               WHERE pc.IdPrecio=@IdPrecio;


                IF @@ROWCOUNT = 0
              PRINT 'No se encontro ese Precio';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH

END
GO
--============================
-- 2.1 GET Obtener PRECIOS 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetPrecios
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
              SELECT
pc.IdPrecio,
p.Nombre AS Producto,
pr.Nombre AS Presentacion,
pc.Precio,
pc.FechaInicio,
pc.FechaFin
FROM Precios pc
INNER JOIN Presentaciones pr
ON pc.IdPresentacion=pr.IdPresentacion
INNER JOIN Productos p
ON pr.IdProducto=p.IdProducto
              IF @@ROWCOUNT = 0
              PRINT 'No se encontro ese Producto';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO

--============================
-- 3 Udate PRECIOS 
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Update_Precios
                          @IdPrecio INT ,
                          @IdPresentacion INT,
                          @Precio DECIMAL (18,2),
                          @FechaInicio DATETIME,
                          @FechaFin DATETIME

                          
AS
BEGIN 
    SET NOCOUNT ON;
    BEGIN TRY
            BEGIN TRANSACTION;

            --VALIDAR QUE EXISTE

            IF NOT EXISTS(SELECT 1 FROM dbo.Precios WHERE IdPrecio =@IdPrecio)
            BEGIN
                  THROW 5001,'No existe ese Precio',1;
            END

            UPDATE dbo.Precios
            SET IdPresentacion = @IdPresentacion,
                Precio = @Precio,
                FechaInicio = @FechaInicio,
                FechaFin =@FechaFin
                WHERE IdPrecio = @IdPrecio;

                COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

--============================
-- 4 DELETE PRECIOS 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Precios
                          @IdPrecio INT
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
               DELETE FROM dbo.Precios
               WHERE IdPrecio = @IdPrecio;

               IF @@ROWCOUNT = 0
           BEGIN
           THROW 50005, 'No se encontró el Precio.', 1;
           END
    END TRY
    BEGIN CATCH
      THROW;
    END CATCH
END
GO



--============================
-- 6.INVENTARIO 
--============================
--============================
-- 1. INSERTAR       INVENTARIO 
--============================
--sp_help 'INVENTARIO'

CREATE OR ALTER PROCEDURE dbo.sp_Insert_Inventario
                         
                          @IdPresentacion INT,
                          @Existencia INT
AS 
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY
              BEGIN TRANSACTION;
              IF EXISTS(SELECT 1 FROM Inventario WHERE IdPresentacion=@IdPresentacion)
                       THROW 5001,'Ya existe inventario para esa presentación',1;
              INSERT INTO dbo.Inventario (IdPresentacion,Existencia)
              VALUES (@IdPresentacion,@Existencia)
              COMMIT TRANSACTION;
              SELECT 'Inventario Agregado Corectamente' AS Mensaje;
     END TRY
      BEGIN CATCH
       IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
           THROW;
      END CATCH
END
GO


--============================
-- 2.LEER GET INVENTARIO POR ID 
--============================
--sp_help 'INVENTARIO'

CREATE OR ALTER PROCEDURE dbo.sp_GetInventarioById
                          @IdInventario INT
AS
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
                   IF NOT EXISTS (SELECT 1 FROM dbo.Inventario WHERE IdInventario = @IdInventario)
                   BEGIN
                        THROW 5001,'No existe ese Inventario.',1;
                   END
                   
                  SELECT
                        i.IdInventario,
                        p.Nombre AS Producto,
                        pr.Nombre AS Presentacion,
                        i.Existencia
                        FROM Inventario i
                        INNER JOIN Presentaciones pr
                        ON i.IdPresentacion=pr.IdPresentacion
                        INNER JOIN Productos p
                        ON pr.IdProducto=p.IdProducto
                        WHERE i.IdInventario=@IdInventario
    END TRY
    BEGIN CATCH
    THROW;
    END CATCH
END
GO

--============================
-- 2.1 LEER GET INVENTARIO  
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetInventario
AS
BEGIN
     SET NOCOUNT ON;
                    BEGIN TRY
                             SELECT 
                             i.IdInventario,
                             p.Nombre AS Producto,
                             pr.Nombre AS Presentacion,
                             i.Existencia
                             FROM Inventario i
                             INNER JOIN Presentaciones pr
                             ON i.IdPresentacion=pr.IdPresentacion
                             INNER JOIN Productos p
                             ON pr.IdProducto=p.IdProducto                                                                                           

                             IF @@ROWCOUNT = 0

                             PRINT 'No se encontro esa Presentacion';

                    END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO



--============================
-- 3 UPDATE  INVENTARIO  
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Update_Inventario
                          @IdInventario INT,
                          @IdPresentacion INT,
                          @Existencia INT
AS 
BEGIN 
     SET NOCOUNT ON;
                   BEGIN TRY
                            BEGIN TRANSACTION;
                            UPDATE dbo.Inventario
                            SET IdPresentacion = @IdPresentacion,
                                Existencia = @Existencia
                            WHERE IdInventario = @IdInventario;

                            IF @@ROWCOUNT = 0
                            BEGIN
                            THROW 5002,'No se encontro ninguna Presentacion con ese ID',1;
                            END
                            COMMIT TRANSACTION;
                   END TRY
     BEGIN CATCH
                IF @@TRANCOUNT > 0
                ROLLBACK TRANSACTION;

                IF ERROR_NUMBER() IN (2601, 2627)
                BEGIN
                THROW 5003, 'Ya existe una Presentacion con ese nombre.', 1;
                END
                ELSE
                THROW;
END CATCH
END
GO

--============================
-- 4 DELETE  INVENTARIO  
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Inventario    
                          @IdInventario INT
AS
BEGIN
     SET NOCOUNT ON;
                    BEGIN TRY
                    DELETE FROM dbo.Inventario
                    WHERE IdInventario = @IdInventario;

                    IF @@ROWCOUNT = 0
                     BEGIN
                     THROW 50005, 'No se encontró la Presentacion.', 1;
                     END
                     END TRY
                     BEGIN CATCH
                     THROW;
                     END CATCH
END
GO

--============================
-- 7.MOVIMIENTOS 
--============================
--============================
-- 1. INSERTAR MOVIMIENTOS
--============================
CREATE OR ALTER PROCEDURE sp_Insert_Movimientos_Inventario
@IdPresentacion INT,
@TipoMovimiento VARCHAR(20),
@Cantidad INT,
@Fecha DATETIME,
@Motivo VARCHAR(200)

AS
BEGIN

SET NOCOUNT ON;

BEGIN TRANSACTION;

BEGIN TRY


INSERT INTO Movimientos_Inventario
(
IdPresentacion,
TipoMovimiento,
Cantidad,
Fecha,
Motivo
)
VALUES
(
@IdPresentacion,
@TipoMovimiento,
@Cantidad,
@Fecha,
@Motivo
);



IF @TipoMovimiento='ENTRADA'
BEGIN

UPDATE Inventario
SET Existencia = Existencia + @Cantidad
WHERE IdPresentacion=@IdPresentacion;

END



IF @TipoMovimiento='SALIDA'
BEGIN

IF EXISTS
(
SELECT 1
FROM Inventario
WHERE IdPresentacion=@IdPresentacion
AND Existencia >= @Cantidad
)
BEGIN

UPDATE Inventario
SET Existencia = Existencia - @Cantidad
WHERE IdPresentacion=@IdPresentacion;

END

ELSE
BEGIN

THROW 50010,'Stock insuficiente',1;

END

END


COMMIT TRANSACTION;


SELECT 'Movimiento registrado correctamente';


END TRY

BEGIN CATCH

ROLLBACK TRANSACTION;

THROW;

END CATCH

END
GO
--============================
-- 2. GET MOVIMIENTO BY ID
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetMovimientoById
        @IdMovimiento_Inventario INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM dbo.Movimientos_Inventario WHERE IdMovimientos_Inventario = @IdMovimiento_Inventario)
        BEGIN
            THROW 50002,'No existe ese movimiento.',1;
        END
        SELECT
    m.IdMovimientos_Inventario,
    m.IdPresentacion,
    p.Nombre AS Producto,
    pr.Nombre AS Presentacion,
    m.TipoMovimiento,
    m.Cantidad,
    m.Fecha,
    m.Motivo
FROM dbo.Movimientos_Inventario m
INNER JOIN dbo.Presentaciones pr
    ON m.IdPresentacion = pr.IdPresentacion
INNER JOIN dbo.Productos p
    ON pr.IdProducto = p.IdProducto
        WHERE m.IdMovimientos_Inventario = @IdMovimiento_Inventario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
--============================
-- 2.1 GET TODOS LOS MOVIMIENTOS
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetMovimientos_Inventario
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
       SELECT
    m.IdMovimientos_Inventario,
    m.IdPresentacion,
    p.Nombre AS Producto,
    pr.Nombre AS Presentacion,
    m.TipoMovimiento,
    m.Cantidad,
    m.Fecha,
    m.Motivo
FROM dbo.Movimientos_Inventario m
INNER JOIN dbo.Presentaciones pr
    ON m.IdPresentacion = pr.IdPresentacion
INNER JOIN dbo.Productos p
    ON pr.IdProducto = p.IdProducto
        IF @@ROWCOUNT = 0
            PRINT 'No hay movimientos registrados';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO
--============================
-- 3. UPDATE MOVIMIENTOS
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Movimiento_Inventario
        @IdMovimiento_Inventario INT,
        @IdPresentacion INT,
        @TipoMovimiento VARCHAR(20),
        @Cantidad INT,
        @Fecha DATETIME,
        @Motivo VARCHAR(200)

AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY

        BEGIN TRANSACTION;
        IF NOT EXISTS
        (
            SELECT 1
            FROM dbo.Movimientos_Inventario
            WHERE IdMovimientos_Inventario = @IdMovimiento_Inventario
        )
        BEGIN
            THROW 50003,'No existe ese movimiento.',1;
        END
        UPDATE dbo.Movimientos_Inventario
        SET

            IdPresentacion = @IdPresentacion,
            TipoMovimiento = @TipoMovimiento,
            Cantidad = @Cantidad,
            Fecha = @Fecha,
            Motivo = @Motivo

        WHERE IdMovimientos_Inventario = @IdMovimiento_Inventario;

        COMMIT TRANSACTION;

        SELECT 'Movimiento actualizado correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
--============================
-- 4. DELETE MOVIMIENTO
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Movimiento_Inventario
        @IdMovimiento_Inventario INT
AS
BEGIN

    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM dbo.Movimientos_Inventario
        WHERE IdMovimientos_Inventario = @IdMovimiento_Inventario;
        IF @@ROWCOUNT = 0
        BEGIN
            THROW 50004,'No se encontró el movimiento.',1;
        END
        SELECT 'Movimiento eliminado correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO       
--============================================
-- 8.CLIENTES
--============================================
--============================
-- 1 INSERT CLIENTE
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_Cliente
    @Nombre VARCHAR(100)
AS
BEGIN
     SET NOCOUNT ON;                    
                    BEGIN TRY
                    BEGIN TRANSACTION;
                    
                    INSERT INTO dbo.Clientes(Nombre)
                    VALUES(@Nombre);
                    
                    COMMIT TRANSACTION;                    
                    SELECT 'Cliente Insertado Correctamente' AS Mensaje;                    
                    END TRY
                    BEGIN CATCH
                    IF @@TRANCOUNT > 0 ROLLBACK;
                    THROW;
                    END CATCH
END
GO

--============================
-- 2 GET ID CLIENTE
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetClienteById
@IdCliente INT
AS
BEGIN
SET NOCOUNT ON;

SELECT *
FROM Clientes
WHERE IdCliente=@IdCliente;

IF @@ROWCOUNT=0
PRINT 'No existe Cliente';

END
GO

--============================
--2.1 GET TODOS CLIENTE
--============================ 
CREATE OR ALTER PROCEDURE dbo.sp_GetClientes
AS
BEGIN
SET NOCOUNT ON;

SELECT *
FROM Clientes;

END
GO
--============================
-- 3 UPDATE CLIENTE
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Cliente
@IdCliente INT,
@Nombre VARCHAR(100)
AS
BEGIN
     SET NOCOUNT ON;
     UPDATE Clientes
     SET Nombre=@Nombre
     WHERE IdCliente=@IdCliente;
IF @@ROWCOUNT=0
THROW 50001,'No existe Cliente',1;
END
GO
--============================
-- 4 DELETE CLIENTE
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Cliente
@IdCliente INT
AS
BEGIN
DELETE FROM Clientes
WHERE IdCliente=@IdCliente;
IF @@ROWCOUNT=0
THROW 50002,'Cliente no encontrado',1;
END
GO
--============================================
-- 9.PROVEEDORES
--============================================
--============================
-- 1 Insert PROVEEDOR
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_Proveedor
@Nombre VARCHAR(100),
@Telefono VARCHAR(20)
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY
     BEGIN TRANSACTION;
     IF EXISTS(SELECT 1 FROM Proveedores WHERE Nombre=@Nombre)
     THROW 50001,'Proveedor ya existe',1;


       INSERT INTO Proveedores
       (
       Nombre,
       Telefono
       )
       VALUES
       (
       @Nombre,
       @Telefono
       );

COMMIT;

END TRY
BEGIN CATCH

IF @@TRANCOUNT>0 ROLLBACK;
THROW;

END CATCH
END
GO
--============================
-- 2. GET  ID PROVEEDOR
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetProveedorById
@IdProveedor INT
AS
BEGIN

SELECT *
FROM Proveedores
WHERE IdProveedor=@IdProveedor;

END
GO

--============================
-- 2 GET PROVEEDOR
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetProveedores
AS
BEGIN

SELECT *
FROM Proveedores;

END
GO

--============================
-- 3 UPDATE PROVEEDOR
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Update_Proveedor
@IdProveedor INT,
@Nombre VARCHAR(100),
@Telefono VARCHAR(20)
AS
BEGIN


UPDATE Proveedores
SET
Nombre=@Nombre,
Telefono=@Telefono
WHERE IdProveedor=@IdProveedor;


IF @@ROWCOUNT=0
THROW 50002,'Proveedor no encontrado',1;

END
GO

--============================
--4 DELETE PROVEEDOR
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Proveedor
@IdProveedor INT
AS
BEGIN

DELETE FROM Proveedores
WHERE IdProveedor=@IdProveedor;


IF @@ROWCOUNT=0
THROW 50003,'Proveedor no encontrado',1;

END
GO

--============================================
-- 10.VENTAS
--============================================
--============================
-- 1 INSERT VENTA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_Venta
@IdCliente INT,
@Fecha DATETIME,
@Total DECIMAL(10,2)
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO Ventas
(
Fecha,
Total,
IdCliente
)
VALUES
(
@Fecha,
@Total,
@IdCliente
);

SELECT 'Venta registrada' AS Mensaje;
END
GO
--============================
-- 2 GET ID VENTA
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetVentaById
@IdVenta INT
AS
BEGIN

SELECT
    v.IdVenta,
    v.IdCliente,
    v.Fecha,
    v.Total,
    c.Nombre AS Cliente
FROM Ventas v
INNER JOIN Clientes c
    ON v.IdCliente = c.IdCliente
WHERE v.IdVenta = @IdVenta;

END
GO

--============================
-- 2.1 GET  VENTA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetVentas
AS
BEGIN

SELECT
    v.IdVenta,
    v.IdCliente,
    v.Fecha,
    v.Total,
    c.Nombre AS Cliente
FROM Ventas v
INNER JOIN Clientes c
    ON v.IdCliente = c.IdCliente;

END
GO
--============================
-- 3 UPDATE VENTA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Venta
@IdVenta INT,
@IdCliente INT,
@Fecha DATETIME,
@Total DECIMAL(10,2)
AS
BEGIN
UPDATE Ventas
SET
IdCliente=@IdCliente,
Fecha=@Fecha,
Total=@Total
WHERE IdVenta=@IdVenta;
IF @@ROWCOUNT=0
THROW 50001,'Venta no encontrada',1;
END
GO
--============================
-- 4 DELETE
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Venta
@IdVenta INT
AS
BEGIN
DELETE FROM Ventas
WHERE IdVenta=@IdVenta;
IF @@ROWCOUNT=0
THROW 50002,'Venta no encontrada',1;
END
GO

--============================
-- 5 DELETE
--============================

CREATE OR ALTER PROCEDURE dbo.sp_Insert_VentaDetalle
@IdCliente INT,
@Fecha DATETIME,
@Total DECIMAL(10,2)
AS
BEGIN

SET NOCOUNT ON;


INSERT INTO Ventas
(
Fecha,
Total,
IdCliente
)
VALUES
(
@Fecha,
@Total,
@IdCliente
);


SELECT SCOPE_IDENTITY() AS IdVenta;


END
GO
--============================================
-- 11.COMPRAS
--============================================
--============================
-- 1 INSERT COMPRA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_Compra
@IdProveedor INT,
@Fecha DATETIME,
@Total DECIMAL(10,2)
AS
BEGIN
INSERT INTO Compras
(
IdProveedor,
Fecha,
Total
)
VALUES
(
@IdProveedor,
@Fecha,
@Total
);
SELECT 'Compra registrada' AS Mensaje;
END
GO

--============================
-- 2 GET ID  COMPRA
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetCompraById
@IdCompra INT
AS
BEGIN


SELECT
c.IdCompra,
c.Fecha,
c.Total,
p.Nombre Proveedor
FROM Compras c
INNER JOIN Proveedores p
ON c.IdProveedor=p.IdProveedor
WHERE c.IdCompra=@IdCompra;


END
GO
--============================
-- 2.1 GET ID COMPRA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetCompras
AS
BEGIN
SELECT
c.IdCompra,
c.Fecha,
c.Total,
p.Nombre Proveedor
FROM Compras c
INNER JOIN Proveedores p
ON c.IdProveedor=p.IdProveedor;
END
GO
--============================
-- 3 UPDATE COMPRA 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Compra
@IdCompra INT,
@IdProveedor INT,
@Fecha DATETIME,
@Total DECIMAL(10,2)
AS
BEGIN
UPDATE Compras
SET
IdProveedor=@IdProveedor,
Fecha=@Fecha,
Total=@Total
WHERE IdCompra=@IdCompra;
IF @@ROWCOUNT=0
THROW 50001,'Compra no encontrada',1;
END
GO
--============================
-- 4 DELETE COMPRA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Compra
@IdCompra INT
AS
BEGIN
DELETE FROM Compras
WHERE IdCompra=@IdCompra;
IF @@ROWCOUNT=0
THROW 50002,'Compra no encontrada',1;
END
GO

--============================================
-- 12.DetalleVenta
--============================================
--============================
-- 1 INSERT COMPRA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_DetalleVenta
@IdVenta INT,
@IdPresentacion INT,
@Cantidad INT,
@PrecioUnitario DECIMAL(10,2)

AS
BEGIN

SET NOCOUNT ON;

BEGIN TRANSACTION;

BEGIN TRY


-- VALIDAR STOCK

IF NOT EXISTS
(
SELECT 1
FROM Inventario
WHERE IdPresentacion=@IdPresentacion
AND Existencia >= @Cantidad
)

BEGIN

THROW 50001,'Stock insuficiente',1;

END



-- INSERT DETALLE

INSERT INTO Detalle_Venta
(
IdVenta,
IdPresentacion,
Cantidad,
PrecioUnitario,
SubTotal
)

VALUES
(
@IdVenta,
@IdPresentacion,
@Cantidad,
@PrecioUnitario,
@Cantidad*@PrecioUnitario
);



-- RESTAR INVENTARIO

UPDATE Inventario
SET Existencia = Existencia - @Cantidad
WHERE IdPresentacion=@IdPresentacion;



-- ACTUALIZAR TOTAL VENTA

UPDATE Ventas
SET Total =
(
SELECT SUM(SubTotal)
FROM Detalle_Venta
WHERE IdVenta=@IdVenta
)

WHERE IdVenta=@IdVenta;



COMMIT;


SELECT 'Detalle agregado correctamente' AS Mensaje;


END TRY

BEGIN CATCH

IF @@TRANCOUNT>0
ROLLBACK;

THROW;

END CATCH

END
GO
--============================
-- 2 GET ID  COMPRA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetDetalleVentaByVenta
@IdVenta INT
AS
BEGIN

SELECT

dv.IdDetalle_Venta,

dv.IdVenta,

p.IdProducto,
dv.IdPresentacion,

pr.Nombre AS Producto,

p.Nombre AS Presentacion,

dv.Cantidad,

dv.PrecioUnitario,

dv.SubTotal

FROM Detalle_Venta dv

INNER JOIN Presentaciones p
ON dv.IdPresentacion = p.IdPresentacion

INNER JOIN Productos pr
ON p.IdProducto = pr.IdProducto

WHERE dv.IdVenta = @IdVenta;

END
GO
--============================
-- 3 GET   VENTA COMPLETA
--============================
CREATE OR ALTER PROCEDURE dbo.sp_GetVentaCompleta
@IdVenta INT
AS
BEGIN

SELECT

v.IdVenta,

c.Nombre AS Cliente,

v.Fecha,

pr.Nombre AS Producto,

p.Nombre AS Presentacion,

dv.Cantidad,

dv.PrecioUnitario,

dv.SubTotal,

v.Total


FROM Ventas v

INNER JOIN Clientes c
ON v.IdCliente = c.IdCliente

INNER JOIN Detalle_Venta dv
ON v.IdVenta = dv.IdVenta

INNER JOIN Presentaciones p
ON dv.IdPresentacion = p.IdPresentacion

INNER JOIN Productos pr
ON p.IdProducto = pr.IdProducto


WHERE v.IdVenta = @IdVenta;


END
GO

--============================
-- 4 GET  FACTURA COMPLETA
--============================

CREATE OR ALTER PROCEDURE dbo.sp_GetFacturaVenta
@IdVenta INT
AS
BEGIN

SELECT
    v.IdVenta,
    c.Nombre AS Cliente,
    v.Fecha,
    p.Nombre AS Presentacion,
    dv.Cantidad,
    dv.PrecioUnitario,
    dv.SubTotal,
    v.Total
FROM Ventas v
INNER JOIN Clientes c
    ON v.IdCliente = c.IdCliente
INNER JOIN Detalle_Venta dv
    ON v.IdVenta = dv.IdVenta
INNER JOIN Presentaciones p
    ON dv.IdPresentacion = p.IdPresentacion
WHERE v.IdVenta = @IdVenta;

END
GO


--============================
-- 5 UPDATE DETALLE   VENTA 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Update_DetalleVenta
@IdDetalle_Venta INT,
@IdPresentacion INT,
@Cantidad INT,
@PrecioUnitario DECIMAL(10,2)
AS
BEGIN

UPDATE Detalle_Venta
SET
    IdPresentacion = @IdPresentacion,
    Cantidad = @Cantidad,
    PrecioUnitario = @PrecioUnitario,
    SubTotal = @Cantidad * @PrecioUnitario
WHERE IdDetalle_Venta = @IdDetalle_Venta;

IF @@ROWCOUNT = 0
    THROW 50001,'Detalle no encontrado',1;

END
GO

--============================
-- 6 DELETE DETALLE   VENTA 
--============================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_DetalleVenta
@IdDetalle_Venta INT
AS
BEGIN

DELETE FROM Detalle_Venta
WHERE IdDetalle_Venta = @IdDetalle_Venta;

IF @@ROWCOUNT = 0
    THROW 50002,'Detalle no encontrado',1;

END
GO


