IF OBJECT_ID ('TEMPDB..##BASEX1') IS NOT NULL DROP TABLE ##BASEX1

SELECT 
CONVERT(DATE, GETDATE(), 103) AS DATA_BASE,
T.CONTRATO_TIT AS CONTRATO,
VTP.VALOR_TOTAL AS SALDO,
T.PLANO_TIT AS PARCELA,
CONVERT(DATE, VTP.MAIOR_VENCIMENTO, 103) AS VENCIMENTO,
T.VALOR_INICIAL_TIT AS PARCELA_ORIGINAL,
CASE 
	WHEN DATEDIFF(DAY, MAX(PARC.VCTO_PARC),GETDATE()) < =0 THEN 0 ELSE DATEDIFF(DAY, MAX(PARC.VCTO_PARC),GETDATE()) END AS ATRASO_SISTEMA,
CASE 
	WHEN DATEDIFF(DAY, MAX(PARC.VCTO_PARC),GETDATE()) < 0 THEN '� VENCER' ELSE 'VENCIDO' END AS DEPARA_ATRASO,
DATEDIFF(DAY, MAX(PARC.VCTO_PARC),GETDATE()) AS ATRASO_VENCIMENTO,

CONVERT(DATE, T.DT_EXPIR_TIT, 103) AS DATA_EXPIRACAO,
CONVERT(DATE, U.DATA_CAD_TIT, 103) AS DATA_CADASTRO,
--RECEB.DT_PGTO_REC AS DATA_PAGTO,
--RECEB.PRESTACAO_FIN_REC,
--CASE
--	WHEN RECEB.PRESTACAO_FIN_REC =1  THEN  MAX(RECEB.DT_PGTO_REC) ELSE RECEB.DT_PGTO_REC END AS DATA_PAGTO,
--SUM(RECEB.VALOR_TOTAL_REC) AS VALOR_TOTAL_PAGTO,
AU.NOME_CEDENTE AS CEDENTE,
T.COD_TIT

INTO ##BASEX1
FROM       [VCOM].[LOCALCRED_Cobsystems].DBO.TITULOS T WITH (NOLOCK)
INNER JOIN [VCOM].[LOCALCRED_Cobsystems].DBO.V_TITULOS_PARC VTP ON T.COD_TIT = VTP.COD_TIT  AND T.COD_CRED = VTP.COD_CRED
INNER JOIN [VCOM].[LOCALCRED_Cobsystems].DBO.CREDORES C ON T.COD_CRED = C.COD_CRED 
INNER JOIN [VCOM].[LOCALCRED_Cobsystems].DBO.ULT_OCOR_TIT U ON  U.COD_TIT = T.COD_TIT 
INNER JOIN [VCOM].[LOCALCRED_Cobsystems].DBO.AUX_CREDZ AU ON AU.ID_CLIENTE = T.CONTRATO_TIT
INNER JOIN [VCOM].[LOCALCRED_Cobsystems].DBO.PARCELAS PARC  ON T.COD_TIT = PARC.COD_TIT
--LEFT JOIN RECEBIMENTOS RECEB ON RECEB.COD_TIT = T.COD_TIT
WHERE
U.ESTAGIO_TIT <> 7 
AND T.COD_CRED = 9 

--AND T.CONTRATO_TIT = 0004329580000504008
AND PARC.PARCELADO_PARC = 0
AND PARC.NUMERO_PARC = 1

GROUP BY 

T.CONTRATO_TIT,
VTP.VALOR_TOTAL,		
T.PLANO_TIT,
CONVERT(DATE, VTP.MAIOR_VENCIMENTO, 103),
T.VALOR_INICIAL_TIT,
CONVERT(DATE, T.DT_EXPIR_TIT, 103),
CONVERT(DATE, U.DATA_CAD_TIT, 103),
AU.NOME_CEDENTE,
T.COD_TIT
ORDER BY T.CONTRATO_TIT ASC

IF OBJECT_ID ('TEMPDB..##BASEX2') IS NOT NULL DROP TABLE ##BASEX2

SELECT *, 
CASE CEDENTE WHEN 'CREDZ' THEN
CASE 
WHEN ATRASO_SISTEMA < 0					THEN 'faixa 00 -  a vencer'
										WHEN ATRASO_SISTEMA BETWEEN 0 AND 120	THEN 'faixa 07 - 78 a 120'
										WHEN ATRASO_SISTEMA BETWEEN 121 AND 150 THEN 'faixa 08 - 121 a 150'
										WHEN ATRASO_SISTEMA BETWEEN 151 AND 180 THEN 'faixa 09 - 151 a 180'
										WHEN ATRASO_SISTEMA BETWEEN 181 AND 360 THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO_SISTEMA BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO_SISTEMA > 720				THEN 'faixa 12 - 721 a 9999999'
	 ELSE 'faixa 00 -  a vencer'
	 END
WHEN 'TRAVESSIA' THEN
CASE 
										WHEN ATRASO_SISTEMA BETWEEN 0 AND 360	THEN 'faixa 10 - 181 a 360'
										WHEN ATRASO_SISTEMA BETWEEN 361 AND 720 THEN 'faixa 11 - 361 a 720'
										WHEN ATRASO_SISTEMA > 720 THEN 'faixa 12 - 721 a 9999999' 
	 ELSE 'faixa 00 -  a vencer'
	 END END AS FX_ATRASO
	INTO ##BASEX2
FROM ##BASEX1


IF OBJECT_ID ('TEMPDB..##BASEX3') IS NOT NULL DROP TABLE ##BASEX3
SELECT 
CONVERT(VARCHAR,DATA_BASE) AS DATA_BASE,
CONVERT(VARCHAR,CONTRATO) AS CONTRATO,
CONVERT(VARCHAR,SALDO) AS SALDO,
CONVERT(VARCHAR,PARCELA) AS PARCELA,
CONVERT(VARCHAR,VENCIMENTO) AS VENCIMENTO,
CONVERT(VARCHAR,PARCELA_ORIGINAL) AS PARCELA_ORIGINAL,
CONVERT(VARCHAR,ATRASO_SISTEMA) AS ATRASO_SISTEMA,
CONVERT(VARCHAR,DEPARA_ATRASO) AS DEPARA_ATRASO,
CONVERT(VARCHAR,ATRASO_VENCIMENTO) AS ATRASO_VENCIMENTO,
CONVERT(VARCHAR,DATA_EXPIRACAO) AS DATA_EXPIRACAO,
CONVERT(VARCHAR,DATA_CADASTRO) AS DATA_CADASTRO,
CONVERT(VARCHAR,CEDENTE) AS CEDENTE,
CONVERT(VARCHAR,COD_TIT) AS COD_TIT,
CONVERT(VARCHAR,FX_ATRASO) AS FX_ATRASO
 INTO ##BASEX3
FROM ##BASEX2


SELECT * FROM ##BASEX3


INSERT INTO ##BASEX3
 
SELECT 'DATA_BASE'	AS	DATA_BASE,
'CONTRATO'	AS	CONTRATO,
'SALDO'	AS	SALDO,
 'PARCELA'	AS	PARCELA,
'VENCIMENTO'	AS	VENCIMENTO,
'PARCELA_ORIGINAL'	AS	PARCELA_ORIGINAL,
'ATRASO_SISTEMA'	AS	ATRASO_SISTEMA,
'DEPARA_ATRASO'	AS	DEPARA_ATRASO,
'ATRASO_VENCIMENTO'	AS	ATRASO_VENCIMENTO,
'DATA_EXPIRACAO'	AS	DATA_EXPIRACAO,
'DATA_CADASTRO'	AS	DATA_CADASTRO,
'CEDENTE'	AS	CEDENTE,
'COD_TIT'	AS	COD_TIT,
'FX_ATRASO'	AS	FX_ATRASO




/*==========================================EXPORTA_ARQUIVOS==============================================================*/
DECLARE @BCPSQL_SMS VARCHAR(2000),
@BCPFILENAME_SMS VARCHAR(200)
SET @BCPFILENAME_SMS = '\\10.155.4.51\itf_in\FOTOGRAFIAS\CREDZ_NOVO\Estratificacao_Credz'+'_'+REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')+'.csv'
SET @BCPSQL_SMS = 'SELECT * FROM ##BASEX3 ORDER BY 1 DESC'
SET @BCPSQL_SMS = 'BCP "' + @BCPSQL_SMS + '" QUERYOUT ' + @BCPFILENAME_SMS + ' -c -t; -r\n -CP850 -T -Slocalhost'
PRINT @BCPSQL_SMS 
 
DECLARE @RC_SMS VARCHAR(100)
EXEC @RC_SMS = MASTER..XP_CMDSHELL @BCPSQL_SMS
 