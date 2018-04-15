--1. Utworzono semgment wycofania w przestrzeni tabel UNDOTBS1 (przestrzeñ ta jest zdefiniowana w init.ora)
--   Utworzony segment zawiera dwa ekstenty: ka¿dy po 250KB, minimalna liczba ekstentów to 2.
create rollback segment s77 tablespace UNDOTBS1
storage( initial 250K next 250K minextents 2 optimal 1m)

--2. Prespektywa ze zdefiniowanymi segmentami wycofania.
select * from dba_rollback_segs

--3. W³¹czanie/wy³¹czanie segmentów wycofania.
alter rollback segment s77 online
alter rollback segment s77 offline

--4. Zmniejszenie rozmiaru segmentu (segment musi znajdowaæ siê w trybie online)
alter rollback segment s77 shrink to 100K

--5. Usuniêcie segmentu wycofania (segment musi znajdowaæ sie w trybie off-line)
drop rollback segment s77