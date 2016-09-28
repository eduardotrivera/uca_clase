/* *************************************** */
/*         PROCEDIMIENTO ELIMINAR          */
/* *************************************** */


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_enc_eliminar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_eliminar];
GO


CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_eliminar](@ventaid int)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRAN;
	BEGIN TRY
		DELETE FROM tbl_ventas_venta_enc WHERE ventaid = @ventaid;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al eliminar la fila en tbl_ventas_venta_enc.%s',16,1,@FULLMSG);
	END CATCH
	IF @@TRANCOUNT > 0 COMMIT TRAN;
	RETURN;
END
GO

/* *************************************** */
/*          PROCEDIMIENTO GUARDAR          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_enc_guardar'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_guardar];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_guardar](@ventaid int, @fecha date, @direccionenvio varchar(100), @concepto varchar(100), @clienteid int)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	IF NOT EXISTS(SELECT * FROM tbl_ventas_cliente WHERE clienteid = @clienteid) 
		BEGIN
			RAISERROR('El registro tiene referencias a la tabla tbl_ventas_cliente que no existen.',16,1);
			RETURN;
		END	

	BEGIN TRAN;
	IF @ventaid = 0 
		BEGIN
			BEGIN TRY
				INSERT INTO dbo.tbl_ventas_venta_enc (fecha,direccionenvio,concepto,clienteid) 
				VALUES(@fecha,@direccionenvio,@concepto,@clienteid);
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error, no se pudo guardar el registro de  tbl_ventas_venta_enc .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END		
	ELSE
		BEGIN
			BEGIN TRY
				UPDATE tbl_ventas_venta_enc 
				SET fecha=@fecha,direccionenvio=@direccionenvio,concepto=@concepto,clienteid=@clienteid
				WHERE ventaid=@ventaid;	
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0 ROLLBACK TRAN;
				IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
				RAISERROR('Error al actualizar los datos de tbl_ventas_venta_enc .%s',16,1,@FULLMSG);
			END CATCH
			IF @@TRANCOUNT > 0 COMMIT TRAN;
			RETURN;
		END
END	
GO

/* *************************************** */
/*          PROCEDIMIENTO LISTADO          */
/* *************************************** */
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.sp_tbl_ventas_venta_enc_listado'))
DROP PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_listado];
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_listado](@ventaid int)
AS
BEGIN

	SET NOCOUNT ON;
    
	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';


	BEGIN TRY
		IF  @ventaid IS NULL  
			SELECT * FROM tbl_ventas_venta_enc;
		ELSE
			SELECT * FROM tbl_ventas_venta_enc WHERE ventaid = @ventaid;   
	END TRY
	BEGIN CATCH
		IF @FULLERROR = 1 SET @FULLMSG = ' [' + ERROR_MESSAGE() + ']';
		RAISERROR('Error al cargar el listado de  tbl_ventas_venta_enc .%s',16,1,@FULLMSG);  
	END CATCH 

END
GO