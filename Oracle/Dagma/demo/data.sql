delete from pracownicy;

insert into pracownicy (id, nazwisko, wiek)
values (1, 'Kowalski', 30);

insert into pracownicy (id, nazwisko, wiek)
values (2, 'Nowak', 25);

delete from pracownicy_wyplaty;

insert into pracownicy_wyplaty(pracownik_id, miesiac_id, brutto)
values (1, 1, 123.23);

insert into pracownicy_wyplaty(pracownik_id, miesiac_id, brutto)
values (1, 2, 23.53);

insert into pracownicy_wyplaty(pracownik_id, miesiac_id, brutto)
values (1, 3, 13.1);

insert into pracownicy_wyplaty(pracownik_id, miesiac_id, brutto)
values (2, 1, 229.63);

commit;
