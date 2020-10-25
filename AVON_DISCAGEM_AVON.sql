DELETE FROM ADCOBMIS01..AVON_DADOS_DISCAGEM_PBI
WHERE DATA_BD = CONVERT(DATE, GETDATE(), 103)



INSERT INTO ADCOBMIS01..AVON_DADOS_DISCAGEM_PBI
SELECT
CONVERT(DATE, A.CallStart, 103) AS DATA_BD,
LEFT(CONVERT(VARCHAR, A.CallStart, 108), 2) AS HORA,
A.CustomerId AS EC,
A.CampaignId AS ID_CAMPANHA,
A.DispositionId AS COD_EVENTO,
A.CallStart AS INICIO,
A.CallEnd AS FIM,
CAST(DATEPART(HOUR, a.AgentStart)*3600 as float)/86400+CAST(DATEPART(MINUTE, a.AgentStart)*60 AS FLOAT)/86400+CAST(DATEPART(SECOND, a.AgentStart) AS FLOAT)/86400 AS AGENT_INI,
CAST(DATEPART(HOUR, a.AgentEnd)*3600 as float)/86400+CAST(DATEPART(MINUTE, a.AgentEnd)*60 AS FLOAT)/86400+CAST(DATEPART(SECOND, a.AgentEnd) AS FLOAT)/86400 as AGENT_FIM,
(CAST(DATEPART(HOUR, a.AgentEnd)*3600 as float)/86400+CAST(DATEPART(MINUTE, a.AgentEnd)*60 AS FLOAT)/86400+CAST(DATEPART(SECOND, a.AgentEnd) AS FLOAT)/86400)-
(CAST(DATEPART(HOUR, a.AgentStart)*3600 as float)/86400+CAST(DATEPART(MINUTE, a.AgentStart)*60 AS FLOAT)/86400+CAST(DATEPART(SECOND, a.AgentStart) AS FLOAT)/86400)as TMA,
A.PhoneNumber AS TELEFONE1,
A.DNIS AS TELEFONE2,
A.Route AS TIPO_DISC,
A.Redialed AS REDISC,
A.AgentId AS ID_AGENTE,

CASE 
	WHEN  DispositionId = 	'0'		THEN	'AGENT'
	WHEN  DispositionId = 	'1'		THEN	'Busy'
	WHEN  DispositionId = 	'2'		THEN	'NoAnswer'
	WHEN  DispositionId = 	'3'		THEN	'Announcement'
	WHEN  DispositionId = 	'4'		THEN	'HangUp'
	WHEN  DispositionId = 	'5'		THEN	'BadLine'
	WHEN  DispositionId = 	'6'		THEN	'BadNumber'
	WHEN  DispositionId = 	'7'		THEN	'CancelDial'
	WHEN  DispositionId = 	'8'		THEN	'CarrierMessage'
	WHEN  DispositionId = 	'9'		THEN	'DeniedCall'
	WHEN  DispositionId = 	'10'	THEN	'AgentDisconnected'
	WHEN  DispositionId = 	'11'	THEN	'InternalCongestion'
	WHEN  DispositionId = 	'12'	THEN	'ExternalCongestion'
	WHEN  DispositionId = 	'13'	THEN	'AbortCustomerOnQueue'
	WHEN  DispositionId = 	'14'	THEN	'QueueMaximumTime'
	WHEN  DispositionId = 	'15'	THEN	'QueueMaximumLength'
	WHEN  DispositionId = 	'16'	THEN	'NoDisposition'
	WHEN  DispositionId = 	'17'	THEN	'TransferModule'
	WHEN  DispositionId = 	'18'	THEN	'NoAgents'
	WHEN  DispositionId = 	'19'	THEN	'SLAExceeded'
	WHEN  DispositionId = 	'20'	THEN	'FAX'
	WHEN  DispositionId = 	'21'	THEN	'Silence'
	WHEN  DispositionId = 	'22'	THEN	'SMSFailed'
	WHEN  DispositionId = 	'23'	THEN	'SMSSent'
	WHEN  DispositionId = 	'24'	THEN	'Out of Hours'
	WHEN  DispositionId = 	'100'	THEN	'TELEFONE NAO ATENDE'
	WHEN  DispositionId = 	'101'	THEN	'FONE NAO PERTENCE AO CLIENTE'
	WHEN  DispositionId = 	'102'	THEN	'TELEFONE NAO EXISTE'
	WHEN  DispositionId = 	'103'	THEN	'RECADO'
	WHEN  DispositionId = 	'104'	THEN	'RECADO CAIXA POSTAL'
	WHEN  DispositionId = 	'105'	THEN	'CLIENTE DESCONHECIDO'
	WHEN  DispositionId = 	'106'	THEN	'CLIENTE DESCONHECE DIVIDA'
	WHEN  DispositionId = 	'107'	THEN	'CLIENTE FALECIDO'
	WHEN  DispositionId = 	'108'	THEN	'CLIENTE DESEMPREGADO'
	WHEN  DispositionId = 	'109'	THEN	'CLIENTE NAO RECEBEU O CARNE'
	WHEN  DispositionId = 	'110'	THEN	'CLIENTE NAO RECEBEU PARTE DA MERCADORIA'
	WHEN  DispositionId = 	'111'	THEN	'CLIENTE ALEGA PAGAMENTO'
	WHEN  DispositionId = 	'112'	THEN	'CLIENTE REGISTROU RECLAMACAO'
	WHEN  DispositionId = 	'113'	THEN	'PROMESSA DE PAGAMENTO COM BOLETO'
	WHEN  DispositionId = 	'114'	THEN	'CLIENTE NAO RECEBEU A MERCADORIA'
	WHEN  DispositionId = 	'115'	THEN	'PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'116'	THEN	'QUEDA DE LIGACAO'
	WHEN  DispositionId = 	'117'	THEN	'COBRANCA SEM PPG'
	WHEN  DispositionId = 	'118'	THEN	'CONFIRMACAO PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'119'	THEN	'MENSAGEM DA OPERADORA'
	WHEN  DispositionId = 	'120'	THEN	'TELEFONE MUDO'
	WHEN  DispositionId = 	'121'	THEN	'AGENDAMENTO COM O CLIENTE'
	WHEN  DispositionId = 	'122'	THEN	'AGENDAMENTO COM TERCEIROS'
	WHEN  DispositionId = 	'123'	THEN	'TESTE ACAO'
	WHEN  DispositionId = 	'124'	THEN	'teste'
	WHEN  DispositionId = 	'125'	THEN	'TELEFONE SEMPRE OCUPADO'
	WHEN  DispositionId = 	'126'	THEN	'TELEFONE DESLIGADO'
	WHEN  DispositionId = 	'127'	THEN	'TELEFONE PROGRAMADO PARA NAO ATENDER'
	WHEN  DispositionId = 	'128'	THEN	'TELEFONE CADASTRADO INCORRETAMENTE'
	WHEN  DispositionId = 	'129'	THEN	'TELEFONES INVALIDOS'
	WHEN  DispositionId = 	'130'	THEN	'RECEPTIVO - CLIENTE FALECIDO'
	WHEN  DispositionId = 	'131'	THEN	'CLIENTE ALEGA PAGAMENTO A MAIS DE 4 DIAS'
	WHEN  DispositionId = 	'132'	THEN	'RECEPTIVO - COBRANCA SEM PPG'
	WHEN  DispositionId = 	'133'	THEN	'CLIENTE DOENTE'
	WHEN  DispositionId = 	'134'	THEN	'RECEPTIVO - REVENDEDORA NAO RECEBEU A CAIXA'
	WHEN  DispositionId = 	'135'	THEN	'RECEPTIVO - REVENDEDORA DEVOLVEU A CAIXA'
	WHEN  DispositionId = 	'136'	THEN	'RECEPTIVO - CLIENTE DESCONHECE DIVIDA'
	WHEN  DispositionId = 	'137'	THEN	'RECEPTIVO - REVENDEDORA NAO FEZ O PEDIDO'
	WHEN  DispositionId = 	'138'	THEN	'REVENDEDORA NAO RECEBEU A CAIXA'
	WHEN  DispositionId = 	'139'	THEN	'REVENDEDORA DEVOLVEU A CAIXA'
	WHEN  DispositionId = 	'140'	THEN	'REVENDEDORA NAO FEZ O PEDIDO'
	WHEN  DispositionId = 	'141'	THEN	'REVENDEDORA REALIZOU DEVOLUCAO PARCIAL'
	WHEN  DispositionId = 	'142'	THEN	'CLIENTE NAO CONCORDA COM O SALDO COBRADO'
	WHEN  DispositionId = 	'143'	THEN	'CLIENTE NAO CONCORDA COM OS ENCARGOS COBRADOS'
	WHEN  DispositionId = 	'144'	THEN	'RECEPTIVO - REVENDEDORA RECEBEU CAIXA FALTANDO PRODUTO'
	WHEN  DispositionId = 	'145'	THEN	'RECEPTIVO - REVENDEDORA REALIZOU DEVOLUCAO PARCIAL'
	WHEN  DispositionId = 	'146'	THEN	'RECEPTIVO - CLIENTE NAO CONCORDA COM O SALDO COBRADO'
	WHEN  DispositionId = 	'147'	THEN	'RECEPTIVO - CLIENTE NAO CONCORDA COM OS ENCARGOS COBRADOS'
	WHEN  DispositionId = 	'148'	THEN	'RECEPTIVO - ALEGA ACAO JUDICIAL_PASSIVA OU ATIVA'
	WHEN  DispositionId = 	'149'	THEN	'ALEGA ACAO JUDICIAL_PASSIVA OU ATIVA'
	WHEN  DispositionId = 	'150'	THEN	'PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'151'	THEN	'PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'152'	THEN	'PROMESSA DE PAGAMENTO NAO EFETUADO'
	WHEN  DispositionId = 	'153'	THEN	'RECEPTIVO - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'154'	THEN	'RECEPTIVO - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'155'	THEN	'RECEPTIVO - PROMESSA DE PAGAMENTO NAO EFETUADO'
	WHEN  DispositionId = 	'156'	THEN	'CONFIRMACAO DE PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'157'	THEN	'RECEPTIVO - CONFIRMACAO DE PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'158'	THEN	'REVENDEDORA RECEBEU CAIXA FALTANDO PRODUTO'
	WHEN  DispositionId = 	'159'	THEN	'TABULACAO_TESTE'
	WHEN  DispositionId = 	'160'	THEN	'Teste_Agenda_Manual'
	WHEN  DispositionId = 	'161'	THEN	'Teste_Agenda_Automatica'
	WHEN  DispositionId = 	'162'	THEN	'LIGACAO CAIU_DESLIGOU'
	WHEN  DispositionId = 	'163'	THEN	'RECEPTIVO - CLIENTE ALEGA PAGAMENTO'
	WHEN  DispositionId = 	'164'	THEN	'RECEPTIVO - CLIENTE ALEGA PAGAMENTO A MAIS DE 4 DIAS'
	WHEN  DispositionId = 	'165'	THEN	'RECEPTIVO - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'166'	THEN	'REENVIO DE BOLETO'
	WHEN  DispositionId = 	'167'	THEN	'RECEPTIVO - REENVIO DE BOLETO '
	WHEN  DispositionId = 	'168'	THEN	'PROPOSTA DE ACORDO ENVIADA PARA A AVON'
	WHEN  DispositionId = 	'169'	THEN	'RECEPTIVO - AGENDAMENTO COM O CLIENTE'
	WHEN  DispositionId = 	'170'	THEN	'ACAO DE SMS'
	WHEN  DispositionId = 	'171'	THEN	'ACAO DE MALA DIRETA POR E-MAIL'
	WHEN  DispositionId = 	'172'	THEN	'ACAO DE MALA DIRETA POR CORREIO'
	WHEN  DispositionId = 	'173'	THEN	'ACAO DE URA'
	WHEN  DispositionId = 	'174'	THEN	'ACAO DE MALA DIRETA POR SMS'
	WHEN  DispositionId = 	'175'	THEN	'ACAO DE CARTA DE COBRANCA'
	WHEN  DispositionId = 	'176'	THEN	'DIGITAL - ENVIO DE WHATSAPP'
	WHEN  DispositionId = 	'177'	THEN	'DIGITAL - RETORNO DE WHATSAPP'
	WHEN  DispositionId = 	'178'	THEN	'ACAO DE E-MAIL'
	WHEN  DispositionId = 	'179'	THEN	'CLIENTE SEM PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'180'	THEN	'TELEFONE NA CAIXA POSTAL'
	WHEN  DispositionId = 	'181'	THEN	'TELEFONE COM SINAL DE FAX'
	WHEN  DispositionId = 	'182'	THEN	'TELEFONE OCUPADO'
	WHEN  DispositionId = 	'183'	THEN	'TELEAFONE PROG PARA NAO ATENDER'
	WHEN  DispositionId = 	'184'	THEN	'ACAO JUDICIAL'
	WHEN  DispositionId = 	'185'	THEN	'PAGAMENTO BAIXADO MANUALMENTE'
	WHEN  DispositionId = 	'186'	THEN	'DEVOLUCAO DE CHEQUE'
	WHEN  DispositionId = 	'187'	THEN	'OBSERVACOES GERAIS'
	WHEN  DispositionId = 	'188'	THEN	'CLIENTE ALEGA FRAUDE'
	WHEN  DispositionId = 	'189'	THEN	'RECEPTIVO - ALEGA ACAO JUDICIAL PASSIVA OU ATIVA'
	WHEN  DispositionId = 	'190'	THEN	'WAY_ENVIADOAGENTE'
	WHEN  DispositionId = 	'191'	THEN	'WAY_AGENDAMENTO'
	WHEN  DispositionId = 	'192'	THEN	'WAY_DESCONHECEAPESSOA'
	WHEN  DispositionId = 	'193'	THEN	'WAY_Cliente_Nao_Identificado'
	WHEN  DispositionId = 	'194'	THEN	'RECEPTIVO - DEVOLUCAO DE CHEQUE'
	WHEN  DispositionId = 	'195'	THEN	'PROMESSA DE PAGAMENTO PARCIAL'
	WHEN  DispositionId = 	'196'	THEN	'PROMESSA DE PAGAMENTO AVON'
	WHEN  DispositionId = 	'197'	THEN	'TABULACAO AUTOMATICA '
	WHEN  DispositionId = 	'198'	THEN	'CONTRATO SEM DIVIDA'
	WHEN  DispositionId = 	'199'	THEN	'TRANSFERENCIA-SAC AVON '
	WHEN  DispositionId = 	'200'	THEN	'teste1'
	WHEN  DispositionId = 	'201'	THEN	'TELEFONEMA RA'
	WHEN  DispositionId = 	'202'	THEN	'TELEFONEMA EVA'
	WHEN  DispositionId = 	'203'	THEN	'TELEFONE RECEPTIVO RA'
	WHEN  DispositionId = 	'204'	THEN	'TELEFONEMA RECEPTIVO EVA'
	WHEN  DispositionId = 	'205'	THEN	'TELEFONEMA GS'
	WHEN  DispositionId = 	'206'	THEN	'TELEFONEMA RECEPTIVO GS'
	WHEN  DispositionId = 	'207'	THEN	'RA NAO RECEBEU O BOLETO'
	WHEN  DispositionId = 	'208'	THEN	'RA RECEBEU O BOLETO'
	WHEN  DispositionId = 	'209'	THEN	'NAO COMPROU PERFUME'
	WHEN  DispositionId = 	'210'	THEN	'PERDEU O PEDIDO'
	WHEN  DispositionId = 	'211'	THEN	'PERDEU O BOLETO'
	WHEN  DispositionId = 	'212'	THEN	'PEDIU PARA RETORNAR'
	WHEN  DispositionId = 	'213'	THEN	'NAO RECEBEU O PERFUME'
	WHEN  DispositionId = 	'214'	THEN	'LIGACAO CAIU_DESLIGOU_EVE DUET'
	WHEN  DispositionId = 	'215'	THEN	'RECADO_EVE DUET'
	WHEN  DispositionId = 	'216'	THEN	'CLIENTE DESCONHECE DIVIDA_EVE DUET'
	WHEN  DispositionId = 	'217'	THEN	'FONE NAO PERTENCE AO CLIENTE_EVE DUET'
	WHEN  DispositionId = 	'218'	THEN	'TELEFONE MUDO_EVE DUET'
	WHEN  DispositionId = 	'219'	THEN	'TELEFONE NAO ATENDE_EVE DUET'
	WHEN  DispositionId = 	'220'	THEN	'Digital_Iniciou o Fluxo'
	WHEN  DispositionId = 	'221'	THEN	'Digital_E a pessoa'
	WHEN  DispositionId = 	'222'	THEN	'Digital_Confirmou CPF'
	WHEN  DispositionId = 	'223'	THEN	'Digital_Nao confirmou CPF'
	WHEN  DispositionId = 	'224'	THEN	'Digital_Confirma pgto amanha'
	WHEN  DispositionId = 	'225'	THEN	'Digital_Nao confirma pgto amanha'
	WHEN  DispositionId = 	'226'	THEN	'Digital_Confirma pgto D3'
	WHEN  DispositionId = 	'227'	THEN	'Digital_Nao confirma pgto D3'
	WHEN  DispositionId = 	'228'	THEN	'Digital_Nao e a pessoa'
	WHEN  DispositionId = 	'229'	THEN	'Digital_Conhece a pessoa'
	WHEN  DispositionId = 	'230'	THEN	'Digital_Pede repeticao de numero'
	WHEN  DispositionId = 	'231'	THEN	'Digital_Nao conhece a pessoa'
	WHEN  DispositionId = 	'232'	THEN	'RECEPTIVO - CLIENTE ALEGA FRAUDE '
	WHEN  DispositionId = 	'233'	THEN	'RECEPTIVO - PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'234'	THEN	'RECEPTIVO - CONFIRMACAO DE BOLETO'
	WHEN  DispositionId = 	'235'	THEN	'RECEPTIVO - CLIENTE COM ACORDO VIGENTE '
	WHEN  DispositionId = 	'236'	THEN	'RECEPTIVO - RETORNO DE E-MAIL'
	WHEN  DispositionId = 	'237'	THEN	'CLIENTE NAO CONFIRMA OS DADOS CADASTRAIS'
	WHEN  DispositionId = 	'238'	THEN	'RECEPTIVO - CONTRATO SEM DIVIDA'
	WHEN  DispositionId = 	'239'	THEN	'FINANCIAMENTO TERCEIRO'
	WHEN  DispositionId = 	'240'	THEN	'CLIENTE SOLICITA REFINANCIAR O CONTRATO'
	WHEN  DispositionId = 	'241'	THEN	'CELULAR DESLIGADO'
	WHEN  DispositionId = 	'242'	THEN	'CONTRATO SEM TELEFONE'
	WHEN  DispositionId = 	'243'	THEN	'PROPOSTA DE REFIN'
	WHEN  DispositionId = 	'244'	THEN	'CLIENTE COM REFIN INICIADO EM OUTRA ASSESSORIA'
	WHEN  DispositionId = 	'245'	THEN	'PROPOSTA DE ACORDO GERADA'
	WHEN  DispositionId = 	'246'	THEN	'POTENCIAL RECLAMACAO'
	WHEN  DispositionId = 	'247'	THEN	'ATENDENTE RECUSA PASSAR RECADO'
	WHEN  DispositionId = 	'248'	THEN	'CLIENTE ALEGA PGTO PARCIAL'
	WHEN  DispositionId = 	'249'	THEN	'CONTRATO ENVIADO P ANALISE INTERNA'
	WHEN  DispositionId = 	'250'	THEN	'CONFIRMACAO DE PAGAMENTO COLCHAO DE ACORDO'
	WHEN  DispositionId = 	'251'	THEN	'CONTRA PROPOSTA - PROPOSTA FORA DA POLITICA'
	WHEN  DispositionId = 	'252'	THEN	'CLIENTE DESLIGOU'
	WHEN  DispositionId = 	'253'	THEN	'SUSPEITA DE FRAUDE'
	WHEN  DispositionId = 	'254'	THEN	'CLIENTE SOLICITOU RETORNO'
	WHEN  DispositionId = 	'255'	THEN	'SEM TABULACAO'
	WHEN  DispositionId = 	'256'	THEN	'TERCEIROS - RECEPTIVO - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'257'	THEN	'TERCEIROS - RECEPTIVO - COBRANCA SEM PPG'
	WHEN  DispositionId = 	'258'	THEN	'TERCEIROS - PROMESSA DE PAGAMENTO NAO EFETUADO'
	WHEN  DispositionId = 	'259'	THEN	'TERCEIROS - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'260'	THEN	'TERCEIROS - RECEPTIVO - CLIENTE NAO CONCORDA COM OS ENCARGOS COBRADOS'
	WHEN  DispositionId = 	'261'	THEN	'TERCEIROS - RECEPTIVO - PROMESSA DE PAGAMENTO NAO EFETUADO'
	WHEN  DispositionId = 	'262'	THEN	'TERCEIROS - COBRANCA SEM PPG'
	WHEN  DispositionId = 	'263'	THEN	'TERCEIROS - CLIENTE DOENTE'
	WHEN  DispositionId = 	'264'	THEN	'TERCEIROS - CLIENTE NAO CONCORDA COM OS ENCARGOS COBRADOS'
	WHEN  DispositionId = 	'265'	THEN	'TERCEIROS - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'266'	THEN	'TERCEIROS - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'267'	THEN	'TERCEIROS - RECEPTIVO - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'268'	THEN	'TERCEIROS - RECEPTIVO - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'269'	THEN	'TERCEIROS - PROMESSA DE PAGAMENTO PARCIAL'
	WHEN  DispositionId = 	'270'	THEN	'TERCEIROS - PROMESSA DE PAGAMENTO AVON'
	WHEN  DispositionId = 	'271'	THEN	'TERCEIROS - CLIENTE NAO CONCORDA COM O SALDO COBRADO'
	WHEN  DispositionId = 	'272'	THEN	'teste_vcom'
	WHEN  DispositionId = 	'273'	THEN	'NAO CPC'
	WHEN  DispositionId = 	'274'	THEN	'CPC COM ACORDO DE EXCECAO'
	WHEN  DispositionId = 	'275'	THEN	'CPC SEM ACORDO'
	WHEN  DispositionId = 	'276'	THEN	'CPC COM ACORDO'
	WHEN  DispositionId = 	'277'	THEN	'NAO CPC COM AGENDAMENTO'
	WHEN  DispositionId = 	'278'	THEN	'NAO CPC DESCONHECE CLIENTE'
	WHEN  DispositionId = 	'279'	THEN	'CPC COM AGENDAMENTO'
	WHEN  DispositionId = 	'280'	THEN	'OCORRENCIA NAO INFORMADA'
	WHEN  DispositionId = 	'281'	THEN	'CPC COM ACORDO EXCECAO'
	WHEN  DispositionId = 	'282'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - COBRANCA SEM PPG'
	WHEN  DispositionId = 	'283'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - CLIENTE NAO CONCORDA COM OS ENCARGOS COBRADOS'
	WHEN  DispositionId = 	'284'	THEN	'TERCEIROS - DIGITAL - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'285'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'286'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - PROMESSA DE PAGAMENTO NAO EFETUADO'
	WHEN  DispositionId = 	'287'	THEN	'TERCEIROS - DIGITAL - COBRANCA SEM PPG'
	WHEN  DispositionId = 	'288'	THEN	'TERCEIROS - DIGITAL - CLIENTE DOENTE'
	WHEN  DispositionId = 	'289'	THEN	'TERCEIROS - DIGITAL - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'290'	THEN	'TERCEIROS - DIGITAL - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'291'	THEN	'TERCEIROS - DIGITAL - PROMESSA DE PAGAMENTO PARCIAL'
	WHEN  DispositionId = 	'292'	THEN	'TERCEIROS - DIGITAL - PROMESSA DE PAGAMENTO AVON'
	WHEN  DispositionId = 	'293'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'294'	THEN	'TERCEIROS - DIGITAL - RECEPTIVO - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'295'	THEN	'DIGITAL - REVENDEDORA DEVOLVEU A CAIXA'
	WHEN  DispositionId = 	'296'	THEN	'DIGITAL - RECEPTIVO - PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'297'	THEN	'DIGITAL - REENVIO DE BOLETO'
	WHEN  DispositionId = 	'298'	THEN	'DIGITAL - RECEPTIVO - REVENDEDORA NAO RECEBEU A CAIXA'
	WHEN  DispositionId = 	'299'	THEN	'DIGITAL - RECEPTIVO - REVENDEDORA NAO FEZ O PEDIDO'
	WHEN  DispositionId = 	'300'	THEN	'DIGITAL - RECEPTIVO - REVENDEDORA RECEBEU CAIXA FALTANDO PRODUTO'
	WHEN  DispositionId = 	'301'	THEN	'DIGITAL - RECEPTIVO - REVENDEDORA REALIZOU DEVOLUCAO PARCIAL'
	WHEN  DispositionId = 	'302'	THEN	'DIGITAL - RECEPTIVO - PROMESSA COM BOLETO A VISTA'
	WHEN  DispositionId = 	'303'	THEN	'DIGITAL - RECEPTIVO - CONFIRMACAO DE PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'304'	THEN	'DIGITAL - PROMESSA DE PAGAMENTO AVON'
	WHEN  DispositionId = 	'305'	THEN	'DIGITAL - PROMESSA COM BOLETO PARCELADO'
	WHEN  DispositionId = 	'306'	THEN	'TELEFONE BLOQUEADO'
	WHEN  DispositionId = 	'307'	THEN	'TELEFONE INEXISTENTE'
	WHEN  DispositionId = 	'308'	THEN	'TELEFONE FORA DE AREA'
	WHEN  DispositionId = 	'309'	THEN	'LIGACAO NAO COMPLETADA'
	WHEN  DispositionId = 	'310'	THEN	'LIGACAO NAO ATENDE'
	WHEN  DispositionId = 	'311'	THEN	'LIGACAO MUDA'
	WHEN  DispositionId = 	'312'	THEN	'TELEFONE MUDOU'
	WHEN  DispositionId = 	'313'	THEN	'QUEDA DE LIGACAO TERCEIRO'
	WHEN  DispositionId = 	'314'	THEN	'OCORRENCIA MAQUINA'
	WHEN  DispositionId = 	'315'	THEN	'CLIENTE NAO CONFIRMA DADOS'
	WHEN  DispositionId = 	'316'	THEN	'CONTRATO DEVOLVIDO'
	WHEN  DispositionId = 	'317'	THEN	'PREVENTIVO NEGATIVO'
	WHEN  DispositionId = 	'318'	THEN	'QUEDA DE LIGACAO CLIENTE'
	WHEN  DispositionId = 	'319'	THEN	'PROMESSA DE PAGAMENTO'
	WHEN  DispositionId = 	'320'	THEN	'ALEGA PAGAMENTO'
	WHEN  DispositionId = 	'321'	THEN	'PREVENTIVO POSITIVO'
	WHEN  DispositionId = 	'322'	THEN	'ALEGA ACAO CONTRARIA'
	WHEN  DispositionId = 	'323'	THEN	'NEGOCIACAO DE ENTREGA'
	WHEN  DispositionId = 	'324'	THEN	'ANALISANDO VALOR'
	WHEN  DispositionId = 	'325'	THEN	'PROPOSTA VALOR PARCIAL'
	WHEN  DispositionId = 	'326'	THEN	'SEM PREVISAO DE PAGAMENTO'
	WHEN  DispositionId = 	'327'	THEN	'DESCONHECE DIVIDA'
	WHEN  DispositionId = 	'328'	THEN	'SEM CONTATO - CAIXA POSTAL'
	WHEN  DispositionId = 	'329'	THEN	'SEM CONTATO - LIGACAO MUDA'
	WHEN  DispositionId = 	'330'	THEN	'SEM CONTATO - MENSAGEM OPERADORA'
	WHEN  DispositionId = 	'331'	THEN	'CONTATO - DESCONHECE CLIENTE'
	WHEN  DispositionId = 	'332'	THEN	'CONTATO - CAIU A LINHA'
	WHEN  DispositionId = 	'333'	THEN	'CONTATO - RECADO'
	WHEN  DispositionId = 	'334'	THEN	'CONTATO - RETORNAR'
	WHEN  DispositionId = 	'335'	THEN	'CONTATO - OUTROS'
	WHEN  DispositionId = 	'336'	THEN	'CPC - PROMESSA COM DEVEDOR'
	WHEN  DispositionId = 	'337'	THEN	'CPC - PROMESSA COM TERCEIRO'
	WHEN  DispositionId = 	'338'	THEN	'CPC - ALEGA PAGAMENTO'
	WHEN  DispositionId = 	'339'	THEN	'CPC - SE RECUSA A PAGAR'
	WHEN  DispositionId = 	'340'	THEN	'CPC - PREVENTIVO QUEBRA'
	WHEN  DispositionId = 	'341'	THEN	'CPC - CONTESTACAO'
	WHEN  DispositionId = 	'342'	THEN	'CPC - FRAUDE'
	WHEN  DispositionId = 	'343'	THEN	'CPC - JURIDICO'
	WHEN  DispositionId = 	'344'	THEN	'CONTATO - OBITO - TRANSFERENCIA SAC'
	WHEN  DispositionId = 	'345'	THEN	'RECEPTIVO - SEM CONTATO - CAIXA POSTAL'
	WHEN  DispositionId = 	'346'	THEN	'RECEPTIVO - SEM CONTATO - LIGACAO MUDA'
	WHEN  DispositionId = 	'347'	THEN	'RECEPTIVO - SEM CONTATO - MENSAGEM OPERADORA'
	WHEN  DispositionId = 	'348'	THEN	'RECEPTIVO - CONTATO - DESCONHECE CLIENTE'
	WHEN  DispositionId = 	'349'	THEN	'RECEPTIVO - CONTATO - CAIU A LINHA'
	WHEN  DispositionId = 	'350'	THEN	'RECEPTIVO - CONTATO - RECADO'
	WHEN  DispositionId = 	'351'	THEN	'RECEPTIVO - CONTATO - RETORNAR'
	WHEN  DispositionId = 	'352'	THEN	'RECEPTIVO - CONTATO - OUTROS'
	WHEN  DispositionId = 	'353'	THEN	'RECEPTIVO - CPC - PROMESSA COM DEVEDOR'
	WHEN  DispositionId = 	'354'	THEN	'RECEPTIVO - CPC - PROMESSA COM TERCEIRO'
	WHEN  DispositionId = 	'355'	THEN	'RECEPTIVO - CPC - ALEGA PAGAMENTO'
	WHEN  DispositionId = 	'356'	THEN	'RECEPTIVO - CPC - PREVENTIVO QUEBRA'
	WHEN  DispositionId = 	'357'	THEN	'RECEPTIVO - CPC - CONTESTACAO'
	WHEN  DispositionId = 	'358'	THEN	'RECEPTIVO - CPC - FRAUDE'
	WHEN  DispositionId = 	'359'	THEN	'RECEPTIVO - CPC - JURIDICO'
	WHEN  DispositionId = 	'360'	THEN	'RECEPTIVO - CONTATO - OBITO - TRANSFERENCIA SAC'
	WHEN  DispositionId = 	'361'	THEN	'RECEPTIVO - CPC - SE RECUSA A PAGAR'
	WHEN  DispositionId = 	'362'	THEN	'PROMESSA DE PAGAMENTO COM TERCEIRO'
	WHEN  DispositionId = 	'363'	THEN	'CPC COM TERCEIRO'
	WHEN  DispositionId = 	'364'	THEN	'ACORDO EM ANDAMENTO'
	WHEN  DispositionId = 	'365'	THEN	'AGUARDANDO APROVACAO FORA DE ALCADA BKO'
	WHEN  DispositionId = 	'366'	THEN	'CLIENTE NAO LOCALIZADO BKO'
	WHEN  DispositionId = 	'367'	THEN	'CONTATADO'
	WHEN  DispositionId = 	'368'	THEN	'RECOMENDACAO DE AJUIZAMENTO BKO'
	WHEN  DispositionId = 	'369'	THEN	'RECOMENDACAO DE LUCROS E PERDAS BKO'
	WHEN  DispositionId = 	'370'	THEN	'RECUPERACAO JUDICIAL BKO'
	WHEN  DispositionId = 	'371'	THEN	'SOLICITACAO DE NF COMPROVANTES ENTREGA BKO'
	WHEN  DispositionId = 	'372'	THEN	'Executiva fez o pedido'
	WHEN  DispositionId = 	'373'	THEN	'RA - Nao fez o pedido'
	WHEN  DispositionId = 	'374'	THEN	'Desastres Naturais '
	WHEN  DispositionId = 	'375'	THEN	'Doenca'
	WHEN  DispositionId = 	'376'	THEN	'Falecimento '
	WHEN  DispositionId = 	'377'	THEN	'Caixa com Excesso - Falta de produtos'
	WHEN  DispositionId = 	'378'	THEN	'Nao quis realizar a pesquisa'
	WHEN  DispositionId = 	'379'	THEN	'Descontrole Financeiro - Nao conseguiu vender'
	WHEN  DispositionId = 	'380'	THEN	'Descontrole Financeiro - Vendeu e nao recebeu'
	WHEN  DispositionId = 	'381'	THEN	'Descontrole Fnanceiro - Recebeu mas gastou o dinheiro'
	WHEN  DispositionId = 	'382'	THEN	'Outros'
			END AS DESCR_TAB,
'TENTATIVAS' AS TENTA_,
CASE
	WHEN DispositionId in ('101',	'103',	'104',	'105',	'106',	'107',	'108',	'109',	'110',	'111',	'112',	'113',	'114',	'115',	'116',	'117',	'118',	'130',	'131',	'132',	
	'133',	'134',	'135',	'136',	'137',	'138',	'139',	'140',	'141',	'142',	'143',	'144',	'145',	'146',	'147',	'148',	'150',	'151',	'152',	'153',	'154',	'155',	'156',	
	'157',	'158',	'159',	'162',	'163',	'164',	'165',	'166',	'167',	'168',	'169',	'176',	'177',	'179',	'185',	'186',	'187',	'188',	'189',	'190',	'191',	'192',	'193',	
	'194',	'195',	'196',	'197',	'198',	'199',	'207',	'208',	'209',	'210',	'211',	'212',	'213',	'214',	'215',	'216',	'217',	'220',	'221',	'222',	'223',	'224',	'225',	
	'226',	'227',	'228',	'229',	'230',	'231',	'232',	'233',	'234',	'235',	'236',	'237',	'238',	'239',	'240',	'242',	'243',	'244',	'245',	'246',	'248',	'249',	'250',	
	'251',	'252',	'253',	'254',	'255',	'256',	'257',	'258',	'259',	'260',	'261',	'262',	'263',	'264',	'265',	'266',	'267',	'268',	'269',	'270',	'271',	'273',	'274',	
	'275',	'276',	'277',	'278',	'279',	'280',	'281',	'282',	'283',	'284',	'285',	'286',	'287',	'288',	'289',	'290',	'291',	'292',	'293',	'294',	'295',	'296',	'297',	
	'298',	'299',	'300',	'301',	'302',	'303',	'304',	'305',	'309',	'310',	'311',	'313',	'314',	'315',	'316',	'317',	'318',	'319',	'321',	'323',	'325',	'326',	'327',	
	'331',	'332',	'333',	'334',	'335',	'336',	'337',	'338',	'339',	'340',	'341',	'342',	'343',	'344',	'345',	'346',	'347',	'348',	'349',	'350',	'351',	'352',	'353',	
	'354',	'355',	'356',	'357',	'358',	'359',	'360',	'361',	'362',	'363',	'366',	'367',	'368',	'369',	'370',	'371',	'373',	'374',	'378',	'379',	'380',	'381') then 'ALO' ELSE '' END AS ALO_,
CASE
	WHEN DispositionId in ('274','275','276','279','281','336','337','338','339','340','341','342','343','363') THEN 'CPC' ELSE '' END AS CPC_,
	A.MailingName AS MAILING

FROM [10.155.4.17].[EXPORTDATA].[DBO].CALLDATA A
WHERE AgentStart is not null
AND CONVERT(DATE, A.CallStart, 103) = CONVERT(DATE, GETDATE(), 103)
AND MailingName IS NOT NULL
AND MailingName LIKE '%AVON%'