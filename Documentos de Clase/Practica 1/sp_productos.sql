/* *************************************** */
/*         PROCEDIMIENTO ELIMINAR          */
/* *************************************** */


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_producto_eliminar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_producto_eliminar];
GO


CREATE PROCEDURE [dbo].[sp_tbl_ventas_producto_eliminar](@productoid int)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRAN;
	BEGIN TRY
		DELETE FROM tbl_ventas_producto WHERE productoid = @productoid;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al eliminar la fila en tbl_ventas_producto.%s',16,1,@FULLMSG);
	END CATCH
	IF @@TRANCOUNT > 0 COMMIT TRAN;
	RETURN;
END
GO

/* *************************************** */
/*          PROCEDIMIENTO GUARDAR          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_producto_guardar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_producto_guardar];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_producto_guardar](@productoid int, @productoidt varchar(10), @descripcion varchar(50), @precio decimal(18,2), @existencia bigint)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	/* Validacion de tbl_ventas_producto (productoidt = @productoidt and productoid != @productoid) */
	IF EXISTS(SELECT * FROM tbl_ventas_producto WHERE productoidt = @productoidt and productoid != @productoid)
		BEGIN
			RAISERROR('El registro ya existe y no se puede duplicar.',16,1);
			RETURN;
		END


	BEGIN TRAN;
	IF @productoid = 0 
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.tbl_ventas_producto (productoidt,descripcion,precio,existencia) 
				VALUES(@productoidt,@descripcion,@precio,@existencia);
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error, no se pudo guardar el registro de  tbl_ventas_producto .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END		
	ELSE
		BEGIN
			BEGIN TRY
				UPDATE tbl_ventas_producto 
				SET productoidt=@productoidt,descripcion=@descripcion,precio=@precio,existencia=@existencia
				WHERE productoid=@productoid;	
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error al actualizar los datos de tbl_ventas_producto .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END
END	
GO

/* *************************************** */
/*          PROCEDIMIENTO LISTADO          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_producto_listado'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_producto_listado];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_producto_listado](@productoid int)
AS
BEGIN

	SET NOCOUNT ON;
    
	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRY
		IF  @productoid IS NULL  
			SELECT * FROM tbl_ventas_producto;
		ELSE
			SELECT * FROM tbl_ventas_producto WHERE productoid = @productoid;   
	END TRY
	BEGIN CATCH
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al cargar el listado de  tbl_ventas_producto .%s',16,1,@FULLMSG);  
	END CATCH 

END
GO