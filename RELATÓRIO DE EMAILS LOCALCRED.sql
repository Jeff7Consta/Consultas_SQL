
SELECT

Data_de_Envio,
CARTEIRA,
DDS,
MES,
ANO,
Email_Status,
COUNT(CARTEIRA) AS Quantidade

FROM (
SELECT
ROW_NUMBER()over(partition by A.Email order by A.Email) AS QTD_CTT,
A.Configuracao AS CARTEIRA,
Convert(date, A.Data_de_Envio, 103) as Data_de_Envio,
A.Email,
A.Email_Status,
A.Erro_Descricao,
Convert(date, A.Data_de_Atualizacao, 103) as Data_de_Atualizacao,
A.Lista
      ,CASE
		WHEN DATEPART(DW,A.Data_de_Envio) = 1 THEN 'DOMINGO'
		WHEN DATEPART(DW,A.Data_de_Envio) = 2 THEN 'SEGUNDA-FEIRA'
		WHEN DATEPART(DW,A.Data_de_Envio) = 3 THEN 'TERÇA-FEIRA'
		WHEN DATEPART(DW,A.Data_de_Envio) = 4 THEN 'QUARTA-FEIRA'
		WHEN DATEPART(DW,A.Data_de_Envio) = 5 THEN 'QUINTA-FEIRA'
		WHEN DATEPART(DW,A.Data_de_Envio) = 6 THEN 'SEXTA-FEIRA'
		WHEN DATEPART(DW,A.Data_de_Envio) = 7 THEN 'SÁBADO'
		END AS 'DDS'
	,CASE
		WHEN MONTH(A.Data_de_Envio)	= 1  THEN 'JANEIRO'
		WHEN MONTH(A.Data_de_Envio)	= 2  THEN 'FEVEREIRO'
		WHEN MONTH(A.Data_de_Envio)	= 3  THEN 'MARÇO'
		WHEN MONTH(A.Data_de_Envio)	= 4  THEN 'ABRIL'
		WHEN MONTH(A.Data_de_Envio)	= 5  THEN 'MAIO'
		WHEN MONTH(A.Data_de_Envio)	= 6  THEN 'JUNHO'
		WHEN MONTH(A.Data_de_Envio)	= 7  THEN 'JULHO'
		WHEN MONTH(A.Data_de_Envio)	= 8  THEN 'AGOSTO'
		WHEN MONTH(A.Data_de_Envio)	= 9  THEN 'SETEMBRO'
		WHEN MONTH(A.Data_de_Envio)	= 10 THEN 'OUTUBRO'
		WHEN MONTH(A.Data_de_Envio)	= 11 THEN 'NOVEMBRO'
		WHEN MONTH(A.Data_de_Envio)	= 12 THEN 'DEZEMBRO'
		END AS 'MES'				
,YEAR(A.Data_de_Envio) AS ANO	
FROM ADCOBMIS01..DADOS_EMAIL_LOCALCRED A
)CONTAGEM
GROUP BY 
Data_de_Envio,
CARTEIRA,
DDS,
MES,
ANO,
Email_Status

ORDER BY Data_de_Envio ASC