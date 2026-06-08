USE GenJun
Go
--Autor:Carlos David Quintero Villegas
--Created:20260602
--Descripcion:CargaInicial
--P01R01_BD_CDQV:C Carga Inicial

--Insertar datos de ejemplo

INSERT INTO Productos(Nombre,Categoria,Precio,Stock)
VALUES
      ('Cafe Americano','Bebidas',35.00,100),
      ('Cappucciono','Bebidas',45.00,100),
      ('Croissant','Panaderia',25.00,50);
GO


--Insertar Clientes
INSERT INTO Clientes(Nombre,Email,Telefono)
VALUES ('Juan','juan@email.com','5599991214');
GO

--Insertar Pedidos
INSERT INTO Pedidos(ClienteID,Total,Estado)
VALUES (1,125.50,'Completado');
GO


--Insertar DETALLE PEDIDOS
INSERT INTO DetallesPedido(PedidoID,ProductoId,Cantidad,PrecioUnitario)
VALUES (1,1,2,35)
GO


UPDATE DetallesPedido
SET PrecioUnitario = 35 
WHERE PedidoID =1 
AND ProductoID =1;
GO
---tarea
--PRODUCTOS
INSERT INTO Productos(Nombre,Categoria,Precio,Stock)
VALUES      --tarea
      ('Latte', 'Bebidas', 50.00, 80),
('Mocha', 'Bebidas', 55.00, 70),
('Chocolate Caliente', 'Bebidas', 40.00, 60),
('Te Chai', 'Bebidas', 45.00, 50),
('Panque de Platano', 'Panaderia', 30.00, 40),
('Muffin de Chocolate', 'Panaderia', 28.00, 35),
('Galleta de Avena', 'Panaderia', 18.00, 60),
('Bagel con Queso', 'Panaderia', 32.00, 25),
('Sandwich de Pavo', 'Alimentos', 65.00, 30),
('Ensalada Cesar', 'Alimentos', 75.00, 20);
GO

--CLIENTES 
INSERT INTO Clientes(Nombre,Email,Telefono)
VALUES  ('Maria Lopez', 'maria@email.com', '5511111111'),
('Carlos Perez', 'carlos@email.com', '5522222222'),
('Ana Torres', 'ana@email.com', '5533333333'),
('Luis Hernandez', 'luis@email.com', '5544444444'),
('Sofia Ramirez', 'sofia@email.com', '5555555555'),
('Pedro Garcia', 'pedro@email.com', '5566666666'),
('Fernanda Ruiz', 'fernanda@email.com', '5577777777'),
('Diego Martinez', 'diego@email.com', '5588888888'),
('Valeria Cruz', 'valeria@email.com', '5599999999'),
('Jorge Castillo', 'jorge@email.com', '5512345678');
GO


--PEDIDIOS 
INSERT INTO Pedidos(ClienteID,Total,Estado)
VALUES (2, 95.00, 'Completado'),
(3, 120.00, 'Pendiente'),
(4, 80.00, 'Completado'),
(5, 140.00, 'En Proceso'),
(6, 60.00, 'Completado'),
(7, 175.00, 'Pendiente'),
(8, 90.00, 'Completado'),
(9, 110.00, 'En Proceso'),
(10, 135.00, 'Completado'),
(11, 70.00, 'Pendiente');
GO

--DETALLE PEDIDOS 
INSERT INTO DetallesPedido(PedidoID,ProductoID,Cantidad,PrecioUnitario)
VALUES (2, 2, 2, 45.00),
(3, 4, 3, 40.00),
(4, 5, 2, 50.00),
(5, 10, 2, 65.00),
(6, 8, 2, 30.00),
(7, 11, 2, 75.00),
(8, 7, 2, 45.00),
(9, 9, 2, 55.00),
(10, 6, 3, 45.00),
(11, 3, 2, 35.00);
GO