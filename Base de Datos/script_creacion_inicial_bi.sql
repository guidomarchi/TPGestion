USE [GD2C2024]
GO
---------------------------Eliminar tablas -----------------------
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_ventas', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_ventas;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_envio', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_envio;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_facturacion', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_facturacion;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_pago', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_pago;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_publicacion', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_publicacion;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_marca', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_marca;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_medio_pago', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_medio_pago;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_rango_etario_clie', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_subrubro', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_subrubro;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_tiempo', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_tiempo;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_tipo_envio', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_tipo_envio;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_turnos', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_turnos;
IF OBJECT_ID('4_FILAS_AFECTADAS.BI_dim_ubicacion', 'U') IS NOT NULL DROP TABLE [4_FILAS_AFECTADAS].BI_dim_ubicacion;

DROP VIEW [4_FILAS_AFECTADAS].Facturación_por_provincia;
DROP VIEW [4_FILAS_AFECTADAS].Promedio_de_Stock_Inicial;
DROP VIEW [4_FILAS_AFECTADAS].Venta_promedio_mensual;
DROP VIEW [4_FILAS_AFECTADAS].Rendimiento_de_rubros;
DROP VIEW [4_FILAS_AFECTADAS].Pago_en_Cuotas;
DROP VIEW [4_FILAS_AFECTADAS].Porcentaje_de_cumplimiento_de_envíos;
DROP VIEW [4_FILAS_AFECTADAS].Localidades_que_pagan_mayor_costo_de_envío;
DROP VIEW [4_FILAS_AFECTADAS].Porcentaje_de_facturación_por_concepto;
DROP VIEW [4_FILAS_AFECTADAS].Volumen_de_ventas;
DROP VIEW [4_FILAS_AFECTADAS].Promedio_de_tiempo_de_publicaciones;


---------------------------dimensiones-----------------------------

CREATE TABLE [4_FILAS_AFECTADAS].BI_dim_tiempo (
	anio INT,
    cuatrimestre INT,
    mes INT,
    tiempo_id int identity(1,1) PRIMARY KEY
)
PRINT 'tabla BI_dim_tiempo'
DECLARE @startYear INT = 2000;
DECLARE @currentYear INT = 2040;
DECLARE @year INT = @startYear;

WHILE @year <= @currentYear
BEGIN
    INSERT INTO [4_FILAS_AFECTADAS].BI_dim_tiempo (anio, cuatrimestre, mes)
    VALUES
    (@year, 1, 1),  -- Enero
    (@year, 1, 2),  -- Febrero
    (@year, 1, 3),  -- Marzo
    (@year, 1, 4),  -- Abril
    (@year, 2, 5),  -- Mayo
    (@year, 2, 6),  -- Junio
    (@year, 2, 7),  -- Julio
    (@year, 2, 8),  -- Agosto
    (@year, 3, 9),  -- Septiembre
    (@year, 3, 10), -- Octubre
    (@year, 3, 11), -- Noviembre
    (@year, 3, 12); -- Diciembre
    
    SET @year = @year + 1;
END


CREATE TABLE [4_FILAS_AFECTADAS].BI_dim_ubicacion(
	ubi_localidad NVARCHAR(50),
	ubi_provincia NVARCHAR(50),
    ubi_id int primary key 
);

print 'tabla BI_dim_ubicacion'
insert into  [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_localidad,ubi_provincia,ubi_id)
select
	l.loc_nombre,
	p.prov_nombre,
	l.loc_id
from [4_FILAS_AFECTADAS].Localidad l
join [4_FILAS_AFECTADAS].Provincia p on p.prov_id = l.loc_prov


CREATE TABLE [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie (
    rango_etario_id INT IDENTITY(1,1) PRIMARY KEY,
    rango VARCHAR(20),
    minimo int,
    maximo int
);

PRINT 'tabla BI_dim_rango_etario_clie'
INSERT INTO [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie (rango, minimo, maximo)
values('< 25',0,24),('25 - 35',25,35),('35 - 50',36,50),('> 50',51,150);

create table [4_FILAS_AFECTADAS].BI_dim_turnos(
	turno_id int identity(1,1) primary key,
	hora_inicio int,
	hora_final int,
    hora_inicio_time time,
	hora_final_time time,
);

PRINT 'tabla BI_dim_turnos'
insert into [4_FILAS_AFECTADAS].BI_dim_turnos(hora_inicio,hora_final,hora_inicio_time,hora_final_time)
values(8,12,'08:00:00','12:00:00'),(12,16,'12:00:00','16:00:00'),(16,20,'16:00:00','20:00:00')

CREATE TABLE [4_FILAS_AFECTADAS].BI_dim_medio_pago(
    mp_id int primary key,
	mp_tipo nvarchar(50),
	mp_nombre nvarchar(50)
);
GO

print 'tabla BI_dim_medio_pago'
insert into [4_FILAS_AFECTADAS].BI_dim_medio_pago(mp_id,mp_tipo,mp_nombre)
select
    mp.mp_id,
    t.tmp_tipo,
	mp.mp_nombre
from [4_FILAS_AFECTADAS].MedioDePago mp
join [4_FILAS_AFECTADAS].TipoMedioDePago t on t.tmp_id = mp.mp_tipo;

create table [4_FILAS_AFECTADAS].BI_dim_subrubro(
    subrubro NVARCHAR(50),
    rubro NVARCHAR(50),
    subrubro_id int primary key
);

print 'tabla BI_dim_subrubro'
insert into [4_FILAS_AFECTADAS].BI_dim_subrubro(subrubro,rubro,subrubro_id)
select
	s.subrubro_descripcion,
	r.rubro_descripcion,
	s.subrubro_id
from [4_FILAS_AFECTADAS].SubRubro s
join [4_FILAS_AFECTADAS].Rubro r on r.rubro_id = s.subrubro_rubro;


create Table [4_FILAS_AFECTADAS].BI_dim_tipo_envio(
    te_id int primary key,
	te_tipo nvarchar(50)
);
GO

print'tabla BI_dim_tipo_envio'
insert into [4_FILAS_AFECTADAS].BI_dim_tipo_envio(te_id,te_tipo)
select
    t.te_id,t.te_tipo
from [4_FILAS_AFECTADAS].TipoEnvio t


create Table [4_FILAS_AFECTADAS].BI_dim_marca(
    mar_id int primary key,
	mar_desc nvarchar(50)
);
GO

print'tabla BI_dim_marca'
insert into [4_FILAS_AFECTADAS].BI_dim_marca(mar_id,mar_desc)
select
    m.marca_id,m.marca_descripcion
from [4_FILAS_AFECTADAS].Marca m


--------------------Hechos---------------------


CREATE TABLE [4_FILAS_AFECTADAS].BI_facturacion (
	concepto nvarchar(50),
    fact_total decimal(18,2),
    fact_ubi int,
    fact_tiempo INT,
    primary key (concepto,fact_ubi,fact_tiempo),
    FOREIGN KEY (fact_tiempo) 
    REFERENCES [4_FILAS_AFECTADAS].BI_dim_tiempo (tiempo_id),
    FOREIGN KEY (fact_ubi) 
    REFERENCES [4_FILAS_AFECTADAS].BI_dim_ubicacion (ubi_id)
);


print 'tabla BI_facturacion'
insert into [4_FILAS_AFECTADAS].BI_facturacion(concepto,fact_total,fact_ubi,fact_tiempo)
select
	df.det_fac_tipo,
	sum(f.fac_total),
	ub.ubi_id,
	t.tiempo_id
from [4_FILAS_AFECTADAS].Factura f
join [4_FILAS_AFECTADAS].Detalle_Factura df on df.det_fac_nro = f.fac_nro
join [4_FILAS_AFECTADAS].Vendedor v on v.ven_id = f.fac_vendedor_id
join [4_FILAS_AFECTADAS].Usuario u on u.usu_id = v.ven_usu_id
join [4_FILAS_AFECTADAS].UsuarioXDomicilio uxd on u.usu_id = uxd.usu_id
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_id = uxd.dom_id
join [4_FILAS_AFECTADAS].Localidad l on l.loc_id = d.dom_loc
join [4_FILAS_AFECTADAS].Provincia p on p.prov_id = l.loc_prov
join [4_FILAS_AFECTADAS].BI_dim_ubicacion ub on ub.ubi_localidad = l.loc_nombre and ub.ubi_provincia = p.prov_nombre
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.anio=year(f.fac_fecha) and t.mes = MONTH(f.fac_fecha)
group by ub.ubi_id,
	t.tiempo_id, df.det_fac_tipo
;

CREATE TABLE [4_FILAS_AFECTADAS].BI_envio (
    envio_tiempo int foreign key references [4_FILAS_AFECTADAS].BI_dim_tiempo(tiempo_id),
	envio_tipo int foreign key references  [4_FILAS_AFECTADAS].BI_dim_tipo_envio(te_id),
	envio_ubi_alm INT foreign key references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
    envio_ubi_clie INT foreign key references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
	total_envios INT,
    total_envios_cumplidos INT,
    costo_total_envios DECIMAL(18, 2),
    PRIMARY KEY (envio_tiempo, envio_tipo, envio_ubi_alm)
);

PRINT 'tabla BI_envio'
INSERT INTO [4_FILAS_AFECTADAS].BI_envio (
    envio_tiempo, envio_tipo, envio_ubi_alm, envio_ubi_clie, total_envios, total_envios_cumplidos, costo_total_envios
)
SELECT
    t.tiempo_id,
    te.te_id,
    ub.ubi_id,
    ub2.ubi_id,
    COUNT(e.envio_costo) AS total_envios,
    SUM(CASE WHEN cast(e.envio_fecha_entrega as date) = e.envio_fecha_programada and	
		cast(e.envio_fecha_entrega as time) between tu.hora_inicio_time and tu.hora_final_time
		THEN 1 ELSE 0 END) AS total_envios_cumplidos,
    SUM(e.envio_costo) AS costo_total_envios
FROM [4_FILAS_AFECTADAS].Envio e
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON t.mes = MONTH(e.envio_fecha_entrega) AND t.anio = YEAR(e.envio_fecha_entrega)
JOIN [4_FILAS_AFECTADAS].BI_dim_tipo_envio te ON te.te_id = e.envio_tipo
JOIN [4_FILAS_AFECTADAS].Domicilio d ON d.dom_id = e.envio_domicilio_id
JOIN [4_FILAS_AFECTADAS].Localidad l ON l.loc_id = d.dom_loc
JOIN [4_FILAS_AFECTADAS].Provincia p ON p.prov_id = l.loc_prov
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion ub ON ub.ubi_localidad = l.loc_nombre AND ub.ubi_provincia = p.prov_nombre
JOIN [4_FILAS_AFECTADAS].Domicilio d2 ON d2.dom_id = e.envio_domicilio_id
JOIN [4_FILAS_AFECTADAS].Localidad l2 ON l2.loc_id = d2.dom_loc
JOIN [4_FILAS_AFECTADAS].Provincia p2 ON p2.prov_id = l2.loc_prov
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion ub2 ON ub2.ubi_localidad = l2.loc_nombre AND ub2.ubi_provincia = p2.prov_nombre
join [4_FILAS_AFECTADAS].BI_dim_turnos tu on tu.hora_inicio = e.envio_hora_inicio and tu.hora_final = e.envio_hora_fin_inicio
GROUP BY t.tiempo_id, te.te_id, ub.ubi_id, ub2.ubi_id;



create table [4_FILAS_AFECTADAS].BI_pago(
	pago_tiempo int foreign key references [4_FILAS_AFECTADAS].BI_dim_tiempo(tiempo_id),
	pago_medio_pago int FOREIGN KEY REFERENCES [4_FILAS_AFECTADAS].BI_dim_medio_pago(mp_id),
	pago_importe_cuotas decimal(18,2),
	pago_importe_total decimal(18,2),
	pago_ubi int foreign key references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
);

print 'tabla BI_pago'
insert into [4_FILAS_AFECTADAS].BI_pago(pago_tiempo, 
										pago_medio_pago,  
										pago_importe_cuotas, 
										pago_importe_total, 
										pago_ubi)
SELECT
    t.tiempo_id,
    bimp.mp_id,
    SUM(
        CASE
            WHEN dp.det_pago_cant_cuotas > 1 and mp.mp_tipo = 1 THEN p.pago_importe
            ELSE 0
        END
    ) AS total_con_cuotas,
    SUM(p.pago_importe) AS total_importe,
    ubi.ubi_id
FROM [4_FILAS_AFECTADAS].MedioDePago mp
join [4_FILAS_AFECTADAS].BI_dim_medio_pago bimp on bimp.mp_id = mp.mp_id
JOIN [4_FILAS_AFECTADAS].Detalle_Pago dp ON mp.mp_id = dp.det_pago_medio_id
JOIN [4_FILAS_AFECTADAS].Pago p ON dp.det_pago_pago_id = p.pago_id
JOIN [4_FILAS_AFECTADAS].Venta v ON p.pago_venta_nro = v.ven_codigo
join [4_FILAS_AFECTADAS].Envio ev on ev.envio_venta_id = v.ven_codigo
JOIN [4_FILAS_AFECTADAS].Domicilio d ON ev.envio_domicilio_id = d.dom_id
JOIN [4_FILAS_AFECTADAS].Localidad l ON d.dom_loc = l.loc_id
JOIN [4_FILAS_AFECTADAS].Provincia pro ON l.loc_prov = pro.prov_id
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion ubi ON l.loc_nombre = ubi.ubi_localidad AND pro.prov_nombre = ubi.ubi_provincia
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON t.anio = YEAR(p.pago_fecha) AND t.mes = MONTH(p.pago_fecha)
GROUP BY
    t.tiempo_id,
    bimp.mp_id,
    ubi.ubi_id;


create table [4_FILAS_AFECTADAS].BI_publicacion(
	pub_cant_publicaciones int,
	pub_cant_dias int,
	pub_stock_total_inicial decimal(18,0),
	pub_tiempo int foreign key references [4_FILAS_AFECTADAS].BI_dim_tiempo(tiempo_id),
	pub_ubi int foreign key references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
	pub_subrubro int foreign key references [4_FILAS_AFECTADAS].BI_dim_subrubro(subrubro_id),
	pub_marca int foreign key references [4_FILAS_AFECTADAS].BI_dim_marca(mar_id),
	primary key(pub_tiempo,pub_ubi,pub_subrubro,pub_marca)
);


print 'tabla BI_publicacion'
insert into [4_FILAS_AFECTADAS].BI_publicacion(
									pub_cant_publicaciones,pub_cant_dias,pub_stock_total_inicial,
									pub_tiempo,pub_ubi,pub_subrubro,pub_marca)
select
	count(distinct p.publ_codigo) as cant_punlicaciones,
	sum(DATEDIFF(DAY, p.publ_fecha, p.publ_fecha_ven)) AS vigencia_total_dias,
	sum(p.publ_stock) as stock_total_inicial,
	t.tiempo_id,
	ub.ubi_id,
	ds.subrubro_id,
	dm.mar_id
from [4_FILAS_AFECTADAS].Publicacion p
join [4_FILAS_AFECTADAS].AlmacenXProducto axp on axp.axp_id = p.publ_alm_prod
join [4_FILAS_AFECTADAS].Almacen a on a.alm_id = axp.axp_alm
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_id = a.alm_dom
join [4_FILAS_AFECTADAS].Localidad l on l.loc_id = d.dom_loc
join [4_FILAS_AFECTADAS].Provincia pr on pr.prov_id = l.loc_prov
join [4_FILAS_AFECTADAS].BI_dim_ubicacion ub on ub.ubi_localidad = l.loc_nombre and ub.ubi_provincia = pr.prov_nombre
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.anio=year(p.publ_fecha) and t.mes = MONTH(p.publ_fecha)
join [4_FILAS_AFECTADAS].Producto prod on prod.prod_id = axp.axp_prod
join [4_FILAS_AFECTADAS].SubRubro s on s.subrubro_id = prod.prod_subRub
join [4_FILAS_AFECTADAS].BI_dim_subrubro ds on ds.subrubro_id = s.subrubro_id
join [4_FILAS_AFECTADAS].Marca m on m.marca_id = prod.prod_marca
join [4_FILAS_AFECTADAS].BI_dim_marca dm on dm.mar_id = m.marca_id
group by t.tiempo_id,
		ub.ubi_id,
		ds.subrubro_id,
		dm.mar_id

CREATE TABLE [4_FILAS_AFECTADAS].BI_ventas(
	venta_ubi int references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
	venta_tiempo int references [4_FILAS_AFECTADAS].BI_dim_tiempo(tiempo_id),
	venta_rg_et_clie int references [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie(rango_etario_id),
	venta_subrubro int references [4_FILAS_AFECTADAS].BI_dim_subrubro(subrubro_id),
	venta_turno int references [4_FILAS_AFECTADAS].BI_dim_turnos(turno_id),
	venta_total decimal(18,2),
	venta_cantidad decimal(18,2)
	primary key(venta_ubi,venta_tiempo,venta_turno,venta_rg_et_clie,venta_subrubro)
)

print 'tabla BI_ventas'
insert into [4_FILAS_AFECTADAS].BI_ventas(venta_ubi, venta_tiempo, venta_rg_et_clie,venta_turno, venta_subrubro,venta_total, venta_cantidad)
Select du.ubi_id, dt.tiempo_id, re.rango_etario_id,tur.turno_id, ds.subrubro_id, sum(v.ven_total), COUNT(DISTINCT v.ven_codigo) from [4_FILAS_AFECTADAS].Venta v
join [4_FILAS_AFECTADAS].Detalle_Venta dv on dv.det_ven_nro = v.ven_codigo
join [4_FILAS_AFECTADAS].Cliente c on v.ven_cli_id = c.cli_id
join [4_FILAS_AFECTADAS].Envio e on e.envio_venta_id = v.ven_codigo
join [4_FILAS_AFECTADAS].Publicacion p on dv.det_ven_publ_id = p.publ_codigo
join [4_FILAS_AFECTADAS].AlmacenXProducto ap on ap.axp_id = p.publ_alm_prod
join [4_FILAS_AFECTADAS].Almacen a on a.alm_id = ap.axp_alm
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_id = a.alm_dom
join [4_FILAS_AFECTADAS].Producto pr on pr.prod_id = ap.axp_prod 
join [4_FILAS_AFECTADAS].BI_dim_ubicacion du on du.ubi_id = d.dom_loc
join [4_FILAS_AFECTADAS].BI_dim_tiempo dt on dt.anio = YEAR(v.ven_fecha) and dt.mes = MONTH(v.ven_fecha)
join [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie re on DATEDIFF(YEAR, c.cli_fecha_nac, GETDATE()) BETWEEN re.minimo and re.maximo
join [4_FILAS_AFECTADAS].BI_dim_subrubro ds on ds.subrubro_id = pr.prod_subRub
join [4_FILAS_AFECTADAS].BI_dim_turnos tur on tur.hora_inicio = e.envio_hora_inicio and tur.hora_final = e.envio_hora_fin_inicio
group by du.ubi_id, dt.tiempo_id, re.rango_etario_id, ds.subrubro_id, tur.turno_id;
go

--------------------------Vistas-------------------

-- vista 1
CREATE VIEW [4_FILAS_AFECTADAS].Promedio_de_tiempo_de_publicaciones
as
select
	sum(p.pub_cant_dias)/sum(p.pub_cant_publicaciones) as promedio_dias,
	ds.subrubro,
	t.cuatrimestre,
	t.anio
from [4_FILAS_AFECTADAS].BI_publicacion p
join [4_FILAS_AFECTADAS].BI_dim_subrubro ds on ds.subrubro_id = p.pub_subrubro
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.tiempo_id = p.pub_tiempo
group by ds.subrubro,
	t.cuatrimestre,
	t.anio
go


-- vista 2
CREATE VIEW [4_FILAS_AFECTADAS].Promedio_de_Stock_Inicial
as
select
	sum(p.pub_stock_total_inicial)/sum(p.pub_cant_publicaciones) as promedio_stock_inicial,
	t.anio,
	m.mar_desc
from [4_FILAS_AFECTADAS].BI_publicacion p
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.tiempo_id = p.pub_tiempo
join [4_FILAS_AFECTADAS].BI_dim_marca m on m.mar_id = p.pub_marca
group by t.anio,m.mar_desc;
go

--vista 3
CREATE VIEW [4_FILAS_AFECTADAS].Venta_promedio_mensual
as
Select u.ubi_provincia as Provincia, t.anio, t.mes, sum(v.venta_total)/sum(v.venta_cantidad) as 'Promedio_Ventas' from [4_FILAS_AFECTADAS].BI_ventas v
join [4_FILAS_AFECTADAS].BI_dim_ubicacion u on v.venta_ubi = u.ubi_id
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on v.venta_tiempo = t.tiempo_id
group by  u.ubi_provincia, t.anio,  t.mes
go

-- vista 4
CREATE VIEW [4_FILAS_AFECTADAS].Rendimiento_de_rubros
as
Select top 5 t.anio, t.cuatrimestre, u.ubi_localidad, r.rango, sum(v.venta_total) as total_ventas from [4_FILAS_AFECTADAS].BI_ventas v
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.tiempo_id = v.venta_tiempo
join [4_FILAS_AFECTADAS].BI_dim_rango_etario_clie r on r.rango_etario_id = v.venta_rg_et_clie
join [4_FILAS_AFECTADAS].BI_dim_ubicacion u on u.ubi_id = v.venta_ubi
join [4_FILAS_AFECTADAS].BI_dim_subrubro s on s.subrubro_id = v.venta_subrubro
group by t.anio, t.cuatrimestre, u.ubi_localidad, r.rango
order by 5 desc
go

--vista 5
CREATE VIEW [4_FILAS_AFECTADAS].Volumen_de_ventas
as
select tp.anio, tp.mes, cast(t.hora_inicio_time as varchar(10))+ ' - '+ cast(t.hora_final_time as varchar(10)) as rango_horario, sum(v.venta_cantidad) as ventas_registradas from [4_FILAS_AFECTADAS].BI_ventas v
join [4_FILAS_AFECTADAS].BI_dim_turnos t on v.venta_turno = turno_id
join [4_FILAS_AFECTADAS].BI_dim_tiempo tp on tp.tiempo_id = v.venta_tiempo
group by tp.anio, tp.mes, cast(t.hora_inicio_time as varchar(10))+ ' - '+ cast(t.hora_final_time as varchar(10))
go

--vista 6
CREATE VIEW [4_FILAS_AFECTADAS].Pago_en_Cuotas
as
select top 3
	u.ubi_localidad,
	sum(p.pago_importe_cuotas) as importe_en_cuotas,
	mp.mp_nombre,
	t.anio,
	t.mes
from [4_FILAS_AFECTADAS].BI_pago p
join [4_FILAS_AFECTADAS].BI_dim_ubicacion u on u.ubi_id = p.pago_ubi
join [4_FILAS_AFECTADAS].BI_dim_medio_pago mp on mp.mp_id = p.pago_medio_pago
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.tiempo_id = p.pago_tiempo
group by
	u.ubi_localidad,
	mp.mp_nombre,
	t.anio,
	t.mes
order by 2 desc;
go

-- vista 7
CREATE VIEW [4_FILAS_AFECTADAS].Porcentaje_de_cumplimiento_de_envíos
as
SELECT
    u.ubi_provincia,
    t.anio,
    t.mes,
    (CAST(SUM(eb.total_envios_cumplidos) AS FLOAT) / CAST(SUM(eb.total_envios) AS FLOAT)) * 100 AS porcentaje_cumplimiento
FROM [4_FILAS_AFECTADAS].BI_envio eb
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion u ON eb.envio_ubi_alm = u.ubi_id
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON eb.envio_tiempo = t.tiempo_id
GROUP BY u.ubi_provincia, t.anio, t.mes;
go

-- vista 8
CREATE VIEW [4_FILAS_AFECTADAS].Localidades_que_pagan_mayor_costo_de_envío
as
SELECT TOP 5
    u.ubi_localidad
FROM [4_FILAS_AFECTADAS].BI_envio eb
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion u ON eb.envio_ubi_clie = u.ubi_id
GROUP BY u.ubi_localidad
ORDER BY SUM(eb.costo_total_envios)/sum(eb.total_envios) DESC;
go

-- vista 9
CREATE VIEW [4_FILAS_AFECTADAS].Porcentaje_de_facturación_por_concepto
as
select
	t.mes,
	t.anio,
	f.concepto,
	sum(f.fact_total)/(
		select sum(f2.fact_total) 
		from [4_FILAS_AFECTADAS].BI_facturacion f2 
		JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t2 ON f2.fact_tiempo = t2.tiempo_id
		where t2.anio = t.anio and t.mes = t2.mes) * 100 as porcentaje
from [4_FILAS_AFECTADAS].BI_facturacion f
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON f.fact_tiempo = t.tiempo_id
group by 
	t.mes,
	t.anio,
	f.concepto
go

-- vista 10
CREATE VIEW [4_FILAS_AFECTADAS].Facturación_por_provincia
as
select
	t.cuatrimestre,
	t.anio,
	u.ubi_provincia,
	sum(f.fact_total) as total_facturado
from [4_FILAS_AFECTADAS].BI_facturacion f
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON f.fact_tiempo = t.tiempo_id
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion u ON f.fact_ubi = u.ubi_id
group by
	t.cuatrimestre,
	t.anio,
	u.ubi_provincia
go