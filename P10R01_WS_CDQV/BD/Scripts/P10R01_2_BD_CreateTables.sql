USE BD_Ejemplo
GO

-- ===============================================
-- Autor: Erick Eduardo Valencia Gómez
-- Creación: 20260612
-- Descripción: Create Table
-- P10R01_BD_EEVG: Scripts #2
-- ===============================================

-- COMMIT Y ROLLBACK
BEGIN TRANSACTION
	BEGIN TRY
		--VALIDACIONES
		IF OBJECT_ID('dbo.Usuarios', 'U') IS NULL
			BEGIN
				CREATE TABLE dbo.Usuarios(
					Id INT IDENTITY(1,1) PRIMARY KEY,
					Nombre VARCHAR(100) NOT NULL,
					FechaRegistro DATETIME DEFAULT GETDATE()
				)
		
				PRINT 'Tabla Usuarios creada correctamente.'
			END
		ELSE
			BEGIN
				PRINT 'La tabla [dbo].[Usuarios] ya existe.'
			END
		COMMIT TRANSACTION -- Confirmar cambios
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION
		THROW
	END CATCH
GO