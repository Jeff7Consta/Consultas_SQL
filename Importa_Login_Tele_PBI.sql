	DELETE from ADCOBMIS01..ROBBU_FINALIZACOES 
	WHERE CONVERT(DATE, datahoraEvento, 103)  = CONVERT(DATE, GETDATE()-1, 103)

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

set @vchArquivo = 'ROBBU_EVENTOS_FIN_'+ REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE()-1)))),'-','')
set @vchArquivoExtensao = '.csv'
set @vchDiretorioOrigem = '\\10.155.4.51\itf_in\MIS\ROBBU\'
set @vchTabelaDestino = 'ROBBU_FINALIZACOES'
set @fieldterminator = ';'
set @field = ''';'''

	set @vchSQL = @vchDiretorioOrigem + @vchArquivo + @vchArquivoExtensao

	set @SQLextracaodados =  'bulk insert ' + @vchTabelaDestino 
		+ ' FROM ''' + @vchSQL + ''' WITH (FIELDTERMINATOR =' + @field + ')'

	exec(@SQLextracaodados)

		