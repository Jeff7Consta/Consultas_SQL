USE msdb
Go

SELECT
      j.name,
      h.step_name ,--um job pode ter diversos passos
      CONVERT(CHAR(10), CAST(STR(h.run_date,8, 0) AS dateTIME), 111) as [Data],
      STUFF(STUFF(RIGHT('000000' + CAST ( h.run_time AS VARCHAR(6 ) ) ,6),5,0,':'),3,0,':') as [Hora]
FROM
      sysjobhistory h
inner join sysjobs j ON j.job_id = h.job_id
WHERE h.step_name != '(Job outcome)'
AND CAST(STR(h.run_date,8, 0) AS date) >= CONVERT(CHAR(10), CAST(getdate()-5 AS dateTIME), 111) AND j.name NOT LIKE ('%DBA%') -- Usar apenas no banco MIS

ORDER BY
      h.run_date desc,
      h.run_time desc,
      j.name desc