

IF OBJECT_ID ('TEMPDB..##CONSOLIDADO') IS NOT NULL DROP TABLE ##CONSOLIDADO
SELECT 
DATA,
CONTRATO_TIT,
CPF,
SEGMENTA플O,
VALOR,
CARTEIRA,


CASE WHEN (CASE SEGMENTA플O WHEN 'CREDZ' THEN
CASE 
WHEN ATRASO < 0					THEN 'faixa 00 -  a vencer'
										WHEN ATRASO BETWEEN 0 AND 120	THEN 'faixa 07 - 78 a 120'
										WHEN ATRASO BETWEEN 121 AND 150 THEN 'faixa 08 - 121 a 150'
										WHEN ATRASO BETWEEN 151 AND 180 THEN 'faixa 09 - 151 a 180'
										WHEN ATRASO BETWEEN 181 AND 360 THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO > 720				THEN 'faixa 12 - 721 a 9999999'
	 ELSE 'faixa 00 -  a vencer'
	 END
WHEN 'TRAVESSIA' THEN
CASE 
										WHEN ATRASO BETWEEN 0 AND 360	THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO > 720 THEN 'faixa 12 - 721 a 9999999' 
	 ELSE 'faixa 00 -  a vencer'
	 END END) IS NULL THEN SEGMENTA플O ELSE CASE SEGMENTA플O WHEN 'CREDZ' THEN
CASE 
WHEN ATRASO < 0					THEN 'faixa 00 -  a vencer'
										WHEN ATRASO BETWEEN 0 AND 120	THEN 'faixa 07 - 78 a 120'
										WHEN ATRASO BETWEEN 121 AND 150 THEN 'faixa 08 - 121 a 150'
										WHEN ATRASO BETWEEN 151 AND 180 THEN 'faixa 09 - 151 a 180'
										WHEN ATRASO BETWEEN 181 AND 360 THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO > 720				THEN 'faixa 12 - 721 a 9999999'
	 ELSE 'faixa 00 -  a vencer'
	 END
WHEN 'TRAVESSIA' THEN
CASE 
										WHEN ATRASO BETWEEN 0 AND 360	THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO > 720 THEN 'faixa 12 - 721 a 9999999' 
	 ELSE 'faixa 00 -  a vencer'
	 END END END AS FX_ATRASO

	 INTO ##CONSOLIDADO

FROM ADCOBMIS01..FOTOGRAFIA_VCOM

SELECT
DATA,
SEGMENTA플O,
CARTEIRA,
FX_ATRASO,
COUNT(CONTRATO_TIT) AS Qtd_Total,
COUNT(DISTINCT(CPF)) AS Qtd_Unique,
SUM(VALOR) AS SALDO
FROM ##CONSOLIDADO

GROUP BY 
DATA,
SEGMENTA플O,
CARTEIRA,
FX_ATRASO


