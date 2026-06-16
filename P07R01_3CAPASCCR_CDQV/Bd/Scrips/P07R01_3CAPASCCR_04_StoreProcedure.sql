USE GenJunCCR
GO

--Autor:Carlos David Quintero Villegas
--Created:20260609
--Descripcion:Store Procedueres
--P07R01_3CAPASCCR_04_StoreProcedures
--sp_help 'Rutas'

--===========================================
--
--===========================================

CREATE OR ALTER PROCEDURE dbo.Insert_Camion
         @Matricula VARCHAR(50),
         @TipoCamion VARCHAR(50),
         @Modelo INT,
         @Marca VARCHAR(50),
         @Capacidad INT,
         @Kilometraje FLOAT,
         @Disponibilidad BIT,
         @UrlFoto VARCHAR (255)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY 
          BEGIN TRANSACTION;

          IF EXISTS (SELECT 1 FROM dbo.Camiones WHERE Matricula = @Matricula)
             THROW 50001,'Ya existe un camion con esa matricula',1;
          INSERT INTO dbo.Camiones
          VALUES (@Matricula,@TipoCamion,@Modelo,@Marca,@Capacidad,@Kilometraje,@Disponibilidad,@UrlFoto);

          COMMIT TRANSACTION;
          SELECT 'Camion Insertado Correctamente' AS Mensaje; 

    END TRY 
    BEGIN CATCH
          IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
          THROW
    END CATCH
END
GO

--===========SELECT CAMION
CREATE OR ALTER PROCEDURE dbo.sp_Select_Camion 
          @Matricula VARCHAR(50)
AS
BEGIN 
     SET NOCOUNT ON;
     BEGIN TRY
            SELECT * FROM dbo.Camiones
            WHERE Matricula = @Matricula;

            IF @@ROWCOUNT = 0
               PRINT 'No se encontro el camion';
     END TRY
     BEGIN CATCH
     THROW;
     END CATCH
END
GO

--=================================UPDATE_CAMION

CREATE OR ALTER PROCEDURE dbo.sp_Update_Camion
       @IdCamion INT,
       @Matricula VARCHAR(50),
       @TipoCamion VARCHAR(50),
       @Modelo INT,
       @Marca VARCHAR(50),
       @Capacidad INT,
       @Kilometraje FLOAT,
       @Disponibilidad BIT,
       @UrlFoto VARCHAR(255)
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY
          BEGIN TRANSACTION;

          UPDATE dbo.Camiones
          SET
             Matricula = @Matricula,
             TipoCamion = @TipoCamion,
             Modelo = @Modelo,
             Marca = @Marca,
             Capacidad = @Capacidad,
             Kilometraje = @Kilometraje,
             Disponibilidad = @Disponibilidad,
             UrlFoto = @UrlFoto
          WHERE IdCamion = @IdCamion;

          IF @@ROWCOUNT = 0 
          BEGIN
                THROW 50002, 'No se encontró ningún camión con ese ID', 1;
          END

          COMMIT TRANSACTION;

     END TRY
     BEGIN CATCH

          IF @@TRANCOUNT > 0
               ROLLBACK TRANSACTION;

          THROW;

     END CATCH
END
GO


--===========================================
--CHOFERES INSERT
--===========================================
--sp_help 'Choferes'

CREATE OR ALTER PROCEDURE dbo.sp_Insert_Choferes
      @Nombre NVARCHAR (100),
      @ApPaterno NVARCHAR (100),
      @ApMaterno NVARCHAR (100),
      @Telefono NVARCHAR(15),
      @FechaNacimiento DATE,
      @Licencia VARCHAR(255),
      @UrlFoto NVARCHAR(255),
      @Disponibilidad BIT,
      @FechaRegistro DATETIME
AS
BEGIN
     SET NOCOUNT ON;
     BEGIN TRY
         BEGIN TRANSACTION;

         IF EXISTS (SELECT 1 FROM dbo.Choferes WHERE Licencia = @Licencia)
            THROW 50001,'Ya existe un chofer con esa licencia',1;

         INSERT INTO dbo.Choferes
         (Nombre,ApPaterno,ApMaterno,Telefono,FechaNacimiento,Licencia,UrlFoto,Disponibilidad,FechaRegistro)
         VALUES(
         @Nombre,@ApPaterno,@ApMaterno,@Telefono,@FechaNacimiento,@Licencia,@UrlFoto,@Disponibilidad,@FechaRegistro);

         COMMIT TRANSACTION;
         SELECT 'Chofer insertado Correctamente' AS Mensaje;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END 
GO

--==========================Select Choferes
CREATE OR ALTER PROCEDURE dbo.sp_Select_Chofer
          @Disponibilidad BIT= NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
          IdChofer,Nombre,ApPaterno,ApMaterno,
          Telefono,FechaNacimiento,Licencia,
          UrlFoto,Disponibilidad,FechaRegistro
    FROM Choferes 
    WHERE (@Disponibilidad IS NULL OR Disponibilidad=@Disponibilidad);
END
GO
--======================================================================
--UPDATE CHOFERES
--======================================================================
CREATE OR ALTER PROCEDURE  dbo.sp_Update_Choferes
                          @IdChofer INT,
                          @Nombre VARCHAR(100),
                          @ApPaterno VARCHAR(100),
                          @ApMaterno VARCHAR(100),
                          @Telefono VARCHAR(15),
                          @FechaNacimiento DATE,
                          @Licencia VARCHAR (50),
                          @UrlFoto VARCHAR( 255),
                          @Disponibilidad BIT
AS
BEGIN
     SET NOCOUNT ON ;
     BEGIN TRY 
           BEGIN TRANSACTION;

           UPDATE dbo.Choferes
           SET
             Nombre = @Nombre,
             ApPaterno =@ApPaterno,
             ApMaterno = @ApMaterno,
             Telefono = @Telefono,
             FechaNacimiento = @FechaNacimiento,
             Licencia = @Licencia,
             UrlFoto = @UrlFoto,
             Disponibilidad = @Disponibilidad
           WHERE IdChofer = @IdChofer;

           IF @@ROWCOUNT = 0 
           BEGIN 
                 THROW 50002,'No se encontro ningun chofer con ese ID',1;
           END

           COMMIT TRANSACTION
           SELECT 'OK' AS Mensaje;
END TRY
BEGIN CATCH
     IF @@TRANCOUNT > 0 
      ROLLBACK TRANSACTION;

     THROW;
     END CATCH
END
GO

--=====================================
--DELETE CHOFER
--=====================================

CREATE OR ALTER PROCEDURE dbo.sp_Delete_Chofer
     @IdChofer INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.Choferes
    WHERE IdChofer = @IdChofer;

    SELECT @@ROWCOUNT AS FilasAfectadas;
END
GO
--============================================
--INSERTAR RUTAS
--============================================
CREATE OR ALTER PROCEDURE dbo.sp_Insert_Rutas
     @IdChofer INT, 
     @IdCamion INT,
     @Origen VARCHAR (200),
     @Destino VARCHAR (200),
     @FechaSalida DATETIME,
     @FechaLlegada DATETIME,
     @ATiempo BIT,
     @Distancia FLOAT,
     @FechaRegistro DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM dbo.Rutas WHERE IdChofer = @IdChofer AND IdCamion = @IdCamion)
           THROW 50001,'Ya existe esa ruta',1;

        INSERT INTO dbo.Rutas
        VALUES (@IdChofer,@IdCamion,@Origen,@Destino,@FechaSalida,@FechaLlegada,@ATiempo,@Distancia,@FechaRegistro);

        COMMIT TRANSACTION;
        SELECT 'Ruta insertad correctamente' AS Mensaje;

     END TRY
     BEGIN CATCH
         IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
         THROW
     END CATCH
END
GO

--==========================================
--SELECCIONAR RUTAS
--=========================================

CREATE OR ALTER PROCEDURE dbo.sp_Select_Rutas
     @IdRuta INT = NULL

AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
         SELECT
              IdRuta,IdChofer,IdCamion,Origen,Destino,FechaSalida,FechaLlegada,ATiempo,Distancia,FechaRegistro
         FROM dbo.Rutas
         WHERE (@IdRuta IS NULL OR IdRuta = @IdRuta);
    END TRY
    BEGIN CATCH
          THROW;
    END CATCH
END
GO
                   
--========================================
--UPDATE RUTAS
--========================================
CREATE OR ALTER PROCEDURE dbo.sp_Update_Rutas
      @IdRuta INT,
      @IdChofer INT, 
      @IdCamion INT,
      @Origen VARCHAR (200),
      @Destino VARCHAR (200),
      @FechaSalida DATETIME,
      @FechaLlegada DATETIME,
      @ATiempo BIT,
      @Distancia FLOAT,
      @FechaRegistro DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE dbo.Rutas
        SET IdChofer =@IdChofer,
            IdCamion = @IdCamion,
            Origen = @Origen,
            Destino = @Destino,
            FechaSalida = @FechaSalida,
            FechaLlegada =@FechaLlegada,
            ATiempo = @ATiempo,
            Distancia =@Distancia,
            FechaRegistro = @FechaRegistro
        WHERE IdRuta=@IdRuta;

        IF @@ROWCOUNT = 0
           THROW 50002,'No se encontro la ruta',1;

        COMMIT TRANSACTION;
        SELECT 'Ruta actualizada correctamente' AS Mensaje;

    END TRY 
    BEGIN CATCH
          IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
          THROW;
    END CATCH
END
GO



--================================================
--SELECCIONAR RUTA DETALLE
--================================================
CREATE OR ALTER PROCEDURE dbo.sp_Select_Rutas_Detalle
AS
BEGIN
     SET NOCOUNT ON;
     SELECT
           r.IdRuta,
           r.Origen,
           r.destino,
           r.FechaSalida,
           r.FechaLlegada,
           r.ATiempo,
           r.Distancia,
           --Chofer
           c.Nombre AS NombreChofer,
           c.Licencia ,
           c.Telefono AS TelefonoChofer,
           c.UrlFoto AS FotoChofer,
           --Camion
           cam.Matricula,
           cam.UrlFoto AS FotoCamion
     FROM Rutas AS r
     INNER JOIN Choferes as c
     ON r.IdChofer= c.IdChofer
     INNER JOIN Camiones AS cam 
     ON r.IdCamion = cam.IdCamion
END
GO

--=============================================
--Existe Licencia
--=============================================

CREATE OR ALTER PROCEDURE dbo.sp_Existe_Licencia
      @Licencia VARCHAR (50)
AS
BEGIN 
     SET NOCOUNT ON;
         SELECT 
               CASE 
                   WHEN EXISTS(
                   SELECT 1 
                   FROM dbo.Choferes
                   WHERE Licencia = @Licencia
                   )THEN 1
                   ELSE 0
               END AS ExistenciaLicencia;
END
GO

--=============================================
--OBTENER CAMION
--=============================================

--sp_help 'Camiones'
CREATE OR ALTER PROCEDURE dbo.sp_Obtener_Camion_ID
      @IdCamion INT
AS
BEGIN 
    SET NOCOUNT ON;

    BEGIN TRY
    SELECT
         IdCamion,
         Matricula,
         TipoCamion,
         Modelo,
         Marca,
         Capacidad,
         Kilometraje,
         Disponibilidad,
         UrlFoto
          
    FROM dbo.Camiones
    WHERE IdCamion = @IdCamion;

    IF @@ROWCOUNT = 0
       BEGIN;
            THROW 50001,'No se encontro ningun camion con el Id Proprocionado',1;
       END
    END TRY
    BEGIN CATCH 
          THROW;
    END CATCH
END
GO

--=============================================================================
--DELETE CAMION
--=======================================================================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Camion
     @IdCamion INT
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY
           BEGIN TRANSACTION;
           DELETE FROM dbo.Camiones
           WHERE IdCamion = @IdCamion;

           IF @@ROWCOUNT = 0 
           BEGIN
                THROW 50001,'No se encontro ningun camoin con ese ID.', 1;
           END

           COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            THROW;
      END CATCH
END
GO








--=============================================================================
--
--=======================================================================
CREATE OR ALTER PROCEDURE dbo.sp_Existe_Matricula
     @Matricula VARCHAR (50)
AS
BEGIN
SET NOCOUNT ON;
     
     SELECT 
          CASE  
              WHEN EXISTS(
              SELECT 1
                    FROM dbo.Camiones
                    WHERE Matricula = @Matricula
                    )THEN 1
               ELSE 0 
           END AS ExisteMatricula;
END
GO

--===============================================
--Listar Camiones
--===============================================
CREATE OR ALTER PROCEDURE dbo.sp_Listar_Camiones
      @Disponibilidad BIT NULL
AS
BEGIN
     SET NOCOUNT ON ;

     BEGIN TRY 
           SELECT
                IdCamion,
                Matricula,
                TipoCamion,
                Modelo,
                Marca,
                Capacidad,
                Kilometraje,
                Disponibilidad,
                UrlFoto

           FROM dbo.Camiones 
           WHERE (@Disponibilidad IS NULL OR Disponibilidad = @Disponibilidad)
           ORDER BY IdCamion DESC;
      END TRY
      BEGIN CATCH
            THROW;
      END CATCH 
END
GO
--=============================================================================
--DELETE Ruta
--=======================================================================
CREATE OR ALTER PROCEDURE dbo.sp_Delete_Ruta
     @IdRuta INT
AS
BEGIN
     SET NOCOUNT ON;

     BEGIN TRY
           BEGIN TRANSACTION;
           DELETE FROM dbo.Rutas
           WHERE IdRuta = @IdRuta;

           IF @@ROWCOUNT = 0 
              PRINT 'No se encontro la ruta'

           COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            THROW;
      END CATCH
END
GO



