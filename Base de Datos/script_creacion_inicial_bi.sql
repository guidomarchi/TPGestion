USE [GD2C2024]
GO


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
	hora_inicio int,
	hora_final int,
    hora_inicio_time time,
	hora_final_time time,
	primary key (hora_inicio,hora_final) 
);

PRINT 'tabla BI_dim_turnos'
insert into [4_FILAS_AFECTADAS].BI_dim_turnos(hora_inicio,hora_final,hora_inicio_time,hora_final_time)
values(8,12,'08:00:00','12:00:00'),(12,16,'12:00:00','16:00:00'),(16,20,'16:00:00','20:00:00')

CREATE TABLE [4_FILAS_AFECTADAS].BI_dim_medio_pago(
    medio_pago_tipo NVARCHAR(50),
    medio_pago NVARCHAR(50),
	PRIMARY KEY (medio_pago_tipo,medio_pago)
);
GO

print 'tabla BI_dim_medio_pago'
insert into [4_FILAS_AFECTADAS].BI_dim_medio_pago(medio_pago_tipo,medio_pago)
select
	mp.mp_nombre,
	mp.mp_tipo
from [4_FILAS_AFECTADAS].MedioDePago mp;

create table [4_FILAS_AFECTADAS].BI_dim_subrubro(
    subrubro NVARCHAR(50),
    rubro NVARCHAR(50),
    primary key (subrubro,rubro)
);

print 'tabla BI_dim_subrubro'
insert into [4_FILAS_AFECTADAS].BI_dim_subrubro(subrubro,rubro)
select
	s.subrubro_descripcion,
	r.rubro_descripcion
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


--------------------Hechos---------------------


CREATE TABLE [4_FILAS_AFECTADAS].BI_facturacion (
    fact_total decimal(18,2),
    fact_ubi int,
    fact_tiempo INT,
    primary key (fact_total,fact_ubi,fact_tiempo),
    FOREIGN KEY (fact_tiempo) 
    REFERENCES [4_FILAS_AFECTADAS].BI_dim_tiempo (tiempo_id),
    FOREIGN KEY (fact_ubi) 
    REFERENCES [4_FILAS_AFECTADAS].BI_dim_ubicacion (ubi_id)
);


print 'tabla BI_facturacion'
insert into [4_FILAS_AFECTADAS].BI_facturacion(fact_total,fact_ubi,fact_tiempo)
select
	sum(f.fac_total),
	ub.ubi_id,
	t.tiempo_id
from [4_FILAS_AFECTADAS].Factura f
join [4_FILAS_AFECTADAS].Vendedor v on v.ven_id = f.fac_vendedor_id
join [4_FILAS_AFECTADAS].Usuario u on u.usu_id = v.ven_usu_id
join [4_FILAS_AFECTADAS].UsuarioXDomicilio uxd on u.usu_id = uxd.usu_id
join [4_FILAS_AFECTADAS].Domicilio d on d.dom_id = uxd.dom_id
join [4_FILAS_AFECTADAS].Localidad l on l.loc_id = d.dom_loc
join [4_FILAS_AFECTADAS].Provincia p on p.prov_id = l.loc_prov
join [4_FILAS_AFECTADAS].BI_dim_ubicacion ub on ub.ubi_localidad = l.loc_nombre and ub.ubi_provincia = p.prov_nombre
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.anio=year(f.fac_fecha) and t.mes = MONTH(f.fac_fecha)
group by ub.ubi_id,
	t.tiempo_id
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

create table [4_FILAS_AFECTADAS].BI_PAGO(
	pago_tiempo int foreign key references [4_FILAS_AFECTADAS].BI_dim_tiempo(tiempo_id),
	pago_medio_pago nvarchar(50),
	pago_tipo_medio_pago nvarchar(50),
	pago_importe decimal(18,2),
	pago_cuotas decimal(18,0),
	pago_ubi int foreign key references [4_FILAS_AFECTADAS].BI_dim_ubicacion(ubi_id),
	CONSTRAINT FK_Pago_MedioPago 
       FOREIGN KEY (pago_tipo_medio_pago, pago_medio_pago)
       REFERENCES [4_FILAS_AFECTADAS].BI_dim_medio_pago(medio_pago_tipo, medio_pago)
);

print 'tabla BI_pago'
insert into [4_FILAS_AFECTADAS].BI_PAGO(pago_tiempo, 
										pago_medio_pago, 
										pago_tipo_medio_pago, 
										pago_importe, 
										pago_cuotas, 
										pago_ubi)
select
	t.tiempo_id,
	mp.mp_nombre,
	mp.mp_tipo,
	p.pago_importe,
	dp.det_pago_cant_cuotas,
	ubi.ubi_id
from [4_FILAS_AFECTADAS].MedioDePago mp
join [4_FILAS_AFECTADAS].Detalle_Pago dp on mp.mp_id = dp.det_pago_medio_id
join [4_FILAS_AFECTADAS].Pago p on dp.det_pago_pago_id = p.pago_id
join [4_FILAS_AFECTADAS].Venta v on p.pago_venta_nro = v.ven_codigo
join [4_FILAS_AFECTADAS].Cliente c on v.ven_cli_id = c.cli_id
join [4_FILAS_AFECTADAS].Usuario u on c.cli_usu_id = u.usu_id
join [4_FILAS_AFECTADAS].UsuarioXDomicilio ud on u.usu_id = ud.usu_id
join [4_FILAS_AFECTADAS].Domicilio d on ud.dom_id = d.dom_id
join [4_FILAS_AFECTADAS].Localidad l on d.dom_loc = l.loc_id
join [4_FILAS_AFECTADAS].Provincia pro on l.loc_prov = pro.prov_id
join [4_FILAS_AFECTADAS].BI_dim_ubicacion ubi on l.loc_nombre = ubi.ubi_localidad and pro.prov_nombre = ubi_provincia
join [4_FILAS_AFECTADAS].BI_dim_tiempo t on t.anio = YEAR(p.pago_fecha) and t.mes = MONTH(p.pago_fecha)


--------------------------Vistas-------------------
print 'vista 7'
SELECT
    u.ubi_provincia,
    t.anio,
    t.mes,
    (CAST(SUM(eb.total_envios_cumplidos) AS FLOAT) / CAST(SUM(eb.total_envios) AS FLOAT)) * 100 AS porcentaje_cumplimiento
FROM [4_FILAS_AFECTADAS].BI_envio eb
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion u ON eb.envio_ubi_alm = u.ubi_id
JOIN [4_FILAS_AFECTADAS].BI_dim_tiempo t ON eb.envio_tiempo = t.tiempo_id
GROUP BY u.ubi_provincia, t.anio, t.mes;

print 'vista 8'
SELECT TOP 5
    u.ubi_localidad
FROM [4_FILAS_AFECTADAS].BI_envio eb
JOIN [4_FILAS_AFECTADAS].BI_dim_ubicacion u ON eb.envio_ubi_clie = u.ubi_id
GROUP BY u.ubi_localidad
ORDER BY SUM(eb.costo_total_envios)/sum(eb.total_envios) DESC;
