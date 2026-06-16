USE GenJunCCR
Go

--Autor:Carlos David Quintero Villegas
--Created:20260609
--Descripcion:Creacion de la base de datos
--P07R01_3CAPASCCR_01_CreateDataBase:

--==================================================================================================================TABLE CAMIONES
BEGIN TRANSACTION ;
     BEGIN TRY 

     IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Camiones' AND TABLE_SCHEMA = 'dbo')
          BEGIN

               CREATE TABLE dbo.Camiones(
                    IdCamion INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                    Matricula VARCHAR (50) NOT NULL,
                    TipoCamion VARCHAR (50) NOT NULL,
                    Modelo INT NOT NULL,
                    Marca VARCHAR (50),
                    Capacidad INT NOT NULL ,
                    Kilometraje FLOAT NOT NULL,
                    Disponibilidad BIT NOT NULL,
                    UrlFoto VARCHAR (255) NOT NULL);

               PRINT 'Tabla Camiones creada correctamente';
               
          END
      ELSE
         BEGIN
              PRINT 'Tabla Camiones ya existe'
         END
 COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO

  --==================================================================================================================TABLE Choferes

 BEGIN TRANSACTION;
       BEGIN TRY

       IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Choferes' AND TABLE_SCHEMA ='dbo')
            BEGIN
                 
                 CREATE TABLE dbo.Choferes(
                 IdChofer INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
                 Nombre NVARCHAR (100) NOT NULL,
                 ApPaterno NVARCHAR (100) NOT NULL,
                 ApMaterno NVARCHAR (100) NOT NULL,
                 Telefono NVARCHAR (15) NOT NULL,
                 FechaNacimiento DATE NOT NULL,
                 Licencia VARCHAR (50) NOT NULL,
                 UrlFoto NVARCHAR (255) NOT NULL,
                 Disponibilidad BIT NOT NULL,
                 FechaRegistro DATETIME NOT NULL
                 CONSTRAINT DF_Choferes_FechaRegistro DEFAULT GETDATE());

                
               PRINT 'Tabla Choferes creada correctamente';
               
          END
      ELSE
         BEGIN
              PRINT 'Tabla Choferes ya existe'
         END
 COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO 


    --==================================================================================================================TABLE RUTAS
BEGIN TRANSACTION;
      BEGIN TRY
      IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Rutas' AND TABLE_SCHEMA = 'dbo')
         BEGIN
              CREATE TABLE dbo.Rutas (
              IdRuta INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
              IdChofer INT NOT NULL,
              IdCamion INT NOT NULL,
              Origen NVARCHAR (200) NOT NULL,
              Destino NVARCHAR (200) NOT NULL,
              FechaSalida DATETIME NOT NULL,
              FechaLlegada DATETIME NOT NULL,
              ATiempo BIT NOT NULL,
              Distancia FLOAT NOT NULL,
              FechaRegistro DATETIME NOT NULL
              CONSTRAINT DF_Rutas_FechaRegistro DEFAULT GETDATE(),
              CONSTRAINT FK_Rutas_Choferes FOREIGN kEY (IdChofer) REFERENCES Choferes(IdChofer),
              CONSTRAINT FK_Rutas_Camiones FOREIGN kEY (IdCamion) REFERENCES Camiones(IdCamion));
              PRINT 'Tabla Rutas creada correctamente';
               
          END
      ELSE
         BEGIN
              PRINT 'Tabla Rutas ya existe'
         END
 COMMIT TRANSACTION;--Confirmar cambios
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT >0
        ROLLBACK TRANSACTION;
     THROW;
  END CATCH
  GO 

