USE GenJun
GO
--=============================================
--Autor:Carlos David Quintero Villegas
--Created:20260603
--Descripcion:Trigger AFTER
--P01R01_BD_CDQV:Create TRIGGER
--=============================================
CREATE OR ALTER TRIGGER trAuditoriaCambioPrecio
ON Productos
AFTER UPDATE
AS
BEGIN
    IF UPDATE (Precio)
    BEGIN 
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             d.ProductoID,
             'AFTER UPDATE',
             d.Precio,
             i.Precio,
             SYSTEM_USER
        FROM deleted d
        INNER JOIN inserted i ON d.ProductoId = i.ProductoId;
     END
END;
GO
--ACTIVIDAD : CREAR  / AFTER / INSTEAD : INSERT,UPDATE,DELETE PARA TABLA AUDITORIA 
------------------------------------------------------------------------------------INSERT
CREATE OR ALTER TRIGGER tr_After_Insert_AuditoriaCambioPrecio
ON Productos
AFTER INSERT
AS
BEGIN    
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             ProductoID,
             'AFTER INSERT',
             NULL,
             Precio,
             SYSTEM_USER
        FROM inserted
     
END;
GO

--===========================================================================================DELETE
CREATE OR ALTER TRIGGER tr_After_Delete_AuditoriaCambioPrecio
ON Productos
AFTER DELETE
AS
BEGIN    
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             d.ProductoID,
             'AFTER DELETE',
             d.Precio,
             d.Precio,
             SYSTEM_USER
        FROM deleted d
        
     
END;
GO

--========================================================================================INSTEAD OF UPDATE

CREATE OR ALTER TRIGGER tr_Instead_Update_AuditoriaCambioPrecio
ON Productos
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE (Precio)
    BEGIN 
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             d.ProductoID,
             'INSTEAD UPDATE',
             d.Precio,
             i.Precio,
             SYSTEM_USER
        FROM deleted d
        INNER JOIN inserted i ON
        d.ProductoId = i.ProductoId
        WHERE d.Precio <> i.Precio;

        UPDATE p
    SET
        p.Nombre = i.Nombre,
        p.Precio = i.Precio
        
    FROM Productos p
    INNER JOIN inserted i
        ON p.ProductoID = i.ProductoID;
     END
END;
GO

--====================================================================INSTEAD INSERT
CREATE OR ALTER TRIGGER tr_Instead_Insert_AuditoriaCambioPrecio
ON Productos
INSTEAD OF INSERT
AS
BEGIN 
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             i.ProductoID,
             'INSTEAD INSERT',
             NULL,
             i.Precio,
             SYSTEM_USER
        FROM inserted i;
  
        INSERT INTO Productos
    (        
        Nombre,
        Precio,
        Categoria,
        Stock
      
    )
    SELECT
        
        i.Nombre,
        i.Precio,
        i.Categoria,
        i.Stock
     
    FROM  inserted i;
        
END;
GO

--=============================================================== INSTEAD DELETE

CREATE OR ALTER TRIGGER tr_Instead_Delete_AuditoriaCambioPrecio
ON Productos
INSTEAD OF DELETE
AS
BEGIN 
        INSERT INTO AuditoriaProductos(ProductoID,Accion,PrecioAnterior,PrecioNuevo,Usuario)
        SELECT
             d.ProductoID,
             'INSTEAD DELETE',             
             d.Precio,
             NULL,
             SYSTEM_USER
        FROM deleted d;
  
        -- Delete real
        DELETE p
        FROM Productos p
        INNER JOIN deleted d
        ON p.ProductoID = d.ProductoID;      
        
END;
GO

--sp_help'AuditoriaProductos'