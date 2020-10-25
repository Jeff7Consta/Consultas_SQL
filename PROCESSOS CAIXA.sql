SELECT
A.NUMCONTRDIV AS CONTRATO, 
B.NOMCLI AS CLIENTE,
A.NUMPROCFORUM AS PROCESSO,
A.VLRPROC AS [VALOR DA A��O],
'' AS [ESTATUS PROCESSUAL]
FROM ADCOBDAT..JU006 A
LEFT JOIN ADCOBDAT..CO001 B ON A.NUMCONTRDIV = B.NUMCONTRDIV AND A.CODEMPRESA = B.CODEMPRESA
WHERE A.CODEMPRESA in(66001, 66002, 67001)