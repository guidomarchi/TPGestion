USE [GD2C2024]
GO

-- Eliminar constraints
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Venta_Cliente', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Venta DROP CONSTRAINT FK_Venta_Cliente;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Factura_Vendedor', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Factura DROP CONSTRAINT FK_Factura_Vendedor;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Cliente_Usuario', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Cliente DROP CONSTRAINT FK_Cliente_Usuario;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Vendedor_Usuario', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Vendedor DROP CONSTRAINT FK_Vendedor_Usuario;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Domicilio_Localidad', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Domicilio DROP CONSTRAINT FK_Domicilio_Localidad;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Producto', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].AlmacenXProducto DROP CONSTRAINT FK_Producto;
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Almacen', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].AlmacenXProducto DROP CONSTRAINT FK_Almacen; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Almacen_publicacion', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Publicacion DROP CONSTRAINT FK_Almacen_publicacion; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_vendedor_publicacion', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Publicacion DROP CONSTRAINT FK_vendedor_publicacion; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Detalle_Factura', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Factura DROP CONSTRAINT FK_Detalle_Factura; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Detalle_Publicacion', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Factura DROP CONSTRAINT FK_Detalle_Publicacion; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Detalle_Venta', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Venta DROP CONSTRAINT FK_Detalle_Venta; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Venta_Publicacion', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Venta DROP CONSTRAINT FK_Venta_Publicacion; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Pago_Venta', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Pago DROP CONSTRAINT FK_Pago_Venta; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Detalle_Pago', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Pago DROP CONSTRAINT FK_Detalle_Pago; 
IF OBJECT_ID('[4_FILAS_AFECTADAS].FK_Pago_medio', 'F') IS NOT NULL ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Pago DROP CONSTRAINT FK_Pago_medio; 


-- Eliminar tablas existentes si ya existen
IF OBJECT_ID('4_FILAS_AFECTADAS.Factura', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Factura;
IF OBJECT_ID('4_FILAS_AFECTADAS.Producto', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Producto;
IF OBJECT_ID('4_FILAS_AFECTADAS.Venta', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Venta;
IF OBJECT_ID('4_FILAS_AFECTADAS.Cliente', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Cliente;
IF OBJECT_ID('4_FILAS_AFECTADAS.Vendedor', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Vendedor;
IF OBJECT_ID('4_FILAS_AFECTADAS.Usuario', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Usuario;
IF OBJECT_ID('4_FILAS_AFECTADAS.Almacen', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Almacen;
IF OBJECT_ID('4_FILAS_AFECTADAS.Domicilio', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Domicilio;
IF OBJECT_ID('4_FILAS_AFECTADAS.Localidad', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Localidad;
IF OBJECT_ID('4_FILAS_AFECTADAS.Provincia', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Provincia;
IF OBJECT_ID('4_FILAS_AFECTADAS.SubRubro', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].SubRubro;
IF OBJECT_ID('4_FILAS_AFECTADAS.Rubro', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Rubro;
IF OBJECT_ID('4_FILAS_AFECTADAS.Marca', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Marca;
IF OBJECT_ID('4_FILAS_AFECTADAS.Modelo', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Modelo;
IF OBJECT_ID('4_FILAS_AFECTADAS.MedioDePago', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].MedioDePago;
IF OBJECT_ID('4_FILAS_AFECTADAS.TipoEnvio', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].TipoEnvio;
IF OBJECT_ID('4_FILAS_AFECTADAS.AlmacenXProducto', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].AlmacenXProducto;
IF OBJECT_ID('4_FILAS_AFECTADAS.Publicacion', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Publicacion;
IF OBJECT_ID('4_FILAS_AFECTADAS.Detalle_Factura', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Detalle_Factura;
IF OBJECT_ID('4_FILAS_AFECTADAS.Detalle_Venta', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Detalle_Venta;
IF OBJECT_ID('4_FILAS_AFECTADAS.Pago', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Pago;
IF OBJECT_ID('4_FILAS_AFECTADAS.Detalle_Pago', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].Detalle_Pago;


-- Eliminar esquema si ya existe
IF EXISTS (SELECT * FROM sys.schemas WHERE name = '4_FILAS_AFECTADAS')
BEGIN
    DROP SCHEMA [4_FILAS_AFECTADAS];
END
GO

CREATE SCHEMA [4_FILAS_AFECTADAS]
GO

--------------------------------------------------------------/TABLAS/----------------------------------------------------------------

CREATE TABLE [4_FILAS_AFECTADAS].Modelo(
    modelo_id Decimal(18,0) PRIMARY KEY,
    modelo_descripcion NVARCHAR(50)
);
GO

CREATE TABLE [4_FILAS_AFECTADAS].Marca(
    marca_id INT IDENTITY(1,1) PRIMARY KEY,
    marca_descripcion NVARCHAR(50)
);
GO

create table [4_FILAS_AFECTADAS].Rubro(
	rubro_id int identity(1,1) primary key,
	rubro_descripcion nvarchar(50)
);
GO

create table [4_FILAS_AFECTADAS].SubRubro(
	subrubro_id int identity(1,1) primary key,
	subrubro_descripcion nvarchar(50),
	subrubro_rubro int foreign key references [4_FILAS_AFECTADAS].Rubro(rubro_id)
);
GO

create table [4_FILAS_AFECTADAS].Provincia(
	prov_id int identity(1,1) primary key,
	prov_nombre nvarchar(50)
);
GO

create table [4_FILAS_AFECTADAS].Localidad(
	loc_id int identity(1,1) primary key,
	loc_nombre nvarchar(50),
	loc_prov int foreign key references [4_FILAS_AFECTADAS].Provincia(prov_id)
);
GO

create table [4_FILAS_AFECTADAS].Usuario(
	usu_id int identity(1,1) primary key,
	usu_nombre nvarchar(50),
	usu_contrasenia nvarchar(50),
	usu_fecha_creacion date,
);
GO

create table [4_FILAS_AFECTADAS].Vendedor(
	ven_id int identity(1,1) primary key,
	ven_rs nvarchar(50),
	ven_cuit nvarchar(50),
	ven_mail nvarchar(50),
	ven_usu_id int
);
GO

create table [4_FILAS_AFECTADAS].Factura(
	fac_nro decimal(18,0) primary key,
	fac_fecha date,
	fac_total decimal(18,2),
	fac_vendedor_id int
);
GO

create table [4_FILAS_AFECTADAS].Cliente(
	cli_id int identity(1,1) primary key,
	cli_nombre nvarchar(50),
	cli_apellido nvarchar(50),
	cli_dni decimal(18,0),
	cli_fecha_nac date,
	cli_mail nvarchar(50),
	cli_usu_id int
);
GO


create table [4_FILAS_AFECTADAS].Venta(
	ven_codigo decimal(18,0) primary key,
	ven_fecha date,
	ven_total decimal(18,2),
	ven_cli_id int
);
go

CREATE TABLE [4_FILAS_AFECTADAS].Domicilio (
    dom_id INT PRIMARY KEY IDENTITY(1,1),
    dom_calle NVARCHAR(50),
    dom_no_calle DECIMAL(18,0),
    dom_piso DECIMAL(18,0),
    dom_depto NVARCHAR(50),
    dom_cp NVARCHAR(50),
    dom_loc INT
);
GO

create table [4_FILAS_AFECTADAS].MedioDePago(
	mp_id int identity(1,1) primary key,
	mp_tipo nvarchar(50),
	mp_nombre nvarchar(50)
)
GO


CREATE TABLE [4_FILAS_AFECTADAS].Producto(
	prod_id int identity(1,1) primary key,
	prod_cod nvarchar(50),
	prod_desc nvarchar(50),
	prod_precio decimal(18,2),
	prod_subRub int foreign key references [4_FILAS_AFECTADAS].SubRubro(subrubro_id),
	prod_marca int foreign key references [4_FILAS_AFECTADAS].Marca(marca_id),
	prod_modelo Decimal(18,0) foreign key references [4_FILAS_AFECTADAS].Modelo(modelo_id)
)
GO

create table [4_FILAS_AFECTADAS].TipoEnvio(
	te_id int identity(1,1) primary key,
	te_tipo nvarchar(50)
)
GO


create table [4_FILAS_AFECTADAS].Almacen(
	alm_id decimal(18,0) primary key,
	alm_costo decimal(18,2),
	alm_dom int foreign key references [4_FILAS_AFECTADAS].Domicilio(dom_id)
)
GO

create table [4_FILAS_AFECTADAS].AlmacenXProducto(
	axp_prod int not null,
	axp_alm decimal(18,0) not null,
	axp_id int identity(1,1) primary key
)
GO

CREATE TABLE [4_FILAS_AFECTADAS].Publicacion(
	publ_codigo int primary key,
	publ_descripcion nvarchar(50),
	publ_stock decimal(18,0),
	publ_fecha date,
	publ_fecha_ven date,
	publ_precio decimal(18,2),
	publ_costo decimal(18,2),
	publ_porc_venta decimal(18,2),
	publ_vendedor_id int,
	publ_alm_prod int
)
GO

Create Table [4_FILAS_AFECTADAS].Detalle_Factura(
	det_fac_id INT IDENTITY(1,1) PRIMARY KEY,
	det_fac_precio decimal(18,2),
	det_fac_cantidad decimal(18,0),
	det_fac_publ int,
	det_fac_tipo nvarchar(50),
	det_fac_nro decimal(18,0),
	det_fac_subtotal decimal(18,2)
)
GO

Create table [4_FILAS_AFECTADAS].Detalle_Venta(
	det_ven_id int identity(1,1) primary key,
	det_ven_cant decimal(18,0),
	det_ven_precio decimal(18,2),
	det_ven_subtotal decimal(18,2),
	det_ven_publ_id int,
	det_ven_nro decimal(18,0)
)
GO

Create table [4_FILAS_AFECTADAS].Pago(
	pago_id int identity(1,1) primary key,
	pago_importe decimal(18,2),
	pago_fecha date,
	pago_venta_nro decimal(18,0)
)
GO

create table [4_FILAS_AFECTADAS].Detalle_Pago(
	det_pago_id int identity(1,1) primary key,
	det_pago_nro_tarjeta nvarchar(50),
	det_pago_venc_tarjeta date,
	det_pago_cant_cuotas decimal(18,0),
	det_pago_medio_id int,
	det_pago_pago_id int
)
GO
--------------------------------------------------------------/PROCEDURES/------------------------------------------------------------
CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MODELO
AS
BEGIN
print 'Tabla Modelo'
insert into [4_FILAS_AFECTADAS].Modelo(modelo_id, modelo_descripcion)
select distinct
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_MOD_DESCRIPCION
from GD2C2024.gd_esquema.Maestra
where
	PRODUCTO_MOD_CODIGO is not null and
	PRODUCTO_MOD_DESCRIPCION is not null ; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MARCA
AS
BEGIN
print 'Tabla Marca'
insert into [4_FILAS_AFECTADAS].Marca(marca_descripcion)
select distinct
	PRODUCTO_MARCA
from GD2C2024.gd_esquema.Maestra m
where
PRODUCTO_MARCA is not null 
; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_RUBRO
AS
BEGIN
print 'Tabla Rubro'
insert into [4_FILAS_AFECTADAS].Rubro(rubro_descripcion)
select distinct
	PRODUCTO_RUBRO_DESCRIPCION
from GD2C2024.gd_esquema.Maestra m
where
	PRODUCTO_RUBRO_DESCRIPCION is not null
; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_SUBRUBRO
AS
BEGIN
print 'Tabla SubRubro'
insert into [4_FILAS_AFECTADAS].SubRubro(	subrubro_descripcion ,	subrubro_rubro)
select distinct
	PRODUCTO_SUB_RUBRO,
	r.rubro_id
from GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Rubro r on r.rubro_descripcion = PRODUCTO_RUBRO_DESCRIPCION
where
	PRODUCTO_SUB_RUBRO is not null and
	PRODUCTO_RUBRO_DESCRIPCION is not null 
; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PROVINCIA
AS
BEGIN
print 'Tabla Provincia'
insert into [4_FILAS_AFECTADAS].Provincia(prov_nombre)
select distinct
	m.ALMACEN_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where ALMACEN_PROVINCIA is not null
union
select distinct
	m.CLI_USUARIO_DOMICILIO_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where CLI_USUARIO_DOMICILIO_PROVINCIA is not null
union
select distinct
	m.VEN_USUARIO_DOMICILIO_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where VEN_USUARIO_DOMICILIO_PROVINCIA is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_LOCALIDAD
AS
BEGIN
print 'Tabla Localidad'
insert into [4_FILAS_AFECTADAS].Localidad(loc_nombre,loc_prov)
select distinct
	m.ALMACEN_Localidad,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.ALMACEN_PROVINCIA
where ALMACEN_Localidad is not null and ALMACEN_PROVINCIA is not null 
union
select distinct
	m.CLI_USUARIO_DOMICILIO_LOCALIDAD,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.CLI_USUARIO_DOMICILIO_PROVINCIA
where CLI_USUARIO_DOMICILIO_LOCALIDAD is not null and CLI_USUARIO_DOMICILIO_PROVINCIA is not null
union
select distinct
	m.VEN_USUARIO_DOMICILIO_LOCALIDAD,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.VEN_USUARIO_DOMICILIO_PROVINCIA
where VEN_USUARIO_DOMICILIO_LOCALIDAD is not null and VEN_USUARIO_DOMICILIO_PROVINCIA is not null
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_USUARIO
AS
BEGIN
print 'Tabla Usuario'
insert into [4_FILAS_AFECTADAS].Usuario(usu_nombre,usu_contrasenia,usu_fecha_creacion)
select distinct
	m.VEN_USUARIO_NOMBRE,
	m.VEN_USUARIO_PASS,
	m.VEN_USUARIO_FECHA_CREACION
from GD2C2024.gd_esquema.Maestra m
where 
	m.VEN_USUARIO_NOMBRE is not null and
	m.VEN_USUARIO_PASS is not null
union
select distinct
	m.CLI_USUARIO_PASS,
	m.CLI_USUARIO_NOMBRE,
	m.CLI_USUARIO_FECHA_CREACION
from GD2C2024.gd_esquema.Maestra m
where 
	m.CLI_USUARIO_PASS is not null and
	m.CLI_USUARIO_NOMBRE is not null
; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_VENDEDOR
AS
BEGIN
print 'Tabla Vendedor'
insert into [4_FILAS_AFECTADAS].Vendedor(ven_rs,ven_cuit, ven_mail , ven_usu_id )
SELECT DISTINCT
    m.VENDEDOR_RAZON_SOCIAL,
    m.VENDEDOR_CUIT,
    m.VENDEDOR_MAIL,
    u.usu_id
FROM GD2C2024.gd_esquema.Maestra m
JOIN [4_FILAS_AFECTADAS].Usuario u 
    ON m.VEN_USUARIO_NOMBRE = u.usu_nombre
    AND m.VEN_USUARIO_PASS = u.usu_contrasenia
WHERE 
    m.VENDEDOR_RAZON_SOCIAL IS NOT NULL 
    AND m.VENDEDOR_MAIL IS NOT NULL 
    AND m.VENDEDOR_CUIT IS NOT NULL 
    AND m.VEN_USUARIO_NOMBRE IS NOT NULL 
    AND m.VEN_USUARIO_PASS IS NOT NULL
; 
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_FACTURA
AS
BEGIN
print 'Tabla Facturas'
insert into [4_FILAS_AFECTADAS].Factura(fac_nro,fac_fecha,fac_total,fac_vendedor_id)
SELECT distinct m.FACTURA_NUMERO, m.FACTURA_FECHA, m.FACTURA_TOTAL, v.ven_id  FROM GD2C2024.gd_esquema.Maestra m
join(select m.PUBLICACION_CODIGO, m.VENDEDOR_CUIT 
	 from  GD2C2024.gd_esquema.Maestra m
	 where m.PUBLICACION_CODIGO is not null and m.VENDEDOR_CUIT is not null)  m2 on m2.PUBLICACION_CODIGO = m.PUBLICACION_CODIGO
join [4_FILAS_AFECTADAS].Vendedor v on (m2.VENDEDOR_CUIT = v.ven_cuit)
where m.FACTURA_NUMERO is not null and m.PUBLICACION_CODIGO is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_CLIENTE
AS
BEGIN
print 'Tabla Clientes'
insert into [4_FILAS_AFECTADAS].Cliente(cli_nombre, cli_apellido, cli_dni, cli_fecha_nac, cli_mail, cli_usu_id)
select distinct
	m.CLIENTE_NOMBRE,
	m.CLIENTE_APELLIDO,
	m.CLIENTE_DNI,
	m.CLIENTE_FECHA_NAC,
	m.CLIENTE_MAIL,
	u.usu_id
from GD2C2024.gd_esquema.Maestra m
JOIN [4_FILAS_AFECTADAS].Usuario u 
    ON m.CLI_USUARIO_NOMBRE = u.usu_nombre
    AND m.CLI_USUARIO_PASS = u.usu_contrasenia and m.CLI_USUARIO_FECHA_CREACION = u.usu_fecha_creacion
where 
	m.CLIENTE_DNI is not null and
	m.CLI_USUARIO_PASS is not null and
	m.CLI_USUARIO_NOMBRE is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_VENTA
AS
BEGIN
print 'tabla Ventas'
insert into [4_FILAS_AFECTADAS].Venta(ven_codigo, ven_fecha, ven_total, ven_cli_id)
select distinct m.VENTA_CODIGO, m.VENTA_FECHA, m.VENTA_TOTAL, c.cli_id
from GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Cliente c on (m.CLIENTE_DNI = c.cli_dni and m.CLIENTE_NOMBRE = c.cli_nombre)
where m.VENTA_CODIGO is not null
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DOMICILIO
AS
BEGIN
print 'tabla Domicilio'
INSERT INTO [4_FILAS_AFECTADAS].Domicilio (
    dom_calle,
    dom_no_calle,
    dom_piso,
    dom_depto,
    dom_cp,
    dom_loc
)
SELECT 
    VEN_USUARIO_DOMICILIO_CALLE AS dom_calle,
    VEN_USUARIO_DOMICILIO_NRO_CALLE AS dom_no_calle,
    VEN_USUARIO_DOMICILIO_PISO AS dom_piso,
    VEN_USUARIO_DOMICILIO_DEPTO AS dom_depto,
    VEN_USUARIO_DOMICILIO_CP AS dom_cp,
    l.loc_id
FROM [gd_esquema].[Maestra] m
JOIN [4_FILAS_AFECTADAS].Localidad l ON l.loc_nombre = m.VEN_USUARIO_DOMICILIO_LOCALIDAD
JOIN [4_FILAS_AFECTADAS].Provincia p ON p.prov_nombre = m.VEN_USUARIO_DOMICILIO_PROVINCIA and l.loc_prov = p.prov_id
WHERE m.VEN_USUARIO_DOMICILIO_CALLE IS NOT NULL AND m.VEN_USUARIO_DOMICILIO_CP IS NOT NULL AND m.VEN_USUARIO_DOMICILIO_NRO_CALLE IS NOT NULL AND l.loc_id IS NOT NULL 
UNION
SELECT 
    ALMACEN_CALLE AS dom_calle,
    ALMACEN_NRO_CALLE AS dom_no_calle,
    null AS dom_piso,
    null AS dom_depto,
    null AS dom_cp,
    l.loc_id
FROM [gd_esquema].Maestra 
JOIN [4_FILAS_AFECTADAS].Localidad l ON l.loc_nombre = ALMACEN_Localidad
JOIN [4_FILAS_AFECTADAS].Provincia p ON p.prov_nombre = ALMACEN_PROVINCIA and l.loc_prov = p.prov_id
WHERE ALMACEN_CALLE IS NOT NULL AND ALMACEN_NRO_CALLE IS NOT NULL AND l.loc_id IS NOT NULL 
UNION 
SELECT 
    CLI_USUARIO_DOMICILIO_CALLE AS dom_calle,
    CLI_USUARIO_DOMICILIO_NRO_CALLE AS dom_no_calle,
    CLI_USUARIO_DOMICILIO_PISO AS dom_piso,
    CLI_USUARIO_DOMICILIO_DEPTO AS dom_depto,
    CLI_USUARIO_DOMICILIO_CP AS dom_cp,
    l.loc_id
FROM [gd_esquema].[Maestra] m
JOIN [4_FILAS_AFECTADAS].Localidad l ON l.loc_nombre = m.CLI_USUARIO_DOMICILIO_LOCALIDAD
JOIN [4_FILAS_AFECTADAS].Provincia p ON p.prov_nombre = m.CLI_USUARIO_DOMICILIO_PROVINCIA and l.loc_prov = p.prov_id
WHERE m.CLI_USUARIO_DOMICILIO_CALLE IS NOT NULL AND 
	m.CLI_USUARIO_DOMICILIO_CP IS NOT NULL AND 
	m.CLI_USUARIO_DOMICILIO_NRO_CALLE IS NOT NULL AND 
	l.loc_id IS NOT NULL 
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MEDIODEPAGO
AS
BEGIN
print 'tabla MedioDePago'
insert into [4_FILAS_AFECTADAS].MedioDePago(mp_tipo,mp_nombre)
select distinct
	m.PAGO_TIPO_MEDIO_PAGO,
	m.PAGO_MEDIO_PAGO
from [gd_esquema].[Maestra] m
where 
	m.PAGO_TIPO_MEDIO_PAGO is not null and
	m.PAGO_TIPO_MEDIO_PAGO is not null
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PRODUCTO
AS
BEGIN
print 'tabla Producto'
insert into [4_FILAS_AFECTADAS].Producto(
	prod_cod , prod_desc , prod_precio , prod_subRub , prod_marca , prod_modelo
)
select distinct
	PRODUCTO_CODIGO,
	PRODUCTO_DESCRIPCION,
	PRODUCTO_PRECIO,
	s.subrubro_id,
	m.marca_id,
	mo.modelo_id
from GD2C2024.gd_esquema.Maestra
JOIN [4_FILAS_AFECTADAS].Rubro r on r.rubro_descripcion = PRODUCTO_RUBRO_DESCRIPCION
JOIN [4_FILAS_AFECTADAS].SubRubro s on s.subrubro_descripcion = PRODUCTO_SUB_RUBRO AND r.rubro_id = s.subrubro_rubro
JOIN [4_FILAS_AFECTADAS].Marca m on m.marca_descripcion = PRODUCTO_MARCA
JOIN [4_FILAS_AFECTADAS].Modelo mo on mo.modelo_id = PRODUCTO_MOD_CODIGO
where
	
	PRODUCTO_CODIGO is not null and
	PRODUCTO_MARCA is not null and
	PRODUCTO_MOD_CODIGO is not null and
	PRODUCTO_PRECIO is not null and
	PRODUCTO_SUB_RUBRO is not null and
	PRODUCTO_RUBRO_DESCRIPCION is not null and
	PRODUCTO_MOD_DESCRIPCION is not null and
	PRODUCTO_DESCRIPCION is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_TIPOENVIO
AS
BEGIN
print 'tabla TipoEnvio'
insert into [4_FILAS_AFECTADAS].TipoEnvio(te_tipo)
select distinct
	ENVIO_TIPO
from GD2C2024.gd_esquema.Maestra
where ENVIO_TIPO is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_ALMACEN
AS
BEGIN
print 'tabla Almacen'
insert into [4_FILAS_AFECTADAS].Almacen(alm_id,alm_costo,alm_dom)
select distinct
    ALMACEN_CODIGO,
    ALMACEN_COSTO_DIA_AL,
    d.dom_id
from GD2C2024.gd_esquema.Maestra
join [4_FILAS_AFECTADAS].Provincia p on p.prov_nombre = ALMACEN_PROVINCIA
join [4_FILAS_AFECTADAS].Localidad l on l.loc_nombre = ALMACEN_Localidad and l.loc_prov = p.prov_id
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_calle = ALMACEN_CALLE and d.dom_no_calle = ALMACEN_NRO_CALLE and d.dom_loc = l.loc_id
where ALMACEN_CODIGO is not null and ALMACEN_COSTO_DIA_AL is not null and d.dom_id is not null
;
END 
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_ALMACENXPRODUCTO
AS
BEGIN
PRINT 'Tabla AlmacenXProductos'
INSERT INTO [4_FILAS_AFECTADAS].AlmacenXProducto(axp_prod, axp_alm)
SELECT DISTINCT
    p.prod_id, 
    a.alm_id
FROM 
    GD2C2024.gd_esquema.Maestra m
JOIN [4_FILAS_AFECTADAS].Producto p ON m.PRODUCTO_CODIGO = p.prod_cod and m.PRODUCTO_MOD_CODIGO = p.prod_modelo
join [4_FILAS_AFECTADAS].Marca ma on ma.marca_descripcion = m.PRODUCTO_MARCA and p.prod_marca = ma.marca_id
join [4_FILAS_AFECTADAS].Rubro r on r.rubro_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
join [4_FILAS_AFECTADAS].SubRubro s on s.subrubro_descripcion = m.PRODUCTO_SUB_RUBRO and s.subrubro_id = p.prod_subRub and s.subrubro_rubro = r.rubro_id
join [4_FILAS_AFECTADAS].Provincia pr on pr.prov_nombre = ALMACEN_PROVINCIA
join [4_FILAS_AFECTADAS].Localidad l on l.loc_nombre = ALMACEN_Localidad and l.loc_prov = pr.prov_id
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_calle = ALMACEN_CALLE and d.dom_no_calle = ALMACEN_NRO_CALLE and d.dom_loc = l.loc_id
JOIN 
    [4_FILAS_AFECTADAS].Almacen a ON m.ALMACEN_CODIGO = a.alm_id and a.alm_costo = m.ALMACEN_COSTO_DIA_AL and a.alm_dom = d.dom_id
WHERE 
    m.PRODUCTO_CODIGO IS NOT NULL 
    AND m.ALMACEN_CODIGO IS NOT NULL 
    AND m.PRODUCTO_MOD_CODIGO IS NOT NULL
    AND m.PRODUCTO_MARCA IS NOT NULL
    AND m.PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL
    AND m.PRODUCTO_SUB_RUBRO IS NOT NULL 
	and ALMACEN_COSTO_DIA_AL is not null 
	and d.dom_id is not null;
END
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PUBLICACION
AS
BEGIN
PRINT 'Tabla Publicacion'
INSERT INTO [4_FILAS_AFECTADAS].Publicacion(publ_codigo, publ_descripcion, publ_stock, publ_fecha, publ_fecha_ven, publ_precio, publ_costo, publ_porc_venta, publ_vendedor_id, publ_alm_prod)
SELECT distinct PUBLICACION_CODIGO, PUBLICACION_DESCRIPCION, PUBLICACION_STOCK, PUBLICACION_FECHA, PUBLICACION_FECHA_V, PUBLICACION_PRECIO, PUBLICACION_COSTO, PUBLICACION_PORC_VENTA
				, v.ven_id, ap.axp_id
FROM GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].Vendedor v on v.ven_rs = m.VENDEDOR_RAZON_SOCIAL and v.ven_cuit = m.VENDEDOR_CUIT
join (select prod_id ,prod_cod, subrubro_descripcion, m.marca_descripcion, prod_modelo, r.rubro_descripcion from [4_FILAS_AFECTADAS].Producto pr
	  join [4_FILAS_AFECTADAS].SubRubro s on pr.prod_subRub = s.subrubro_id
	  join [4_FILAS_AFECTADAS].Marca m on m.marca_id = pr.prod_marca
	  join [4_FILAS_AFECTADAS].Rubro r on r.rubro_id = s.subrubro_rubro) prs on prs.prod_cod = m.PRODUCTO_CODIGO and prs.subrubro_descripcion = m.PRODUCTO_SUB_RUBRO and prs.marca_descripcion = m.PRODUCTO_MARCA and prs.prod_modelo = m.PRODUCTO_MOD_CODIGO and prs.rubro_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
join [4_FILAS_AFECTADAS].Almacen a on a.alm_id = m.ALMACEN_CODIGO													
JOIN [4_FILAS_AFECTADAS].AlmacenXProducto ap 
    ON ap.axp_alm = a.alm_id 
    AND ap.axp_prod = prs.prod_id
where PUBLICACION_CODIGO is not null
and PUBLICACION_DESCRIPCION is not null;
END
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_FACTURA
AS
BEGIN
PRINT 'Tabla Detalle_Factura'
INSERT INTO [4_FILAS_AFECTADAS].Detalle_Factura(det_fac_precio, det_fac_cantidad, det_fac_publ, det_fac_tipo, det_fac_nro, det_fac_subtotal)
SELECT DISTINCT M.FACTURA_DET_PRECIO,FACTURA_DET_CANTIDAD, PUBLICACION_CODIGO, FACTURA_DET_TIPO, FACTURA_NUMERO, FACTURA_DET_SUBTOTAL
FROM GD2C2024.gd_esquema.Maestra m
WHERE FACTURA_DET_PRECIO IS NOT NULL 
AND FACTURA_DET_CANTIDAD IS NOT NULL 
AND  FACTURA_DET_TIPO IS NOT NULL 
AND FACTURA_DET_SUBTOTAL  IS NOT NULL
and FACTURA_NUMERO is not null
and PUBLICACION_CODIGO is not null;
END
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_VENTA
AS
BEGIN
PRINT 'Tabla Detalle_Venta'
insert into [4_FILAS_AFECTADAS].Detalle_Venta(det_ven_cant, det_ven_precio, det_ven_subtotal, det_ven_publ_id, det_ven_nro )
SELECT VENTA_DET_CANT, VENTA_DET_PRECIO, VENTA_DET_SUB_TOTAL, PUBLICACION_CODIGO,VENTA_CODIGO FROM GD2C2024.gd_esquema.Maestra m
WHERE VENTA_DET_CANT IS NOT NULL;
END
GO

CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PAGO
AS
BEGIN
PRINT 'Tabla Pago'
insert into [4_FILAS_AFECTADAS].Pago(pago_importe, pago_fecha, pago_venta_nro)
SELECT PAGO_IMPORTE, PAGO_FECHA, VENTA_CODIGO FROM GD2C2024.gd_esquema.Maestra m
WHERE PAGO_IMPORTE is not null;
END
GO


CREATE PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_PAGO
AS
BEGIN
PRINT 'Tabla detalle_Pago'
insert into [4_FILAS_AFECTADAS].Detalle_Pago(det_pago_nro_tarjeta, det_pago_venc_tarjeta, det_pago_medio_id, det_pago_pago_id, det_pago_cant_cuotas)
SELECT distinct PAGO_NRO_TARJETA, PAGO_FECHA_VENC_TARJETA, mp.mp_id, p.pago_id, PAGO_CANT_CUOTAS FROM GD2C2024.gd_esquema.Maestra m
join [4_FILAS_AFECTADAS].MedioDePago mp on mp.mp_tipo = PAGO_TIPO_MEDIO_PAGO and mp.mp_nombre = m.PAGO_MEDIO_PAGO
join [4_FILAS_AFECTADAS].pago p on p.pago_importe = m.PAGO_IMPORTE and p.pago_fecha = m.PAGO_FECHA and p.pago_venta_nro = m.VENTA_CODIGO;
END
GO


---------------------------------------------------------/EJECUTAR PROCEDURES/--------------------------------------------------------
BEGIN TRANSACTION
	EXEC [4_FILAS_AFECTADAS].CARGAR_MODELO
	EXEC [4_FILAS_AFECTADAS].CARGAR_MARCA
	EXEC [4_FILAS_AFECTADAS].CARGAR_RUBRO
	EXEC [4_FILAS_AFECTADAS].CARGAR_SUBRUBRO
	EXEC [4_FILAS_AFECTADAS].CARGAR_PROVINCIA
	EXEC [4_FILAS_AFECTADAS].CARGAR_LOCALIDAD
	EXEC [4_FILAS_AFECTADAS].CARGAR_USUARIO
	EXEC [4_FILAS_AFECTADAS].CARGAR_VENDEDOR
	EXEC [4_FILAS_AFECTADAS].CARGAR_FACTURA
	EXEC [4_FILAS_AFECTADAS].CARGAR_CLIENTE
	EXEC [4_FILAS_AFECTADAS].CARGAR_VENTA
	EXEC [4_FILAS_AFECTADAS].CARGAR_DOMICILIO
	EXEC [4_FILAS_AFECTADAS].CARGAR_MEDIODEPAGO
	EXEC [4_FILAS_AFECTADAS].CARGAR_PRODUCTO
	EXEC [4_FILAS_AFECTADAS].CARGAR_TIPOENVIO
	EXEC [4_FILAS_AFECTADAS].CARGAR_ALMACEN
	EXEC [4_FILAS_AFECTADAS].CARGAR_ALMACENXPRODUCTO
	EXEC [4_FILAS_AFECTADAS].CARGAR_PUBLICACION
	EXEC [4_FILAS_AFECTADAS].CARGAR_DETALLE_FACTURA
	EXEC [4_FILAS_AFECTADAS].CARGAR_DETALLE_VENTA
	EXEC [4_FILAS_AFECTADAS].CARGAR_PAGO
	EXEC [4_FILAS_AFECTADAS].CARGAR_DETALLE_PAGO
COMMIT TRANSACTION
------------------------------------------------------------/DROPS PROCEDURES/--------------------------------------------------------
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MODELO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MARCA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_RUBRO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_SUBRUBRO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PROVINCIA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_LOCALIDAD
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_USUARIO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_VENDEDOR
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_FACTURA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_CLIENTE
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_VENTA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DOMICILIO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_MEDIODEPAGO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PRODUCTO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_TIPOENVIO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_ALMACEN
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_ALMACENXPRODUCTO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PUBLICACION
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_FACTURA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_VENTA
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_PAGO
	DROP PROCEDURE [4_FILAS_AFECTADAS].CARGAR_DETALLE_PAGO


----------------------------------------------------------------/FKS/-----------------------------------------------------------------


-- Agregar FK en Venta que referencia a Cliente
ALTER TABLE [4_FILAS_AFECTADAS].Venta
ADD CONSTRAINT FK_Venta_Cliente
FOREIGN KEY (ven_cli_id) REFERENCES [4_FILAS_AFECTADAS].Cliente(cli_id);

-- Agregar FK en Factura que referencia a Vendedor
ALTER TABLE [4_FILAS_AFECTADAS].Factura
ADD CONSTRAINT FK_Factura_Vendedor
FOREIGN KEY (fac_vendedor_id) REFERENCES [4_FILAS_AFECTADAS].Vendedor(ven_id);

-- Agregar FK en Cliente que referencia a Usuario
ALTER TABLE [4_FILAS_AFECTADAS].Cliente
ADD CONSTRAINT FK_Cliente_Usuario
FOREIGN KEY (cli_usu_id) REFERENCES [4_FILAS_AFECTADAS].Usuario(usu_id);

-- Agregar FK en Vendedor que referencia a Usuario
ALTER TABLE [4_FILAS_AFECTADAS].Vendedor
ADD CONSTRAINT FK_Vendedor_Usuario
FOREIGN KEY (ven_usu_id) REFERENCES [4_FILAS_AFECTADAS].Usuario(usu_id);

-- Agregar FK en Domicilio que referencia a Localidad
ALTER TABLE [4_FILAS_AFECTADAS].Domicilio
ADD CONSTRAINT FK_Domicilio_Localidad
FOREIGN KEY (dom_loc) REFERENCES [4_FILAS_AFECTADAS].Localidad(loc_id);


-- Agregar FK en AlmacenXProductos que referencia a Producto
ALTER TABLE [4_FILAS_AFECTADAS].AlmacenXProducto
ADD CONSTRAINT FK_Producto FOREIGN KEY (axp_prod) 
    REFERENCES [4_FILAS_AFECTADAS].Producto (prod_id);


-- Agregar FK en AlmacenXProductos que referencia a Almacen
ALTER TABLE [4_FILAS_AFECTADAS].AlmacenXProducto
ADD CONSTRAINT FK_Almacen FOREIGN KEY (axp_alm) 
    REFERENCES [4_FILAS_AFECTADAS].Almacen (alm_id);
GO

-- Agregar FK en Pulicacion que referencia a Vendedor
ALTER TABLE [4_FILAS_AFECTADAS].Publicacion
ADD CONSTRAINT FK_vendedor_publicacion FOREIGN KEY (publ_vendedor_id) 
    REFERENCES [4_FILAS_AFECTADAS].Vendedor (ven_id);
GO

-- Agregar FK en Pulicacion que referencia a AlmacenXProducto
ALTER TABLE [4_FILAS_AFECTADAS].Publicacion
ADD CONSTRAINT FK_Almacen_publicacion FOREIGN KEY (publ_alm_prod) 
    REFERENCES [4_FILAS_AFECTADAS].AlmacenXProducto (axp_id);
GO

-- Agregar FK en Detalle_Factura que referencia a Factura
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Factura
ADD CONSTRAINT FK_Detalle_Factura FOREIGN KEY (det_fac_nro) 
    REFERENCES [4_FILAS_AFECTADAS].Factura (fac_nro);
GO

-- Agregar FK en Detalle_Factura que referencia a Publicacion
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Factura
ADD CONSTRAINT FK_Detalle_Publicacion FOREIGN KEY (det_fac_publ) 
    REFERENCES [4_FILAS_AFECTADAS].Publicacion (publ_codigo);
GO

-- Agregar FK en Detalle_Venta que referencia a Publicacion
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Venta
ADD CONSTRAINT FK_Venta_Publicacion FOREIGN KEY (det_ven_publ_id) 
    REFERENCES [4_FILAS_AFECTADAS].Publicacion (publ_codigo);
GO

-- Agregar FK en Detalle_Venta que referencia a Venta
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Venta
ADD CONSTRAINT FK_Detalle_Venta FOREIGN KEY (det_ven_nro) 
    REFERENCES [4_FILAS_AFECTADAS].Venta (ven_codigo);
GO

-- Agregar FK en Pago que referencia a Venta
ALTER TABLE [4_FILAS_AFECTADAS].Pago
ADD CONSTRAINT FK_Pago_Venta FOREIGN KEY (pago_venta_nro) 
    REFERENCES [4_FILAS_AFECTADAS].Venta (ven_codigo);
GO

-- Agregar FK en Detalle_Pago que referencia a Medio_pago
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Pago
ADD CONSTRAINT FK_Pago_medio FOREIGN KEY (det_pago_medio_id) 
    REFERENCES [4_FILAS_AFECTADAS].MedioDePago (mp_id);
GO

-- Agregar FK en Detalle_Pago que referencia a Pago
ALTER TABLE [4_FILAS_AFECTADAS].Detalle_Pago
ADD CONSTRAINT FK_Detalle_Pago FOREIGN KEY (det_pago_pago_id) 
    REFERENCES [4_FILAS_AFECTADAS].Pago (pago_id);
GO