

SELECT
C.DIASATRASO										AS 	'DIAS DE ATRASO NO MOMENTO DA NEGOCIAÇÃO',/*FEITO*/
'ALOC'												AS 	'COD_EMPRESA',							  /*FEITO*/
CONVERT(VARCHAR, MAX(B.[DT-BASE]), 103)				AS 	'DAT_LOTE',							      /*FEITO*/
B.[NUM-CONTA-CARTAO]								AS 	'NUM_CONTA',							  /*FEITO*/
B.[NUM-CONTA-CARTAO]								AS 	'NUM_CARTAO',							  /*FEITO*/
B.[CGC-CPF-PORTADOR]								AS 	'CPF_CNPJ',								  /*FEITO*/
CAST(C.VLRNEGOCIADO AS MONEY)						AS 	'SLD_RENEG',							  /*FEITO*/
LEFT(C.PERCTAXAJUROS,2)								AS 	'TAX_RENEG',								/*FEITO*/
D.VLRDESCONTO										AS 	'VAL_DESC,',								/*FEITO*/
C.PLANOACORDO										AS 	'QTD_PARC',								  /*FEITO*/
CAST(D.VLRACORDO AS MONEY)							AS 	'VAL_PARC',									/*FEITO*/
CONVERT(VARCHAR, A.DATVENCTITBOL,103)				AS 	'DAT_1° VENC',							  /*FEITO*/
'B'													AS 	'FORMA_PAGT',							  /*FEITO*/
CASE
	WHEN NUMPARCACORDO = 1 THEN CAST(D.VLRACORDO AS MONEY) ELSE '' END AS 	'VAL_ENTR',									/*FEITO*/
CASE WHEN C.PLANOACORDO = 1 THEN 'S' ELSE 'N' END	AS 'PAG_A_VISTA',							  /*FEITO*/
D.IDACORDO





FROM ADCOBDAT..FI011 A 
LEFT JOIN ADCOBDAT..LY028 B ON A.NUMCONTRDIV = B.NUMCONTRDIV
LEFT JOIN ADCOBDAT..CO131 C  ON A.NUMCONTRDIV = C.NUMCONTRDIV /* COMPLETA FI011*/
LEFT JOIN ADCOBDAT..CO268 D  WITH (NOLOCK) ON C.IDACORDO = D.IDACORDO AND A.NUMCARTEIRA = D.NUMCARTEIRA /*COMPLETA A FI011 E CO131*/
WHERE A.CODEMPRESA = 25020
AND A.DATPGTOTITBOL IS NOT NULL
AND C.STAACORDO IN ('AP', 'PG')
AND A.STATITBOL = 'A'
AND D.VLRPGTOPARC IS NOT NULL
AND D.DATBXPARC IS NOT NULL
AND A.DATPCTITBOL BETWEEN '2020-06-01' AND '2020-08-10'
GROUP BY

C.DIASATRASO,
A.CODEMPRESA,
B.[NUM-CONTA-CARTAO],
B.[NUM-CONTA-CARTAO],
B.[CGC-CPF-PORTADOR],
C.VLRNEGOCIADO,
C.PERCTAXAJUROS,
D.VLRDESCONTO,
CAST(D.VLRACORDO AS MONEY),
C.PLANOACORDO,
A.VLRTITBOL,
CONVERT(VARCHAR, A.DATVENCTITBOL,103),
CASE
	WHEN NUMPARCACORDO = 2 THEN CAST(D.VLRACORDO AS MONEY) ELSE '' END,
	CASE
	WHEN NUMPARCACORDO = 1 THEN CAST(D.VLRACORDO AS MONEY) ELSE '' END,
CASE
	WHEN C.PLANOACORDO = 1 THEN 'S' 
	ELSE 'N' END,
	D.IDACORDO







	
--SELECT * FROM ADCOBDAT..CO268
----WHERE NUMCONTRDIV = '000374767001133893'
--WHERE IDACORDO = '16028497'

