USE Test
GO
--============================================
--Autor:Carlos David Quintero Villegas
--Created:20260622
--Descripcion: CARGAS INICIALES
--P20R01_01_InitialCharges:
--============================================
--============================
-- 1. GESTORES
--============================



INSERT INTO dbo.Gestores_bd (Nombre, Lazamiento, Desarrollador)
VALUES
('Unity', 2005, 'Unity Technologies'),
('Unreal Engine', 1998, 'Epic Games'),
('CryEngine', 2002, 'Crytek'),
('Godot Engine', 2014, 'Godot Foundation'),
('GameMaker Studio', 1999, 'YoYo Games'),
('RPG Maker', 1988, 'Gotcha Gotcha Games'),
('Frostbite', 2008, 'Electronic Arts'),
('Source Engine', 2004, 'Valve'),
('id Tech', 1996, 'id Software'),
('Decima Engine', 2016, 'Guerrilla Games')
GO

SELECT * 
FROM dbo.Gestores_bd
GO