--USE GenJun
--GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:DROP DATABASE - CONTINGENCIA
--P01R01_BD_CDQV:F CONTINGENCIA
--============================================= 

BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='GenJun')
         BEGIN
              --ELIMINAR :Base de datos GenJun
              USE master; --Asegurarse de no estar dentro de la DB a Eliminar

              ALTER DATABASE GenJun SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
              DROP DATABASE GenJun;

              PRINT 'Base de Datos GenJun eliminada correctamente';
         END
    ELSE
         BEGIN
             PRINT 'La base de datos [GenJun] no existe'
        END
      
  END TRY
  BEGIN CATCH
     --Intentar restaurar acceso multiusuario si algo fallo
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name='GenJun')
        ALTER DATABASE GenJun SET MULTI_USER;

     THROW;
 END CATCH
GO
