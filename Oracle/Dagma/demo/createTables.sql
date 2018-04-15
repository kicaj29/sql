drop table pracownicy;
-- Create table
create table pracownicy
(
  id       integer,
  nazwisko varchar2(50),
  wiek     integer
);

-- Create/Recreate primary, unique and foreign key constraints 
alter table pracownicy add constraint pk primary key (ID);
  
  
drop table pracownicy_wyplaty;
create table pracownicy_wyplaty
(
  pracownik_id integer,
  miesiac_id integer,
  brutto number     
);

alter table pracownicy_wyplaty
  add constraint pk_pracownicy_wyplaty primary key (pracownik_id, miesiac_id);
  
alter table pracownicy_wyplaty
  add constraint fk_pracownicy_wyplaty_01 foreign key (pracownik_id) references pracownicy(id);
