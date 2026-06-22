USE master
GO

-- ===============================================
-- Autor: Erick Eduardo Valencia Gómez
-- Creación: 202606012
-- Descripción: Create Database
-- P10R01_BD_EEVG: Scripts #1
-- ===============================================

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BD_Ejemplo')
BEGIN
    CREATE DATABASE BD_Ejemplo
    PRINT 'Base de datos BD_Ejemplo creada correctamente.'
END
ELSE
BEGIN
    PRINT 'La base de datos BD_Ejemplo ya existe.'
END
