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
%SQLCMD% -S "%SERVER%" %AUTH% -d master -i "%SCRIPT_DIR%P20R01_01_CreateDataBase.sql" -b
if errorlevel 1 goto error

set "DB=Test"
echo Ejecutando Scrip 2: Crear tables...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P20R01_02_CreateTable.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 3: Carga inicial de datos...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P20R01_03_InitialCharge.sql" -b
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