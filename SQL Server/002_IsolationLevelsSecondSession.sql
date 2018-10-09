use testdb

--DIRTY READ EXAMPLE (these are the second session steps)----
BEGIN TRANSACTION;
update t2 set col1 = 'xxx' where id = 1 --2. update the row
WAITFOR DELAY '00:00:06'
rollback;

----NON REPEATABLE READ EXAMPLE----
use testdb
BEGIN TRANSACTION;
update t2 set col1 = 'zzz' where id = 1 --2. update the row
delete t2 where id = 2 --2. remove row with age 20
commit;


----PHANTOM READ EXAMPLE----
use testdb
BEGIN TRANSACTION;
insert into t2 (col1, col2, age) values ('ttt', 'wwww', 23)
--delete t2 where id = 2 --2. remove row with age 20
--if we do insert and delete we get deadlock in the first transaction! why???
commit

----Snapshot Isolation Level----
use testdb
BEGIN TRANSACTION; --1. start transaction, do insert but do not commit it, it will block reading in first transaction
insert into t2 (col1, col2, age) values ('ttt', 'wwww', 23)
commit --3. commit

----Serializable----
use testdb
BEGIN TRANSACTION;
update t2 set col1 = 'zzz' where id = 1 --2. update the row, it will be blocked until serializable transaction is finished!
commit;