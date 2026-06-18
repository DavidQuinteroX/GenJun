USE GenJunCCR
GO

--=============================================
--Autor:Carlos David Quintero  Villegas
--Created:20260616
--Descripcion:TRUNCATE TABLE - CONTINGENCIA
--P07R01_BD_CDQV:C CONTINGENCIA
--============================================= 1 Camiones

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF OBJECT_ID('dbo.Rutas', 'U') IS NOT NULL
			BEGIN
				IF OBJECT_ID('dbo.FK_Rutas_Camiones', 'F') IS NOT NULL
					ALTER TABLE dbo.Rutas
					DROP CONSTRAINT FK_Rutas_Camiones;
				IF OBJECT_ID('dbo.FK_Rutas_Choferes', 'F') IS NOT NULL
					ALTER TABLE dbo.Rutas 
					DROP CONSTRAINT FK_Rutas_Choferes;
				TRUNCATE TABLE dbo.Rutas;
				PRINT 'Datos de la tabla Rutas eliminados correctamente';
			END
		ELSE
			BEGIN
				PRINT 'La tabla [dbo].[Rutas] no existe';
			END
		COMMIT TRANSACTION; -- Confirmar cambios
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
GO

--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF OBJECT_ID('dbo.Camiones', 'U') IS NOT NULL
			BEGIN
				TRUNCATE TABLE dbo.Camiones;
				PRINT 'Datos de la tabla Camiones eliminados correctamente';
			END
		ELSE
			BEGIN
				PRINT 'La tabla [dbo].[Camiones] no existe';
			END
		COMMIT TRANSACTION; -- Confirmar cambios
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
GO


--COMMIT Y ROLLBACK
BEGIN TRANSACTION;
	BEGIN TRY
		--VALIDACIONES
		IF OBJECT_ID('dbo.Choferes', 'U') IS NOT NULL
			BEGIN
				TRUNCATE TABLE dbo.Choferes;
				PRINT 'Datos de la tabla Choferes eliminados correctamente';
			END
		ELSE
			BEGIN
				PRINT 'La tabla [dbo].[Choferes] no existe';
			END
		COMMIT TRANSACTION; -- Confirmar cambios
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
		THROW;
	END CATCH
GO