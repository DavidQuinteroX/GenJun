Use DepositoBD
GO
--============================================
--Autor:Carlos David Quintero Villegas
--Created:20260617
--Descripcion: CARGAS INICIALES
--P10R01_NCAPAS_03_InitialCharges:
--============================================
--============================
-- 1. CATEGORIAS
--============================

INSERT INTO Categorias(Nombre)
VALUES
('Cerveza Clara'),
('Cerveza Oscura'),
('Cerveza Ligera'),
('Cerveza Especial'),
('Paquetes');


--============================
-- 2. MARCAS
--============================

INSERT INTO Marcas(Nombre)
VALUES
('Victoria'),
('Corona'),
('Pacifico'),
('Leon'),
('Modelo');


--============================
-- 3. PRODUCTOS
--============================

INSERT INTO Productos
(
Nombre,
IdMarca,
IdCategoria,
ContenidoML
)
VALUES

('Cerveza Victoria',1,1,355),

('Cerveza Corona Extra',2,3,355),

('Cerveza Pacifico Clara',3,1,355),

('Cerveza Leon Negra',4,2,355),

('Cerveza Modelo Especial',5,4,355);




--============================
-- 4. PRESENTACIONES
--============================

INSERT INTO Presentaciones
(
IdProducto,
Nombre,
Cantidad
)
VALUES

-- Victoria
(1,'Botella 355ml',355),
(1,'Caguama 1.2L',1200),

-- Corona
(2,'Botella 355ml',355),
(2,'Six Pack 355ml',2130),

-- Pacifico
(3,'Botella 355ml',355),

-- Leon
(4,'Botella 355ml',355),

-- Modelo
(5,'Lata 355ml',355);



--============================
-- 5. PRECIOS
--============================

INSERT INTO Precios
(
IdPresentacion,
Precio,
FechaInicio,
FechaFin
)
VALUES

(1,18.00,GETDATE(),NULL),
(2,45.00,GETDATE(),NULL),
(3,20.00,GETDATE(),NULL),
(4,110.00,GETDATE(),NULL),
(5,19.00,GETDATE(),NULL),
(6,25.00,GETDATE(),NULL),
(7,22.00,GETDATE(),NULL);




--============================
-- 6. INVENTARIO
--============================

INSERT INTO Inventario
(
 IdPresentacion,
 Existencia
)
VALUES
(1,100),
(2,80),
(3,150),
(4,50),
(5,200);



--============================
-- 7. MOVIMIENTOS INVENTARIO
--============================

INSERT INTO Movimientos_Inventario
(
IdPresentacion,
TipoMovimiento,
Cantidad,
Fecha,
Motivo
)
VALUES

(1,'ENTRADA',200,GETDATE(),'Carga inicial deposito'),
(2,'ENTRADA',80,GETDATE(),'Carga inicial deposito'),
(3,'ENTRADA',150,GETDATE(),'Carga inicial deposito'),
(4,'ENTRADA',40,GETDATE(),'Carga inicial deposito'),
(5,'ENTRADA',180,GETDATE(),'Carga inicial deposito');


--============================
-- 8. CLIENTES
--============================

INSERT INTO Clientes(Nombre)
VALUES
('Juan Perez'),
('Maria Lopez'),
('Carlos Ramirez'),
('Ana Torres'),
('Pedro Gomez');



--============================
-- 9. PROVEEDORES
--============================

INSERT INTO Proveedores
(
 Nombre,
 Telefono
)
VALUES
('Grupo Modelo','5551001000'),
('Cerveceria Victoria','5552002000'),
('Distribuidora Pacifico','5553003000'),
('Proveedor Leon','5554004000'),
('Mayorista Bebidas','5555005000');




--============================
-- 10. COMPRAS
--============================

INSERT INTO Compras
(
 IdProveedor,
 Fecha,
 Total
)
VALUES
(1,GETDATE(),500000),
(2,GETDATE(),350000),
(3,GETDATE(),250000),
(4,GETDATE(),400000),
(5,GETDATE(),150000);



--============================
-- 11. DETALLE COMPRA
--============================

INSERT INTO Detalle_Compra
(
 IdCompra,
 IdPresentacion,
 Cantidad,
 Costo
)
VALUES
(1,1,100,2000),
(2,2,80,1800),
(3,3,150,1400),
(4,4,50,5000),
(5,5,200,2200);



--============================
-- 12. VENTAS
--============================

INSERT INTO Ventas
(
 Fecha,
 Total,
 IdCliente
)
VALUES
(GETDATE(),25000,1),
(GETDATE(),18000,2),
(GETDATE(),30000,3),
(GETDATE(),12000,4),
(GETDATE(),15000,5);



--============================
-- 13. DETALLE VENTA
--============================

INSERT INTO Detalle_Venta
(
 IdVenta,
 IdPresentacion,
 Cantidad,
 PrecioUnitario,
 SubTotal
)
VALUES
(1,1,5,2500,12500),
(2,2,4,2300,9200),
(3,3,10,1800,18000),
(4,4,2,6000,12000),
(5,5,5,3000,15000);


PRINT 'CARGA INICIAL FINALIZADA'
GO

--SELECT 
--'SELECT * FROM dbo.' + TABLE_NAME + ';' AS Consulta
--FROM INFORMATION_SCHEMA.TABLES
--WHERE TABLE_SCHEMA = 'dbo';

--SELECT * FROM dbo.Categorias;
--SELECT * FROM dbo.Marcas;
--SELECT * FROM dbo.Productos;
--SELECT * FROM dbo.Presentaciones;
--SELECT * FROM dbo.Precios;
--SELECT * FROM dbo.Inventario;
--SELECT * FROM dbo.Movimientos_Inventario;
--SELECT * FROM dbo.Clientes;
--SELECT * FROM dbo.Ventas;
--SELECT * FROM dbo.Detalle_Venta;
--SELECT * FROM dbo.Proveedores;
--SELECT * FROM dbo.Compras;
--SELECT * FROM dbo.Detalle_Compra;
