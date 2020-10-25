DECLARE @DTINI   AS DATE DECLARE @DTFIM   AS DATE
 SET @DTINI = '2020-7-01' SET @DTFIM = '2020-7-2' 
 
DECLARE @ANO VARCHAR (4)
SET @ANO = year(getdate()) SELECT

 A.MES
,A.DATA
,A.HORA
,A.LISTA1
,A.CARTEIRA
,A.SERVIÇO
,A.TENTATIVAS
,A.ATENDIDAS
,A.CPC
,A.CPCPROD
,A.BOL
,A.ALOIMP
,A.ALOPRO
,A.HangUp
,A.FAIXA
,TEMPOS.TMA
,TEMPOS.TMU

FROM
(SELECT 

 MONTH(CallStart)            AS MES
,CONVERT(DATE,CallStart,102) AS DATA
,DATEPART(HOUR,CallStart)    AS HORA
--,MAILINGNAME                    AS LISTA1
,LISTA1 = CASE WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%QUEBRA%'    THEN 'QUEBRA'
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%08A15%'    THEN '08A30' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%16A30%'    THEN '08A30' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%31A60%'    THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%61A69%'    THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%MISC_BTC%'    THEN 'MISC BTC' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%FA1P%'     THEN 'FPD' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%MISC%'     THEN 'MISC'                                
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%PREVENTIVA%'   THEN 'PREVENTIVO' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%AVONFASE1_8A69_BTC%'THEN '31A69'                               
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%05A07%'    THEN '08A30'                                 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%ENTRADA%'    THEN '08A30'      
      WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%ACORDO%'   THEN 'PREVENTIVO'     
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%AGING%'    THEN '08A30'                                                          
               ELSE 
   CASE WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%08A15%'      THEN '08A30'            
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%QUEBRA%'    THEN 'QUEBRA'  
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%16A30%'     THEN '08A30' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%70A90%'     THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%31A60%'     THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%61A69%'     THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%MISC_BTC%'    THEN 'MISC BTC' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%FA1P%'     THEN 'FPD' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%MISC%'     THEN 'MISC'                   
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%PREVENTIVA%'   THEN 'PREVENTIVO' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%AVONFASE1_8A69_BTC%' THEN '31A69'                     
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%05A07%'     THEN '08A30'                                
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%ENTRADA%'    THEN '08A30'     
      WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%ACORDO%'   THEN 'PREVENTIVO'     
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3) LIKE '%AGING%'    THEN '08A30'                                                          
      ELSE SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-3)        END        END --Caso o     Control renomeie a fila errado
,CARTEIRA = CASE WHEN MailingName LIKE 'AVONFASE1_%'     THEN 'AVON FASE 1'
               WHEN MailingName LIKE 'AVON_%' THEN 'AVON FASE 2'
               WHEN CampaignId  = '22'        THEN 'AVON FASE 2'
               WHEN CampaignId  = '21'        THEN 'AVON FASE 2' 
               WHEN CampaignId  = '23'        THEN 'AVON FASE 2'
               WHEN CampaignId  = '13'        THEN 'AVON FASE 1'
               WHEN CampaignId  = '15'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '14'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '29'        THEN 'AVON FASE 1'        
               WHEN CampaignId  = '26'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '9'         THEN 'AVON FASE 1' 
               WHEN CampaignId  = '34'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '35'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '36'        THEN 'AVON FASE 1' 
               WHEN CampaignId  = '5'         THEN 'AVON FASE 2'
               WHEN MailingName LIKE 'AVONEVEDUET%'     THEN 'EVE_DUET'     
               WHEN MailingName LIKE 'AVON%'       THEN 'AVON FASE 2'                           
               ELSE MailingName       END 
,SERVIÇO  = CASE WHEN MailingName LIKE 'AVONFASE1%'  THEN 'AVON FASE 1'
               WHEN MailingName LIKE 'AVON_%'   THEN 'AVON FASE 2'
               WHEN CampaignId  =    '22'    THEN 'AVON FASE 2'
               WHEN CampaignId  =    '21'    THEN 'AVON FASE 2' 
               WHEN CampaignId  =    '23'    THEN 'AVON FASE 2'
               WHEN CampaignId  =    '13'    THEN 'AVON FASE 1'
               WHEN CampaignId  =    '15'    THEN 'AVON FASE 1' 
               WHEN CampaignId  =    '14'    THEN 'AVON FASE 1'           
               WHEN MailingName LIKE 'AVONEVEDUET%'THEN 'EVE_DUET'     
               WHEN MailingName LIKE 'AVON%'   THEN 'AVON FASE 2'        
               WHEN MailingName LIKE '2AVON_%'  THEN 'AVON FASE 2' 
               WHEN MailingName LIKE 'C16_%'   THEN 'AVON FASE 1' 
               WHEN MailingName LIKE 'C17_%'   THEN 'AVON FASE 1'          
               WHEN MailingName LIKE 'C18_%'   THEN 'AVON FASE 1'          
               WHEN MailingName LIKE 'C19_%'   THEN 'AVON FASE 1' 
               WHEN MailingName LIKE 'IVR_%'   THEN 'URA CPC'  
               WHEN MailingName LIKE 'CALL%'   THEN 'URA CPC'
               ELSE MailingName      END  
,COUNT (CASE WHEN (Route LIKE '%PREDITIVO%') THEN DispositionId END)  AS TENTATIVAS
,COUNT  (CASE WHEN (AgentId IS NOT NULL AND AgentId >= '100') THEN DispositionId END) AS ATENDIDAS
,COUNT  (CASE WHEN DispositionId IN ('106','108','109','110','111','112','113',
          '117','118','121','131','133','138','139',
          '143','149','150','151','152','156','158',
          '114','115','140','141','142','166','168',
          '132','134','135','136','137','144','145',
          '146','147','148','153','154','155','157',
          '163','164','165','167','169','179','184',
          '188','189','195','196','207','208','209',
          '210','211','213','216','338','341','342',
          '343','340','336','337','339','355','357',
          '358','359','356','353','354','361')
                    THEN DispositionId END) AS CPC
,COUNT  (CASE WHEN DispositionId IN ('108','109','113','115','117','133',
          '142','143','150','151','152','168',
          '195','196','179','207','208','211',
          '336','337','339','353','354','361','340')
                    THEN DispositionId END) AS CPCPROD  
,COUNT  (CASE WHEN DispositionId IN ('113','150','151','196','195',
          '336','337','353','354')        THEN DispositionId END) AS BOL 
,COUNT  (CASE WHEN DispositionId IN ('100','102','104','119','120',
          '125','126','127','128','129',
          '162','180','181','182','183',
          '332','349','328','329','330')    THEN DispositionId END) AS ALOIMP 
, COUNT  (CASE WHEN (AgentId IS NOT NULL AND AgentId >= '100')     THEN DispositionId END) -
COUNT  (CASE WHEN DispositionId IN ('100','102','104','119','120',
          '125','126','127','128','129',
          '162','180','181','182','183',
          '332','349','328','329','330')           THEN DispositionId END) AS ALOPRO 
,COUNT  (CASE WHEN DispositionId IN ('4')          THEN DispositionId END) AS HangUp
,FAIXA = CASE WHEN MAILINGNAME LIKE '%8A15%'  THEN '08A30'
               WHEN MAILINGNAME LIKE '%16A30%' THEN '08A30'
               WHEN MAILINGNAME LIKE '%31A60%' THEN '31A69'
               WHEN MAILINGNAME LIKE '%61A69%' THEN '31A69'
               WHEN MAILINGNAME LIKE '%MISC%'  THEN 'MISC'
               WHEN MAILINGNAME LIKE '%FA1P%'  THEN 'FPD'
               ELSE MAILINGNAME    END
FROM dbo.CallData

WHERE CONVERT(DATE,CallStart,102) BETWEEN @DTINI AND @DTFIM
AND DispositionId NOT IN ('0','11','12')
AND CampaignId NOT IN ('0','10','11','12','6','17','18','45')
AND Route NOT LIKE ('Manual%')
AND Route NOT LIKE ('TransfAvon%') 
AND MailingName NOT LIKE 'AVONFASE1_TESTE%'
AND MailingName LIKE '%_OLOS_ENVIO_%'
AND MailingName LIKE 'AVONFASE1%'
AND MailingName LIKE ('%'+@ANO+'%')

GROUP BY
 MONTH(CallStart)               
,CONVERT(DATE,CallStart,102)              
,DATEPART(HOUR,CallStart)
,MailingName                
,CampaignId
)A  

LEFT JOIN

(SELECT 

 PREVIA.MES
,PREVIA.DATA
,PREVIA.LISTA1
,SUM(PREVIA.QTD)   AS ACIONADO
,SUM(PREVIA.TALK)  AS TALK2
,SUM(PREVIA.UPDAT) AS UPDAT2 
,SUM(PREVIA.TALK)/SUM(PREVIA.QTD)  AS TMA
,SUM(PREVIA.UPDAT)/SUM(PREVIA.QTD) AS TMU

FROM
(SELECT 

 MONTH(CallStart)                   AS MES
,CONVERT(DATE,CallStart,102)                AS DATA
--,DATEPART(HOUR,CallStart)                 AS HORA
--,MAILINGNAME as LISTA1
,LISTA1 = CASE WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%08A15%'    THEN '08A30' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%16A30%'    THEN '08A30' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%31A60%'    THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%61A69%'    THEN '31A69' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%MISC_BTC%'    THEN 'MISC BTC' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%FA1P%'     THEN 'FPD' 
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%MISC%'     THEN 'MISC'                
               WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%QUEBRA%'    THEN 'QUEBRA'                
      WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%PREVENTIVA%'   THEN 'PREVENTIVO' 
      WHEN SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) LIKE '%AVONFASE1_8A69_BTC%' THEN '8A69'       
               ELSE SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13)        END       
,CampaignId
,COUNT(CampaignId)                   AS QTD
,SUM(CAST(DATEDIFF(SECOND,AgentStart,AgentEnd) AS FLOAT)/86400)        AS TALK
,SUM(CAST(DATEDIFF(SECOND,WrapStart,WrapEnd) AS FLOAT)/86400)        AS UPDAT

FROM dbo.CallData

WHERE CONVERT(DATE,CallStart,102) BETWEEN @DTINI AND @DTFIM

AND DispositionId NOT IN ('0','11','12','4')
AND CampaignId NOT IN ('0','10','11','12','6','17','18','45')
AND Route NOT LIKE ('Manual%')
AND Route NOT LIKE ('TransfAvon%') 
AND MailingName NOT LIKE 'AVONFASE1_TESTE%'
AND AgentId IS NOT NULL
AND AgentStart  <> '1900-01-01 00:00:00.000'
AND AgentEnd    <> '1900-01-01 00:00:00.000'
AND WrapStart   <> '1900-01-01 00:00:00.000'
AND WrapEnd     <> '1900-01-01 00:00:00.000'
AND MailingName LIKE 'AVON%'
AND MailingName LIKE '%_OLOS_ENVIO_%'
AND MailingName LIKE 'AVONFASE1%'
AND  MailingName LIKE ('%'+@ANO+'%')

GROUP BY
MAILINGNAME,
 MONTH(CallStart)                 
,CONVERT(DATE,CallStart,102)                
--,DATEPART(HOUR,CallStart)                 
--,SUBSTRING(MAILINGNAME, 1, CHARINDEX(@ANO, MAILINGNAME )-13) 
,CampaignId
)PREVIA

GROUP BY

 PREVIA.MES
,PREVIA.DATA
,PREVIA.LISTA1
)TEMPOS

ON  A.MES  = TEMPOS.MES
AND A.DATA = TEMPOS.DATA
AND A.LISTA1 = TEMPOS.LISTA1 

WHERE

A.CARTEIRA LIKE '%AVON%'


DECLARE @DTINI1   AS DATE
DECLARE @DTFIM2   AS DATE
DECLARE @ANO2 VARCHAR (4)
SET @ANO2 = year(getdate())
SET @DTINI1 = '2020-7-2' SET @DTFIM2 = '2020-7-2' 

SELECT *
--CampaignId,
--DispositionId,
--CallStart,
--CallEnd,
--PhoneNumber,
--AgentId,
--MailingName,
--PhoneNumberId

FROM [10.155.4.17].[EXPORTDATA].[DBO].[CallData]
WHERE CONVERT(DATE,CallStart,102) BETWEEN @DTINI1 AND @DTFIM2
AND DispositionId NOT IN ('0','11','12','4')
AND CampaignId NOT IN ('0','10','11','12','6','17','18','45')
AND Route NOT LIKE ('Manual%')
AND Route NOT LIKE ('TransfAvon%') 
AND MailingName NOT LIKE 'AVONFASE1_TESTE%'
AND AgentId IS NOT NULL
AND AgentStart  <> '1900-01-01 00:00:00.000'
AND AgentEnd    <> '1900-01-01 00:00:00.000'
AND WrapStart   <> '1900-01-01 00:00:00.000'
AND WrapEnd     <> '1900-01-01 00:00:00.000'
AND MailingName LIKE 'AVON%'
AND MailingName LIKE '%_OLOS_ENVIO_%'
AND MailingName LIKE 'AVONFASE1%'
AND  MailingName LIKE ('%'+@ANO2+'%')
AND DispositionId IN ('113','150','151','196','195',
          '336','337','353','354')