/*example 1 https://social.msdn.microsoft.com/Forums/sqlserver/en-US/c00e8ee2-4d0a-4775-a758-6602c536b0a3/lock-single-row-for-update?forum=transactsql/ */
use testdb
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t1](
 [id] [bigint] IDENTITY(1,1) NOT NULL,
 [col1] [nchar](10) NULL,
 [col2] [nchar](10) NULL,
 [col3] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t1] ADD  CONSTRAINT [DF_t1_col3]  DEFAULT (getdate()) FOR [col3]
GO

CREATE UNIQUE NONCLUSTERED INDEX [t1_id_index] ON [dbo].[t1] 
(
 [id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
GO

insert into dbo.t1 (col1, col2) values ('Jacek', 'Kowalski')
insert into dbo.t1 (col1, col2) values ('Jacek1', 'Kowalski1')
insert into dbo.t1 (col1, col2) values ('Jacek2', 'Kowalski2')

/*The SELECT statement will issue a Shared Lock which means the transaction is looking at the data and someone else can to.*/
/*To see 'real' row lock use update statement in on of the sessions*/

begin
--select * from t1 with(rowlock) where id=1
UPDATE t1 with(rowlock, UPDLOCK, HOLDLOCK) SET Col1 = 'Test' WHERE id = 3
-- wait for 5 seconds
WAITFOR DELAY '00:00:07'
end;


