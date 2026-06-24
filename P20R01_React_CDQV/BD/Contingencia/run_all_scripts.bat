@echo off
rem Ejecutar todos los scripts SQL en orden para la base de datos GenJun
rem Ajusta SERVER si tu instancia no es (Local)
setlocal
set "SERVER=(local)"
set "AUTH=-E"
set "SQLCMD=sqlcmd"
set "SCRIPT_DIR=%~dp0"

echo.
echo Ejecutando Scrip 1 :Eliminar Contenido de Tabla...
%SQLCMD% -S "%SERVER%" %AUTH% -d master -i "%SCRIPT_DIR%P20R01_BD_A_TruncateTable.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 2 :Eliminar Tabla...
%SQLCMD% -S "%SERVER%" %AUTH% -d master -i "%SCRIPT_DIR%P20R01_BD_B_DropTable.sql" -b
if errorlevel 1 goto error

echo Ejecutando Scrip 3: Eliminar Base...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P20R01_BD_C_DropDataBase.sql" -b
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