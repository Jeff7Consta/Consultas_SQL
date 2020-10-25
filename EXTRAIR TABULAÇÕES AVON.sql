select distinct
CustomerId as EC
from CallData
where Convert(date, CallStart, 103) Between '2020-07-28' and '2020-07-29'
and DispositionId = 339
