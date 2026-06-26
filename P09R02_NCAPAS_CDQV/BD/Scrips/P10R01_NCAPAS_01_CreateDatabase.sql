IF NOT EXISTS(SELECT name FROM	master.dbo.sysdatabases WHERE name =N'DepositoBD')
BEGIN 
CREATE DATABASE DepositoBD;
print 'Base de datos creada Correctamente';
END
ELSE 
BEGIN 
PRINT 'La base de datos ya existe'
END
GO
