/*example 1 https://social.msdn.microsoft.com/Forums/sqlserver/en-US/c00e8ee2-4d0a-4775-a758-6602c536b0a3/lock-single-row-for-update?forum=transactsql/ */
use testdb
go

--on SQL Server it does not work, this transaction finishes before first transaction! why???
begin
--select * from t1 with(rowlock) where id=3;
select * from t1 where id=3;
end;