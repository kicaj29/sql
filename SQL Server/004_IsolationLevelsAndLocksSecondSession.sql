use testdb

--Read Committed (Default Behavior)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
BEGIN TRANSACTION;
select * from t2 where id = 1	--2. try read the row, it will be blocked 										
COMMIT TRANSACTION;

--Read Committed Snapshot On
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
go
BEGIN TRANSACTION;
select * from t2 where id = 1	--2. try read the row, it will be NOT be blocked
COMMIT TRANSACTION;