--1.  
select * from v$log
select * from v$logfile

--2.  Aby usun¹æ dziennik powtórzeñ zwi¹zany z grup¹ 1, nale¿y prze³¹czyæ dziennik
alter system switch logfile

--teraz mo¿na usun¹æ:
alter database drop logfile group 1

--3. Dodanie dziennika powtórzeñ:
alter database add logfile group 4
('c:\oracle\oradata\db\test1.log',
'c:\oracle\oradata\db\test2.log')
size 1M reuse

