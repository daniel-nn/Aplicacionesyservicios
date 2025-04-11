-- =============================================
-- Procedimiento: CrearVariable
-- Descripción: Crea una nueva variable en la base de datos.
-- Parámetros:
--    @nombre - Nombre de la variable.
--    @fkemailusuario - Email del usuario que crea la variable.
-- =============================================
CREATE PROCEDURE CrearVariable
    @nombre VARCHAR(200),
    @fkemailusuario VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO variable (nombre, fechacreacion, fkemailusuario)
        VALUES (@nombre, GETDATE(), @fkemailusuario);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW 50001, 'Error al crear la variable.', 1;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: ObtenerVariables
-- Descripción: Obtiene todas las variables registradas.
-- Parámetros: Ninguno.
-- =============================================
CREATE PROCEDURE ObtenerVariables
AS
BEGIN
    SELECT id, nombre, fechacreacion, fkemailusuario
    FROM variable;
END;
GO

-- =============================================
-- Procedimiento: ObtenerVariablePorId
-- Descripción: Obtiene una variable por su ID.
-- Parámetros:
--    @id - ID de la variable a consultar.
-- =============================================
CREATE PROCEDURE ObtenerVariablePorId
    @id INT
AS
BEGIN
    SELECT id, nombre, fechacreacion, fkemailusuario
    FROM variable
    WHERE id = @id;
END;
GO

-- =============================================
-- Procedimiento: ActualizarVariable
-- Descripción: Actualiza los datos de una variable existente.
-- Parámetros:
--    @id - ID de la variable.
--    @nombre - Nuevo nombre de la variable.
--    @fkemailusuario - Email del usuario que actualiza la variable.
-- =============================================
CREATE PROCEDURE ActualizarVariable
    @id INT,
    @nombre VARCHAR(200),
    @fkemailusuario VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE variable
        SET nombre = @nombre,
            fkemailusuario = @fkemailusuario
        WHERE id = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW 50002, 'Error al actualizar la variable.', 1;
    END CATCH
END;
GO

-- =============================================
-- Procedimiento: EliminarVariable
-- Descripción: Elimina una variable por su ID.
-- Parámetros:
--    @id - ID de la variable a eliminar.
-- =============================================
CREATE PROCEDURE EliminarVariable
    @id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM variable
        WHERE id = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW 50003, 'Error al eliminar la variable.', 1;
    END CATCH
END;
GO
