USE [bdindicadores1330]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarUsuarioConRol]    Script Date: 10/04/2025 5:28:56 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ActualizarUsuarioConRol]
    @Email NVARCHAR(100),
    @NuevaContrasena NVARCHAR(100),
	@NuevoRol int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Actualizar solo la contraseña del usuario
	
		 -- Verificar que el usuario exista
		IF NOT EXISTS (select 1 from usuario where email = @Email)
		BEGIN

			;THROW 50001, 'No se encontro el usuario seleccionado', 151;
		END
		
		
	
        UPDATE usuario
        SET contrasena = @NuevaContrasena
		WHERE email = @Email;

				   
       	IF NOT EXISTS (select 1 from rol_usuario where fkemail = @Email)
		BEGIN

			;THROW 50001, 'El usuario no tiene rol asignado', 151;
		END
		
		
		 UPDATE rol_usuario
        SET fkidrol = @NuevoRol
		WHERE fkemail = @Email;


		
        -- Verificar que se haya actualizado al menos una fila.
        -- Esto podría ocurrir si no existe un usuario con el email indicado.
   

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si hay una transacción activa, se revierte.
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();

        -- Lanza el error capturado con otro código personalizado.
        THROW 50002, @ErrorMessage, 1; -- Código 50002: Error en sistema general
    END CATCH
END

