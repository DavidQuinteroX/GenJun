--USE GenJunCCR
--GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260616
--Descripcion:DROP DATABASE - CONTINGENCIA
--P01R01_BD_CDQV:E CONTINGENCIA
--============================================= 

BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='GenJunCCR')
         BEGIN
              --ELIMINAR :Base de datos GenJunCCR
              USE master; --Asegurarse de no estar dentro de la DB a Eliminar

              ALTER DATABASE GenJunCCR SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
              DROP DATABASE GenJunCCR;

              PRINT 'Base de Datos GenJunCCR eliminada correctamente';
         END
    ELSE
         BEGIN
             PRINT 'La base de datos [GenJunCCR] no existe'
        END
      
  END TRY
  BEGIN CATCH
     --Intentar restaurar acceso multiusuario si algo fallo
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name='GenJunCCR')
        ALTER DATABASE GenJunCCR SET MULTI_USER;

     THROW;
 END CATCH
GO
