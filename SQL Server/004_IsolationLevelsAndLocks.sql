use testdb

/*LINKS: 
https://blog.sqlauthority.com/2015/07/03/sql-server-difference-between-read-committed-snapshot-and-snapshot-isolation-level/
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

--Read Committed (Default Behavior)
BEGIN TRANSACTION; --1. start transaction, update the row, it will block read from the second session
update t2 set col1 = 'xxx' where id = 1 
commit; --3. finish the transaction, after this select from the second session should return the results

--Read Committed Snapshot On (this is not separate isolation level but just optimistic implementation of READ COMMITED)
ALTER DATABASE TestDB SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE --0. enable snapshot, it should be run in separated session (another tab in SQL Mgmt Studio)
GO

BEGIN TRANSACTION; --1. start transaction, update the row, it will block read from the second session
update t2 set col1 = 'xxx' where id = 1 
commit; --3. finish the transaction, after this select from the second session should return the results