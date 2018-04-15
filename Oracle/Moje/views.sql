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

--nie mo¿na wstawiaæ nowych wartoœci jak w widoku nie ma klucza g³ównego tabeli, na której ten widok siê opiera
insert into v_pracownicy (imie) values('BBB')

--mo¿na modyfikowaæ
update v_pracownicy set imie = 'XXX' where imie = 'Jacek'

--mo¿na usuwaæ
delete v_pracownicy where imie = 'Jacek'
