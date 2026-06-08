USE GenJun
GO

CREATE OR ALTER VIEW VistaResumenVentas AS
SELECT
     c.ClienteID,
     c.Nombre AS Cliente,
     c.Email,
     COUNT(p.PedidoID) AS TotalPedidos,
     ISNULL(SUM(p.Total),0) AS MontoTotal,
     MAX(p.Fecha) AS UltimaCompra
FROM Clientes AS c
LEFT JOIN Pedidos AS p 
ON c.ClienteId = p.ClienteID
GROUP BY c.ClienteId,c.Nombre,c.Email
GO

