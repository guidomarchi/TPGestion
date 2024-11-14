USE [GD2C2024]
GO

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
	primary key (hora_inicio,hora_final) 
);

PRINT 'tabla BI_dim_turnos'
insert into [4_FILAS_AFECTADAS].BI_dim_turnos(hora_inicio,hora_final)
values(8,12),(12,16),(16,20)

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

CREATE TABLE [4_FILAS_AFECTADAS].BI_facturacion (
    fact_id int identity(1,1) primary key,
    fact_total decimal(18,2),
    fact_ubi int,
    fact_tiempo INT,
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


