--1. Rozmiar utworzonego pliku to 5MB
--   Jeœli podczas tworzenia obiektu w tej przestrzeni tabel u¿ytkownik nie okreœli rozmiaru
--   obiektu, to zostanie zastosowana domyœlna klauzula sk³adowania:
--   rozmiar utworzonej tabeli bêdzie wynosi³ 25KB i bêdzie przyrasta³ w jednostkach co 25KB
create tablespace przestrzenTabel
datafile 'c:\oracle\oradata\db\przestrzenTabel.dbf'
size 5M reuse
default storage (initial 25K next 25K
minextents 5
maxextents 100
pctincrease 0)

--To nie dzia³a:
--Zarz¹dzanie sposobem przydzielania ekstentów przez tê przestrzeñ tabel jest realizowane
--za poœrednictwem s³ownika danych. Oznacza to, ¿e gdy kierowane jest ¿¹danie o umieszczenie obiektu w
--przestrzeni tabel, najpierw za poœrednictwem s³ownika danych okreœlane jest po³o¿enie wolnych ekstentów
create tablespace przestrzenTabel
datafile 'c:\oracle\oradata\db\przestrzenTabel.dbf'
size 5M reuse
extent management dictionary
default storage (initial 25K next 25K
minextents 5
maxextents 100
pctincrease 0)
--2. Zarz¹dzanie sposobem przydzielania ekstentów przez tê przestrzeñ tabel jest realizowane w 
--   wewn¹trz jej samej. Jeœli podczas tworzenia obiektu bazy danych w tej przestrzeni tabel
--   u¿ytkownik nie okresli rozmiaru obiektu, rozmiar jest przydzielany przez bazê

create tablespace mojaPrzestrzen
datafile 'c:\oracle\oradata\db\PrzestrzenMoja.dbf'
size 5m reuse
extent management local autoallocate

--3. Zarz¹dzanie przydzielaniem ekstentów przez tê przestrzeñ tabel jest realizowane wewn¹trz jej samej.
--   Jeœli podczas tworzenia obiektu u¿ytkownik nie okresli jego rozmiaru, automatycznie sotoswany jest
--   rozmiar 128KB, a jego zwiêkszanie odbywa siê równie¿ w jednostakch co 128KB

create tablespace nowaPrzestrzen
datafile 'c:\oracle\oradata\db\plik.dbf'
size 5m reuse
extent management local uniform size 128K
--4. Wycofanie zmian: nie maj¹ byæ wycofywane segmenty (przerwanie lub anulowanie transakcji) a zmiast
--   tego ma zostaæ wykorzystana specjalna przestrzeñ tabel umo¿liwiaj¹ca wycofanie poszczególnych transakcji.
--   Zarz¹dzanie wszystkimi segmentami wycofania bêdzie realizowane przez bazê danych w tych przestrzeniach tabel.

create undo tablespace space
datafile 'c:\oracle\oradata\db\space.dbf'
size 2M reuse
autoextend on

--5. Do przestrzeni mojaPrzestrzen zosta³ dodany drugi plik danych. W razie potrzeby plik mo¿e siê automatycznie
--   powiêkszaæ (autoextend on). Dziêki temu nie bêdzie trzeba dodawaæ kolejnego pliku danych. Plik mo¿e 
--   rosn¹æ w jednostkach co 1MB a¿ do osi¹gniêcia 10MB.

alter tablespace mojaPrzestrzen
add datafile 'c:\oracle\oradata\db\dodatkowy plik.dbf'
size 2M reuse
autoextend on
next 1M
maxsize 10M

--6. Wy³¹czenie funkcji automatycznego powiêkszania.
alter database
datafile 'c:\oracle\oradata\db\dodatkowy plik.dbf'
autoextend off

--7. Wy³¹czenie/w³¹czenia przestrzeni tabel.
alter tablespace mojaPrzestrzen offline
alter tablespace mojaPrzestrzen online

--8. Usuwanie.

--usuwane s¹ wszystkie obiekty niezale¿nie od tego, kto jest ich w³aœcielem( nie jest usuwany plik dbf!!!)
drop tablespace space including contents cascade constraints

--teraz zostan¹ równie¿ usuniete fizyczne pliki
drop tablespace space including contents and datafile

--przestrzeñ musi byæ pusta, je¿eli bêd¹ znajdowa³y siê w niej obiekty polecenie nie zostanie wykonane
--(plik dbf nie zostanie usuniêty)
drop tablespace mojaPrzestrzen
