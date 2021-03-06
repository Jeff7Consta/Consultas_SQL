
SELECT 
A.dataEntrada AS DATA,
CASE
	WHEN MONTH(A.dataEntrada)= 1  THEN 'JANEIRO'
	WHEN MONTH(A.dataEntrada) =2  THEN 'FEVEREIRO'
	WHEN MONTH(A.dataEntrada) =3  THEN 'MARÇO'
	WHEN MONTH(A.dataEntrada) =4  THEN 'ABRIL'
	WHEN MONTH(A.dataEntrada) =5  THEN 'MAIO'
	WHEN MONTH(A.dataEntrada) =6 THEN 'JUNHO'
	WHEN MONTH(A.dataEntrada) =7  THEN 'JULHO'
	WHEN MONTH(A.dataEntrada) =8  THEN 'AGOSTO'
	WHEN MONTH(A.dataEntrada) =9  THEN 'SETEMBRO'
	WHEN MONTH(A.dataEntrada) =10  THEN 'OUTUBRO'
	WHEN MONTH(A.dataEntrada) =11  THEN 'NOVEMBRO'
	WHEN MONTH(A.dataEntrada) =12  THEN 'DEZEMBRO' END AS MES_TEXT,

month(A.dataEntrada) as MES_NUMBER,

A.CARTEIRA_2,
COUNT(A.CARTEIRA_2) As QUANTIDADE

FROM (

SELECT [nomepessoa]
      ,[cpfcnpj]
      ,[codpessoacliente]
      ,[descricaocanal]
      ,[qtdtotalmensagensdia]
      ,Convert(date, [data],103) as data
      ,[usuariofidelizado]
      ,Convert(date, [dataEntrada],103) as dataEntrada
      ,[smsprincipal]
      ,[whatsappprincipal]	
      ,[ultimoevento]
      ,[Carteiras]	
      ,[CARTEIRA_2]
  FROM [ADCOBMIS01].[dbo].[ROBBU_ATENDIDOS]
 )A

 GROUP BY
 A.dataEntrada,
 CASE
	WHEN MONTH(A.dataEntrada)= 1  THEN 'JANEIRO'
	WHEN MONTH(A.dataEntrada) =2  THEN 'FEVEREIRO'
	WHEN MONTH(A.dataEntrada) =3  THEN 'MARÇO'
	WHEN MONTH(A.dataEntrada) =4  THEN 'ABRIL'
	WHEN MONTH(A.dataEntrada) =5  THEN 'MAIO'
	WHEN MONTH(A.dataEntrada) =6 THEN 'JUNHO'
	WHEN MONTH(A.dataEntrada) =7  THEN 'JULHO'
	WHEN MONTH(A.dataEntrada) =8  THEN 'AGOSTO'
	WHEN MONTH(A.dataEntrada) =9  THEN 'SETEMBRO'
	WHEN MONTH(A.dataEntrada) =10  THEN 'OUTUBRO'
	WHEN MONTH(A.dataEntrada) =11  THEN 'NOVEMBRO'
	WHEN MONTH(A.dataEntrada) =12  THEN 'DEZEMBRO' END ,

month(A.dataEntrada),
 A.CARTEIRA_2