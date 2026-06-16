USE GenJunCCR
GO

--Autor:Carlos David Quintero Villegas
--Created:20260609
--Descripcion:INSER INTO TABLES
--P07R01_3CAPASCCR_03_CargaInicial:
--sp_help 'Rutas'

BEGIN TRANSACTION;
BEGIN TRY
         --INSERTAR DATOS EN CAMIONES
         INSERT INTO dbo.Camiones (Matricula,TipoCamion,Modelo,Marca,Capacidad,Kilometraje,Disponibilidad,UrlFoto)
         VALUES 
         ('ABC-123','Caja Seca',2018,'Volvo',10000,150000,1,'https://imagenes.com/camion1.jpg'),
         ('DEF-456','Refrigerado',2020,'Kenworth',12000,98000,1,'https://imagenes.com/camion2.jpg'),
         ('GHI-789','Plataforma',2019,'Freightliner',15000,125000,0,'https://imagenes.com/camion3.jpg'),
         ('JKL-321','Tolva',2017,'International',18000,210000,1,'https://imagenes.com/camion4.jpg'),
         ('MNO-654','Caja Seca',2021,'Volvo',11000,75000,1,'https://imagenes.com/camion5.jpg'),
         ('PQR-987','Refrigerado',2022,'Scania',13000,50000,1,'https://imagenes.com/camion6.jpg'),
         ('STU-147','Plataforma',2018,'MAN',14000,160000,0,'https://imagenes.com/camion7.jpg'),
         ('VWX-258','Tolva',2016,'Mercedes-Benz',20000,250000,1,'https://imagenes.com/camion8.jpg'),
         ('YZA-369','Caja Seca',2023,'Kenworth',12500,30000,1,'https://imagenes.com/camion9.jpg'),
         ('BCD-741','Refrigerado',2020,'Freightliner',13500,85000,0,'https://imagenes.com/camion10.jpg');
         
         --INSERTAR DATOS EN CHOFERES
         INSERT INTO dbo.Choferes(Nombre,ApPaterno,ApMaterno,Telefono,FechaNacimiento,Licencia,UrlFoto,Disponibilidad,FechaRegistro)
         VALUES 
         ('Juan','Pérez','García','2221234567','1985-03-15','LIC001','https://imagenes.com/chofer1.jpg',1,GETDATE()),
         ('Carlos','Ramírez','López','2222345678','1990-07-22','LIC002','https://imagenes.com/chofer2.jpg',1,GETDATE()),
         ('Miguel','Hernández','Martínez','2223456789','1988-11-10','LIC003','https://imagenes.com/chofer3.jpg',0,GETDATE()),
         ('José','Torres','Sánchez','2224567890','1979-05-18','LIC004','https://imagenes.com/chofer4.jpg',1,GETDATE()),
         ('Luis','Flores','Morales','2225678901','1992-01-30','LIC005','https://imagenes.com/chofer5.jpg',1,GETDATE()),
         ('Roberto','Vargas','Castillo','2226789012','1987-09-12','LIC006','https://imagenes.com/chofer6.jpg',0,GETDATE()),
         ('Fernando','Jiménez','Ruiz','2227890123','1984-12-05','LIC007','https://imagenes.com/chofer7.jpg',1,GETDATE()),
         ('Alejandro','Mendoza','Ortiz','2228901234','1995-06-28','LIC008','https://imagenes.com/chofer8.jpg',1,GETDATE()),
         ('Ricardo','Cruz','Navarro','2229012345','1981-08-17','LIC009','https://imagenes.com/chofer9.jpg',0,GETDATE()),
         ('Jorge','Reyes','Aguilar','2220123456','1989-04-09','LIC010','https://imagenes.com/chofer10.jpg',1,GETDATE());


         INSERT INTO dbo.Rutas (IdChofer,IdCamion,Origen,Destino,FechaSalida,FechaLlegada,ATiempo,Distancia,FechaRegistro)
         VALUES 
         (1,1,'Puebla, Puebla','Ciudad de México','2026-06-01 06:00:00','2026-06-01 09:00:00',1,130,GETDATE()),
         (2,2,'Puebla, Puebla','Veracruz, Veracruz','2026-06-02 05:30:00','2026-06-02 11:00:00',1,280,GETDATE()),
         (3,3,'Ciudad de México','Guadalajara, Jalisco','2026-06-03 04:00:00','2026-06-03 11:30:00',0,550,GETDATE()),
         (4,4,'Monterrey, Nuevo León','Saltillo, Coahuila','2026-06-04 07:00:00','2026-06-04 08:30:00',1,90,GETDATE()),
         (5,5,'Puebla, Puebla','Oaxaca, Oaxaca','2026-06-05 06:15:00','2026-06-05 11:15:00',1,340,GETDATE()),
         (6,6,'Querétaro, Querétaro','León, Guanajuato','2026-06-06 08:00:00','2026-06-06 10:30:00',1,160,GETDATE()),
         (7,7,'Mérida, Yucatán','Cancún, Quintana Roo','2026-06-07 05:00:00','2026-06-07 09:00:00',0,310,GETDATE()),
         (8,8,'Tijuana, Baja California','Mexicali, Baja California','2026-06-08 07:00:00','2026-06-08 09:30:00',1,180,GETDATE()),
         (9,9,'Toluca, Estado de México','Pachuca, Hidalgo','2026-06-09 06:45:00','2026-06-09 08:30:00',1,105,GETDATE()),
         (10,10,'Veracruz, Veracruz','Villahermosa, Tabasco','2026-06-10 04:30:00','2026-06-10 10:30:00',0,430,GETDATE());

         COMMIT TRANSACTION;
         PRINT 'Carga Inicial completada correctamente.';
END TRY
BEGIN CATCH
      --Si hay algun error, deshacer todo
      IF @@TRANCOUNT > 0 
         ROLLBACK TRANSACTION;
       THROW;
END CATCH
GO

--SELECT * FROM dbo.Camiones;
--SELECT * FROM dbo.Choferes;
--SELECT * FROM dbo.Rutas;