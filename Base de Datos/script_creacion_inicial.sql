USE [GD2C2024]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SCHEMA [4_FLIAS_AFECTADAS]
GO

CREATE TABLE [4_FLIAS_AFECTADAS].Modelo(
    modelo_id Decimal(18,0) PRIMARY KEY,
    modelo_descripcion NVARCHAR(50)
);
GO

print 'Tabla Modelo'
insert into [4_FLIAS_AFECTADAS].Modelo(modelo_id, modelo_descripcion)
select distinct
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_MOD_DESCRIPCION
from GD2C2024.gd_esquema.Maestra
where
	PRODUCTO_MOD_CODIGO is not null and
	PRODUCTO_MOD_DESCRIPCION is not null ;


CREATE TABLE [4_FLIAS_AFECTADAS].Marca(
    marca_id INT IDENTITY(1,1) PRIMARY KEY,
    marca_descripcion NVARCHAR(50)
);
GO

print 'Tabla Marca'
insert into [4_FLIAS_AFECTADAS].Marca(marca_descripcion)
select distinct
	PRODUCTO_MARCA
from GD2C2024.gd_esquema.Maestra m
where
PRODUCTO_MARCA is not null 
;

create table [4_FLIAS_AFECTADAS].Rubro(
	rubro_id int identity(1,1) primary key,
	rubro_descripcion nvarchar(50)
);


print 'Tabla Rubro'
insert into [4_FLIAS_AFECTADAS].Rubro(rubro_descripcion)
select distinct
	PRODUCTO_RUBRO_DESCRIPCION
from GD2C2024.gd_esquema.Maestra m
where
	PRODUCTO_RUBRO_DESCRIPCION is not null
;

create table [4_FLIAS_AFECTADAS].SubRubro(
	subrubro_id int identity(1,1) primary key,
	subrubro_descripcion nvarchar(50),
	subrubro_rubro int foreign key references [4_FLIAS_AFECTADAS].Rubro(rubro_id)
);


print 'Tabla SubRubro'
insert into [4_FLIAS_AFECTADAS].SubRubro(	subrubro_descripcion ,	subrubro_rubro)
select distinct
	PRODUCTO_SUB_RUBRO,
	r.rubro_id
from GD2C2024.gd_esquema.Maestra m
join [4_FLIAS_AFECTADAS].Rubro r on r.rubro_descripcion = PRODUCTO_RUBRO_DESCRIPCION
where
	PRODUCTO_SUB_RUBRO is not null and
	PRODUCTO_RUBRO_DESCRIPCION is not null 
;

create table [4_FLIAS_AFECTADAS].Provincia(
	prov_id int identity(1,1) primary key,
	prov_nombre nvarchar(50)
);


print 'Tabla Provincia'
insert into [4_FLIAS_AFECTADAS].Provincia(prov_nombre)
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


create table [4_FLIAS_AFECTADAS].Localidad(
	loc_id int identity(1,1) primary key,
	loc_nombre nvarchar(50),
	loc_prov int foreign key references [4_FLIAS_AFECTADAS].Provincia(prov_id)
);


print 'Tabla Localidad'
insert into [4_FLIAS_AFECTADAS].Localidad(loc_nombre,loc_prov)
select distinct
	m.ALMACEN_Localidad,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FLIAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.ALMACEN_PROVINCIA
where ALMACEN_Localidad is not null and ALMACEN_PROVINCIA is not null 
union
select distinct
	m.CLI_USUARIO_DOMICILIO_LOCALIDAD,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FLIAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.CLI_USUARIO_DOMICILIO_PROVINCIA
where CLI_USUARIO_DOMICILIO_LOCALIDAD is not null and CLI_USUARIO_DOMICILIO_PROVINCIA is not null
union
select distinct
	m.VEN_USUARIO_DOMICILIO_LOCALIDAD,
	p.prov_id
from GD2C2024.gd_esquema.Maestra m
join [4_FLIAS_AFECTADAS].Provincia p on p.prov_nombre = 	m.VEN_USUARIO_DOMICILIO_PROVINCIA
where VEN_USUARIO_DOMICILIO_LOCALIDAD is not null and VEN_USUARIO_DOMICILIO_PROVINCIA is not null

--Hay localidades con dos provincias!! Ver

print 'Tabla Usuario'
create table [4_FLIAS_AFECTADAS].Usuario(
	usu_id bigint identity(1,1) primary key,
	usu_nombre nvarchar(50),
	usu_contrasenia nvarchar(50),
	usu_fecha_creacion date,
);

insert into [4_FLIAS_AFECTADAS].Usuario(usu_nombre,usu_contrasenia,usu_fecha_creacion)
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



print 'Tabla Vendedor'
create table [4_FLIAS_AFECTADAS].Vendedor(
	ven_id bigint identity(1,1) primary key,
	ven_rs nvarchar(50),
	ven_cuit nvarchar(50),
	ven_mail nvarchar(50),
	ven_usu_id bigint
);

insert into [4_FLIAS_AFECTADAS].Vendedor(ven_rs,ven_cuit, ven_mail , ven_usu_id )
SELECT DISTINCT
    m.VENDEDOR_RAZON_SOCIAL,
    m.VENDEDOR_MAIL,
    m.VENDEDOR_CUIT,
    u.usu_id
FROM GD2C2024.gd_esquema.Maestra m
JOIN [4_FLIAS_AFECTADAS].Usuario u 
    ON m.VEN_USUARIO_NOMBRE = u.usu_nombre
    AND m.VEN_USUARIO_PASS = u.usu_contrasenia
WHERE 
    m.VENDEDOR_RAZON_SOCIAL IS NOT NULL 
    AND m.VENDEDOR_MAIL IS NOT NULL 
    AND m.VENDEDOR_CUIT IS NOT NULL 
    AND m.VEN_USUARIO_NOMBRE IS NOT NULL 
    AND m.VEN_USUARIO_PASS IS NOT NULL
;


print 'Tabla Facturas'

create table [4_FLIAS_AFECTADAS].Factura(
	fac_nro decimal(18,0) primary key,
	fac_fecha date,
	fac_total decimal(18,2),
	fac_vendedor_id bigint
);

insert into [4_FLIAS_AFECTADAS].Factura(fac_nro,fac_fecha,fac_total,fac_vendedor_id)
SELECT distinct m.FACTURA_NUMERO, m.FACTURA_FECHA, m.FACTURA_TOTAL, v.ven_id  FROM GD2C2024.gd_esquema.Maestra m
join(select m.PUBLICACION_CODIGO, m.VENDEDOR_CUIT 
	 from  GD2C2024.gd_esquema.Maestra m
	 where m.PUBLICACION_CODIGO is not null and m.VENDEDOR_CUIT is not null)  m2 on m2.PUBLICACION_CODIGO = m.PUBLICACION_CODIGO
join [4_FLIAS_AFECTADAS].Vendedor v on (m2.VENDEDOR_CUIT = v.ven_cuit)
where m.FACTURA_NUMERO is not null and m.PUBLICACION_CODIGO is not null
;

print 'Tabla Clientes'

create table [4_FLIAS_AFECTADAS].Cliente(
	cli_id bigint identity(1,1) primary key,
	cli_nombre nvarchar(50),
	cli_apellido nvarchar(50),
	cli_dni decimal(18,0),
	cli_fecha_nac date,
	cli_mail nvarchar(50),
	cli_usu_id bigint
);

insert into [4_FLIAS_AFECTADAS].Cliente(cli_nombre, cli_apellido, cli_dni, cli_fecha_nac, cli_mail, cli_usu_id)
select distinct
	m.CLIENTE_NOMBRE,
	m.CLIENTE_APELLIDO,
	m.CLIENTE_DNI,
	m.CLIENTE_FECHA_NAC,
	m.CLIENTE_MAIL,
	u.usu_id
from GD2C2024.gd_esquema.Maestra m
JOIN [4_FLIAS_AFECTADAS].Usuario u 
    ON m.CLI_USUARIO_NOMBRE = u.usu_nombre
    AND m.CLI_USUARIO_PASS = u.usu_contrasenia and m.CLI_USUARIO_FECHA_CREACION = u.usu_fecha_creacion
where 
	m.CLIENTE_DNI is not null and
	m.CLI_USUARIO_PASS is not null and
	m.CLI_USUARIO_NOMBRE is not null
;

print 'tabla Ventas'
create table [4_FLIAS_AFECTADAS].Venta(
	ven_codigo decimal(18,0) primary key,
	ven_fecha date,
	ven_total decimal(18,2),
	ven_cli_id bigint
);

insert into [4_FLIAS_AFECTADAS].Venta(ven_codigo, ven_fecha, ven_total, ven_cli_id)
select distinct m.VENTA_CODIGO, m.VENTA_FECHA, m.VENTA_TOTAL, c.cli_id
from GD2C2024.gd_esquema.Maestra m
join [4_FLIAS_AFECTADAS].Cliente c on (m.CLIENTE_DNI = c.cli_dni and m.CLIENTE_NOMBRE = c.cli_nombre)
where m.VENTA_CODIGO is not null


print 'tabla Domicilio'
CREATE TABLE [4_FLIAS_AFECTADAS].Domicilio (
    dom_id INT PRIMARY KEY IDENTITY(1,1),
    dom_calle NVARCHAR(50),
    dom_no_calle DECIMAL(18,0),
    dom_piso DECIMAL(18,0),
    dom_depto NVARCHAR(50),
    dom_cp NVARCHAR(50),
    dom_loc INT
);


INSERT INTO [4_FLIAS_AFECTADAS].Domicilio (
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
JOIN [4_FLIAS_AFECTADAS].Localidad l ON l.loc_nombre = m.VEN_USUARIO_DOMICILIO_LOCALIDAD
JOIN [4_FLIAS_AFECTADAS].Provincia p ON p.prov_nombre = m.VEN_USUARIO_DOMICILIO_PROVINCIA and l.loc_prov = p.prov_id
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
JOIN [4_FLIAS_AFECTADAS].Localidad l ON l.loc_nombre = ALMACEN_Localidad
JOIN [4_FLIAS_AFECTADAS].Provincia p ON p.prov_nombre = ALMACEN_PROVINCIA and l.loc_prov = p.prov_id
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
JOIN [4_FLIAS_AFECTADAS].Localidad l ON l.loc_nombre = m.CLI_USUARIO_DOMICILIO_LOCALIDAD
JOIN [4_FLIAS_AFECTADAS].Provincia p ON p.prov_nombre = m.CLI_USUARIO_DOMICILIO_PROVINCIA and l.loc_prov = p.prov_id
WHERE m.CLI_USUARIO_DOMICILIO_CALLE IS NOT NULL AND 
	m.CLI_USUARIO_DOMICILIO_CP IS NOT NULL AND 
	m.CLI_USUARIO_DOMICILIO_NRO_CALLE IS NOT NULL AND 
	l.loc_id IS NOT NULL 
;


print 'tabla MedioDePago'
create table [4_FLIAS_AFECTADAS].MedioDePago(
	mp_id bigint identity(1,1) primary key,
	mp_tipo nvarchar(50),
	mp_nombre nvarchar(50)
)

insert into [4_FLIAS_AFECTADAS].MedioDePago(mp_tipo,mp_nombre)
select distinct
	m.PAGO_TIPO_MEDIO_PAGO,
	m.PAGO_MEDIO_PAGO
from [gd_esquema].[Maestra] m
where 
	m.PAGO_TIPO_MEDIO_PAGO is not null and
	m.PAGO_TIPO_MEDIO_PAGO is not null


print 'tabla Producto'
CREATE TABLE [4_FLIAS_AFECTADAS].Producto(
	prod_id int identity(1,1) primary key,
	prod_cod nvarchar(50),
	prod_desc nvarchar(50),
	prod_precio decimal(18,2),
	prod_subRub int foreign key references [4_FLIAS_AFECTADAS].SubRubro(subrubro_id),
	prod_marca int foreign key references [4_FLIAS_AFECTADAS].Marca(marca_id),
	prod_modelo Decimal(18,0) foreign key references [4_FLIAS_AFECTADAS].Modelo(modelo_id)
)

insert into [4_FLIAS_AFECTADAS].Producto(
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

JOIN [4_FLIAS_AFECTADAS].Rubro r on r.rubro_descripcion = PRODUCTO_RUBRO_DESCRIPCION
JOIN [4_FLIAS_AFECTADAS].SubRubro s on s.subrubro_descripcion = PRODUCTO_SUB_RUBRO AND r.rubro_id = s.subrubro_rubro
JOIN [4_FLIAS_AFECTADAS].Marca m on m.marca_descripcion = PRODUCTO_MARCA
JOIN [4_FLIAS_AFECTADAS].Modelo mo on mo.modelo_id = PRODUCTO_MOD_CODIGO

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

print 'tabla TipoEnvio'
create table [4_FLIAS_AFECTADAS].TipoEnvio(
	te_id int identity(1,1) primary key,
	te_tipo nvarchar(50)
)
insert into [4_FLIAS_AFECTADAS].TipoEnvio(te_tipo)
select distinct
	ENVIO_TIPO
from GD2C2024.gd_esquema.Maestra
where ENVIO_TIPO is not null
;

print 'tabla Almacen'
create table [4_FLIAS_AFECTADAS].Almacen(
	alm_id decimal(18,0) primary key,
	alm_costo decimal(18,2),
	alm_dom int foreign key references [4_FLIAS_AFECTADAS].Domicilio(dom_id)
)
insert into [4_FLIAS_AFECTADAS].Almacen(alm_id,alm_costo,alm_dom)
select distinct
	ALMACEN_CODIGO,
	ALMACEN_COSTO_DIA_AL,
	d.dom_id
from GD2C2024.gd_esquema.Maestra
join [4_FLIAS_AFECTADAS].Provincia p on p.prov_nombre = ALMACEN_PROVINCIA
join [4_FLIAS_AFECTADAS].Localidad l on l.loc_nombre = ALMACEN_Localidad and l.loc_prov = p.prov_id
join [4_FLIAS_AFECTADAS].Domicilio d on d.dom_calle = ALMACEN_CALLE and d.dom_no_calle = ALMACEN_NRO_CALLE and d.dom_loc = l.loc_id
where ALMACEN_CODIGO is not null and ALMACEN_COSTO_DIA_AL is not null and d.dom_id is not null
;

----------------------------------/FKS/--------------------------------------------------------------

-- Agregar FK en Venta que referencia a Cliente
ALTER TABLE [4_FLIAS_AFECTADAS].Venta
ADD CONSTRAINT FK_Venta_Cliente
FOREIGN KEY (ven_cli_id) REFERENCES [4_FLIAS_AFECTADAS].Cliente(cli_id);

-- Agregar FK en Factura que referencia a Vendedor
ALTER TABLE [4_FLIAS_AFECTADAS].Factura
ADD CONSTRAINT FK_Factura_Vendedor
FOREIGN KEY (fac_vendedor_id) REFERENCES [4_FLIAS_AFECTADAS].Vendedor(ven_id);

-- Agregar FK en Cliente que referencia a Usuario
ALTER TABLE [4_FLIAS_AFECTADAS].Cliente
ADD CONSTRAINT FK_Cliente_Usuario
FOREIGN KEY (cli_usu_id) REFERENCES [4_FLIAS_AFECTADAS].Usuario(usu_id);

-- Agregar FK en Vendedor que referencia a Usuario
ALTER TABLE [4_FLIAS_AFECTADAS].Vendedor
ADD CONSTRAINT FK_Vendedor_Usuario
FOREIGN KEY (ven_usu_id) REFERENCES [4_FLIAS_AFECTADAS].Usuario(usu_id);

-- Agregar FK en Domicilio que referencia a Localidad
ALTER TABLE [4_FLIAS_AFECTADAS].Domicilio
ADD CONSTRAINT FK_Domicilio_Localidad
FOREIGN KEY (dom_loc) REFERENCES [4_FLIAS_AFECTADAS].Localidad(loc_id);



