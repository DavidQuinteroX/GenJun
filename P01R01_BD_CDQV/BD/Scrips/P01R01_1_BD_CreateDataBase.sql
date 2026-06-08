--=============================================
--Autor:Carlos David Quintero Villegas
--Creacion de BD:P01R01_BD_DQ
--Fecha :20260527
--=============================================
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'GenJun')
BEGIN
     CREATE DATABASE GenJun;
     PRINT 'Base de datos GenJun creada correctamente.';
END
ELSE
BEGIN
     PRINT 'La base de datos GenJun ya existe.';
END
GO