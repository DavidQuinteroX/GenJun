@echo off
rem Ejecutar todos los scripts SQL en orden para la base de datos GenJun
rem Ajusta SERVER si tu instancia no es (Local)
setlocal
set "SERVER=(local)"
set "AUTH=-E"
set "SQLCMD=sqlcmd"
set "SCRIPT_DIR=%~dp0"

echo.
echo Ejecutando Scrip 1 :Crear base de datos...
%SQLCMD% -S "%SERVER%" %AUTH% -d master -i "%SCRIPT_DIR%P07R01_3CAPASCCR_01_CreateDataBase.sql" -b
if errorlevel 1 goto error

set "DB=GenJunCCR"
echo Ejecutando Scrip 2: Crear tables...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P07R01_3CAPASCCR_02_CreateTable.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 3: Carga inicial de datos...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P07R01_3CAPASCCR_03_CargaInicial.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 4: Stored Procedures...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P07R01_3CAPASCCR_04_StoreProcedure.sql" -b
if errorlevel 1 goto error

rem echo Ejecutando Scrip 5: Triggers...
rem %SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_5_BD_Trigger.sql" -b
rem if errorlevel 1 goto error

echo Ejecutando Scrip 6: Views...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P07R01_3CAPASCCR_05_Views.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 7: Pruebas Unitarias...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P07R01_3CAPASCCR_06_PU.sql" -b
if errorlevel 1 goto error

echo.
echo Todos los scrips se ejecutaron correctamente.
echo Presiona Enter para cerrar
pause > nul
goto end


:error
echo.
echo ERROR: FALLO en la ejecucion de los scripts.
echo Revisa el mensaje anterior para obtener detalles.
echo Presiona Enter para cerrar.
pause > nul

:end
endlocal