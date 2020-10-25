DECLARE @data_EMAIL VARCHAR (20)
SET @data_EMAIL = (SELECT CONVERT(CHAR,GETDATE(),103))
 
DECLARE @assunto VARCHAR (200)
SET @assunto = 'INATIVAÇÃO_TELEFONES_ED.ABRIL '+@data_EMAIL
 
DECLARE @arquivo VARCHAR(5000)
SET @arquivo = '\\10.155.4.51\itf_in\AVON\SMS\SMS_AVON_FASE_1'+'_'+REPLACE((CONVERT(VARCHAR,CONVERT(DATE,(GETDATE())))),'-','')+'.csv'
 
Declare @Body VARCHAR (500)
 
Set @Body = 'Prezados, Bom Dia!
 
Segue base para inativação de telefones da carteira Editora Abril.
 
@Control,
 
Por gentileza incluir os telefones em blacklist por 30 dias.
 
Atenciosamente,

Editora Abril - Robô '
 
EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Rotinas_Editora_Abril',
--@recipients = 'pettyalessandra@localcred.com.br;jefferson.azevedo@localcred.com.br;controle.dti@melhadoadvogados.com.br;alana.sousa@localcred.com.br',
--@copy_recipients = 'erikaucheli@localcred.com.br;adilson.almeida@localcred.com.br;alana.sousa@localcred.com.br;kassia.nascimento@localcred.com.br;mariane.silva@localcred.com.br;patricia.odilon@localcred.com.br;paulo.araujo@localcred.com.br;rubens.carneiro@localcred.com.br',
@blind_copy_recipients = 'jefferson.azevedo@localcred.com.br',
@subject = @assunto,
@body = @Body,
 
@file_attachments = @arquivo
 
GO