IF OBJECT_ID('tempdb..##BASEUNIQ') IS NOT NULL DROP TABLE ##BASEUNIQ

SELECT DISTINCT CUSTOMERID INTO ##BASEUNIQ FROM CallData
where Convert(date, CallStart, 103) = '2020-08-10'
And CustomerId is not null

SELECT
 Convert(date, B.CallStart, 103) as Data_Ligacao,
 A.CustomerId AS EC,
 b.MailingName,
 COUNT(B.CustomerId) AS TENT_CTT

FROM ##BASEUNIQ A 
INNER JOIN CallData B ON A.CustomerId = B.CustomerId
WHERE  Convert(date, b.CallStart, 103) = '2020-08-10'

GROUP BY
Convert(date, B.CallStart, 103),
 A.CustomerId,
 B.DispositionId


 select distinct CustomerId from CallData
where Convert(date, CallStart, 103) between '2020-08-01' and '2020-08-10'
And MailingName like 'AVONFASE1%'