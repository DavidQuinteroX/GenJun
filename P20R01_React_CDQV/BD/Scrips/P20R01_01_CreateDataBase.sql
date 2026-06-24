USE master
GO

IF NOT EXISTS(SELECT name FROM	master.dbo.sysdatabases WHERE name =N'Test')
BEGIN 
CREATE DATABASE Test;
print 'Base de datos creada Correctamente';
END
ELSE 
BEGIN 
PRINT 'La base de datos ya existe'
END
GO
