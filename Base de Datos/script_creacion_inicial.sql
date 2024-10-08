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
	rubro_id int foreign key references [4_FLIAS_AFECTADAS].Rubro(rubro_id)
);


print 'Tabla SubRubro'
insert into [4_FLIAS_AFECTADAS].SubRubro(	subrubro_descripcion ,	rubro_id)
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

