USE GenJun
GO
--=============================================
--Autor:Carlos David Quintero Villegas
--Created:202603
--Descripcion:Este SP obtiene Clientes por ID
--P01R01_BD_CDQV:Create SP
--=============================================
CREATE OR ALTER PROCEDURE spObtenerClientePorId
      @ClienteID INT
      AS
BEGIN
     SELECT
          ClienteID,
          Nombre,
          Email,
          Telefono
    FROM Clientes
    WHERE ClienteId = @ClienteID;
END;
GO
--sp_help 'Pedidos'
--===============================
CREATE OR ALTER PROCEDURE spInsertarPedido
        @ClienteID INT,
        @Total Decimal(10,2),
        @Estado NVARCHAR(20) = 'Pendiente',
        @NuevoPedidoID INT OUTPUT   --OUTPUT PARAMETRO DE SALIDA
AS
BEGIN
     INSERT INTO Pedidos(ClienteID,Total,Estado,Fecha)
     VALUES (@ClienteID,@Total,@Estado,GETDATE());

     --Obtener el ID del pedido recien creado
     SET @NuevoPedidoID = SCOPE_IDENTITY();--Funcion valida el ultimo ID en una tabla

     SELECT @NuevoPedidoID AS PedidoCreado;
END


--==============================