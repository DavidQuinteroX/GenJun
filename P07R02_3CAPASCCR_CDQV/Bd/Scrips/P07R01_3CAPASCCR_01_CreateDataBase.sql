--Autor:Carlos David Quintero Villegas
--Created:20260609
--Descripcion:Creacion de la base de datos
--P07R01_3CAPASCCR_01_CreateDataBase:Base de datos 


IF NOT EXISTS(SELECT name FROM master.dbo.sysdatabases WHERE name = N'GenJunCCR')
BEGIN
     CREATE DATABASE GenJunCCR;
     PRINT 'Base de datos GenJunCCR creada CORRECTAMENTE ';
END
ELSE
BEGIN
    PRINT 'La base de datos GenJunCCR ya EXISTE';
END
GO