USE proyecto_turismo;
-- Creación de tablas

CREATE TABLE IF NOT EXISTS turismo_receptor(
año INT,
mes INT,
ccaa_destino VARCHAR (100),
pais_origen VARCHAR (250),
turistas INT,
pernoctaciones INT,
estancia_media VARCHAR (5),
PRIMARY KEY(ccaa_destino)
);	

CREATE TABLE IF NOT EXISTS turismo_emisor(
año INT,
mes INT,
ccaa_origen VARCHAR (100),
pais_destino VARCHAR (250),
turistas INT,
pernoctaciones INT,
estancia_media VARCHAR (5),
PRIMARY KEY(ccaa_origen)
);


CREATE TABLE IF NOT EXISTS turismo_interno(
año INT,
mes INT,
ccaa_destino VARCHAR (100),
ccaa_origen VARCHAR (100),
provincia_origen VARCHAR (100),
provincia_destino VARCHAR (250),
turistas INT NOT NULL,
pernoctaciones INT,
estancia_media VARCHAR (5),
PRIMARY KEY(provincia_origen),
FOREIGN KEY(ccaa_destino) REFERENCES turismo_receptor (ccaa_destino),
FOREIGN KEY(ccaa_origen) REFERENCES turismo_emisor (ccaa_origen)
);

-- Miramos que los csv que hemos importado estén completos y revisamos las colunmas que tienen
SELECT *
FROM`turismo_emisor_ccaa_pais (1)`;

SELECT *
FROM`turismo_receptor_ccaa_pais (1)`
LIMIT 5;

SELECT *
FROM`turismo_interno_prov_ccaa (1)`;

-- Empezamos el análisis de los datos

-- Empiezo con TURISMO EMISOR

SELECT
SUM(TURISTAS) AS Total,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2023; 

SELECT 
SUM(TURISTAS) AS Total,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2022; 

SELECT 
SUM(TURISTAS) AS Total,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2021; 


-- Calculamos el TOP 5 de las CCAA que mas salieron por año.
CREATE VIEW top_5_emisor_2021 AS 
SELECT
AÑO, 
CCAA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2021
GROUP BY 
AÑO, CCAA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más salieron en 2021 son: 
-- Cataluña: 3.372.886
-- Andalucia: 2.026.372
-- C. Madrid: 1.908.197
-- Galicia: 1.284.440
-- País Vasco: 1.133.139

CREATE VIEW top_5_emisor_2022 AS 
SELECT
AÑO, 
CCAA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2022
GROUP BY 
AÑO, CCAA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más salieron en 2022 son: 
-- Cataluña: 5.596.999
-- C. Madrid: 3.837.366
-- Andalucia: 3.112.205
-- Galicia: 2.103.928
-- País Vasco: 2.021.922

CREATE VIEW top_5_emisor_2023 AS 
SELECT
AÑO, 
CCAA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2023
GROUP BY 
AÑO, CCAA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más salieron en 2023 son: 
-- Cataluña: 6.475.960
-- C. Madrid: 4.621.879
-- Andalucia: 3.801.572
-- Galicia: 2.295.559
-- C. Valenciana: 2.088.996

CREATE VIEW total_top_5_emisor AS 
SELECT
AÑO, 
CCAA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' 
GROUP BY 
AÑO, CCAA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 10; 

-- El TOP 10 de las comunidades que más salieron en 2023 son: 
-- 2023	Cataluña	6475960
-- 2022	Cataluña	5596999
-- 2023	C. Madrid	4621879
-- 2022	C. Madrid	3837366
-- 2023	Andalucía	3801572
-- 2021	Cataluña	3372886
-- 2022	Andalucía	3112205
-- 2023	Galicia	2295559
-- 2022	Galicia	2103928
-- 2023	C. Valenciana	2088996
-- y para determinar los paises a los que más viajamos:

CREATE VIEW top_5_dest_emisor_2021 AS 
SELECT
AÑO, 
PAIS_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2021
GROUP BY 
AÑO, PAIS_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- Los 5 destinos preferidos en 2021 en relacion al número de turistas fueron:
-- Francia	4.603.978
-- Portugal	3.781.431
-- Italia	1.026.846
-- Marruecos 880.146
-- Andorra	747.592

CREATE VIEW top_5_dest_emisor_2022 AS 
SELECT
AÑO, 
PAIS_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2022
GROUP BY 
AÑO, PAIS_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- Los 5 destinos preferidos en 2022 en relacion al número de turistas fueron:
-- Francia: 6.751.634
-- Portugal	5.478.155
-- Italia	2.071.907
-- Reino Unido	1.484.718
-- Alemania	1.106.895

CREATE VIEW top_5_dest_emisor_2023 AS 
SELECT
AÑO, 
PAIS_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2023
GROUP BY 
AÑO, PAIS_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- Los 5 destinos preferidos en 2023 en relacion al número de turistas fueron:
-- Francia: 7.232.653
-- Portugal:	6.188.983
-- Italia:	2.545.681
-- Reino Unido:	1.880.983
-- Alemania:	1.335.183


-- Para ello vamos a agrupar los meses y los turistas para poder ver los datos de turismo por CCAA y 
-- en que temporada del año salienron más de España
  
SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2023
GROUP BY Estacion
ORDER BY Tur DESC;

-- en 2023 lAs estaciones en las que más nos movimos 3588	Otoño = 3582, Verano, 3343	Primavera, 3274	InviernoAunque es muy ligera la diferencia


SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2022
GROUP BY Estacion
ORDER BY Tur DESC;

-- en 2022 lAs estaciones en las que más nos movimos 3588	Otoño = 3329, Verano, 3222	Primavera, 2709	Invierno. Aunque es muy ligera la diferencia


SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_emisor_ccaa_pais (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND AÑO = 2021
GROUP BY Estacion
ORDER BY Tur DESC;

-- en 2021 lAs estaciones en las que más nos movimos 2672	Otoño = 2360, Verano, 1840	Primavera, 1564	Invierno. Aunque es muy ligera la diferencia

-- Hacer una relación entre el número de pernoctaciones y las paises de destino en los distintos años 

SELECT 
AÑO,
PAIS_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_emisor_ccaa_pais (1)`
GROUP BY AÑO, PAIS_DESTINO
HAVING AÑO = '2021'
ORDER BY NOCHES DESC
LIMIT 5;

-- los 5 destinos donde más pernoctaciones hicimos en 2021 fueron: 
-- Francia:	2.598.432; 
-- Portugal. 1.691.663; 
-- Italia: 967.866;
-- Alemania: 638.581
-- Reino Unido: 487.923.

SELECT 
AÑO,
PAIS_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_emisor_ccaa_pais (1)`
GROUP BY AÑO, PAIS_DESTINO
HAVING AÑO = '2022'
ORDER BY NOCHES DESC
LIMIT 5;

-- los 5 destinos donde más pernoctaciones hicimos en 2022 fueron: 
-- Francia: 3.721.963
-- Portugal: 2.461.658
-- Italia: 1.778.392
-- Reino Unido: 1.216.209
-- Alemania: 1.054.328

SELECT 
AÑO,
PAIS_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_emisor_ccaa_pais (1)`
GROUP BY AÑO, PAIS_DESTINO
HAVING AÑO = '2023'
ORDER BY NOCHES DESC
LIMIT 5;

-- los 5 destinos donde más pernoctaciones hicimos en 2022 fueron: 
-- Francia: 3.971.049
-- Portugal: 2.774.440
-- Italia: 2.126.065
-- Reino Unido: 1.464.817
-- Alemania: 1.238.180


-- TURISMO RECEPTOR

-- Vamos a analizar los CCAA que mas turistas recibieron segun los años

CREATE VIEW top_5_receptor_2021 AS 
SELECT
ANO, 
CCAA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2021
GROUP BY 
ANO, CCAA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más recibieron en 2021 son: 
-- Cataluña: 8.100.352
-- Andalucía	5.499.118
-- Illes Balears: 5.017.410
-- Canarias	4.476.042
-- Comunitat Valenciana	4.134.575


CREATE VIEW top_5_receptor_2022 AS 
SELECT
ANO, 
CCAA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2022
GROUP BY 
ANO, CCAA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más recibieron en 2022 son: 
-- Cataluña	14.714.860
-- Illes Balears	12.947.967
-- Canarias	12.081.247
-- Andalucía	10.291.375
-- Comunitat Valenciana	7.509.756

CREATE VIEW top_5_receptor_2023 AS 
SELECT
ANO, 
CCAA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2023
GROUP BY 
ANO, CCAA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- El TOP 5 de las comunidades que más recibieron en 2023 son: 
-- Cataluña	18.536.471
-- Illes Balears	13.771.514
-- Canarias	13.520.566
-- Andalucía	12.545.750
-- Comunitat Valenciana	9.111.202


-- Para ello vamos a agrupar los meses y los turistas para poder ver los datos de turismo por CCAA y 
-- en que temporada del año salienron más de España

SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2021
GROUP BY Estacion
ORDER BY TUR, Estacion DESC;

-- en 2021 lAs estaciones en las que más turistas recibimos  3500	Otoño = 3254, Verano, 2926	Invierno, 2810	Primavera, Aunque es muy ligera la diferencia


SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2022
GROUP BY Estacion
ORDER BY Tur DESC;

-- en 2022 lAs estaciones en las que más turistas recibimos 
-- 3910	Otoño
-- 3908	Verano
-- 3593	Primavera
-- 3419	Invierno

SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2023
GROUP BY Estacion
ORDER BY Tur DESC;

-- en 2023 lAs estaciones en las que más turistas recibimos 

-- 4378	Verano
-- 4377	Otoño
-- 3961	Primavera
-- 3845	Invierno

-- QUIERO QUE ME DE LA SUMA DE TURISTAS POR ESTACIONES 
SELECT 
DISTINCT CCAA_DESTINO, 
ANO,
PAIS_ORIGEN,
COUNT(TURISTAS) AS TOTAL_TURISTAS,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion
FROM `turismo_receptor_ccaa_pais (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2023
GROUP BY PAIS_ORIGEN, ANO, CCAA_DESTINO,Estacion
HAVING PAIS_ORIGEN = 'Reino Unido'
ORDER BY TOTAL_TURISTAS, CCAA_DESTINO;

-- Hacer una relación entre el número de pernoctaciones y las comunidades en los distintos años 

SELECT 
ANO,
CCAA_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_receptor_ccaa_pais (1)`
GROUP BY ANO, CCAA_DESTINO
HAVING ANO = '2021'
LIMIT 5;

SELECT 
ANO,
CCAA_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_receptor_ccaa_pais (1)`
GROUP BY ANO, CCAA_DESTINO
HAVING ANO = '2022'
LIMIT 5;

SELECT 
ANO,
CCAA_DESTINO, 
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_receptor_ccaa_pais (1)`
GROUP BY ANO, CCAA_DESTINO
HAVING ANO = '2023'
LIMIT 5;





-- INTERNO



-- 2021: RELACION ENTRE CC Y PROVINCIA EN RELACION AL DESTINO
CREATE VIEW top_5_interno_2023 AS 
SELECT
ANO, 
CCAA_DESTINO,
PROVINCIA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2023
GROUP BY 
ANO, CCAA_DESTINO,PROVINCIA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- 2021: RELACION ENTRE CC Y PROVINCIA EN RELACION AL DESTINO
-- Comunidad de Madrid	Madrid	18675228
-- Cataluña	Barcelona	9378381
-- Comunitat Valenciana	Alicante/Alacant	7774921
-- Cataluña	Girona	7444479
-- Andalucía	Cádiz	6841546

-- 2022: RELACION ENTRE CC Y PROVINCIA EN RELACION AL DESTINO
CREATE VIEW top_5_interno_2022 AS 
SELECT
ANO, 
CCAA_DESTINO,
PROVINCIA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2022
GROUP BY 
ANO, CCAA_DESTINO,PROVINCIA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- 2022 RELACION CCAA PROVINCIA RELACION ENTRE CC Y PROVINCIA EN RELACION AL DESTINO
-- Comunidad de Madrid	Madrid	17911541
-- Cataluña	Barcelona	9047134
-- Comunitat Valenciana	Alicante/Alacant	7573043
-- Cataluña	Girona	7020609
-- Andalucía	Cádiz	6435188


-- TOP 5 2021: RELACION ENTRE CC Y PROVINCIA EN RELACION AL DESTINO
CREATE VIEW top_5_interno_2021 AS 
SELECT
ANO, 
CCAA_DESTINO,
PROVINCIA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_DESTINO <> 'Total Nacional' AND ANO = 2021
GROUP BY 
ANO, CCAA_DESTINO,PROVINCIA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- LOS TOP 5 2021 FUERON:

-- Comunidad de Madrid	Madrid	14784757
-- Cataluña	Barcelona	7851643
-- Comunitat Valenciana	Alicante/Alacant	7013866
-- Cataluña	Girona	6913870
-- Cataluña	Tarragona	6195426
 
 
-- 2021: RELACION ENTRE CC Y PROVINCIA EN RELACION AL ORIGEN
CREATE VIEW top_5_interno_2021_or AS 
SELECT
ANO, 
CCAA_ORIGEN,
PROVINCIA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND ANO = 2021
GROUP BY 
ANO, CCAA_ORIGEN, PROVINCIA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- EL TOP5 2021: RELACION ENTRE CC Y PROVINCIA EN RELACION AL ORIGEN
-- Comunidad de Madrid	Madrid	27335111
-- Cataluña	Barcelona	16500323
-- Andalucía	Sevilla	7684293
-- Comunitat Valenciana	Valencia/València	7376831
-- Comunitat Valenciana	Alicante/Alacant	4749133


-- 2022: RELACION ENTRE CC Y PROVINCIA EN RELACION AL ORIGEN
CREATE VIEW top_5_interno_2022_or AS 
SELECT
ANO, 
CCAA_ORIGEN,
PROVINCIA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND ANO = 2022
GROUP BY 
ANO, CCAA_ORIGEN, PROVINCIA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- EL TOP5 2022: RELACION ENTRE CC Y PROVINCIA EN RELACION AL ORIGEN
-- Comunidad de Madrid	Madrid	31916462
-- Cataluña	Barcelona	18072291
-- Andalucía	Sevilla	8524035
-- Comunitat Valenciana	Valencia/València	8035156
-- Comunitat Valenciana	Alicante/Alacant	5474213

CREATE VIEW top_5_interno_2023_or AS 
SELECT
ANO, 
CCAA_ORIGEN,
PROVINCIA_ORIGEN,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND ANO = 2023
GROUP BY 
ANO, CCAA_ORIGEN, PROVINCIA_ORIGEN
ORDER BY num_turistas DESC
LIMIT 5; 

-- EL TOP5 2023: RELACION ENTRE CC Y PROVINCIA EN RELACION AL ORIGEN
-- Comunidad de Madrid	Madrid	34638579
-- Cataluña	Barcelona	19560363
-- Andalucía	Sevilla	8868331
-- Comunitat Valenciana	Valencia/València	8234306
-- Comunitat Valenciana	Alicante/Alacant	5449470


-- saber de que comunidades a que comunidades vamos más
CREATE VIEW top_5_interno_2023_or AS 
SELECT
ANO, 
CCAA_ORIGEN,
CCAA_DESTINO,
SUM(TURISTAS) AS num_turistas,
ROUND(AVG(TURISTAS),2) AS MEAN
FROM`turismo_interno_prov_ccaa (1)`
WHERE CCAA_ORIGEN <> 'Total Nacional' AND ANO = 2023
GROUP BY 
ANO, CCAA_ORIGEN, CCAA_DESTINO
ORDER BY num_turistas DESC
LIMIT 5; 

-- Estos son los top 5
-- Andalucía	Andalucía
-- Cataluña	Cataluña
-- Comunidad de Madrid	Castilla - La Mancha
-- Comunidad de Madrid	Castilla y León
-- Galicia	Galicia

-- 	queremos ver en que estación realizan mas movimientos internos los turistas

-- 2023
SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_interno_prov_ccaa (1)`
WHERE ANO = 2023
GROUP BY Estacion
ORDER BY Tur DESC;

-- 7668	Verano
-- 7646	Otoño
-- 7622	Primavera
-- 7607	Invierno

SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_interno_prov_ccaa (1)`
WHERE ANO = 2022
GROUP BY Estacion
ORDER BY Tur DESC;

-- 2022-- 
-- 7677	Verano
-- 7656	Otoño
-- 7603	Primavera
-- 7569	Invierno


-- 2023-- 
SELECT COUNT(TURISTAS) AS TUR,
CASE
	WHEN MES IN (1, 2, 12) THEN "Invierno"
	WHEN MES IN (3, 4, 5) THEN "Primavera"
	WHEN MES IN (6, 7, 8) THEN "Verano"
	ELSE "Otoño"
	END AS Estacion   
FROM `turismo_interno_prov_ccaa (1)`
WHERE ANO = 2021
GROUP BY Estacion
ORDER BY Tur DESC;

-- 7662	Verano
-- 7657	Otoño
-- 7491	Invierno
-- 7488	Primavera


-- Hacer una relación entre el número de pernoctaciones y las comunidades en los distintos años 
SELECT 
ANO,
PROVINCIA_ORIGEN, 
PROVINCIA_DESTINO,
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_interno_prov_ccaa (1)`
GROUP BY ANO, PROVINCIA_ORIGEN, PROVINCIA_DESTINO
HAVING ANO = '2021'
ORDER BY NOCHES DESC
LIMIT 5;

-- 2021 --
-- Barcelona	Girona	1.592.985
-- Barcelona	Tarragona	1.151.440
-- Madrid	Alicante/Alacant	1.051.668
-- Madrid	Toledo	980.617
-- Sevilla	Cádiz	795.236


-- 2022-- 
SELECT 
ANO,
PROVINCIA_ORIGEN, 
PROVINCIA_DESTINO,
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_interno_prov_ccaa (1)`
GROUP BY ANO, PROVINCIA_ORIGEN, PROVINCIA_DESTINO
HAVING ANO = '2022'
ORDER BY NOCHES DESC
LIMIT 5;

-- Barcelona	Girona	1467.039
-- Madrid	Alicante/Alacant	1.078.637
-- Barcelona	Tarragona	1.062.523
-- Madrid	Toledo	995.890
-- Toledo	Madrid	766.188


-- 2023 --
SELECT 
ANO,
PROVINCIA_ORIGEN, 
PROVINCIA_DESTINO,
SUM(PERNOCTACIONES) / COUNT(DISTINCT mes) AS NOCHES
FROM `turismo_interno_prov_ccaa (1)`
GROUP BY ANO, PROVINCIA_ORIGEN, PROVINCIA_DESTINO
HAVING ANO = '2023'
ORDER BY NOCHES DESC
LIMIT 5;

-- Barcelona	Girona	1.556.135
-- Barcelona	Tarragona	1.146.789
-- Madrid	Alicante/Alacant	1.141.388
-- Madrid	Toledo	1.047.934
-- Sevilla	Cádiz	804.288


-- QUE PROVINCIAS SUPERAN LA MEDIA DE LAS PERNOCTACIONES EN TURISMO INTERNO

SELECT PROVINCIA_DESTINO, ANO, COUNT(PERNOCTACIONES) AS TOTAL
FROM `turismo_interno_prov_ccaa (1)`
WHERE  (ANO, PROVINCIA_DESTINO) IN (
    SELECT ANO, PROVINCIA_DESTINO
    FROM `turismo_interno_prov_ccaa (1)`
    GROUP BY ANO, PROVINCIA_DESTINO
    HAVING COUNT(PERNOCTACIONES) > ROUND(AVG(PERNOCTACIONES), 0)
)
GROUP BY ANO, PROVINCIA_DESTINO
ORDER BY TOTAL;


SELECT *
FROM top_5_emisor_2023 AS E23
INNER JOIN top_5_receptor_2023 AS R23
ON R23.ANO = E23.AÑO; 

SELECT *
FROM top_5_emisor_2022 AS E22
INNER JOIN top_5_receptor_2022 R22
ON R22.ANO = E22.AÑO; 

SELECT *
FROM top_5_emisor_2021 AS E21
INNER JOIN top_5_receptor_2021 R21
ON R21.ANO = E21.AÑO; 


