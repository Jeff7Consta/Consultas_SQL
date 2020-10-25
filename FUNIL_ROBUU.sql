--IF OBJECT_ID('tempdb..##RO_FIN') IS NOT NULL DROP TABLE ##RO_FIN
SELECT
CONVERT(DATE, datahoraEvento, 103) AS DATA_ACIONAMENTO,
CASE
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 1 THEN 'JANEIRO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 2 THEN 'FEVEREIRO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 3 THEN 'MARÇO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 4 THEN 'ABRIL'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 5 THEN 'MAIO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 6 THEN 'JUNHO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 7 THEN 'JULHO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 8 THEN 'AGOSTO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 9 THEN 'SETEMBRO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 10 THEN 'OUTUBRO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 11 THEN 'NOVEMBRO'
	WHEN MONTH(CONVERT(DATE, datahoraEvento, 103)) = 12 THEN 'DEZEMBRO'
	ELSE '' END AS MES_TEXT,
	MONTH(CONVERT(DATE, datahoraEvento, 103)) AS MES_NUMBER,
	
LEFT(CONVERT(VARCHAR, datahoraEvento, 108),2) AS HORA_ACIONAMENTO,
descricaoEvento AS DESCRICAO_EVENTO,
cpfcnpj AS CPF,
nomeUsuario AS OPERADOR,
TelefoneWhatsappPrincipal AS TEL_WHATS,
DescricaoCanal AS CANAL,
CARTEIRA_2 AS CARTEIRA,
'ATENDIDO' AS ATENDIDOS,
CASE				
WHEN	descricaoEvento	=	'Previsão de Pagamento'	THEN 'CPC'
WHEN	descricaoEvento	=	'Sem Previsão Pagamento'	THEN 'CPC'
WHEN	descricaoEvento	=	'Contrato não está no Escritório'	THEN 'CPC'
WHEN	descricaoEvento	=	'Sem Interesse'	THEN 'CPC'
WHEN	descricaoEvento	=	'Já Negociado'	THEN 'CPC'
WHEN	descricaoEvento	=	'Boleto Enviado'	THEN 'CPC'
WHEN	descricaoEvento	=	'Reenvio do Boleto'	THEN 'CPC'
WHEN	descricaoEvento	=	'Comprovante'	THEN 'CPC'
WHEN	descricaoEvento	=	'Promessa finaliza'	THEN 'CPC'
WHEN	descricaoEvento	=	'Alega Pagamento'	THEN 'CPC'
WHEN	descricaoEvento	=	'Cliente Direcionado para Loja'	THEN 'CPC'
WHEN	descricaoEvento	=	'Promessa de Pagamento'	THEN 'CPC'
WHEN	descricaoEvento	=	'Em Negociação'	THEN 'CPC'
WHEN	descricaoEvento	=	'Entrega Amigável/Refin'	THEN 'CPC'
WHEN	descricaoEvento	=	'Veículo com Terceiros'	THEN 'CPC' ELSE ''
END AS CPC_COUNT,
CASE				
WHEN	descricaoEvento	=	'Previsão de Pagamento'	THEN 'ACORDO'
WHEN	descricaoEvento	=	'Boleto Enviado'	THEN 'ACORDO'
WHEN	descricaoEvento	=	'Promessa de Pagamento'	THEN 'ACORDO'
WHEN	descricaoEvento	=	'Entrega Amigável/Refin'	THEN 'ACORDO'
ELSE '' END AS ACORDO_COUNT
----INTO ##RO_FIN
FROM ADCOBMIS01..ROBBU_FINALIZACOES

select max(datahoraEvento) from ADCOBMIS01..ROBBU_FINALIZACOES

SELECT mAX(Data_de_Envio) FROM ADCOBMIS01..DADOS_EMAIL_LOCALCRED