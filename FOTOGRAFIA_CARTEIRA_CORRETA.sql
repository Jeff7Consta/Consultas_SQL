DECLARE @DATAINI DATE
DECLARE @DATAFIM DATE

SET @DATAINI = CONVERT(DATE, GETDATE(), 103)
SET @DATAFIM = CONVERT(DATE, GETDATE(), 103)

INSERT INTO ADCOBMIS01..ESTRATIFICACAO_AVON_MIS_01
SELECT 
DATA_BASE,
CAST(LEFT(RIGHT(CONTRATO,6), 2) AS VARCHAR) AS CAMPANHA,
RIGHT(CONTRATO,4) AS ANO_CAMPANHA,
CASE
WHEN ATRASO <				    5		THEN 	't - <5 dias'
WHEN ATRASO BETWEEN	5	 AND	7		THEN 	'a - 5 a 7 dias'
WHEN ATRASO BETWEEN	8	 AND	15		THEN 	'b - 8 a 15 dias'
WHEN ATRASO BETWEEN	16	 AND	30		THEN 	'c - 16 a 30 dias'
WHEN ATRASO BETWEEN	31	 AND	60		THEN 	'd - 31 a 60 dias'
WHEN ATRASO BETWEEN	61	 AND	69		THEN 	'e - 61 a 69 dias'
WHEN ATRASO BETWEEN	70	 AND	90		THEN 	'f - 70 a 90 dias'
WHEN ATRASO BETWEEN	91	 AND	180		THEN 	'g - 91 a 180 dias'
WHEN ATRASO BETWEEN	181	 AND	270		THEN 	'h - 181 a 270 dias'
WHEN ATRASO BETWEEN	271	 AND	360		THEN 	'i - 271 a 360 dias'
WHEN ATRASO BETWEEN	361	 AND	720		THEN 	'j - 361 a 720 dias'
WHEN ATRASO BETWEEN	721	 AND	1080	THEN 	'k - 721 a 1080 dias'
WHEN ATRASO BETWEEN	1081 AND	1440	THEN 	'l - 1081 a 1440 dias'
WHEN ATRASO BETWEEN	1441 AND	1800	THEN 	'm - 1441 a 1800 dias'
WHEN ATRASO BETWEEN	1801 AND	2160	THEN 	'n - 1801 a 2160 dias'
WHEN ATRASO BETWEEN	2161 AND	2520	THEN 	'o - 2161 a 2520 dias'
WHEN ATRASO BETWEEN	2521 AND	2880	THEN 	'p - 2521 a 2880 dias'
WHEN ATRASO BETWEEN	2881 AND	3240	THEN 	'q - 2881 a 3240 dias'
WHEN ATRASO BETWEEN	3241 AND	3600	THEN 	'r - 3241 a 3600 dias'
WHEN ATRASO					   >3600	THEN 	's - Acima 3600 dias' END AS FX_ATRASO,
CASE 
WHEN ATRASO < 5 THEN 't - Menor 5'
WHEN ATRASO BETWEEN 5 AND 7 THEN 'a - 5 a 7'
WHEN ATRASO BETWEEN 8 AND 30 THEN 'b - 8 a 30'
WHEN ATRASO BETWEEN 31 AND 60 THEN 'c - 31 a 60'
WHEN ATRASO BETWEEN 61 AND 90 THEN 'd - 61 a 90'
WHEN ATRASO > 90 THEN 'e - Maior 90' END AS AGING_CLUSTER,
CASE 
WHEN ATRASO < 8 THEN '08<'
WHEN ATRASO BETWEEN 8 AND 30 THEN '08 a 30'
WHEN ATRASO BETWEEN 31 AND 60 THEN '31 a 60'
WHEN ATRASO BETWEEN 61 AND 90 THEN '61 a 90'
WHEN ATRASO > 90 THEN '90<' END AS AGING_CLUSTER_2,
   CASE
 WHEN CAMPANHA =  	1	 THEN 	'A - 1'
 WHEN CAMPANHA =  	2	 THEN 	'B - 2'
 WHEN CAMPANHA =  	3	 THEN 	'C - 3'
 WHEN CAMPANHA =  	4	 THEN 	'D - 4'
 WHEN CAMPANHA =  	5	 THEN 	'E - 5'
 WHEN CAMPANHA =  	6	 THEN 	'F - 6'
 WHEN CAMPANHA =  	7	 THEN 	'G - 7'
 WHEN CAMPANHA =  	8	 THEN 	'H - 8'
 WHEN CAMPANHA =  	9	 THEN 	'I - 9'
 WHEN CAMPANHA =  	10	 THEN 	'J - 10'
 WHEN CAMPANHA =  	11	 THEN 	'K - 11'
 WHEN CAMPANHA =  	12	 THEN 	'L -12'
 WHEN CAMPANHA =  	15	 THEN 	'M - 15'
 WHEN CAMPANHA =  	16	 THEN 	'O - 16'
 WHEN CAMPANHA =  	17	 THEN 	'P - 17'
 WHEN CAMPANHA =  	18	 THEN 	'Q - 18'
 WHEN CAMPANHA =  	19	 THEN 	'R - 19'
 WHEN CAMPANHA =  	20	 THEN 	'S - 20'
 WHEN CAMPANHA =  	21	 THEN 	'T - 21'
 WHEN CAMPANHA =  	22	 THEN 	'U - 22'
 WHEN CAMPANHA =  	23	 THEN 	'V - 23'
 WHEN CAMPANHA =  	24	 THEN 	'X - 24'
 WHEN CAMPANHA =  	25	 THEN 	'Y - 25'
 WHEN CAMPANHA =  	26	 THEN 	'Z - 26'
 END AS FX_CARTEIRA,
 CASE 
	WHEN VL_SALDO < '30' THEN '01-Menor que 30'
	WHEN VL_SALDO BETWEEN '30' AND '39.99' THEN '02-30 a 39,99'
	WHEN VL_SALDO BETWEEN '40' AND '49.99' THEN '03-40 a 49,99'
	WHEN VL_SALDO BETWEEN '50' AND '99.99' THEN '04-50 a 99,99'
	WHEN VL_SALDO BETWEEN '100' AND '149.99' THEN '05-100 a 149,99'
	WHEN VL_SALDO BETWEEN '150' AND '199.99' THEN '06-150 a 199,99'
	WHEN VL_SALDO BETWEEN '200' AND '299.99' THEN '07-200 a 299,99'
	WHEN VL_SALDO BETWEEN '300' AND '399.99' THEN '08-300 a 399,99'
	WHEN VL_SALDO BETWEEN '400' AND '499.99' THEN '09-400 a 499,99'
	WHEN VL_SALDO BETWEEN '500' AND '999.99' THEN '10-500 a 999,99'
	WHEN VL_SALDO BETWEEN '1000' AND '1999.99' THEN '11-1000 a 1999,99'
	WHEN VL_SALDO BETWEEN '2000' AND '2999.99' THEN '12-2000 a 2999,99'
			ELSE '13-Maior que 2999.99' END AS FX_VALOR,

FASE_COB,
count(CONTRATO) as quantidade,
SUM(VL_SALDO) AS SALDO
from ADCOBMIS01..Carteira_Avon
WHERE DATA_BASE BETWEEN @DATAINI AND @DATAFIM
GROUP BY 
DATA_BASE,
CAST(LEFT(RIGHT(CONTRATO,6), 2) AS VARCHAR),
RIGHT(CONTRATO,4),
CASE
WHEN ATRASO <				5			THEN 	't - <5 dias'
WHEN ATRASO BETWEEN	5	 AND	7		THEN 	'a - 5 a 7 dias'
WHEN ATRASO BETWEEN	8	 AND	15		THEN 	'b - 8 a 15 dias'
WHEN ATRASO BETWEEN	16	 AND	30		THEN 	'c - 16 a 30 dias'
WHEN ATRASO BETWEEN	31	 AND	60		THEN 	'd - 31 a 60 dias'
WHEN ATRASO BETWEEN	61	 AND	69		THEN 	'e - 61 a 69 dias'
WHEN ATRASO BETWEEN	70	 AND	90		THEN 	'f - 70 a 90 dias'
WHEN ATRASO BETWEEN	91	 AND	180		THEN 	'g - 91 a 180 dias'
WHEN ATRASO BETWEEN	181	 AND	270		THEN 	'h - 181 a 270 dias'
WHEN ATRASO BETWEEN	271	 AND	360		THEN 	'i - 271 a 360 dias'
WHEN ATRASO BETWEEN	361	 AND	720		THEN 	'j - 361 a 720 dias'
WHEN ATRASO BETWEEN	721	 AND	1080	THEN 	'k - 721 a 1080 dias'
WHEN ATRASO BETWEEN	1081 AND	1440	THEN 	'l - 1081 a 1440 dias'
WHEN ATRASO BETWEEN	1441 AND	1800	THEN 	'm - 1441 a 1800 dias'
WHEN ATRASO BETWEEN	1801 AND	2160	THEN 	'n - 1801 a 2160 dias'
WHEN ATRASO BETWEEN	2161 AND	2520	THEN 	'o - 2161 a 2520 dias'
WHEN ATRASO BETWEEN	2521 AND	2880	THEN 	'p - 2521 a 2880 dias'
WHEN ATRASO BETWEEN	2881 AND	3240	THEN 	'q - 2881 a 3240 dias'
WHEN ATRASO BETWEEN	3241 AND	3600	THEN 	'r - 3241 a 3600 dias'
WHEN ATRASO					   >3600	THEN 	's - Acima 3600 dias' END,
CASE 
WHEN ATRASO < 5 THEN 't - Menor 5'
WHEN ATRASO BETWEEN 5 AND 7 THEN 'a - 5 a 7'
WHEN ATRASO BETWEEN 8 AND 30 THEN 'b - 8 a 30'
WHEN ATRASO BETWEEN 31 AND 60 THEN 'c - 31 a 60'
WHEN ATRASO BETWEEN 61 AND 90 THEN 'd - 61 a 90'
WHEN ATRASO > 90 THEN 'e - Maior 90' END,
CASE 
WHEN ATRASO < 8 THEN '08<'
WHEN ATRASO BETWEEN 8 AND 30 THEN '08 a 30'
WHEN ATRASO BETWEEN 31 AND 60 THEN '31 a 60'
WHEN ATRASO BETWEEN 61 AND 90 THEN '61 a 90'
WHEN ATRASO > 90 THEN '90<' END,
FASE_COB,
   CASE
 WHEN CAMPANHA =  	1	 THEN 	'A - 1'
 WHEN CAMPANHA =  	2	 THEN 	'B - 2'
 WHEN CAMPANHA =  	3	 THEN 	'C - 3'
 WHEN CAMPANHA =  	4	 THEN 	'D - 4'
 WHEN CAMPANHA =  	5	 THEN 	'E - 5'
 WHEN CAMPANHA =  	6	 THEN 	'F - 6'
 WHEN CAMPANHA =  	7	 THEN 	'G - 7'
 WHEN CAMPANHA =  	8	 THEN 	'H - 8'
 WHEN CAMPANHA =  	9	 THEN 	'I - 9'
 WHEN CAMPANHA =  	10	 THEN 	'J - 10'
 WHEN CAMPANHA =  	11	 THEN 	'K - 11'
 WHEN CAMPANHA =  	12	 THEN 	'L -12'
 WHEN CAMPANHA =  	15	 THEN 	'M - 15'
 WHEN CAMPANHA =  	16	 THEN 	'O - 16'
 WHEN CAMPANHA =  	17	 THEN 	'P - 17'
 WHEN CAMPANHA =  	18	 THEN 	'Q - 18'
 WHEN CAMPANHA =  	19	 THEN 	'R - 19'
 WHEN CAMPANHA =  	20	 THEN 	'S - 20'
 WHEN CAMPANHA =  	21	 THEN 	'T - 21'
 WHEN CAMPANHA =  	22	 THEN 	'U - 22'
 WHEN CAMPANHA =  	23	 THEN 	'V - 23'
 WHEN CAMPANHA =  	24	 THEN 	'X - 24'
 WHEN CAMPANHA =  	25	 THEN 	'Y - 25'
 WHEN CAMPANHA =  	26	 THEN 	'Z - 26'
 END,
 CASE 
	WHEN VL_SALDO < '30' THEN '01-Menor que 30'
	WHEN VL_SALDO BETWEEN '30' AND '39.99' THEN '02-30 a 39,99'
	WHEN VL_SALDO BETWEEN '40' AND '49.99' THEN '03-40 a 49,99'
	WHEN VL_SALDO BETWEEN '50' AND '99.99' THEN '04-50 a 99,99'
	WHEN VL_SALDO BETWEEN '100' AND '149.99' THEN '05-100 a 149,99'
	WHEN VL_SALDO BETWEEN '150' AND '199.99' THEN '06-150 a 199,99'
	WHEN VL_SALDO BETWEEN '200' AND '299.99' THEN '07-200 a 299,99'
	WHEN VL_SALDO BETWEEN '300' AND '399.99' THEN '08-300 a 399,99'
	WHEN VL_SALDO BETWEEN '400' AND '499.99' THEN '09-400 a 499,99'
	WHEN VL_SALDO BETWEEN '500' AND '999.99' THEN '10-500 a 999,99'
	WHEN VL_SALDO BETWEEN '1000' AND '1999.99' THEN '11-1000 a 1999,99'
	WHEN VL_SALDO BETWEEN '2000' AND '2999.99' THEN '12-2000 a 2999,99'
			ELSE '13-Maior que 2999.99' END

