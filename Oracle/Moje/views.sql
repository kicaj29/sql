create table pracownicy(
id number,
imie varchar2(16),
nazwisko varchar2(16),
primary key (id))


insert into pracownicy values(1, 'Jacek', 'Kowalski')
insert into pracownicy values(2, 'Kasia', 'ABC')
insert into pracownicy values(3, 'Jacek', 'ABC')

select * from pracownicy

create view v_pracownicy
as select imie from pracownicy

--nie mo�na wstawia� nowych warto�ci jak w widoku nie ma klucza g��wnego tabeli, na kt�rej ten widok si� opiera
insert into v_pracownicy (imie) values('BBB')

--mo�na modyfikowa�
update v_pracownicy set imie = 'XXX' where imie = 'Jacek'

--mo�na usuwa�
delete v_pracownicy where imie = 'Jacek'
