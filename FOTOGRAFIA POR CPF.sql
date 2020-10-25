select distinct 
	CPF,
	NOME,
	CASE
WHEN MIN(ATRASO) <				5			THEN 	't - <5 dias'
WHEN MIN(ATRASO) BETWEEN	5	 AND	7		THEN 	'a - 5 a 7 dias'
WHEN MIN(ATRASO) BETWEEN	8	 AND	15		THEN 	'b - 8 a 15 dias'
WHEN MIN(ATRASO) BETWEEN	16	 AND	30		THEN 	'c - 16 a 30 dias'
WHEN MIN(ATRASO) BETWEEN	31	 AND	60		THEN 	'd - 31 a 60 dias'
WHEN MIN(ATRASO) BETWEEN	61	 AND	69		THEN 	'e - 61 a 69 dias'
WHEN MIN(ATRASO) BETWEEN	70	 AND	90		THEN 	'f - 70 a 90 dias'
WHEN MIN(ATRASO) BETWEEN	91	 AND	180		THEN 	'g - 91 a 180 dias'
WHEN MIN(ATRASO) BETWEEN	181	 AND	270		THEN 	'h - 181 a 270 dias'
WHEN MIN(ATRASO) BETWEEN	271	 AND	360		THEN 	'i - 271 a 360 dias'
WHEN MIN(ATRASO) BETWEEN	361	 AND	720		THEN 	'j - 361 a 720 dias'
WHEN MIN(ATRASO) BETWEEN	721	 AND	1080	THEN 	'k - 721 a 1080 dias'
WHEN MIN(ATRASO) BETWEEN	1081 AND	1440	THEN 	'l - 1081 a 1440 dias'
WHEN MIN(ATRASO) BETWEEN	1441 AND	1800	THEN 	'm - 1441 a 1800 dias'
WHEN MIN(ATRASO) BETWEEN	1801 AND	2160	THEN 	'n - 1801 a 2160 dias'
WHEN MIN(ATRASO) BETWEEN	2161 AND	2520	THEN 	'o - 2161 a 2520 dias'
WHEN MIN(ATRASO) BETWEEN	2521 AND	2880	THEN 	'p - 2521 a 2880 dias'
WHEN MIN(ATRASO) BETWEEN	2881 AND	3240	THEN 	'q - 2881 a 3240 dias'
WHEN MIN(ATRASO) BETWEEN	3241 AND	3600	THEN 	'r - 3241 a 3600 dias'
WHEN MIN(ATRASO)					   >3600	THEN 	's - Acima 3600 dias' END AS FX_ATRASO,
CASE 
WHEN MIN(ATRASO) < 5 THEN 't - Menor 5'
WHEN MIN(ATRASO) BETWEEN 5 AND 7 THEN 'a - 5 a 7'
WHEN MIN(ATRASO) BETWEEN 8 AND 30 THEN 'b - 8 a 30'
WHEN MIN(ATRASO) BETWEEN 31 AND 60 THEN 'c - 31 a 60'
WHEN MIN(ATRASO) BETWEEN 61 AND 90 THEN 'd - 61 a 90'
WHEN MIN(ATRASO) > 90 THEN 'e - Maior 90' END AS AGING_CLUSTER,
CASE 
WHEN MIN(ATRASO) < 8 THEN '08<'
WHEN MIN(ATRASO) BETWEEN 8 AND 30 THEN '08 a 30'
WHEN MIN(ATRASO) BETWEEN 31 AND 60 THEN '31 a 60'
WHEN MIN(ATRASO) BETWEEN 61 AND 90 THEN '61 a 90'
WHEN MIN(ATRASO) > 90 THEN '90<' END AS AGING_CLUSTER_2,
COUNT(DISTINCT(CPF)) AS QUANTIDADE
	
	from ADCOBMIS01..vw_CARTEIRA_AVON_V2_dia_F1

	GROUP BY 
		CPF,
	NOME

