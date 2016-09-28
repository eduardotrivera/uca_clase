/* *************************************** */
/*         PROCEDIMIENTO ELIMINAR          */
/* *************************************** */


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_det_eliminar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_det_eliminar];
GO


CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_det_eliminar](@ventadetid int)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRAN;
	BEGIN TRY
		DELETE FROM tbl_ventas_venta_det WHERE ventadetid = @ventadetid;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al eliminar la fila en tbl_ventas_venta_det.%s',16,1,@FULLMSG);
	END CATCH
	IF @@TRANCOUNT > 0 COMMIT TRAN;
	RETURN;
END
GO

/* *************************************** */
/*          PROCEDIMIENTO GUARDAR          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_det_guardar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_det_guardar];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_det_guardar](@ventadetid int , @ventaid int, @productoid int, @cantidad int, @precio decimal(18,2), @descuento decimal(18,2), @importe decimal(18,2))
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	IF NOT EXISTS(SELECT * FROM tbl_ventas_producto WHERE productoid = @productoid) 
		BEGIN
			RAISERROR('El registro tiene referencias a la tabla tbl_ventas_producto que no existen.',16,1);
			RETURN;
		END	
	IF NOT EXISTS(SELECT * FROM tbl_ventas_venta_enc WHERE ventaid = @ventaid) 
		BEGIN
			RAISERROR('El registro tiene referencias a la tabla tbl_ventas_venta_enc que no existen.',16,1);
			RETURN;
		END	

	BEGIN TRAN;
	IF @ventadetid = 0 
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.tbl_ventas_venta_det (ventaid,productoid,cantidad,precio,descuento,importe) 
				VALUES(@ventaid,@productoid,@cantidad,@precio,@descuento,@importe);
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error, no se pudo guardar el registro de  tbl_ventas_venta_det .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END		
	ELSE
		BEGIN
			BEGIN TRY
				UPDATE tbl_ventas_venta_det 
				SET ventaid=@ventaid,productoid=@productoid,cantidad=@cantidad,precio=@precio,descuento=@descuento,importe=@importe
				WHERE ventadetid=@ventadetid;	
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error al actualizar los datos de tbl_ventas_venta_det .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END
END	
GO

/* *************************************** */
/*          PROCEDIMIENTO LISTADO          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_det_listado'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_det_listado];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_det_listado](@ventadetid int)
AS
BEGIN

	SET NOCOUNT ON;
    
	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRY
		IF  @ventadetid IS NULL  
			SELECT * FROM tbl_ventas_venta_det;
		ELSE
			SELECT * FROM tbl_ventas_venta_det WHERE ventadetid = @ventadetid;   
	END TRY
	BEGIN CATCH
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al cargar el listado de  tbl_ventas_venta_det .%s',16,1,@FULLMSG);  
	END CATCH 

END
GO