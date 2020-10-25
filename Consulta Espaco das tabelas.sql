--SELECT Min(DATA_BASE) AS PRI_DATA_CARTEIRA_AVON FROM ADCOBMIS01..Carteira_Avon

--SELECT Min(DATA_BASE) AS PRI_DATA_AVON_CARTEIRA_BKP FROM ADCOBMIS01..AVON_CARTEIRA_BKP

--select top 10 *  from ADCOBMIS01..AVON_CARTEIRA_BKP

--SELECT Min(DATA_BASE)  AS PRI_DATA_AVON_TELEFONES FROM ADCOBMIS01..AVON_TELEFONES

--SELECT Min([DATA]) AS PRI_DATA_AVON_FUNIL_DT_BKP FROM ADCOBMIS01..AVON_FUNIL_DT_BKP

/*CONSULTA TAMANHO DAS TABELAS*/

USE ADCOBMIS01

GO

SELECT
    t.NAME AS Entidade,
    p.rows AS Registros,
    SUM(a.total_pages) * 8 AS EspacoTotalKB,
    SUM(a.used_pages) * 8 AS EspacoUsadoKB,
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS EspacoNaoUsadoKB
FROM
    sys.tables t
INNER JOIN
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN
    sys.schemas s ON t.schema_id = s.schema_id
WHERE
    t.NAME NOT LIKE 'dt%'
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255
	--AND t.NAME = 'AVON_CARTEIRA_BKP'
GROUP BY
    t.Name, s.Name, p.Rows
ORDER BY
    Registros DESC

