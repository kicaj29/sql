--1.  
select * from v$log
select * from v$logfile

--2.  Aby usun�� dziennik powt�rze� zwi�zany z grup� 1, nale�y prze��czy� dziennik
alter system switch logfile

--teraz mo�na usun��:
alter database drop logfile group 1

--3. Dodanie dziennika powt�rze�:
alter database add logfile group 4
('c:\oracle\oradata\db\test1.log',
'c:\oracle\oradata\db\test2.log')
size 1M reuse

