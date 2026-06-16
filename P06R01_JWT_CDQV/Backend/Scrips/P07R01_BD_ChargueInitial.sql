Use JwtDemoDB
GO 
--Autor:Carlos David Quintero Villegas
--Created:20260602
--Descripcion:CargaInicial
--P07R01_BD_CDQV:C Carga Inicial
--Insertar datos de ejemplo

sp_help 'RefreshTokens'


--INSERCION DE DATOS EN LA TABLA USUARIOS
INSERT INTO dbo.Usuarios
(
    Nombre,
    Email,
    PasswordHash,
    Rol,
    Activo,
    CreadoEn
)
VALUES
('Juan Pérez', 'juan@empresa.com', 'Juan2025*', 'Admin', 1, GETDATE()),
('María López', 'maria@empresa.com', '<HASH_MARIA>', 'Usuario', 1, GETDATE()),
('Carlos García', 'carlos@empresa.com', '<HASH_CARLOS>', 'Usuario', 1, GETDATE()),
('Ana Martínez', 'ana@empresa.com', '<HASH_ANA>', 'Supervisor', 1, GETDATE()),
('Luis Rodríguez', 'luis@empresa.com', '<HASH_LUIS>', 'Usuario', 1, GETDATE());


--INSERCION DE DATOS EN LA TABLA REFRESH TOKENS

INSERT INTO dbo.RefreshTokens
(
    Token,
    Expira,
    Revocado,
    CreadoEn,
    UsuarioId
)
VALUES
('RT_001_A1B2C3D4E5F6G7H8', DATEADD(DAY,30,GETDATE()), 0, GETDATE(), 1),
('RT_002_B2C3D4E5F6G7H8I9', DATEADD(DAY,30,GETDATE()), 0, GETDATE(), 3),
('RT_003_C3D4E5F6G7H8I9J0', DATEADD(DAY,30,GETDATE()), 0, GETDATE(), 4),
('RT_004_D4E5F6G7H8I9J0K1', DATEADD(DAY,30,GETDATE()), 0, GETDATE(), 5),
('RT_005_E5F6G7H8I9J0K1L2', DATEADD(DAY,30,GETDATE()), 0, GETDATE(), 6);



--INSERCION DE DATOS EN LA TABLA Productos
--sp_help 'Productos'
INSERT INTO dbo.Productos 
(
    Nombre,
    Descripcion,
    Precio,
    Stock,
    Activo
)
VALUES
('Mouse', 'Mouse RGB gamer', 100.00, 100, 1),
('Teclado', 'Teclado mecánico retroiluminado', 450.00, 50, 1),
('Monitor', 'Monitor 24 pulgadas Full HD', 2200.00, 30, 1),
('Audífonos', 'Audífonos gamer con micrófono', 350.00, 80, 1),
('Silla Gamer', 'Silla ergonómica reclinable', 1800.00, 20, 1);



---INSERCION DE DATOS EN LA TABLA 