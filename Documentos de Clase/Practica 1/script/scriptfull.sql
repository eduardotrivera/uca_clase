USE [LAB1]
GO
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_cliente_eliminar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_cliente_guardar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_cliente_listado]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_producto_eliminar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_producto_guardar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_producto_listado]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_det_eliminar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_det_guardar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_det_listado]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_det_xml]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_det_xml](@ventadetid int , @ventaid int, @XML XML)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	declare @productoid INT;
	declare @cantidad INT;
	declare @precio decimal(18,2);
	declare @descuento decimal(18,2);
	declare @importe decimal(18,2);

	DECLARE @handle INT  
	DECLARE @PrepareXmlStatus INT  

	EXEC @PrepareXmlStatus= sp_xml_preparedocument @handle OUTPUT, @XML  

	
	declare cur cursor local fast_forward for
    SELECT  *
	FROM    OPENXML(@handle, '/rows/row', 2)  
		WITH (
		productoid INT,
		cantidad INT,
		precio decimal(18,2),
		descuento decimal(18,2),
		importe decimal(18,2)
		) 

	open cur
	while 1 = 1
	begin
		fetch cur into @productoid, @cantidad, @precio, @descuento, @importe
		if @@fetch_status <> 0 break

		 exec sp_tbl_ventas_venta_det_guardar 0, @ventaid, @productoid, @cantidad, @precio, @descuento, @importe;

	end
	close cur
	deallocate cur

	EXEC sp_xml_removedocument @handle 
		
END	

GO
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_enc_eliminar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_enc_guardar]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_tbl_ventas_venta_enc_guardar](@ventaid int, @fecha date, @direccionenvio varchar(100), @concepto varchar(100), @clienteid int,  @XML XML)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FULLERROR BIT = 0;
	DECLARE @FULLMSG NVARCHAR(4000) = '';

	DECLARE @ID INT;

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

				SET @ID = @@IDENTITY;

				EXEC sp_tbl_ventas_venta_det_xml 0, @ID,  @XML;


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
/****** Object:  StoredProcedure [dbo].[sp_tbl_ventas_venta_enc_listado]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  Table [dbo].[tbl_ventas_cliente]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ventas_cliente](
	[clienteid] [int] IDENTITY(1,1) NOT NULL,
	[clienteidt] [varchar](10) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[direccion] [varchar](100) NULL,
 CONSTRAINT [PK2] PRIMARY KEY NONCLUSTERED 
(
	[clienteid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ventas_producto]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ventas_producto](
	[productoid] [int] IDENTITY(1,1) NOT NULL,
	[productoidt] [varchar](10) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[precio] [decimal](18, 2) NOT NULL,
	[existencia] [bigint] NOT NULL,
 CONSTRAINT [PK1] PRIMARY KEY NONCLUSTERED 
(
	[productoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_ventas_venta_det]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ventas_venta_det](
	[ventadetid] [int] IDENTITY(1,1) NOT NULL,
	[ventaid] [int] NOT NULL,
	[productoid] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio] [decimal](18, 2) NOT NULL,
	[descuento] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK4] PRIMARY KEY NONCLUSTERED 
(
	[ventadetid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_ventas_venta_enc]    Script Date: 21/09/2016 16:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_ventas_venta_enc](
	[ventaid] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NOT NULL,
	[direccionenvio] [varchar](100) NULL,
	[concepto] [varchar](100) NULL,
	[clienteid] [int] NOT NULL,
 CONSTRAINT [PK3] PRIMARY KEY NONCLUSTERED 
(
	[ventaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[tbl_ventas_venta_det]  WITH CHECK ADD FOREIGN KEY([productoid])
REFERENCES [dbo].[tbl_ventas_producto] ([productoid])
GO
ALTER TABLE [dbo].[tbl_ventas_venta_det]  WITH CHECK ADD FOREIGN KEY([ventaid])
REFERENCES [dbo].[tbl_ventas_venta_enc] ([ventaid])
GO
ALTER TABLE [dbo].[tbl_ventas_venta_enc]  WITH CHECK ADD FOREIGN KEY([clienteid])
REFERENCES [dbo].[tbl_ventas_cliente] ([clienteid])
GO
