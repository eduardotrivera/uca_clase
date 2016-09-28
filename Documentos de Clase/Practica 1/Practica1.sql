/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      ABL
 * Project :      DER-p1.dm1
 * Author :       Eduardo Traña
 *
 * Date Created : Wednesday, September 21, 2016 15:18:08
 * Target DBMS : Microsoft SQL Server 2008
 */

USE LAB1
go
IF OBJECT_ID('Reftbl_ventas_producto2') IS NOT NULL
ALTER TABLE tbl_ventas_venta_det
DROP CONSTRAINT Reftbl_ventas_producto2
go

IF OBJECT_ID('Reftbl_ventas_venta_enc3') IS NOT NULL
ALTER TABLE tbl_ventas_venta_det
DROP CONSTRAINT Reftbl_ventas_venta_enc3
go

IF OBJECT_ID('Reftbl_ventas_cliente1') IS NOT NULL
ALTER TABLE tbl_ventas_venta_enc
DROP CONSTRAINT Reftbl_ventas_cliente1
go

/* 
 * TABLE: tbl_ventas_cliente 
 */

CREATE TABLE tbl_ventas_cliente(
    clienteid     int             IDENTITY(1,1),
    clienteidt    varchar(10)     NOT NULL,
    nombre        varchar(50)     NOT NULL,
    direccion     varchar(100)    NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (clienteid)
)
go



IF OBJECT_ID('tbl_ventas_cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE tbl_ventas_cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbl_ventas_cliente >>>'
go

/* 
 * TABLE: tbl_ventas_producto 
 */

CREATE TABLE tbl_ventas_producto(
    productoid     int               IDENTITY(1,1),
    productoidt    varchar(10)       NOT NULL,
    descripcion    varchar(50)       NOT NULL,
    precio         decimal(18, 2)    NOT NULL,
    existencia     bigint            NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (productoid)
)
go



IF OBJECT_ID('tbl_ventas_producto') IS NOT NULL
    PRINT '<<< CREATED TABLE tbl_ventas_producto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbl_ventas_producto >>>'
go

/* 
 * TABLE: tbl_ventas_venta_enc 
 */

CREATE TABLE tbl_ventas_venta_enc(
    ventaid           int             IDENTITY(1,1),
    fecha             date            NOT NULL,
    direccionenvio    varchar(100)    NULL,
    concepto          varchar(100)    NULL,
    clienteid         int             NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (ventaid), 
    FOREIGN KEY (clienteid)
    REFERENCES tbl_ventas_cliente(clienteid)
)
go



IF OBJECT_ID('tbl_ventas_venta_enc') IS NOT NULL
    PRINT '<<< CREATED TABLE tbl_ventas_venta_enc >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbl_ventas_venta_enc >>>'
go

/* 
 * TABLE: tbl_ventas_venta_det 
 */

CREATE TABLE tbl_ventas_venta_det(
    ventadetid    int               IDENTITY(1,1),
    ventaid       int               NOT NULL,
    productoid    int               NOT NULL,
    cantidad      int               NOT NULL,
    precio        decimal(18, 2)    NOT NULL,
    descuento     decimal(18, 2)    NOT NULL,
    importe       decimal(18, 2)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (ventadetid), 
    FOREIGN KEY (productoid)
    REFERENCES tbl_ventas_producto(productoid),
    FOREIGN KEY (ventaid)
    REFERENCES tbl_ventas_venta_enc(ventaid)
)
go



IF OBJECT_ID('tbl_ventas_venta_det') IS NOT NULL
    PRINT '<<< CREATED TABLE tbl_ventas_venta_det >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE tbl_ventas_venta_det >>>'
go

