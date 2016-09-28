/* *************************************** */
/*         PROCEDIMIENTO ELIMINAR          */
/* *************************************** */


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_cliente_eliminar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_cliente_eliminar];
GO


CREATE PROCEDURE [dbo].[sp_tbl_ventas_cliente_eliminar](@clienteid int)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRAN;
	BEGIN TRY
		DELETE FROM tbl_ventas_cliente WHERE clienteid = @clienteid;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al eliminar la fila en tbl_ventas_cliente.%s',16,1,@FULLMSG);
	END CATCH
	IF @@TRANCOUNT > 0 COMMIT TRAN;
	RETURN;
END
GO

/* *************************************** */
/*          PROCEDIMIENTO GUARDAR          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_cliente_guardar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_cliente_guardar];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_cliente_guardar](@clienteid int, @clienteidt varchar(10), @nombre varchar(50), @direccion varchar(100))
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	/* Validacion de tbl_ventas_cliente (clienteidt = @clienteidt and clienteid != @clienteid) */
	IF EXISTS(SELECT * FROM tbl_ventas_cliente WHERE clienteidt = @clienteidt and clienteid != @clienteid)
		BEGIN
			RAISERROR('El registro ya existe y no se puede duplicar.',16,1);
			RETURN;
		END


	BEGIN TRAN;
	IF @clienteid = 0 
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.tbl_ventas_cliente (clienteidt,nombre,direccion) 
				VALUES(@clienteidt,@nombre,@direccion);
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error, no se pudo guardar el registro de  tbl_ventas_cliente .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END		
	ELSE
		BEGIN
			BEGIN TRY
				UPDATE tbl_ventas_cliente 
				SET clienteidt=@clienteidt,nombre=@nombre,direccion=@direccion
				WHERE clienteid=@clienteid;	
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error al actualizar los datos de tbl_ventas_cliente .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END
END	
GO

/* *************************************** */
/*          PROCEDIMIENTO LISTADO          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_cliente_listado'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_cliente_listado];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_cliente_listado](@clienteid int)
AS
BEGIN

	SET NOCOUNT ON;
    
	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRY
		IF  @clienteid IS NULL  
			SELECT * FROM tbl_ventas_cliente;
		ELSE
			SELECT * FROM tbl_ventas_cliente WHERE clienteid = @clienteid;   
	END TRY
	BEGIN CATCH
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al cargar el listado de  tbl_ventas_cliente .%s',16,1,@FULLMSG);  
	END CATCH 

END
GO