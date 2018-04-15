--1. Rozmiar utworzonego pliku to 5MB
--   Je�li podczas tworzenia obiektu w tej przestrzeni tabel u�ytkownik nie okre�li rozmiaru
--   obiektu, to zostanie zastosowana domy�lna klauzula sk�adowania:
--   rozmiar utworzonej tabeli b�dzie wynosi� 25KB i b�dzie przyrasta� w jednostkach co 25KB
create tablespace przestrzenTabel
datafile 'c:\oracle\oradata\db\przestrzenTabel.dbf'
size 5M reuse
default storage (initial 25K next 25K
minextents 5
maxextents 100
pctincrease 0)

--To nie dzia�a:
--Zarz�dzanie sposobem przydzielania ekstent�w przez t� przestrze� tabel jest realizowane
--za po�rednictwem s�ownika danych. Oznacza to, �e gdy kierowane jest ��danie o umieszczenie obiektu w
--przestrzeni tabel, najpierw za po�rednictwem s�ownika danych okre�lane jest po�o�enie wolnych ekstent�w
create tablespace przestrzenTabel
datafile 'c:\oracle\oradata\db\przestrzenTabel.dbf'
size 5M reuse
extent management dictionary
default storage (initial 25K next 25K
minextents 5
maxextents 100
pctincrease 0)
--2. Zarz�dzanie sposobem przydzielania ekstent�w przez t� przestrze� tabel jest realizowane w 
--   wewn�trz jej samej. Je�li podczas tworzenia obiektu bazy danych w tej przestrzeni tabel
--   u�ytkownik nie okresli rozmiaru obiektu, rozmiar jest przydzielany przez baz�

create tablespace mojaPrzestrzen
datafile 'c:\oracle\oradata\db\PrzestrzenMoja.dbf'
size 5m reuse
extent management local autoallocate

--3. Zarz�dzanie przydzielaniem ekstent�w przez t� przestrze� tabel jest realizowane wewn�trz jej samej.
--   Je�li podczas tworzenia obiektu u�ytkownik nie okresli jego rozmiaru, automatycznie sotoswany jest
--   rozmiar 128KB, a jego zwi�kszanie odbywa si� r�wnie� w jednostakch co 128KB

create tablespace nowaPrzestrzen
datafile 'c:\oracle\oradata\db\plik.dbf'
size 5m reuse
extent management local uniform size 128K
--4. Wycofanie zmian: nie maj� by� wycofywane segmenty (przerwanie lub anulowanie transakcji) a zmiast
--   tego ma zosta� wykorzystana specjalna przestrze� tabel umo�liwiaj�ca wycofanie poszczeg�lnych transakcji.
--   Zarz�dzanie wszystkimi segmentami wycofania b�dzie realizowane przez baz� danych w tych przestrzeniach tabel.

create undo tablespace space
datafile 'c:\oracle\oradata\db\space.dbf'
size 2M reuse
autoextend on

--5. Do przestrzeni mojaPrzestrzen zosta� dodany drugi plik danych. W razie potrzeby plik mo�e si� automatycznie
--   powi�ksza� (autoextend on). Dzi�ki temu nie b�dzie trzeba dodawa� kolejnego pliku danych. Plik mo�e 
--   rosn�� w jednostkach co 1MB a� do osi�gni�cia 10MB.

alter tablespace mojaPrzestrzen
add datafile 'c:\oracle\oradata\db\dodatkowy plik.dbf'
size 2M reuse
autoextend on
next 1M
maxsize 10M

--6. Wy��czenie funkcji automatycznego powi�kszania.
alter database
datafile 'c:\oracle\oradata\db\dodatkowy plik.dbf'
autoextend off

--7. Wy��czenie/w��czenia przestrzeni tabel.
alter tablespace mojaPrzestrzen offline
alter tablespace mojaPrzestrzen online

--8. Usuwanie.

--usuwane s� wszystkie obiekty niezale�nie od tego, kto jest ich w�a�cielem( nie jest usuwany plik dbf!!!)
drop tablespace space including contents cascade constraints

--teraz zostan� r�wnie� usuniete fizyczne pliki
drop tablespace space including contents and datafile

--przestrze� musi by� pusta, je�eli b�d� znajdowa�y si� w niej obiekty polecenie nie zostanie wykonane
--(plik dbf nie zostanie usuni�ty)
drop tablespace mojaPrzestrzen
