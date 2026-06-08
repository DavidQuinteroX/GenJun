USE GenJun
Go
--=============================================
--Autor:Carlos David Quintero Villegas
--Creacion de BD:P01R01_BD_DQ
--Fecha :202606201
--Descripcion:Pruebas Unitarias
--=============================================
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