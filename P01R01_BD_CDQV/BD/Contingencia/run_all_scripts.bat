@echo off
rem Ejecutar todos los scripts SQL en orden para la base de datos GenJun
rem Ajusta SERVER si tu instancia no es (Local)
setlocal
set "SERVER=(local)"
set "AUTH=-E"
set "SQLCMD=sqlcmd"
set "SCRIPT_DIR=%~dp0"

echo.
echo Ejecutando scrip A :Eliminando Vista...
%SQLCMD% -S "%SERVER%" %AUTH% -d master -i "%SCRIPT_DIR%P01R01_BD_A_DropView.sql" -b
if errorlevel 1 goto error                        
												  
set "DB=GenJun"                                   
echo Ejecutando Scrip B: Eliminando Triggers...   
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_BD_B_DropTrigger.sql" -b
if errorlevel 1 goto error                        
												  
echo Ejecutando Scrip C: Eliminando StoredProcedures...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_BD_C_DropStoreProcedure.sql" -b
if errorlevel 1 goto error                        
												  
rem echo Ejecutando Scrip D: Eliminando Contenido de Tablas...
rem %SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_BD_D_TruncateTable.sql" -b
rem if errorlevel 1 goto error                        
												  
echo Ejecutando Scrip E: Eliminando Tablas...     
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_BD_E_DropTable.sql" -b
if errorlevel 1 goto error                        
												  
echo Ejecutando Scrip F: Eliminando BaseDeDatos...
%SQLCMD% -S "%SERVER%" %AUTH% -d "%DB%" -i "%SCRIPT_DIR%P01R01_BD_F_DropDatabase.sql" -b
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