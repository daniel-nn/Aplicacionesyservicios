-- =============================================
-- Procedimiento: CrearRolUsuario
-- Descripci�n: Asigna un rol a un usuario.
-- Par�metros:
--    @FkEmail - Email del usuario.
--    @FkIdRol - ID del rol.
-- =============================================
CREATE PROCEDURE CrearRolUsuario
    @FkEmail VARCHAR(100),
    @FkIdRol INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO rol_usuario (fkemail, fkidrol)
        VALUES (@FkEmail, @FkIdRol);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
	    -- Si la transacci�n est� activa, se revierte
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

			
    -- Capturamos el error del sistema
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = 'Error al crear la relaci�n rol-usuario: ' + ERROR_MESSAGE();
        THROW 50001, @ErrorMessage, 151;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: EliminarRolUsuario
-- Descripci�n: Elimina la asignaci�n de un rol a un usuario.
-- Par�metros:
--    @FkEmail - Email del usuario.
--    @FkIdRol - ID del rol.
-- =============================================

CREATE PROCEDURE EliminarRolUsuario
    @FkEmail VARCHAR(100),
    @FkIdRol INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM rol_usuario
        WHERE fkemail = @FkEmail AND fkidrol = @FkIdRol;

        COMMIT TRANSACTION;
    END TRY
   BEGIN CATCH
     -- Si la transacci�n est� activa, se revierte
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

    DECLARE @ErrorMessage NVARCHAR(4000);
    SET @ErrorMessage = ERROR_MESSAGE();

    THROW 50003, @ErrorMessage, 151;
END CATCH
END;
GO

-- =============================================
-- Procedimiento: ObtenerRolesPorUsuario
-- Descripci�n: Obtiene todos los roles asignados a un usuario.
-- Par�metros:
--    @FkEmail - Email del usuario.
-- =============================================
CREATE PROCEDURE ObtenerRolesPorUsuario
    @FkEmail VARCHAR(100)
AS
BEGIN
    SELECT r.id, r.nombre
    FROM rol_usuario ru
    INNER JOIN rol r ON ru.fkidrol = r.id
    WHERE ru.fkemail = @FkEmail;
END;
GO

-- =============================================
-- Procedimiento: ObtenerUsuariosPorRol
-- Descripci�n: Obtiene todos los usuarios asignados a un rol.
-- Par�metros:
--    @FkIdRol - ID del rol.
-- =============================================
CREATE PROCEDURE ObtenerUsuariosPorRol
    @FkIdRol INT
AS
BEGIN
    SELECT u.email
    FROM rol_usuario ru
    INNER JOIN usuario u ON ru.fkemail = u.email
    WHERE ru.fkidrol = @FkIdRol;
END;
GO