IF OBJECT_ID('tempdb..##LOGINS_TELE_PBI') IS NOT NULL DROP TABLE ##LOGINS_TELE_PBI

SELECT 

DATEPART(WEEKDAY,DATA)													AS COD
,MONTH(DATA)															AS MÊS
,DATA
,CARTEIRA
,UPPER(OPERADOR) AS OPERADOR
,QTD_LOGS
,[LOGIN]
,LOGOFF
,LOGADO
,TOTAL_PAUSAS 
,(LOGADO - TOTAL_PAUSAS)												AS PRODUTIVO
,(QTD_CHAMADAS_ATIVO + QTD_CHAMADAS_RECEPTIVO + QTD_CHAMADAS_MANUAL)	AS QTD_CHAMADAS_TOTAL
,(TEMPO_FALADO_ATIVO + TEMPO_FALADO_RECEPTIVO + TEMPO_FALADO_MANUAL)	AS TEMPO_FALADO_TOTAL
,(TEMPO_PÓS_ATIVO + TEMPO_PÓS_RECEPTIVO + TEMPO_PÓS_MANUAL)				AS TEMPO_PÓS_TOTAL
,(LOGADO - TOTAL_PAUSAS) - 
((TEMPO_FALADO_ATIVO + TEMPO_FALADO_RECEPTIVO + TEMPO_FALADO_MANUAL)
 +(TEMPO_PÓS_ATIVO + TEMPO_PÓS_RECEPTIVO + TEMPO_PÓS_MANUAL))			AS IDLE
--,((TEMPO_FALADO_ATIVO + TEMPO_FALADO_RECEPTIVO + TEMPO_FALADO_MANUAL)
-- +(TEMPO_PÓS_ATIVO + TEMPO_PÓS_RECEPTIVO + TEMPO_PÓS_MANUAL))
-- /(LOGADO - TOTAL_PAUSAS)												AS OCUPAÇÃO
,TEMPO_FALADO_ATIVO
,TEMPO_FALADO_RECEPTIVO
,TEMPO_FALADO_MANUAL
,TEMPO_PÓS_ATIVO
,TEMPO_PÓS_RECEPTIVO
,TEMPO_PÓS_MANUAL
,QTD_CHAMADAS_ATIVO	
,QTD_CHAMADAS_RECEPTIVO
,QTD_CHAMADAS_MANUAL
	,              LEFT(UPPER((DATENAME(MM,DATA))),3)
	+        RIGHT(CONVERT(VARCHAR,YEAR(DATA)),2) AS Ref
INTO ##LOGINS_TELE_PBI
FROM
(SELECT 

 A.DATA
,A.CARTEIRA
,A.Workgroup_Name
,A.OPERADOR
,A.QTD_LOGS
,A.[LOGIN]
,A.LOGOFF
,A.LOGADO 
,TOTAL_PAUSAS			= CASE WHEN	B.TOTAL_PAUSAS > A.LOGADO		 THEN A.LOGADO	
							   WHEN	B.TOTAL_PAUSAS			 IS NULL THEN '0'		ELSE B.TOTAL_PAUSAS             END
,TEMPO_FALADO_ATIVO		= CASE WHEN C.TEMPO_FALADO_ATIVO	 IS NULL THEN '0'		ELSE C.TEMPO_FALADO_ATIVO		END
,TEMPO_FALADO_RECEPTIVO = CASE WHEN D.TEMPO_FALADO_RECEPTIVO IS NULL THEN '0'		ELSE D.TEMPO_FALADO_RECEPTIVO	END
,TEMPO_FALADO_MANUAL	= CASE WHEN E.TEMPO_ATIVO_MANUAL	 IS NULL THEN '0'		ELSE E.TEMPO_ATIVO_MANUAL		END
,TEMPO_PÓS_ATIVO		= CASE WHEN C.TEMPO_PÓS_ATIVO		 IS NULL THEN '0'		ELSE C.TEMPO_PÓS_ATIVO			END
,TEMPO_PÓS_RECEPTIVO	= CASE WHEN D.TEMPO_PÓS_RECEPTIVO	 IS NULL THEN '0'		ELSE D.TEMPO_PÓS_RECEPTIVO		END
,TEMPO_PÓS_MANUAL		= CASE WHEN E.TEMPO_PÓS_MANUAL		 IS NULL THEN '0'		ELSE E.TEMPO_PÓS_MANUAL			END
,QTD_CHAMADAS_ATIVO		= CASE WHEN C.QTD_CHAMADAS_ATIVO	 IS NULL THEN '0'		ELSE C.QTD_CHAMADAS_ATIVO		END
,QTD_CHAMADAS_RECEPTIVO	= CASE WHEN D.QTD_CHAMADAS_RECEPTIVO IS NULL THEN '0'		ELSE D.QTD_CHAMADAS_RECEPTIVO	END
,QTD_CHAMADAS_MANUAL	= CASE WHEN E.QTD_CHAMADAS_MANUAL    IS NULL THEN '0'		ELSE E.QTD_CHAMADAS_MANUAL		END

FROM
/*Tabela A - LOGIN, LOGOUT e TEMPO LOGADO*/
(SELECT 

 R.DATA
,R.CARTEIRA
,R.OPERADOR
,R.Workgroup_Name
,R.QTD_LOGS
,MIN    (CONVERT(NVARCHAR,R.[LOGIN],108)) AS [LOGIN]
,MAX   (CONVERT(NVARCHAR,R.LOGOFF,108))  AS LOGOFF
,SUM(CAST(DATEDIFF(SECOND,R.[LOGIN],R.LOGOFF) AS FLOAT)/86400) 		AS LOGADO
,R.GRUPO

FROM

(SELECT 

 CONVERT		     (DATE,LoginDt,102)											AS DATA
 ,CARTEIRA = CASE WHEN Workgroup_Name LIKE 'BCO HONDA LOSS'						THEN 'HONDA_LOSS'	
				  WHEN Workgroup_Name LIKE 'BCO HONDA%'							THEN 'HONDA_FASE 1'					  
				  WHEN Workgroup_Name LIKE 'HONDA CONSORCIO FASE 1'				THEN 'MAPFRE_FASE 1'
				  WHEN Workgroup_Name LIKE 'HONDA CONSORCIO LOSS'				THEN 'MAPFRE_LOSS'	  
				  WHEN Workgroup_Name LIKE '%SAFRA LEVES%'						THEN 'SAFRA_LEVES'
				  WHEN Workgroup_Name LIKE 'SAFRA_CONSIG%'						THEN 'SAFRA_CONSIG'
				  WHEN Workgroup_Name LIKE 'SOMOS_EDUACACAO%'					THEN 'SOMOS EDUCAÇÃO'
				  WHEN Workgroup_Name LIKE 'IDEAL%'								THEN 'IDEAL' 				  
				  WHEN Workgroup_Name LIKE 'VOLKS_PF%'							THEN 'VOLKS_PF'
				  WHEN Workgroup_Name LIKE 'VOLKS PJ%'							THEN 'VOLKS_PJ'
				  WHEN Workgroup_Name LIKE 'RODOBENS%'							THEN 'RODOBENS'
				  WHEN Workgroup_Name LIKE 'UNINTER%'							THEN 'UNINTER'
				  WHEN Workgroup_Name LIKE 'BMW%'								THEN 'BMW'
				  
				  WHEN Workgroup_Name LIKE 'BRADESCO FASE 2%'					THEN 'BRAD_ADM'
				  WHEN Workgroup_Name LIKE 'BRADESCO FASE 1%'					THEN 'BRAD_TELE'
				  WHEN Workgroup_Name LIKE 'BRADESCO FASE 3%'					THEN 'BRAD_JUR'
				  WHEN Workgroup_Name LIKE 'BRADESCO_FASE_3%'					THEN 'BRAD_JUR'
				  WHEN Workgroup_Name LIKE 'BRADESCO LP%'						THEN 'BRAD_LP'
				  WHEN Workgroup_Name LIKE 'EAVM%'                              THEN 'BRADESCO EAVM'  
				  WHEN Workgroup_Name LIKE 'BRADESCO_TELE%'                     THEN 'BRAD_TELE'
                  WHEN Workgroup_Name LIKE 'BRADESCO_ADM%'                      THEN 'BRAD_ADM'
                  WHEN Workgroup_Name LIKE 'CMI%'                               THEN 'BRAD_ADM'
                  WHEN Workgroup_Name LIKE 'BRADESCO_LP%'                       THEN 'BRAD_LP'
                  WHEN Workgroup_Name LIKE 'BRADESCO CMI%'                      THEN 'BRAD_ADM'
				  
				  WHEN Workgroup_Name LIKE 'KROTON%'						    THEN 'KROTON' 
				  WHEN Workgroup_Name LIKE 'PANAMERICANO%'						THEN 'PAN'  
				  WHEN Workgroup_Name LIKE 'GERDAU%'						    THEN 'GERDAU'
				 
				  WHEN Workgroup_Name LIKE 'UNIASSELVI%'                        THEN 'UNIASSELVI' 
				  WHEN Workgroup_Name LIKE 'ITAPEVA_BBF%'                       THEN 'ITAPEVA BBF'
  				  WHEN Workgroup_Name LIKE 'ITAPEVA%'                           THEN 'ITAPEVA'
				  WHEN Workgroup_Name LIKE 'CAIXA%'                           	THEN 'CAIXA'
                  WHEN Workgroup_Name LIKE 'HONDA CONSORCIO QP%'                THEN 'MAPFRE_LOSS'                                                        
                  WHEN Workgroup_Name LIKE 'HONDA CONSORCIO%'                   THEN 'MAPFRE_FASE 1'
                  WHEN Workgroup_Name LIKE 'PERNAMBUCANAS%'						THEN 'PERNAMBUCANAS'
                  WHEN Workgroup_Name LIKE 'PERNAM%'                            THEN 'PERNAMBUCANAS PDD' 
                  WHEN Workgroup_Name LIKE 'EDITORA_ABRIL_COB%'                 THEN 'EDITORA ABRIL COBRANÇA'
                  WHEN Workgroup_Name LIKE 'EDITORA_ABRIL%'                     THEN 'EDITORA ABRIL'
                  
                  WHEN Workgroup_Name LIKE 'VAI_CAR%'                           THEN 'VAICAR'
                  WHEN Workgroup_Name LIKE 'UOL%'                               THEN 'UOL'
                  WHEN Workgroup_Name LIKE 'BANCO_INTER%'                       THEN 'BANCO INTER'
                  WHEN Workgroup_Name LIKE 'GM%'                                THEN 'GM'
                  WHEN Workgroup_Name LIKE 'CREDZ%'                             THEN 'CREDZ'
                  WHEN Workgroup_Name LIKE 'VOLKS_PRE%'                         THEN 'VOLKSWAGEN PRE JURIDICO'
                  
                  WHEN Workgroup_Name LIKE 'PORTOCRED%'                         THEN 'PORTOCRED'
                  WHEN Workgroup_Name LIKE 'GPA%'                               THEN 'GPA'
                  WHEN Workgroup_Name LIKE 'ITPV%'                              THEN 'ITAPEVA AUTOS'
                  WHEN Workgroup_Name LIKE 'RSM%'                               THEN 'RSM'
                  
 	  
				                        										END  
 ,					    UPPER(a.[User_Id])									AS OPERADOR
 ,Workgroup_Name		
 ,COUNT	    			  (LoginDt)									AS QTD_LOGS
 ,MIN    (LoginDt) AS [LOGIN]
 ,MAX    (LogoutDt)						    AS LOGOFF
 --,SUM(CAST(DATEDIFF(SECOND,LoginDt,LogoutDt) AS FLOAT)/86400) 		AS LOGADO
 ,Workgroup_Name													AS GRUPO

FROM

	 [detail_epro].[dbo].[AgentLoginLogout] (NOLOCK) A
JOIN [config_epro].[dbo].[Agent]			(NOLOCK) B ON A.[User_Id]	 = B.[User_Id]
JOIN [config_epro].[dbo].[Workgroup]		(NOLOCK) C ON B.Workgroup_Id = C.Workgroup_Id

WHERE
CONVERT(DATE,LoginDt,102)= CONVERT(DATE,GETDATE(),102)
AND	       a.Service_Id		  =  '0'

GROUP BY

 CONVERT(DATE,LoginDt,102)
 ,		   a.[User_Id]
 ,			  Workgroup_Name
)R

GROUP BY

 R.DATA
,R.CARTEIRA
,R.OPERADOR
,R.Workgroup_Name
,R.QTD_LOGS
,R.[LOGIN]
,R.LOGOFF
,R.GRUPO
 )A

 
LEFT JOIN

/*TABELA DE PAUSAS*/
(SELECT

 CONVERT(DATE,NotReadyStartDt,102) AS DATA 
 ,Workgroup_Name AS CARTEIRA
 ,UPPER(a.User_Id) AS OPERADORES
 ,COUNT(NotReadyStartDt) AS QTD_PAUSAS
 ,SUM (CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400) AS TOTAL_PAUSAS
 ,SUM (CASE WHEN ReasonId IN ('101') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS SISTEMA
 ,SUM (CASE WHEN ReasonId IN ('102') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS PESSOAL
 ,SUM (CASE WHEN ReasonId IN ('103') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS LANCHE
 ,SUM (CASE WHEN ReasonId IN ('104') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS DESCANSO
 ,SUM (CASE WHEN ReasonId IN ('106') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS TREINAMENTO
 ,SUM (CASE WHEN ReasonId IN ('107') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS REUNIAO
 ,SUM (CASE WHEN ReasonId IN ('108') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS OUTRA_ATIVIDADE
 ,SUM (CASE WHEN ReasonId IN ('109') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS AMBULATORIO
 ,SUM (CASE WHEN ReasonId IN ('110') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS LIGACAO_ATIVA
 ,SUM (CASE WHEN ReasonId IN ('111') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS FEEDBACK
 ,SUM (CASE WHEN ReasonId IN ('105') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS FIM_DE_TURNO
 ,SUM (CASE WHEN ReasonId IN ('143') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS ALMOCO
 ,SUM (CASE WHEN ReasonId IN ('146') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS INFORMADA
 ,SUM (CASE WHEN ReasonId IN ('147') THEN CAST(DATEDIFF(SECOND,NotReadyStartDt,NotReadyEndDt) AS FLOAT)/86400 END) AS ESTACIONADO

FROM

	 [detail_epro].[dbo].[AgentNotReadyDetail]  (NOLOCK) A
JOIN [config_epro].[dbo].[Agent]				(NOLOCK) B on a.User_Id      = B.User_Id
JOIN [config_epro].[dbo].[Workgroup]			(NOLOCK) C on b.Workgroup_Id = C.Workgroup_Id

WHERE
CONVERT(DATE,NotReadyStartDt,102)= CONVERT(DATE,GETDATE(),102)
AND ReasonId > 1

GROUP BY

 CONVERT(DATE,NotReadyStartDt,102)
 ,a.User_Id
 ,Workgroup_Name
 )B
 
 ON  A.OPERADOR = B.OPERADORES
 AND A.DATA     = B.DATA
 
LEFT JOIN

/*TABELA DE CHAMADAS, TALK E UPDATE DO ATIVO*/

(SELECT

 CONVERT(DATE,CallStartDt,102) AS DATA
 ,Workgroup_Name AS CARTEIRA
 ,UPPER(a.User_Id) as OPERADORES
 ,SUM(CAST(DATEDIFF(SECOND,AnswerDt,ConnClearDt) AS FLOAT)/86400) AS TEMPO_FALADO_ATIVO
 ,SUM(CAST(DATEDIFF(SECOND,ConnClearDt,WrapEndDt) AS FLOAT)/86400) AS TEMPO_PÓS_ATIVO
 ,COUNT(a.User_Id) AS QTD_CHAMADAS_ATIVO

From

	 [detail_epro].[dbo].[AODCallDetail]	(NOLOCK) A
JOIN [config_epro].[dbo].[Agent]			(NOLOCK) B on A.User_Id			= B.User_Id
JOIN [config_epro].[dbo].[Workgroup]		(NOLOCK) C on B.Workgroup_Id	= C.Workgroup_Id

WHERE
CONVERT(DATE,CallStartDt,102)= CONVERT(DATE,GETDATE(),102)

GROUP BY

CONVERT(DATE,CallStartDt,102)
,a.User_Id
,Workgroup_Name
)C


 ON  A.OPERADOR = C.OPERADORES
 AND A.DATA     = C.DATA
 
LEFT JOIN

/*TABELA DE CHAMADAS, TALK E UPDATE DO RECEPTIVO*/
(SELECT

 CONVERT(DATE,CallStartDt,102)										AS DATA
 ,Workgroup_Name													AS CARTEIRA
 ,UPPER(a.User_Id)															AS OPERADORES
 ,SUM(CAST(DATEDIFF(SECOND,QueueEndDt,ConnClearDt) AS FLOAT)/86400) AS TEMPO_FALADO_RECEPTIVO
 ,SUM(CAST(DATEDIFF(SECOND,ConnClearDt,WrapEndDt) AS FLOAT)/86400)  AS TEMPO_PÓS_RECEPTIVO
 ,COUNT(a.User_Id)												    AS QTD_CHAMADAS_RECEPTIVO

FROM

	 [detail_epro].[dbo].[ACDCallDetail] (NOLOCK) A
JOIN [config_epro].[dbo].[Agent]		 (NOLOCK) B on A.User_Id		= B.User_Id
JOIN [config_epro].[dbo].[Workgroup]	 (NOLOCK) C on B.Workgroup_Id	= C.Workgroup_Id

WHERE
CONVERT(DATE,CallStartDt,102)= CONVERT(DATE,GETDATE(),102)

GROUP BY

CONVERT(DATE,CallStartDt,102)
,a.User_Id
,Workgroup_Name
)D

 ON  A.OPERADOR = D.OPERADORES
 AND A.DATA     = D.DATA

LEFT JOIN

/*TABELA DE CHAMADAS, TALK E UPDATE DO MANUAL*/
(SELECT

 CONVERT(DATE,CallStartDt,102)												 AS DATA
 ,Workgroup_Name															 AS CARTEIRA
 ,UPPER(a.User_Id)																	 AS OPERADORES
 ,SUM(CAST(DATEDIFF(SECOND,ConnectDt,ConnClearDt) AS FLOAT)/86400)			 AS TEMPO_ATIVO_MANUAL
 ,SUM(CAST(DATEDIFF(SECOND,ConnClearDt,FirstPartyWrapEndDt) AS FLOAT)/86400) AS TEMPO_PÓS_MANUAL
 ,COUNT(a.User_Id)														     AS QTD_CHAMADAS_MANUAL

FROM

	 [detail_epro].[dbo].[ManualCallDetail] A
JOIN [config_epro].[dbo].[Agent]			B ON A.User_Id		= B.User_Id
JOIN [config_epro].[dbo].[Workgroup]		C ON B.Workgroup_Id = C.Workgroup_Id

WHERE
CONVERT(DATE,CallStartDt,102) = CONVERT(DATE,GETDATE(),102)

GROUP BY

CONVERT(DATE,CallStartDt,102)
,a.User_Id
,Workgroup_Name
)E

  ON  A.OPERADOR = E.OPERADORES
  AND A.DATA     = E.DATA
)TELEMTRIA

ORDER BY 2


/*=================EXPORTA ARQUIVO============================*/

DECLARE @BCPSQL_ALM2		VARCHAR(2000),
		@BCPFILENAME_ALM2	VARCHAR(200)
SET		@BCPFILENAME_ALM2 = '\\10.155.4.51\itf_in\MIS\DADOS_LOGIN_PBI\LOGINS_TELEMETRIA_PBI'+'_'+REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')+'.csv'
SET		@BCPSQL_ALM2 =		'SELECT * FROM ##LOGINS_TELE_PBI'
SET		@BCPSQL_ALM2 =		'BCP "' + @BCPSQL_ALM2 + '" QUERYOUT ' + @BCPFILENAME_ALM2 + ' -c -t; -r\n -CP850 -T -Slocalhost'
PRINT	@BCPSQL_ALM2
DECLARE @RC_ALM2 VARCHAR(100)
EXEC	@RC_ALM2 = MASTER..XP_CMDSHELL @BCPSQL_ALM2