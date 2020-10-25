SELECT 
DATA_BASE 			 AS  DATA_BASE 			, 
ID_CLIENTE 			 AS  ID_CLIENTE 			, 
RA 					 AS  RA 					, 
NOME 				 AS  NOME 				, 
CPF 				 AS  CPF 				, 
SEXO 				 AS  SEXO 				, 
ID_CONTRATO 		 AS  ID_CONTRATO 		, 
CONTRATO 			 AS  CONTRATO 			, 
CAMPANHA 			 AS  CAMPANHA 			, 
ANO_CAMPANHA 		 AS  ANO_CAMPANHA 		, 
UF 					 AS  UF 					, 
DT_VENCIMENTO 		 AS  DT_VENCIMENTO 		, 
ATRASO 				 AS  ATRASO 				, 
DT_INCLUSAO 		 AS  DT_INCLUSAO 		, 
ID_DIVIDA 			 AS  ID_DIVIDA 			, 
VL_SALDO   	 AS  VL_SALDO 			, 
FAIXA_ATRASO 		 AS  FAIXA_ATRASO 		, 
LOA 				 AS  LOA 				, 
SETOR 				 AS  SETOR 				, 
QUINTIL 			 AS  QUINTIL 			, 
FASE_COB 			 AS  FASE_COB 			, 
RISCO_COB 			 AS  RISCO_COB 			, 
IMPORT_cob 			 AS  IMPORT_cob 			, 
ACORDO_ATIVO 		 AS  ACORDO_ATIVO 		, 
DT_ACORDO 			 AS  DT_ACORDO 			, 
DEPOSITO 			 AS  DEPOSITO 			, 
CONT_CONTRATOS 		 AS  CONT_CONTRATOS 		 
	FROM 
	dbo.CARTEIRA_AVON_V3 fv3
	where
	convert(date,fv3.DT_INCLUSAO,103) >= '20200901'
	AND fv3.IMPORT_cob='002'
	and fv3.DATA_BASE = (select min(t.DATA_BASE ) from dbo.CARTEIRA_AVON_V3 t where t.IMPORT_cob ='002' and t.ID_CLIENTE = fv3.ID_CLIENTE  and convert(date,t.DT_INCLUSAO,103) >= '20200901')
	ORDER BY CPF,1;
	
SELECT 
DATA_BASE 			 AS  DATA_BASE 			, 
ID_CLIENTE 			 AS  ID_CLIENTE 			, 
RA 					 AS  RA 					, 
NOME 				 AS  NOME 				, 
CPF 				 AS  CPF 				, 
SEXO 				 AS  SEXO 				, 
ID_CONTRATO 		 AS  ID_CONTRATO 		, 
CONTRATO 			 AS  CONTRATO 			, 
CAMPANHA 			 AS  CAMPANHA 			, 
ANO_CAMPANHA 		 AS  ANO_CAMPANHA 		, 
UF 					 AS  UF 					, 
DT_VENCIMENTO 		 AS  DT_VENCIMENTO 		, 
ATRASO 				 AS  ATRASO 				, 
DT_INCLUSAO 		 AS  DT_INCLUSAO 		, 
ID_DIVIDA 			 AS  ID_DIVIDA 			, 
VL_SALDO 			 AS  VL_SALDO 			, 
FAIXA_ATRASO 		 AS  FAIXA_ATRASO 		, 
LOA 				 AS  LOA 				, 
SETOR 				 AS  SETOR 				, 
QUINTIL 			 AS  QUINTIL 			, 
FASE_COB 			 AS  FASE_COB 			, 
RISCO_COB 			 AS  RISCO_COB 			, 
IMPORT_cob 			 AS  IMPORT_cob 			, 
ACORDO_ATIVO 		 AS  ACORDO_ATIVO 		, 
DT_ACORDO 			 AS  DT_ACORDO 			, 
DEPOSITO 			 AS  DEPOSITO 			, 
CONT_CONTRATOS 		 AS  CONT_CONTRATOS 		 
	FROM 
	dbo.CARTEIRA_AVON_V3_DIA fv3
	where
	convert(date,fv3.DT_INCLUSAO,103)=fv3.DATA_BASE 
	-- and fv3.DATA_BASE = (select min(t.DATA_BASE ) from dbo.CARTEIRA_AVON_V3 t where t.IMPORT_cob ='002' and t.ID_CLIENTE = fv3.ID_CLIENTE  and convert(date,t.DT_INCLUSAO,103) BETWEEN '20200901' AND '20200914')
	and fv3.IMPORT_cob='002'
	ORDER BY CPF,1;

	SELECT 
DATA_BASE 			 AS  DATA_BASE 			, 
ID_CLIENTE 			 AS  ID_CLIENTE 			, 
RA 					 AS  RA 					, 
NOME 				 AS  NOME 				, 
CPF 				 AS  CPF 				, 
SEXO 				 AS  SEXO 				, 
ID_CONTRATO 		 AS  ID_CONTRATO 		, 
CONTRATO 			 AS  CONTRATO 			, 
CAMPANHA 			 AS  CAMPANHA 			, 
ANO_CAMPANHA 		 AS  ANO_CAMPANHA 		, 
UF 					 AS  UF 					, 
DT_VENCIMENTO 		 AS  DT_VENCIMENTO 		, 
ATRASO 				 AS  ATRASO 				, 
DT_INCLUSAO 		 AS  DT_INCLUSAO 		, 
ID_DIVIDA 			 AS  ID_DIVIDA 			, 
VL_SALDO 			 AS  VL_SALDO 			, 
FAIXA_ATRASO 		 AS  FAIXA_ATRASO 		, 
LOA 				 AS  LOA 				, 
SETOR 				 AS  SETOR 				, 
QUINTIL 			 AS  QUINTIL 			, 
FASE_COB 			 AS  FASE_COB 			, 
RISCO_COB 			 AS  RISCO_COB 			, 
IMPORT_cob 			 AS  IMPORT_cob 			, 
ACORDO_ATIVO 		 AS  ACORDO_ATIVO 		, 
DT_ACORDO 			 AS  DT_ACORDO 			, 
DEPOSITO 			 AS  DEPOSITO 			, 
CONT_CONTRATOS 		 AS  CONT_CONTRATOS 		 
	FROM 
	dbo.CARTEIRA_AVON_V3_DIA fv3
	where
	convert(date,fv3.DT_INCLUSAO,103) = '20200902'
	AND fv3.IMPORT_cob='002';