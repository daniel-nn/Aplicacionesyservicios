-- =============================================
-- Procedimiento: CrearUsuario
-- Descripción: Crea un nuevo usuario en la tabla Usuario.
-- Parámetros:
--    @Email - Correo electrónico del nuevo usuario.
--    @Contrasena - Contraseña del nuevo usuario.
-- =============================================
CREATE PROCEDURE CrearUsuario
    @Email NVARCHAR(100),
    @Contrasena NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Usuario (email, contrasena)
        VALUES (@Email, @Contrasena);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW 50010, 'Error al crear el usuario.', 150;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: ObtenerUsuarios
-- Descripción: Obtiene todos los registros de la tabla Usuario.
-- Parámetros: Ninguno.
-- =============================================
CREATE PROCEDURE ObtenerUsuarios
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Usuario;
    END TRY
    BEGIN CATCH
        THROW 50012, 'Error al obtener los usuarios.', 150;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: ObtenerUsuarioPorEmail
-- Descripción: Obtiene un usuario de la tabla Usuario por su email.
-- Parámetros:
--    @Email - Correo electrónico del usuario a buscar.
-- =============================================
CREATE PROCEDURE ObtenerUsuarioPorEmail
    @Email NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        SELECT * FROM Usuario WHERE email = @Email;
    END TRY
    BEGIN CATCH
        THROW 50013, 'Error al obtener el usuario por email.', 150;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: ActualizarUsuario
-- Descripción: Actualiza la contraseña de un usuario existente.
-- Parámetros:
--    @Email - Correo electrónico del usuario.
--    @Contrasena - Nueva contraseña para el usuario.
-- =============================================
CREATE PROCEDURE ActualizarUsuario
    @Email NVARCHAR(100),
    @Contrasena NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Usuario
        SET contrasena = @Contrasena
        WHERE email = @Email;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW 50014, 'Error al actualizar el usuario.', 150;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: EliminarUsuario
-- Descripción: Elimina un usuario existente de la tabla Usuario.
-- Parámetros:
--    @Email - Correo electrónico del usuario a eliminar.
-- =============================================
CREATE PROCEDURE EliminarUsuario
    @Email NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Usuario WHERE email = @Email;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW 50015, 'Error al eliminar el usuario.', 150;
    END CATCH
END;
GO