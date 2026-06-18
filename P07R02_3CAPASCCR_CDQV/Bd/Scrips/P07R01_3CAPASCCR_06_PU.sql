USE GenJunCCR
GO
--Autor:Carlos David Quintero Villegas
--Created:20260610
--Descripcion:Vistas
--P07R01_3CAPASCCR_06_PU
--sp_help 'Rutas'

--Probar SP

--Insertar Camiones
EXEC dbo.Insert_Camion
@Matricula = 'ABC-123',
@TipoCamion = 'Trailer',
@Modelo = 2022,
@Marca = 'Volvo',
@Capacidad = 20000,
@Kilometraje = 15000,
@Disponibilidad = 1,
@UrlFoto = 'foto1.jpg';
GO
--Listar Camiones
EXEC dbo.sp_Listar_Camiones @Disponibilidad = NULL;
GO
--Obtener por ID
EXEC dbo.sp_Obtener_Camion_ID @IdCamion = 1;
GO
--Update Camion
EXEC dbo.sp_Update_Camion
@IdCamion = 1,
@Matricula = 'XYZ-999',
@TipoCamion = 'Caja seca',
@Modelo = 2023,
@Marca = 'Scania',
@Capacidad = 25000,
@Kilometraje = 20000,
@Disponibilidad = 0,
@UrlFoto = 'foto2.jpg';
GO
--Delete Camion

EXEC dbo.sp_Delete_Camion @IdCamion = 1;

GO
--Insertar chofer
EXEC dbo.sp_Insert_Choferes
    @Nombre = 'Juan',
    @ApPaterno = 'Perez',
    @ApMaterno = 'Lopez',
    @Telefono = '2221234567',
    @FechaNacimiento = '1990-05-10',
    @Licencia = 'LIC-001',
    @UrlFoto = 'chofer1.jpg',
    @Disponibilidad = 1,
    @FechaRegistro = '2026-06-16 10:30:00';
GO
--[dbo].[sp_Choferes]
--[dbo].[sp_Delete_Chofer]
--[dbo].[sp_Existe_Licencia]
--[dbo].[sp_Existe_Matricula]
--[dbo].[sp_Insert_Choferes]
--[dbo].[sp_Insert_Rutas]
--[dbo].[sp_Listar_Camiones]
--[dbo].[sp_Obtener_Camion_ID]
--[dbo].[sp_Select_Camion]
--[dbo].[sp_Select_Chofer]
--[dbo].[sp_Select_Rutas]
--[dbo].[sp_Select_Rutas_Detalle]
--[dbo].[sp_Update_Camion]
--[dbo].[sp_Update_Rutas]


--Probar las vistas 

--sp_help 'Rutas'