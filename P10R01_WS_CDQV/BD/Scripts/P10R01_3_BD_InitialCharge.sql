USE BD_Ejemplo
GO

-- ===============================================
-- Autor: Erick Eduardo Valencia Gómez
-- Creación: 20260612
-- Descripción: Insert Into
-- P10R01_BD_EEVG: Scripts #3
-- ===============================================

BEGIN TRANSACTION;
BEGIN TRY	
	-- Insertar datos en Camiones
	INSERT INTO dbo.Usuarios (Nombre)
	VALUES 
	('Juan Pérez'),
	('María García'),
	('Carlos López'),
	('Ana Martínez'),
	('Pedro Sánchez')

	-- Confirmar todos los inserts
	COMMIT TRANSACTION;
	PRINT 'Carga inicial completada correctamente.';
END TRY
BEGIN CATCH
	-- Si hay algún error, deshacer todo
	IF @@TRANCOUNT > 0
		ROLLBACK TRANSACTION;
	THROW; -- Re-lanzar el error para que sea visible
END CATCH;
GO