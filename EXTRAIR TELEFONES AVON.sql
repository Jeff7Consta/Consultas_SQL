--select distinct
--CustomerId as EC
--from CallData
--where Convert(date, CallStart, 103) Between '2020-07-28' and '2020-07-29'
--and DispositionId = 339

SELECT 
A.EC,
A.RA,
A.NOME,
A.TELEFONE

FROM ADCOBMIS01..AVON_ESCORAGEM_TELEFONES A
WHERE A.PRIORIDADE = 1
AND LEN(A.TELEFONE) = 11
AND CAST(A.EC AS VARCHAR) IN ()