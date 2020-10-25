 
IF OBJECT_ID('tempdb..##Base') IS NOT NULL DROP TABLE ##Base

SELECT 
c.Data_de_Envio,
c.CARTEIRA,
c.Email_Status,
Count(c.Email) as Envio
Into ##Base
FROM(


SELECT
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
)C

Group By 
c.Data_de_Envio,
c.CARTEIRA,
c.Email,
c.Email_Status

IF OBJECT_ID('tempdb..##Meucu') IS NOT NULL DROP TABLE ##Meucu
Select * into ##Meucu from ##Base
Group By 
Envio,
Data_de_Envio,
CARTEIRA,
Email_Status

Select
b.Data_de_Envio,
b.CARTEIRA,
b.Email_Status,
b.Envio,
Sum(a.Envio) as Envio_Base
      ,CASE
		WHEN DATEPART(DW,b.Data_de_Envio) = 1 THEN 'DOMINGO'
		WHEN DATEPART(DW,b.Data_de_Envio) = 2 THEN 'SEGUNDA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 3 THEN 'TERÇA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 4 THEN 'QUARTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 5 THEN 'QUINTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 6 THEN 'SEXTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 7 THEN 'SÁBADO'
		END AS 'DDS'
	,CASE
		WHEN MONTH(b.Data_de_Envio)	= 1  THEN 'JANEIRO'
		WHEN MONTH(b.Data_de_Envio)	= 2  THEN 'FEVEREIRO'
		WHEN MONTH(b.Data_de_Envio)	= 3  THEN 'MARÇO'
		WHEN MONTH(b.Data_de_Envio)	= 4  THEN 'ABRIL'
		WHEN MONTH(b.Data_de_Envio)	= 5  THEN 'MAIO'
		WHEN MONTH(b.Data_de_Envio)	= 6  THEN 'JUNHO'
		WHEN MONTH(b.Data_de_Envio)	= 7  THEN 'JULHO'
		WHEN MONTH(b.Data_de_Envio)	= 8  THEN 'AGOSTO'
		WHEN MONTH(b.Data_de_Envio)	= 9  THEN 'SETEMBRO'
		WHEN MONTH(b.Data_de_Envio)	= 10 THEN 'OUTUBRO'
		WHEN MONTH(b.Data_de_Envio)	= 11 THEN 'NOVEMBRO'
		WHEN MONTH(b.Data_de_Envio)	= 12 THEN 'DEZEMBRO'
		END AS 'MES'				
,YEAR(b.Data_de_Envio) AS ANO	
from ##Meucu b
Inner Join ##Base a on a.Data_de_Envio = b.Data_de_Envio And a.CARTEIRA = b.CARTEIRA and a.Email_Status = b.Email_Status and a.Envio = B.Envio
Group By
b.Data_de_Envio,
b.CARTEIRA,
b.Envio,
b.Email_Status
      ,CASE
		WHEN DATEPART(DW,b.Data_de_Envio) = 1 THEN 'DOMINGO'
		WHEN DATEPART(DW,b.Data_de_Envio) = 2 THEN 'SEGUNDA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 3 THEN 'TERÇA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 4 THEN 'QUARTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 5 THEN 'QUINTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 6 THEN 'SEXTA-FEIRA'
		WHEN DATEPART(DW,b.Data_de_Envio) = 7 THEN 'SÁBADO'
		END
	,CASE
		WHEN MONTH(b.Data_de_Envio)	= 1  THEN 'JANEIRO'
		WHEN MONTH(b.Data_de_Envio)	= 2  THEN 'FEVEREIRO'
		WHEN MONTH(b.Data_de_Envio)	= 3  THEN 'MARÇO'
		WHEN MONTH(b.Data_de_Envio)	= 4  THEN 'ABRIL'
		WHEN MONTH(b.Data_de_Envio)	= 5  THEN 'MAIO'
		WHEN MONTH(b.Data_de_Envio)	= 6  THEN 'JUNHO'
		WHEN MONTH(b.Data_de_Envio)	= 7  THEN 'JULHO'
		WHEN MONTH(b.Data_de_Envio)	= 8  THEN 'AGOSTO'
		WHEN MONTH(b.Data_de_Envio)	= 9  THEN 'SETEMBRO'
		WHEN MONTH(b.Data_de_Envio)	= 10 THEN 'OUTUBRO'
		WHEN MONTH(b.Data_de_Envio)	= 11 THEN 'NOVEMBRO'
		WHEN MONTH(b.Data_de_Envio)	= 12 THEN 'DEZEMBRO'
		END				
,YEAR(b.Data_de_Envio)

Order by Carteira Asc