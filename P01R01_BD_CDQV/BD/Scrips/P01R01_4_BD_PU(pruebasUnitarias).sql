USE GenJun
Go
--Autor:Carlos David Quintero Villegas
--Created:20260602
--Descripcion:Puebas Unitarias
--P01R01_BD_CDQV:PU

SELECT
     c.Nombre AS Cliente,
     p.PedidoID,
     p.Fecha,
     p.Total,
     p.Estado 
FROM Clientes AS c
INNER JOIN Pedidos AS p
ON c.ClienteId = p.ClienteID
ORDER BY p.Fecha DESC;

--------------------------------------------------------------------
SELECT 
      c.Nombre AS Cliente,
      COUNT(p.PedidoID) AS TotalGastado
FROM Clientes c
LEFT JOIN Pedidos p 
ON c.ClienteID = p.ClienteID
GROUP BY c.ClienteID,c.Nombre;

---------------------------------------------------------------------
SELECT 'Clientes' AS Tabla,COUNT(*) AS Cantidad FROM GenJun.dbo.Clientes
UNION
SELECT 'Productos',COUNT(*) FROM GenJun.dbo.Productos
UNION
SELECT 'Pedidos',COUNT(*) FROM GenJun.dbo.Pedidos;
Go
-----------------------------------------------REPORTE COMPLETO
SELECT 
     c.Nombre AS Cliente,
     p.PedidoID,
     p.Fecha,
     prod.Nombre AS Producto,
     dp.Cantidad,
     dp.PrecioUnitario,
     (dp.Cantidad * dp.PrecioUnitario) AS Subtotal
FROM Clientes As c
INNER JOIN Pedidos AS p
ON c.ClienteId = p.ClienteID
INNER JOIN DetallesPedido AS dp
ON p.PedidoId = dp.PedidoID
INNER JOIN Productos AS prod
ON dp.ProductoID = prod.ProductoId
WHERE p.Fecha >= '2024-01-01'
ORDER BY p.Fecha DESC,p.PedidoId;


--VISTAS
--Ahora puedes usar la vista como una tabla:
SELECT * FROM VistaResumenVentas
WHERE TotalPedidos > 0
ORDER BY MontoTotal DESC ;



--EJECUTAR EL SP --
EXEC spObtenerClientePorId @ClienteID = 1;

--EJECUTAR SP ---
DECLARE @IDNuevo INT
EXEC spInsertarPedido
     @ClienteID=1,
     @Total =150.00,
     @NuevoPedidoID = @IDNuevo OUTPUT;

PRINT 'Pedido creado con ID:'+ CAST(@IDNuevo AS NVARCHAR);


--VERIFICAR AUDITORIA PRODUCTOS

SELECT TOP 15 * FROM [dbo].[AuditoriaProductos]
INSERT INTO dbo.Productos(Nombre,Categoria,Precio,Stock)
VALUES ('Galletas de Vainilla','Alimentos',20,100)

--VERIFICAR EL ID PRODUCTO (TRUCO !!! SE PUEDE CORRER EL UPDATE DESPUES DE --)
--UPDATE   
--SELECT * FROM 
Productos 
SET Precio = 25
WHERE ProductoId = 21 

--DELETE
--SELECT * 
FROM Productos
WHERE ProductoID =22




SELECT TOP 15 * FROM [dbo].[Clientes]
SELECT TOP 15 * FROM [dbo].[DetallesPedido]
SELECT TOP 15 * FROM [dbo].[Pedidos]
SELECT TOP 15 * FROM [dbo].[Productos]


--===CANTIDAD DE REGISTROS


SELECT COUNT(*) AS AuditoriaProductos FROM [dbo].[AuditoriaProductos] 
SELECT COUNT(*) AS Clientes FROM [dbo].[Clientes] 
SELECT COUNT(*) AS DetallesPedido FROM [dbo].[DetallesPedido] 
SELECT COUNT(*) AS Pedido FROM [dbo].[Pedidos] 
SELECT COUNT(*) AS Producto FROM [dbo].[Productos] 
