/*===============================================EAVM==========================================================================*/

IF OBJECT_ID('tempdb..##ALM_ARCHIVES') IS NOT NULL DROP TABLE ##ALM_ARCHIVES
USE [meldb]

SELECT *
into ##ALM_ARCHIVES
FROM
(
SELECT 
DATA
,HORA = (HORA - '3') 
,CARTEIRA
,LISTA
,SERVI�O
,COUNT(CASE WHEN FINALIZA��O not in ('RR','NR','NC','TZ','NN') THEN FINALIZA��O END) AS  TENTATIVAS
,COUNT(CASE WHEN (FINALIZA��O LIKE 'C%' OR FINALIZA��O LIKE 'R%') AND FINALIZA��O NOT IN ('CC_NRT') THEN '' END)  AS ATENDIDAS 
,COUNT(CASE WHEN FINALIZA��O in (
'C028','C029','C030','C031','C032','C033','C034','C035',
'C036','C037','C038','C050','C051','C052','C060','C061','C062',
'C063','C064','C065','C066','C070','C071','C072','C073','C074',
'C075','C090','C091','C092','C093','C145','C148','C151','C152',
'C153','C154','C155','C156','C159','C164','C165','C166','C171',
'C172','C174','C178','C179','C180','C181','C182','C183','C185',
'C189','C190','C191','C192','C193','C196','C197','C198','C203',
'C207','C208','C209','C215','C216','C217','C219','C220','C221',
'C222','C223','C225','C226','C227','C228','C229','C230','C233',
'C234','C235','C236','C237','C238','C239','C240','C241','C242',
'C244','C245','C246','C247','C248','C249','C250','C251','C252',
'C253','C254','C258','C259','C260','C261','C262','C263','C275',
'C276','C277','C278','C279','C283','C284','C285','C286','C287',
'C288','C289','C290','C291','C293','C294','C295','C296','C297',
'C298','C299','C300','C301','C302','C303','C304','C305','C306',
'C353','C354','C355','C356','C357','C358','C359','C360','C361',
'C362','C363','C364','C365','C366','C367','C368','C371','C372',
'C373','R001','R002','R003','R004','R005','R006','R007','R009',
'R010','R016','R017','R018','R019','R020','R023','R025','R027',
'R028','R029','R030','R031','R032','R033','R035','R036','R037',
'R039','R040','R041','R043','R044','R045','R046','R047','R048',
'R049','R050','R051','R052','R053','R054','R055','R056','R057',
'R058','R059','R063','R064','R065','R067','R072','R073','R074',
'R075','R076','R077','R078','R079','R080','R081','R082','R083',
'R084','R086','R087','R088','R089','R090','R091','R092','R093',
'R094','R095','R096','R097','R098','R099','R114','R115','R116',
'R117','R118','R119','R120','R121','R122','R123','R125','R126',
'R127','R128','R132','R133','R134','C378','C379','C380','C381',
'C383','C385','C386','C388','C389','C391','C392','C393','C394',
'C395','C397','C398','C399','C401','V002','V003','V006','V008',
'V018','V019','V020','V021','V022','V023','V024','V025','V026',
'V027','V029','V036','V044','V046','V047','V051','C318','C319',
'C320','C321','C322','R102','R103','R104','R105','C416','C417',
'C413','C412','C418','C419','C423','R138','C420','C421','C422'
)THEN FINALIZA��O END) AS  CPCS
,COUNT(CASE WHEN FINALIZA��O in   ('C075','C145','C151','C185',
'C196','C197','C198','C215','C234','C235','C242','C247',
'C262','C263','C283','C284','C285','C372','C373','R002','R003','R007',
'R010','R031','R076','R077','R078','R133','R134','C156','R004','R006')            THEN FINALIZA��O END) AS  PROMESSAS                        
,COUNT(CASE WHEN FINALIZA��O in ('C001','C003','C002','C004','C014','C186','C187')THEN FINALIZA��O END) AS  IMPRODUTIVAS
,COUNT(CASE WHEN OPERADOR is not null AND FINALIZA��O not in ('C001','C003','C002','C004','C014','C186','C187') THEN FINALIZA��O END) AS  PRODUTIVAS
,COUNT(CASE WHEN FINALIZA��O in ('AH','HU')                                       THEN FINALIZA��O END) AS  HUNGUP
,COUNT(CASE WHEN FINALIZA��O in ('DAM')                                           THEN FINALIZA��O END) AS  DAM
,COUNT(CASE WHEN FINALIZA��O in ('3T')                                            THEN FINALIZA��O END) AS [3T]
,COUNT(CASE WHEN FINALIZA��O in ('NA')                                            THEN FINALIZA��O END) AS  NA
,COUNT(CASE WHEN FINALIZA��O in ('NAN')                                           THEN FINALIZA��O END) AS  NAN
,COUNT(CASE WHEN FINALIZA��O in ('NVD')                                           THEN FINALIZA��O END) AS  NVD
,COUNT(CASE WHEN FINALIZA��O in ('BL')                                            THEN FINALIZA��O END) AS  BL
,COUNT(CASE WHEN FINALIZA��O in ('BZ')                                            THEN FINALIZA��O END) AS  BZ
,COUNT(CASE WHEN FINALIZA��O in ('DNR')                                           THEN FINALIZA��O END) AS  DNR
,COUNT(CASE WHEN FINALIZA��O in ('HU')                                            THEN FINALIZA��O END) AS  HU
,COUNT(CASE WHEN FINALIZA��O in ('BN')                                            THEN FINALIZA��O END) AS  BN
,COUNT(CASE WHEN FINALIZA��O in ('AH')                                            THEN FINALIZA��O END) AS  AH
,COUNT(CASE WHEN FINALIZA��O in ('DEFAULT')                                       THEN FINALIZA��O END) AS [DEFAULT]
,COUNT(CASE WHEN FINALIZA��O in ('NON')                                           THEN FINALIZA��O END) AS  NON
,COUNT(CASE WHEN FINALIZA��O in ('CC_NRT')                                        THEN FINALIZA��O END) AS  CC_NRT
,COUNT(CASE WHEN FINALIZA��O in ('AA')                                            THEN FINALIZA��O END) AS  AA
,COUNT(CASE WHEN FINALIZA��O in ('SW_DBS')                                        THEN FINALIZA��O END) AS  SW_DBS
,COUNT(CASE WHEN FINALIZA��O in ('R0')                                            THEN FINALIZA��O END) AS  R0
,COUNT(CASE WHEN FINALIZA��O in ('C001')                                          THEN FINALIZA��O END) AS [N�O ATENDE]
,COUNT(CASE WHEN FINALIZA��O in ('C002')                                          THEN FINALIZA��O END) AS  DESLIGADO
,COUNT(CASE WHEN FINALIZA��O in ('C003')                                          THEN FINALIZA��O END) AS [SEMPRE OCUPADO]
,COUNT(CASE WHEN FINALIZA��O in ('C004')                                          THEN FINALIZA��O END) AS  FAX
,COUNT(CASE WHEN FINALIZA��O in ('C014')                                          THEN FINALIZA��O END) AS [CX. POSTAL]
,COUNT(CASE WHEN FINALIZA��O in ('C186')                                          THEN FINALIZA��O END) AS [MENSAGEM OPERADORA]
,COUNT(CASE WHEN FINALIZA��O in ('C187')                                          THEN FINALIZA��O END) AS  MUDO
,COUNT(CASE WHEN FINALIZA��O in ('DVC')                                           THEN FINALIZA��O END) AS  DVC
,COUNT(CASE WHEN FINALIZA��O in ('DST')                                           THEN FINALIZA��O END) AS  DST
,COUNT(CASE WHEN FINALIZA��O in ('DRO')                                           THEN FINALIZA��O END) AS  DRO
,COUNT(CASE WHEN FINALIZA��O LIKE ('IVR%')                                        THEN FINALIZA��O END) AS  URA
,COUNT(CASE WHEN FINALIZA��O in (
'C028','C029','C030','C031','C032','C033','C035','C036','C037','C038',
'C050','C060','C061','C062','C063','C064','C065','C066','C070','C071','C072',
'C074','C075','C090','C091','C092','C093','C145','C151','C152','C153','C155',
'C156','C159','C164','C165','C166','C171','C172','C174','C178','C179','C180',
'C181','C182','C183','C185','C191','C192','C193','C197','C198','C203','C207',
'C208','C209','C215','C216','C217','C219','C220','C221','C222','C223','C225',
'C226','C227','C228','C229','C230','C233','C234','C235','C236','C237','C238',
'C239','C240','C241','C242','C244','C246','C247','C248','C250','C251','C252',
'C258','C259','C260','C261','C262','C263','C275','C276','C277','C278','C283',
'C284','C285','C286','C287','C289','C290','C293','C294','C295','C297','C301',
'C302','C303','C304','C305','C306','C353','C355','C356','C357','C358','C361',
'C365','C366','C372','C373','R001','R002','R003','R004','R005','R006','R007',
'R009','R010','R016','R018','R019','R020','R023','R025','R027','R029','R030',
'R031','R032','R033','R035','R036','R037','R040','R043','R046','R047','R048',
'R049','R050','R051','R052','R053','R054','R055','R056','R057','R058','R059',
'R063','R064','R065','R067','R073','R074','R076','R077','R078','R079','R080',
'R083','R087','R094','R095','R096','R097','R098','R099','R114','R115','R116',
'R117','R118','R121','R125','R126','R133','R134','C378','C379','C380','C385',
'C386','C389','C399','V002','V003','V006','V008','V018','V021','V022','V029',
'V036','V046','V047','C318','C319','C321','R103','R104','R105','C417','C420'

) THEN FINALIZA��O END)     AS CPCPRODS
, CASE WHEN OPERADOR IS NULL THEN 'SISTEMA'
       ELSE OPERADOR END AS OPERADOR
, Ref
,Nome_Operador
 
 
FROM
(SELECT 
 
CONVERT(DATE,time_of_contact,102)  AS    DATA
,DATEPART(HOUR,time_of_contact)      AS    HORA
,contact_list_name          AS    LISTA
,dialer_target_name         AS    SERVI�O
 
 ,CARTEIRA = CASE				  WHEN (contact_list_name LIKE ('CONSORC_HONDA_LOSS%')) THEN 'MAPFRE_LOSS'
                                  WHEN (contact_list_name LIKE ('%HONDA_LOSS%'))        THEN 'HONDA_LOSS'
                                  WHEN (contact_list_name LIKE ('%BANCO_HONDA%'))       THEN 'HONDA_FASE 1'
                                  WHEN (contact_list_name LIKE ('%BCO_%'))              THEN 'HONDA_FASE 1'                     
                                  WHEN (contact_list_name LIKE ('CONSORC_HONDA%'))      THEN 'MAPFRE_FASE 1'
                                  WHEN (contact_list_name LIKE ('%CONSIG%'))            THEN 'SAFRA_CONSIG'        
                                  WHEN (contact_list_name LIKE ('%LEVES %'))            THEN 'SAFRA_LEVES'
                                  WHEN (contact_list_name LIKE ('%SAFRA_LEVES%'))       THEN 'SAFRA_LEVES'                     
                                  WHEN (contact_list_name LIKE ('VOLKS_PJ%'))           THEN 'VOLKS_PJ'
                                  WHEN (contact_list_name LIKE ('VOLKS_PF%'))           THEN 'VOLKS_PF'     
                                  WHEN (contact_list_name LIKE ('RODOBENS%'))           THEN 'RODOBENS'     
                                  WHEN (contact_list_name LIKE ('UNINTER%'))            THEN 'UNINTER'      
                                  WHEN (contact_list_name LIKE ('BMW%'))                THEN 'BMW'                        
                                  WHEN (contact_list_name LIKE ('BRAD_ADM%'))           THEN 'BRAD_ADM'
                                  WHEN (contact_list_name LIKE ('BRAD_JUR_LP%'))        THEN 'BRADESCO LP JURIDICO'     
                                  WHEN (contact_list_name LIKE ('BRAD_FASE_3%'))        THEN 'BRAD_JUR'                          
                                  WHEN (contact_list_name LIKE ('BRAD_LP%'))            THEN 'BRADESCO LP'      
                                  WHEN (contact_list_name LIKE ('BRAD_JUR%'))           THEN 'BRADESCO JUR'
                                  WHEN (contact_list_name LIKE ('BRAD_FASE_3%'))        THEN 'BRADESCO JUR'
                                  WHEN (contact_list_name LIKE ('BRAD_TEL%'))           THEN 'BRADESCO TELE'    
                                  WHEN (contact_list_name LIKE ('BRAD_APAR%'))          THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('BRAD_FORCA%'))         THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('RAD_FORCA%'))          THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('CAIXA%'))              THEN 'CAIXA'           
                                  WHEN (contact_list_name LIKE ('KROTON%'))             THEN 'KROTON' 
                                  WHEN (contact_list_name LIKE ('UNIASSELVI%'))         THEN 'UNIASSELVI'
                                  WHEN (contact_list_name LIKE ('MAPFRE_FASE_1%'))      THEN 'MAPFRE FASE 1'  
								  WHEN (contact_list_name LIKE ('MAPFRE%'))             THEN 'MAPFRE LOSS' 
			                      WHEN (contact_list_name LIKE ('MAPFRE_APARTADA%'))    THEN 'MAPFRE FASE 1'
						          WHEN (contact_list_name LIKE ('ITAPEVA_BLOCO_A%'))    THEN 'ITAPEVA_CONSUMER_PERN'
								  WHEN (contact_list_name LIKE ('ITAPEVA_BLOCO_B%'))    THEN 'ITAPEVA_CONSUMER_ALL'
								  WHEN (contact_list_name LIKE ('ITAPEVA_BBF%'))			THEN 'RCB'
								  WHEN (contact_list_name LIKE ('EDITORA_ABRIL_COB%'))  THEN 'EDITORA ABRIL COBRAN�A'      
								  WHEN (contact_list_name LIKE ('EDITORA%'))            THEN 'EDITORA ABRIL' 
								  WHEN (contact_list_name LIKE ('VAI%'))                THEN 'VAICAR'
				                  WHEN (contact_list_name LIKE ('UOL%'))                THEN 'UOL' 
							      WHEN (contact_list_name LIKE ('BANCO_INTER%'))        THEN 'BANCO INTER'
								  WHEN (contact_list_name LIKE ('GM%'))                 THEN 'GM'
								  WHEN (contact_list_name LIKE ('CREDZ%'))              THEN 'CREDZ' 
								  WHEN (contact_list_name LIKE ('VOLKS_PRE%'))          THEN 'VOLKSWAGEN PRE JURIDICO'
								  WHEN (contact_list_name LIKE ('EAVM%'))               THEN 'BRADESCO EAVM'
                     
                     END 
,response_status  AS  'FINALIZA��O'
,agent_login_name AS OPERADOR
,LEFT(UPPER((DATENAME(MM,time_of_contact))),3) + RIGHT(CONVERT(VARCHAR,YEAR(time_of_contact)),2) AS Ref
,agent_full_name As 'Nome_Operador'
FROM cl_contact_event
WHERE CONVERT(DATE,time_of_contact,102)between '2020-09-24' and '2020-09-29'  --= Convert(date, Getdate(), 103)
AND response_status not in   ('RR','NR','NC','TZ','NN','R0','INX')
AND response_status not like ('CC_%')


)A
 
WHERE A.CARTEIRA IS NOT NULL
      
GROUP BY DATA
,        HORA
,        CARTEIRA
,        Ref
,        LISTA
,        SERVI�O
,        OPERADOR
,		 Nome_Operador
 
UNION ALL
 
SELECT 
 
DATA
,HORA = (HORA - '3') 
,CARTEIRA
,LISTA
,SERVI�O
,COUNT(CASE WHEN FINALIZA��O not in ('RR','NR','NC','TZ','NN') THEN FINALIZA��O END) AS  TENTATIVAS
,COUNT(CASE WHEN (FINALIZA��O LIKE 'C%' OR FINALIZA��O LIKE 'R%') AND FINALIZA��O NOT IN ('CC_NRT') THEN '' END)  AS ATENDIDAS 
,COUNT(CASE WHEN FINALIZA��O in (
'C028','C029','C030','C031','C032','C033','C034','C035',
'C036','C037','C038','C050','C051','C052','C060','C061','C062',
'C063','C064','C065','C066','C070','C071','C072','C073','C074',
'C075','C090','C091','C092','C093','C145','C148','C151','C152',
'C153','C154','C155','C156','C159','C164','C165','C166','C171',
'C172','C174','C178','C179','C180','C181','C182','C183','C185',
'C189','C190','C191','C192','C193','C196','C197','C198','C203',
'C207','C208','C209','C215','C216','C217','C219','C220','C221',
'C222','C223','C225','C226','C227','C228','C229','C230','C233',
'C234','C235','C236','C237','C238','C239','C240','C241','C242',
'C244','C245','C246','C247','C248','C249','C250','C251','C252',
'C253','C254','C258','C259','C260','C261','C262','C263','C275',
'C276','C277','C278','C279','C283','C284','C285','C286','C287',
'C288','C289','C290','C291','C293','C294','C295','C296','C297',
'C298','C299','C300','C301','C302','C303','C304','C305','C306',
'C353','C354','C355','C356','C357','C358','C359','C360','C361',
'C362','C363','C364','C365','C366','C367','C368','C371','C372',
'C373','R001','R002','R003','R004','R005','R006','R007','R009',
'R010','R016','R017','R018','R019','R020','R023','R025','R027',
'R028','R029','R030','R031','R032','R033','R035','R036','R037',
'R039','R040','R041','R043','R044','R045','R046','R047','R048',
'R049','R050','R051','R052','R053','R054','R055','R056','R057',
'R058','R059','R063','R064','R065','R067','R072','R073','R074',
'R075','R076','R077','R078','R079','R080','R081','R082','R083',
'R084','R086','R087','R088','R089','R090','R091','R092','R093',
'R094','R095','R096','R097','R098','R099','R114','R115','R116',
'R117','R118','R119','R120','R121','R122','R123','R125','R126',
'R127','R128','R132','R133','R134','C378','C379','C380','C381',
'C383','C385','C386','C388','C389','C391','C392','C393','C394',
'C395','C397','C398','C399','C401','V002','V003','V006','V008',
'V018','V019','V020','V021','V022','V023','V024','V025','V026',
'V027','V029','V036','V044','V046','V047','V051','C318','C319',
'C320','C321','C322','R102','R103','R104','R105','C416','C417',
'C413','C412','C418','C419','C423','R138','C420','C421','C422' 
)  THEN FINALIZA��O END) AS  CPCS
,COUNT(CASE WHEN FINALIZA��O in   ('C075','C145','C151','C185',
'C196','C197','C198','C215','C234','C235','C242','C247',
'C262','C263','C283','C284','C285','C372','C373','R002','R003','R007',
'R010','R031','R076','R077','R078','R133','R134','C156','R004','R006') THEN FINALIZA��O END) AS  PROMESSAS                        
,COUNT(CASE WHEN FINALIZA��O in ('C001','C003','C002','C004','C014','C186','C187')  THEN FINALIZA��O END) AS  IMPRODUTIVAS
,COUNT(CASE WHEN OPERADOR is not null AND FINALIZA��O not in ('C001','C003','C002','C004','C014','C186','C187')  THEN FINALIZA��O END) AS  PRODUTIVAS
,COUNT(CASE WHEN FINALIZA��O in ('AH','HU')                                                                      THEN FINALIZA��O END) AS  HUNGUP
,COUNT(CASE WHEN FINALIZA��O in ('DAM')                                                                          THEN FINALIZA��O END) AS  DAM
,COUNT(CASE WHEN FINALIZA��O in ('3T')                                                                           THEN FINALIZA��O END) AS [3T]
,COUNT(CASE WHEN FINALIZA��O in ('NA')                                                                           THEN FINALIZA��O END) AS  NA
,COUNT(CASE WHEN FINALIZA��O in ('NAN')                                                                          THEN FINALIZA��O END) AS  NAN
,COUNT(CASE WHEN FINALIZA��O in ('NVD')                                                                          THEN FINALIZA��O END) AS  NVD
,COUNT(CASE WHEN FINALIZA��O in ('BL')                                                                           THEN FINALIZA��O END) AS  BL
,COUNT(CASE WHEN FINALIZA��O in ('BZ')                                                                           THEN FINALIZA��O END) AS  BZ
,COUNT(CASE WHEN FINALIZA��O in ('DNR')                                                                          THEN FINALIZA��O END) AS  DNR
,COUNT(CASE WHEN FINALIZA��O in ('HU')                                                                           THEN FINALIZA��O END) AS  HU
,COUNT(CASE WHEN FINALIZA��O in ('BN')                                                                           THEN FINALIZA��O END) AS  BN
,COUNT(CASE WHEN FINALIZA��O in ('AH')                                                                           THEN FINALIZA��O END) AS  AH
,COUNT(CASE WHEN FINALIZA��O in ('DEFAULT')                                                                      THEN FINALIZA��O END) AS [DEFAULT]
,COUNT(CASE WHEN FINALIZA��O in ('NON')                                                                          THEN FINALIZA��O END) AS  NON
,COUNT(CASE WHEN FINALIZA��O in ('CC_NRT')                                                                       THEN FINALIZA��O END) AS  CC_NRT
,COUNT(CASE WHEN FINALIZA��O in ('AA')                                                                           THEN FINALIZA��O END) AS  AA
,COUNT(CASE WHEN FINALIZA��O in ('SW_DBS')                                                                       THEN FINALIZA��O END) AS  SW_DBS
,COUNT(CASE WHEN FINALIZA��O in ('R0')                                                                           THEN FINALIZA��O END) AS  R0
,COUNT(CASE WHEN FINALIZA��O in ('C001')                                                                         THEN FINALIZA��O END) AS [N�O ATENDE]
,COUNT(CASE WHEN FINALIZA��O in ('C002')                                                                         THEN FINALIZA��O END) AS  DESLIGADO
,COUNT(CASE WHEN FINALIZA��O in ('C003')                                                                         THEN FINALIZA��O END) AS [SEMPRE OCUPADO]
,COUNT(CASE WHEN FINALIZA��O in ('C004')                                                                         THEN FINALIZA��O END) AS  FAX
,COUNT(CASE WHEN FINALIZA��O in ('C014')                                                                         THEN FINALIZA��O END) AS [CX. POSTAL]
,COUNT(CASE WHEN FINALIZA��O in ('C186')                                                                         THEN FINALIZA��O END) AS [MENSAGEM OPERADORA]
,COUNT(CASE WHEN FINALIZA��O in ('C187')                                                                         THEN FINALIZA��O END) AS  MUDO
,COUNT(CASE WHEN FINALIZA��O in ('DVC')                                                                          THEN FINALIZA��O END) AS  DVC
,COUNT(CASE WHEN FINALIZA��O in ('DST')                                                                          THEN FINALIZA��O END) AS  DST
,COUNT(CASE WHEN FINALIZA��O in ('DRO')                                                                          THEN FINALIZA��O END) AS  DRO
,COUNT(CASE WHEN FINALIZA��O LIKE ('IVR%')                                                                       THEN FINALIZA��O END) AS  URA
,COUNT(CASE WHEN FINALIZA��O in (
'C028','C029','C030','C031','C032','C033','C035','C036','C037','C038',
'C050','C060','C061','C062','C063','C064','C065','C066','C070','C071','C072',
'C074','C075','C090','C091','C092','C093','C145','C151','C152','C153','C155',
'C156','C159','C164','C165','C166','C171','C172','C174','C178','C179','C180',
'C181','C182','C183','C185','C191','C192','C193','C197','C198','C203','C207',
'C208','C209','C215','C216','C217','C219','C220','C221','C222','C223','C225',
'C226','C227','C228','C229','C230','C233','C234','C235','C236','C237','C238',
'C239','C240','C241','C242','C244','C246','C247','C248','C250','C251','C252',
'C258','C259','C260','C261','C262','C263','C275','C276','C277','C278','C283',
'C284','C285','C286','C287','C289','C290','C293','C294','C295','C297','C301',
'C302','C303','C304','C305','C306','C353','C355','C356','C357','C358','C361',
'C365','C366','C372','C373','R001','R002','R003','R004','R005','R006','R007',
'R009','R010','R016','R018','R019','R020','R023','R025','R027','R029','R030',
'R031','R032','R033','R035','R036','R037','R040','R043','R046','R047','R048',
'R049','R050','R051','R052','R053','R054','R055','R056','R057','R058','R059',
'R063','R064','R065','R067','R073','R074','R076','R077','R078','R079','R080',
'R083','R087','R094','R095','R096','R097','R098','R099','R114','R115','R116',
'R117','R118','R121','R125','R126','R133','R134','C378','C379','C380','C385',
'C386','C389','C399','V002','V003','V006','V008','V018','V021','V022','V029',
'V036','V046','V047','C318','C319','C321','R103','R104','R105','C417','C420'
) THEN FINALIZA��O END)     AS CPCPRODS
, CASE WHEN OPERADOR IS NULL THEN 'SISTEMA'
       ELSE OPERADOR END AS OPERADOR
, Ref
,Nome_Operador
 
FROM
(
 
SELECT 
 
 CONVERT(DATE,time_of_contact,102) AS DATA
,DATEPART(HOUR,time_of_contact) AS HORA
,contact_list_name AS LISTA
,dialer_target_name AS SERVI�O
,CARTEIRA = CASE				  WHEN (contact_list_name LIKE ('CONSORC_HONDA_LOSS%')) THEN 'MAPFRE_LOSS'
                                  WHEN (contact_list_name LIKE ('%HONDA_LOSS%'))        THEN 'HONDA_LOSS'
                                  WHEN (contact_list_name LIKE ('%BANCO_HONDA%'))       THEN 'HONDA_FASE 1'
                                  WHEN (contact_list_name LIKE ('%BCO_%'))              THEN 'HONDA_FASE 1'                     
                                  WHEN (contact_list_name LIKE ('CONSORC_HONDA%'))      THEN 'MAPFRE_FASE 1'
                                  WHEN (contact_list_name LIKE ('%CONSIG%'))            THEN 'SAFRA_CONSIG'        
                                  WHEN (contact_list_name LIKE ('%LEVES %'))            THEN 'SAFRA_LEVES'
                                  WHEN (contact_list_name LIKE ('%SAFRA_LEVES%'))       THEN 'SAFRA_LEVES'                     
                                  WHEN (contact_list_name LIKE ('VOLKS_PJ%'))           THEN 'VOLKS_PJ'
                                  WHEN (contact_list_name LIKE ('VOLKS_PF%'))           THEN 'VOLKS_PF'     
                                  WHEN (contact_list_name LIKE ('RODOBENS%'))           THEN 'RODOBENS'     
                                  WHEN (contact_list_name LIKE ('UNINTER%'))            THEN 'UNINTER'      
                                  WHEN (contact_list_name LIKE ('BMW%'))                THEN 'BMW'                        
                                  WHEN (contact_list_name LIKE ('BRAD_ADM%'))           THEN 'BRAD_ADM'
                                  WHEN (contact_list_name LIKE ('BRAD_JUR_LP%'))        THEN 'BRADESCO LP JURIDICO'     
                                  WHEN (contact_list_name LIKE ('BRAD_FASE_3%'))        THEN 'BRAD_JUR'                          
                                  WHEN (contact_list_name LIKE ('BRAD_LP%'))            THEN 'BRADESCO LP'      
                                  WHEN (contact_list_name LIKE ('BRAD_JUR%'))           THEN 'BRADESCO JUR'
                                  WHEN (contact_list_name LIKE ('BRAD_FASE_3%'))        THEN 'BRADESCO JUR'
                                  WHEN (contact_list_name LIKE ('BRAD_TEL%'))           THEN 'BRADESCO TELE'    
                                  WHEN (contact_list_name LIKE ('BRAD_APAR%'))          THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('BRAD_FORCA%'))         THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('RAD_FORCA%'))          THEN 'BRADESCO TELE' 
                                  WHEN (contact_list_name LIKE ('CAIXA%'))              THEN 'CAIXA'           
                                  WHEN (contact_list_name LIKE ('KROTON%'))             THEN 'KROTON' 
                                  WHEN (contact_list_name LIKE ('UNIASSELVI%'))         THEN 'UNIASSELVI'
                                  WHEN (contact_list_name LIKE ('MAPFRE_FASE_1%'))      THEN 'MAPFRE FASE 1'  
								  WHEN (contact_list_name LIKE ('MAPFRE%'))             THEN 'MAPFRE LOSS' 
			                      WHEN (contact_list_name LIKE ('MAPFRE_APARTADA%'))    THEN 'MAPFRE FASE 1'
						          WHEN (contact_list_name LIKE ('ITAPEVA_BLOCO_A%'))    THEN 'ITAPEVA_CONSUMER_PERN'
								  WHEN (contact_list_name LIKE ('ITAPEVA_BLOCO_B%'))    THEN 'ITAPEVA_CONSUMER_ALL'
								  WHEN (contact_list_name LIKE ('ITAPEVA_BBF%'))			THEN 'RCB'
								  WHEN (contact_list_name LIKE ('EDITORA_ABRIL_COB%'))  THEN 'EDITORA ABRIL COBRAN�A'      
								  WHEN (contact_list_name LIKE ('EDITORA%'))            THEN 'EDITORA ABRIL' 
								  WHEN (contact_list_name LIKE ('VAI%'))                THEN 'VAICAR'
				                  WHEN (contact_list_name LIKE ('UOL%'))                THEN 'UOL' 
							      WHEN (contact_list_name LIKE ('BANCO_INTER%'))        THEN 'BANCO INTER'
								  WHEN (contact_list_name LIKE ('GM%'))                 THEN 'GM'
								  WHEN (contact_list_name LIKE ('CREDZ%'))              THEN 'CREDZ' 
								  WHEN (contact_list_name LIKE ('VOLKS_PRE%'))          THEN 'VOLKSWAGEN PRE JURIDICO'
								  WHEN (contact_list_name LIKE ('EAVM%'))               THEN 'BRADESCO EAVM' ELSE '' END    
,response_status  AS    'FINALIZA��O'
,agent_login_name AS OPERADOR
,agent_full_name As Nome_Operador
 
      ,         LEFT(UPPER((DATENAME(MM,time_of_contact))),3)
      +        RIGHT(CONVERT(VARCHAR,YEAR(time_of_contact)),2) AS Ref
 
FROM cl_contact_event
 
WHERE CONVERT(DATE,time_of_contact,102)between '2020-09-24' and '2020-09-29'  --= Convert(date, Getdate(), 103)
AND response_status not in   ('RR','NR','NC','TZ','NN','R0','INX')
AND response_status not like ('CC_%')


)A
 
WHERE A.CARTEIRA IS NOT NULL 
 
GROUP BY DATA
,        HORA
,        CARTEIRA
,        Ref
,        LISTA
,        SERVI�O
,        OPERADOR
,		 Nome_Operador
)B


/*=================EXPORTA ARQUIVO============================*/

DECLARE @BCPSQL_ALM2		VARCHAR(2000),
		@BCPFILENAME_ALM2	VARCHAR(200)
SET		@BCPFILENAME_ALM2 = '\\10.155.4.51\itf_in\BRADESCO_EAVM\ALM_ARQUIVOS\DISCADOR\ALM_ARCHIVES_20200924_29.csv'--+'_'+REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')+'.csv'
SET		@BCPSQL_ALM2 =		'SELECT * FROM ##ALM_ARCHIVES'
SET		@BCPSQL_ALM2 =		'BCP "' + @BCPSQL_ALM2 + '" QUERYOUT ' + @BCPFILENAME_ALM2 + ' -c -t; -r\n -CP850 -T -Slocalhost'
PRINT	@BCPSQL_ALM2
DECLARE @RC_ALM2 VARCHAR(100)
EXEC	@RC_ALM2 = MASTER..XP_CMDSHELL @BCPSQL_ALM2