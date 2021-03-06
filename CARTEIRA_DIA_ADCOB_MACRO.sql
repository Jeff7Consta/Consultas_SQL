IF OBJECT_ID('tempdb..##ULT') IS NOT NULL DROP TABLE ##ULT
IF OBJECT_ID('tempdb..##CARTEIRAS') IS NOT NULL DROP TABLE ##CARTEIRAS
SELECT MAX(DATA) AS ULT_DAT INTO ##ULT FROM ADCOBMIS01.DBO.FOTOGRAFIA_VCOM

SELECT 
CONVERT(DATE, GETDATE(), 103) AS DATA,
YEAR(GETDATE()) AS ANO,
MONTH(GETDATE()) AS M�S,
CASE		WHEN MONTH(GETDATE()) = 1  THEN 'JANEIRO'
		    WHEN MONTH(GETDATE()) = 2  THEN 'FEVEREIRO'
		    WHEN MONTH(GETDATE()) = 3  THEN 'MAR�O'
		    WHEN MONTH(GETDATE()) = 4  THEN 'ABRIL'
		    WHEN MONTH(GETDATE()) = 5  THEN 'MAIO'
		    WHEN MONTH(GETDATE()) = 6  THEN 'JUNHO'
		    WHEN MONTH(GETDATE()) = 7  THEN 'JULHO'
		    WHEN MONTH(GETDATE()) = 8  THEN 'AGOSTO'
		    WHEN MONTH(GETDATE()) = 9  THEN 'SETEMBRO'
		    WHEN MONTH(GETDATE()) = 10 THEN 'OUTUBRO'
		    WHEN MONTH(GETDATE()) = 11 THEN 'NOVEMBRO'
		    WHEN MONTH(GETDATE()) = 12 THEN 'DEZEMBRO'
		    END AS MES_TEXT, *
INTO ##CARTEIRAS
FROM (
SELECT * FROM (

SELECT
COD_CRED AS CODEMPRESA,
 CASE 
 WHEN COD_CRED = 1  THEN 'GMAC - VE�CULOS LEVES'
 WHEN COD_CRED = 6  THEN 'VAI CAR - LOCACAO DE VEICULOS'
 WHEN COD_CRED = 8  THEN 'UOL - EDTECH'
 WHEN COD_CRED = 9  THEN 'CREDZ - CART�ES'
 WHEN COD_CRED = 11 THEN 'PORTOCRED VAREJO' END AS 'CORTE',

 COUNT(CONTRATO_TIT) AS QUANTIDADE
 
 FROM ADCOBMIS01.DBO.FOTOGRAFIA_VCOM A INNER JOIN ##ULT B ON A.DATA = B.ULT_DAT
 GROUP BY

 COD_CRED,
 CASE 
 WHEN COD_CRED = 1  THEN 'GMAC - VE�CULOS LEVES'
 WHEN COD_CRED = 6  THEN 'VAI CAR - LOCACAO DE VEICULOS'
 WHEN COD_CRED = 8  THEN 'UOL - EDTECH'
 WHEN COD_CRED = 9  THEN 'CREDZ - CART�ES'
 WHEN COD_CRED = 11 THEN 'PORTOCRED VAREJO' END)VCOM

 UNION ALL

 SELECT * FROM (

/*BRADESCO*/
SELECT
A.CODEMPRESA,
CASE WHEN CODEMPRESA = 5001 THEN (
CASE				WHEN FASCOBRDIV = 13 AND PARCELA IN ('1','2','3')            THEN 'BRADESCO FIN - FASE 1'
					WHEN FASCOBRDIV = 13							             THEN 'BRADESCO FIN - FASE 1'
					WHEN FASCOBRDIV in (1, 2, 3)           and CODINDFIN = 7     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (1,2,3,5,8,9,11,14) and CODINDFIN = 3     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (14)                and CODINDFIN in (4,7)THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (8,9,11)            and CODINDFIN in (7)  THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (10)                and CODINDFIN = 3     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (10)                and CODINDFIN = 7     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					ELSE '' END) END AS CORTE,

COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA IN (5001)
GROUP BY 
A.CODEMPRESA,
CASE WHEN CODEMPRESA = 5001 THEN (
CASE				WHEN FASCOBRDIV = 13 AND PARCELA IN ('1','2','3')            THEN 'BRADESCO FIN - FASE 1'
					WHEN FASCOBRDIV = 13							             THEN 'BRADESCO FIN - FASE 1'
					WHEN FASCOBRDIV in (1, 2, 3)           and CODINDFIN = 7     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (1,2,3,5,8,9,11,14) and CODINDFIN = 3     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (14)                and CODINDFIN in (4,7)THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (8,9,11)            and CODINDFIN in (7)  THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (10)                and CODINDFIN = 3     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					WHEN FASCOBRDIV in (10)                and CODINDFIN = 7     THEN 'BRADESCO FIN - FASE 2, 3 E LP'
					ELSE '' END) END
UNION ALL

/*CAIXA*/
SELECT
A.CODEMPRESA,
'BANCO PAN - CAIXA LICITACOES' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA IN (67001)
GROUP BY 
A.CODEMPRESA

UNION ALL

/*EAVM*/
SELECT
A.CODEMPRESA,
'BRADESCO CARTOES - EAVM' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA IN (25020)
GROUP BY 
A.CODEMPRESA

UNION ALL

/*HONDA*/
SELECT
A.CODEMPRESA,


CASE			 WHEN FAIXAATRASO BETWEEN 0   AND 30     THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 31  AND 180   THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 181 AND 360   THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 361 AND 1440  THEN 'BANCO HONDA - LOSS'
				 ELSE 'BANCO HONDA - LOSS'                           END AS CORTE,



COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA IN (61001)
GROUP BY 
A.CODEMPRESA,
CASE			 WHEN FAIXAATRASO BETWEEN 0   AND 30     THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 31  AND 180   THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 181 AND 360   THEN 'BANCO HONDA - FASE 1'
				 WHEN FAIXAATRASO BETWEEN 361 AND 1440  THEN 'BANCO HONDA - LOSS'
				 ELSE 'BANCO HONDA - LOSS'                           END 

UNION ALL

/*ITAPEVA*/
SELECT
A.CODEMPRESA,
'ITAPEVA' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA IN (71001)
GROUP BY 
A.CODEMPRESA

UNION ALL

/*KROTON*/
SELECT
A.CODEMPRESA,
'KROTON' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '53008' AND '53013'
GROUP BY 
A.CODEMPRESA

UNION ALL

/*MAPFRE - LOSS*/
SELECT
A.CODEMPRESA,
'MAPFRE - LOSS' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '28010' AND '28010'
GROUP BY 
A.CODEMPRESA

UNION ALL

/*BANCO PAN - VEICULOS*/
SELECT
A.CODEMPRESA,
'BANCO PAN - VEICULOS' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '66001' AND '66002'
GROUP BY 
A.CODEMPRESA

UNION ALL

/*SAFRA*/
SELECT
A.CODEMPRESA,
CASE WHEN CODEMPRESA BETWEEN '6001' AND '6003'													THEN 'SAFRA TELECOBRAN�A'
				 WHEN CODEMPRESA =       '6010'                                                 THEN 'SAFRA - CONSIGNADO'
				 ELSE 'SAFRA - CONSIGNADO'                                                                  END AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '6001' AND '6010'
GROUP BY 
A.CODEMPRESA

UNION ALL

/*UNIASSELVI*/
SELECT
A.CODEMPRESA,
'UNIASSELVI' AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '53002' AND '53003'
GROUP BY 
A.CODEMPRESA

UNION ALL

/*VOLKS*/
SELECT
A.CODEMPRESA,
CASE		 WHEN TIPPESSCLI = 'F' THEN 'VOLKSWAGEN - VE�CULOS PF'
			 WHEN TIPPESSCLI = 'J' THEN 'VOLKSWAGEN - VE�CULOS PJ'
			 ELSE 'OUTROS'         END AS CORTE,
COUNT(A.NUMCONTRDIV) AS QUANTIDADE
FROM ADCOBDAT..VW_CARTEIRACOBRANCA A
WHERE A.CODEMPRESA BETWEEN '3001' AND '3003'
GROUP BY 
A.CODEMPRESA,
CASE		 WHEN TIPPESSCLI = 'F' THEN 'VOLKSWAGEN - VE�CULOS PF'
			 WHEN TIPPESSCLI = 'J' THEN 'VOLKSWAGEN - VE�CULOS PJ'
			 ELSE 'OUTROS'         END)ADCOB)TUDO

--INSERT INTO ADCOBMIS01..CARTEIRAS_POWER_BI 
--SELECT * FROM ##CARTEIRAS
