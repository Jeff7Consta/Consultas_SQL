IF OBJECT_ID('tempdb..##BASE_TALK') IS NOT NULL DROP TABLE ##BASE_TALK


--DECLARE @DATA DATE
--DECLARE @FASE INT
--DECLARE @FAIXA_ATRASO_A INT
--DECLARE @FAIXA_ATRASO_B INT
--DECLARE @FAIXA_VALOR float
--DECLARE @TIPO_TELEFONES	INT
--DECLARE @VENCIMENTO DATE


--SET @FASE = 506
--SET @FAIXA_ATRASO_A = 720
--SET @FAIXA_ATRASO_B = 1080
--SET @FAIXA_VALOR = 150
--SET @TIPO_TELEFONES	= 2
--SET @VENCIMENTO = '20201009'

--	Fase 2;
--	Faixa de atraso: 90-360;
--	Faixa de valor: >100;
--	Melhor telefone (1);
--	Sem acordos;

SET LANGUAGE 'BRAZILIAN'

SELECT DISTINCT
LEFT(RIGHT(A.CONTRATO,6),2) AS CAMPANHA1,
A.RA AS CODIGO_CLIENTE,
1 AS TELEFONE_TIPO,
B.DDD AS DDD, 
B.NUMERO AS TELEFONE,
'' AS RAMAL_AGENDAMENTO,
'' AS DATA_AGENDAMENTO,
RTRIM(LTRIM(LEFT(RTRIM(LTRIM(LEFT(A.NOME,CHARINDEX(' ',A.NOME)))),12))) AS CLIENTE_NOME,
A.CPF AS CPF,
--RTRIM(REPLICATE('0', 11 - LEN(CAST(A.CPF AS varchar))) + CAST(A.CPF AS varchar)) AS CPF,
LEFT(RIGHT(A.CONTRATO,6),2) AS CAMPANHA2,
REPLACE(CONVERT(DATE, A.DT_VENCIMENTO, 103), '-','') AS DATA_VENCIMENTO, 
REPLACE(MAX(A.VL_SALDO),',','.') AS VALOR_ATUALIZADO, 
REPLACE(CONVERT(dATE, GETDATE()+3, 103),'-','') AS DATA_PAGAMENTO,
'' AS CODIGO
INTO ##BASE_TALK
FROM LOCALCOB_DW..CARTEIRA_AVON_V3 A
INNER JOIN ADCOBMIS01..AVON_ESCORAGEM_TELEFONES B ON A.RA = B.RA


INNER JOIN ADCOBMIS01..CALENDARIO_TALK_ROBO C ON 

C.[DATA] = CONVERT(DATE, GETDATE(), 103) 
AND A.IMPORT_cob = C.FASE  
AND A.ATRASO BETWEEN C.FAIXA_ATR1 AND C.FAIXA_ATR2 
AND A.VL_SALDO >= C.FAX_VALOR 
AND B.PRIORIDADE = C.MELHOR_TEL 
AND A.ACORDO_ATIVO = C.ACORDO 
AND C.STATUS_CAMPANHA = 1

WHERE A.DATA_BASE = CONVERT(DATE, GETDATE(), 103)
--AND A.IMPORT_cob = 506
--AND A.ACORDO_ATIVO = 'NÃO'
--AND A.ATRASO BETWEEN 720 AND 1080
--AND A.VL_SALDO > = 150
AND LEN(B.NUMERO) = 9
--AND B.PRIORIDADE IN (2)
AND A.CONT_CONTRATOS = 1

GROUP BY

LEFT(RIGHT(A.CONTRATO,6),2),
A.RA,
B.DDD, 
B.NUMERO ,

RTRIM(LTRIM(LEFT(RTRIM(LTRIM(LEFT(A.NOME,CHARINDEX(' ',A.NOME)))),12))),
A.CPF,
LEFT(RIGHT(A.CONTRATO,6),2) ,
REPLACE(CONVERT(DATE, A.DT_VENCIMENTO, 103), '-','')


DECLARE @BCPSQL_TALK		VARCHAR(2000),
		@BCPFILENAME_TALK	VARCHAR(200)
SET		@BCPFILENAME_TALK = '\\10.155.4.51\itf_in\AVON\BASE_TALK\BASE_TALK_F2'+'_'+REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')+'.csv'
SET		@BCPSQL_TALK =		'SELECT * FROM ##BASE_TALK'
SET		@BCPSQL_TALK =		'BCP "' + @BCPSQL_TALK + '" QUERYOUT ' + @BCPFILENAME_TALK + ' -c -t; -r\n -CP850 -T -Slocalhost'
PRINT	@BCPSQL_TALK
DECLARE @RC_TALK VARCHAR(100)
EXEC	@RC_TALK = MASTER..XP_CMDSHELL @BCPSQL_TALK

