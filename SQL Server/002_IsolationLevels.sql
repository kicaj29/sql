/*
Dirty read occurs wherein one transaction is changing the tuple/record, 
and a second transaction can read this tuple/record before the original change has been committed or rolled back. 
This is known as a dirty read scenario because there is always the possibility that the first transaction may rollback the change,
resulting in the second transaction having read an invalid value. 
*/

/*
Non Repeatable Reads happen when in a same transaction same query yields different results. 
This happens when another transaction updates the data returned by other transaction.
This is not case when we deal with new rows! For new rows we have phantom read definition.
I think it is also case when in the second transaction we delete row and the second select from the first transaction
does not return this record when the first select in this transaction returns it.
Deleted rows are persisted (the second select will return them) in the same transaction if we use at least repeatable read isolation level!
*/

/*
Phantom read occurs where in a transaction same query executes twice, and the second result set includes rows that weren't visible in the first result set. 
This situation is caused by another transaction inserting new rows between the execution of the two queries.
So this is case when we have to deal with new rows!
*/

/*LINKS: 
http://en.wikipedia.org/wiki/Isolation_%28database_systems%29#Serializable
https://msdn.microsoft.com/en-us/library/ms378149%28v=sql.110%29.aspx
*/


use testdb

drop table t2

CREATE TABLE [dbo].[t2](
 [id] [bigint] IDENTITY(1,1) NOT NULL,
 [col1] [nchar](10) NULL,
 [col2] [nchar](10) NULL,
 [col3] [datetime] NOT NULL,
 [age] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t2] ADD  CONSTRAINT [DF_t2_col3]  DEFAULT (getdate()) FOR [col3]
GO

insert into t2 (col1, col2, age) values ('aaa', 'bbb', 10)
insert into t2 (col1, col2, age) values ('ccc', 'ddd', 20)
insert into t2 (col1, col2, age) values ('eee', 'fff', 30)
insert into t2 (col1, col2, age) values ('ggg', 'hhh', 40)

select * from t2


--DIRTY READ EXAMPLE: it occurs only if we set isolation level for this transaction on read uncommitted
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED --READ UNCOMMITTED
go
BEGIN TRANSACTION;
select * from t2 where id = 1	--1. read thre row (col1 should be aaa)

WAITFOR DELAY '00:00:03'		--we need wait a few seconds here to have enough time to update the record in the second session

select * from t2 where id = 1	--3. now read the same record again. Transaction in the second session is not commited yet so dirty ready will occur!
								--col1 should be xxx. If isolation level would be greater than read uncommitted we will get value aaa!
								
WAITFOR DELAY '00:00:08'		--wait for rollback from the second session

select * from t2 where id = 1	--4. select again the same record, this time we should get the same data as in step 1
								--col1 should be again aaa (because the second transaction has been rolled back)
COMMIT TRANSACTION;

--NON REPEATABLE READ: it occures if we set isolation level for this transaction on Read uncommitted or Read committed

SET TRANSACTION ISOLATION LEVEL READ COMMITTED --, Repeatable read												
go
BEGIN TRANSACTION;
select * from t2 where id = 1	--1. read thre row (col1 should be aaa)
select * from t2 where id = 2   --read row that will be deleted

WAITFOR DELAY '00:00:05'		--we need wait a few seconds here to have enough time to update the record and commit it in the second session

select * from t2 where id = 1	--3. now the transaction from the second session has been committed.
								--We read again record with id = 1 and we get different value (zzz) than in previous read (step 1) if this 
								--transaction isolation level is READ UNCOMMITTED or READ COMMITTED. If we set greater isolation level we will get the same data (aaa)
								--that we got in previous read (step1)	
select * from t2 where id = 2	--if we have at least Repeatable read isolation level we will see  this row again even it was deleted by another committed transaction!
												
COMMIT TRANSACTION;

--PHANTOM READ: it occurs for Read uncommitted, Read committed, Repeatable read

SET TRANSACTION ISOLATION LEVEL Repeatable read --Repeatable read, Snapshot, Serializable
go
BEGIN TRANSACTION;
select * from t2 where age between 20 and 30	--1. should return two rows

WAITFOR DELAY '00:00:08'						--we need wait a few seconds here to have enough time to commit changes from the second transaction

select * from t2 where age between 20 and 30	--3. should return three rows 2 old + 1 new inserted by the second transaction.
												--if we set isolation level on Snapshot or Serializable we will get exactly the same data as in step 1
												--NOTE: if we delete row in the second transaction we will see this record in this step if we used at least Repeatable read isolation level
												--it looks that repeatable read preserves rows in current transaction deleted by another transaction!
commit transaction