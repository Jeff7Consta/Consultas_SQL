
--
--  Deletar em tabela grande
--
DECLARE @Deleted_Rows INT;
SET @Deleted_Rows = 1;
 
 
WHILE (@Deleted_Rows > 0)
  BEGIN
  -- Exclua um pequeno número de linhas por vez
     DELETE TOP (100000)  ADCOBMIS01..avon_carteira_bkp  
     WHERE DATA_BASE <= '2020-08-31 23:59:59'
 
  SET @Deleted_Rows = @@ROWCOUNT;
END


TRUNCATE TABLE ADCOBMIS01..Carteira_Kroton  

use ADCOBMIS01;
ALTER DATABASE ADCOBMIS01 SET RECOVERY SIMPLE;
DBCC SHRINKFILE('ADCOBMIS', 10);
DBCC SHRINKFILE('ADCOBMIS_log', 0, TRUNCATEONLY);
ALTER DATABASE ADCOBMIS01 SET RECOVERY FULL;
 