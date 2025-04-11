-- Procedimiento: CrearRol
-- Descripción: Crea un nuevo rol en la base de datos.
-- Parámetros:
--    @Nombre - Nombre del rol a crear.
-- =============================================
CREATE PROCEDURE CrearRol
    @Nombre NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO rol (nombre)
        VALUES (@Nombre);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage NVARCHAR(4000);
		set @ErrorMessage = 'Error al crear el Rol: ' + ERROR_MESSAGE();
  
        THROW 50001, @ErrorMessage, 150;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: ObtenerRoles
-- Descripción: Obtiene todos los roles existentes en la base de datos.
-- =============================================
CREATE PROCEDURE ObtenerRoles
AS
BEGIN
    SELECT * FROM rol;
END;
GO

-- =============================================
-- Procedimiento: ObtenerRolPorId
-- Descripción: Obtiene un rol específico por su Id.
-- Parámetros:
--    @Id - Id del rol a consultar.
-- =============================================

CREATE PROCEDURE ObtenerRolPorId
    @Id INT
AS
BEGIN
    SELECT * FROM rol
    WHERE id = @Id;
END;
GO

-- =============================================
-- Procedimiento: ActualizarRolPorId
-- Descripción: Actualiza el nombre de un rol existente.
-- Parámetros:
--    @Id - Id del rol a actualizar.
--    @Nombre - Nuevo nombre para el rol.
-- =============================================


CREATE PROCEDURE ActualizarRolPorId
    @Id INT,
    @Nombre NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE rol
        SET nombre = @Nombre
        WHERE id = @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
     DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = 'Error al actualizar Rol: ' + ERROR_MESSAGE(); 
		THROW 50002, @ErrorMessage, 151
	END CATCH

END;
GO

-- =============================================
-- Procedimiento: EliminarRolPorId
-- Descripción: Elimina un rol de la base de datos.
-- Parámetros:
--    @Id - Id del rol a eliminar.
-- =============================================
CREATE PROCEDURE EliminarRolPorId
    @Id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM rol
        WHERE id = @Id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = 'Error eliminar el rol: ' + ERROR_MESSAGE(); 
		THROW 50003, @ErrorMessage, 152
    END CATCH
END;
GO