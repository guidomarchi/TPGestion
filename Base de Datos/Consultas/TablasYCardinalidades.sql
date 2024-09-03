
print 'Tabla rubros ...'
	select distinct
	PRODUCTO_SUB_RUBRO,
	PRODUCTO_RUBRO_DESCRIPCION
from GD2C2024.gd_esquema.Maestra m
where
	PRODUCTO_SUB_RUBRO is not null and
	PRODUCTO_RUBRO_DESCRIPCION is not null 
;


-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla marcas ...'
select distinct
	PRODUCTO_MARCA
from GD2C2024.gd_esquema.Maestra m
where
PRODUCTO_MARCA is not null 
;

-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla modelos ....'
select distinct
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_MOD_DESCRIPCION
from GD2C2024.gd_esquema.Maestra m
where
	PRODUCTO_MOD_CODIGO is not null and
	PRODUCTO_MOD_DESCRIPCION is not null 
;

-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla productos ....'
select distinct
	PRODUCTO_CODIGO,
	PRODUCTO_MARCA,
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_PRECIO,
	PRODUCTO_SUB_RUBRO,
	PRODUCTO_RUBRO_DESCRIPCION,
	PRODUCTO_MOD_DESCRIPCION,
	PRODUCTO_DESCRIPCION
from GD2C2024.gd_esquema.Maestra m
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

-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla vendedores/razon social ...'
select distinct
	m.VENDEDOR_RAZON_SOCIAL,
	m.VENDEDOR_MAIL,
	m.VENDEDOR_CUIT,
	m.VEN_USUARIO_NOMBRE,
	m.VEN_USUARIO_PASS
from GD2C2024.gd_esquema.Maestra m
where 
	m.VENDEDOR_RAZON_SOCIAL is not null and
	m.VENDEDOR_MAIL is not null and
	m.VENDEDOR_CUIT is not null and
	m.VEN_USUARIO_NOMBRE is not null and
	m.VEN_USUARIO_PASS is not null
	;
-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla usuarios ...'
select distinct
	m.VEN_USUARIO_NOMBRE,
	m.VEN_USUARIO_PASS
from GD2C2024.gd_esquema.Maestra m
where 
	m.VEN_USUARIO_NOMBRE is not null and
	m.VEN_USUARIO_PASS is not null
union
select distinct
	m.CLI_USUARIO_PASS,
	m.CLI_USUARIO_NOMBRE
from GD2C2024.gd_esquema.Maestra m
where 
	m.CLI_USUARIO_PASS is not null and
	m.CLI_USUARIO_NOMBRE is not null
;

-----------------------------------------------------------------//--------------------------------------------------------------

print 'Tabla clientes ...'
select distinct
	m.CLIENTE_NOMBRE,
	m.CLIENTE_APELLIDO,
	m.CLIENTE_DNI,
	m.CLIENTE_FECHA_NAC,
	m.CLIENTE_MAIL
from GD2C2024.gd_esquema.Maestra m
where 
	m.CLIENTE_APELLIDO is not null and
	m.CLIENTE_DNI is not null and
	m.CLIENTE_FECHA_NAC is not null and
	m.CLIENTE_NOMBRE is not null and
	m.CLIENTE_MAIL is not null
;
--Hay un problema para matchear el user con el cliente. Todos los usuarios tienen el nombre 
--del cliente como contraseña y nombre de user. Si dos clientes tienen el mismo nombre tienen el mismo nombre de usuario y contraseña.
-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla provincias'
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
-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla localidades ...'
select distinct
	m.ALMACEN_Localidad,
	m.ALMACEN_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where ALMACEN_Localidad is not null and ALMACEN_PROVINCIA is not null 
union
select distinct
	m.CLI_USUARIO_DOMICILIO_LOCALIDAD,
	m.CLI_USUARIO_DOMICILIO_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where CLI_USUARIO_DOMICILIO_LOCALIDAD is not null and CLI_USUARIO_DOMICILIO_PROVINCIA is not null
union
select distinct
	m.VEN_USUARIO_DOMICILIO_LOCALIDAD,
	m.VEN_USUARIO_DOMICILIO_PROVINCIA
from GD2C2024.gd_esquema.Maestra m
where VEN_USUARIO_DOMICILIO_LOCALIDAD is not null and VEN_USUARIO_DOMICILIO_PROVINCIA is not null

-- Hay localidades que tienen dos provincias diferentes!!! Hay que ver que solucion le damos.



-----------------------------------------------------------------//--------------------------------------------------------------
print 'Tabla publicaciones'

SELECT
	[PUBLICACION_CODIGO] ,
	[PUBLICACION_DESCRIPCION] ,
	[PUBLICACION_STOCK] ,
	[PUBLICACION_FECHA],
	[PUBLICACION_FECHA_V] ,
	[PUBLICACION_PRECIO] ,
	[PUBLICACION_COSTO] ,
	[PUBLICACION_PORC_VENTA],
	PRODUCTO_CODIGO,
	PRODUCTO_MARCA,
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_PRECIO,
	PRODUCTO_SUB_RUBRO,
	PRODUCTO_RUBRO_DESCRIPCION
FROM GD2C2024.gd_esquema.Maestra m
where
	
	[PUBLICACION_CODIGO] is not null and
	[PUBLICACION_DESCRIPCION] is not null and
	[PUBLICACION_STOCK] is not null and
	[PUBLICACION_FECHA] is not null and
	[PUBLICACION_FECHA_V]  is not null and
	[PUBLICACION_PRECIO]  is not null and
	[PUBLICACION_COSTO]  is not null and
	[PUBLICACION_PORC_VENTA] is not null and
	PRODUCTO_CODIGO is not null and
	PRODUCTO_MARCA is not null and
	PRODUCTO_MOD_CODIGO is not null and
	PRODUCTO_PRECIO is not null and
	PRODUCTO_SUB_RUBRO is not null and
	PRODUCTO_RUBRO_DESCRIPCION is not null and
	PRODUCTO_MOD_DESCRIPCION is not null and
	PRODUCTO_DESCRIPCION is not null
;
