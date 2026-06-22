USE BD_Ejemplo
GO

-- ===============================================
-- Autor: Erick Eduardo Valencia Gómez
-- Creación: 20260610
-- Descripción: Pruebas Unitarias
-- P010R01_BD_EEVG: Scripts #4
-- ==============================================

-- Contar registros de todas las tablas
SELECT 'Usuarios' AS Tabla, COUNT(*) AS 'Filas' FROM [dbo].[Usuarios]

-- Mostrar todos los usuarios
SELECT * FROM Usuarios