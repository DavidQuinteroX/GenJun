--USE GenJun
--GO

--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260623
--Descripcion:DROP DATABASE - CONTINGENCIA
--P20R01_BD_CDQV:B   CONTINGENCIA
--============================================= 

BEGIN TRY
     --VALIDACIONES
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name ='Test')
         BEGIN
              --ELIMINAR :Base de datos Test
              USE master; --Asegurarse de no estar dentro de la DB a Eliminar

              ALTER DATABASE Test SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
              DROP DATABASE Test;

              PRINT 'Base de Datos Test eliminada correctamente';
         END
    ELSE
         BEGIN
             PRINT 'La base de datos [Test] no existe'
        END
      
  END TRY
  BEGIN CATCH
     --Intentar restaurar acceso multiusuario si algo fallo
     IF EXISTS (SELECT 1 FROM sys.databases WHERE name='Test')
        ALTER DATABASE Test SET MULTI_USER;

     THROW;
 END CATCH
GO