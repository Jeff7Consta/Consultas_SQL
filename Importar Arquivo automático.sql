
DELETE ADCOBMIS01..DADOS_TELEMETRIA_ALM_EAVM
WHERE [DATA] = CONVERT(DATE, GETDATE(), 103)

USE ADCOBMIS01
GO
declare @vchArquivo as varchar(50)
declare @vchArquivoExtensao as varchar(50)
declare @vchDiretorioOrigem as varchar(4000)
declare @vchTabelaDestino as varchar(200)
declare @intQTDArquivos as integer
declare @intLinhasCabecalho as integer
declare @fieldterminator as varchar(3)
declare @vchSQL as varchar(700)
declare @SQLextracaodados as varchar(700)
declare @field as varchar(3)

set @vchArquivo = 'ALM_ARCHIVES_' + REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')
set @vchArquivoExtensao = '.csv'
set @vchDiretorioOrigem = '\\10.155.4.51\itf_in\BRADESCO_EAVM\ALM_ARQUIVOS\DISCADOR\'
set @vchTabelaDestino = 'DADOS_TELEMETRIA_ALM_EAVM'
set @fieldterminator = ';'
set @field = ''';'''

	set @vchSQL = @vchDiretorioOrigem + @vchArquivo + @vchArquivoExtensao

	set @SQLextracaodados =  'bulk insert ' + @vchTabelaDestino 
		+ ' FROM ''' + @vchSQL + ''' WITH (FIELDTERMINATOR =' + @field + ')'

	exec(@SQLextracaodados)

