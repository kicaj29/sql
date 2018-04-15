REM tabele.sql
REM Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL

REM Ten plik powoduje usuniêcie i utworzenie wszystkich tabel wykorzystanych
REM w przyk³adach.  Skrypt powoduje wype³nienie danymi tabel studenci,
REM pokoje, grupy oraz zarejestrowani_studenci.

REM Ten skrypt mo¿na uruchomiæ w programie SQL*Plus.


PROMPT studeci_sekwencja...
DROP SEQUENCE studenci_sekwencja;

CREATE SEQUENCE studenci_sekwencja
  START WITH 10000
  INCREMENT BY 1;


PROMPT tabela studenci...
DROP TABLE studenci CASCADE CONSTRAINTS;

CREATE TABLE studenci (
  id              NUMBER(5) PRIMARY KEY,
  imie            VARCHAR2(20),
  nazwisko        VARCHAR2(20),
  specjalnosc     VARCHAR2(30),
  biezace_zaliczenia NUMBER(3)
  );
INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Scott', 'Smith', 
          'Informatyka', 11);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Margaret', 'Mason',
          'Historia', 4);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Joanne', 'Junebug', 
          'Informatyka', 8);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Manish', 'Murgratroid', 
          'Ekonomia', 8);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES(studenci_sekwencja.NEXTVAL, 'Patrick', 'Poll', 
         'Historia', 4);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Timothy', 'Taller', 
          'Historia', 4);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Barbara', 'Blues', 
          'Ekonomia', 7);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'David', 'Dinsmore', 
          'Muzyka', 4);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Ester', 'Elegant', 
          '¯ywienie', 8);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Rose', 'Riznit', 
          'Muzyka', 7);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Rita', 'Razmataz', 
          '¯ywienie', 8);

INSERT INTO studenci (id, imie, nazwisko, specjalnosc, 
                      biezace_zaliczenia)
  VALUES (studenci_sekwencja.NEXTVAL, 'Shay', 'shariatpanahy', 
          'Informatyka', 3);


PROMPT spec_stats...
DROP TABLE spec_stats;

CREATE TABLE spec_stats (
specjalnosc      VARCHAR2(30),
ogolem_zaliczenia   NUMBER,
ogolem_studenci  NUMBER);

INSERT INTO spec_stats (specjalnosc, ogolem_zaliczenia, ogolem_studenci)
  VALUES ('Informatyka', 22, 3);

INSERT INTO spec_stats (specjalnosc, ogolem_zaliczenia, ogolem_studenci)
  VALUES ('Historia', 12, 3);

INSERT INTO spec_stats (specjalnosc, ogolem_zaliczenia, ogolem_studenci)
  VALUES ('Ekonomia', 15, 2);

INSERT INTO spec_stats (specjalnosc, ogolem_zaliczenia, ogolem_studenci)
  VALUES ('Muzyka', 11, 2);

INSERT INTO spec_stats (specjalnosc, ogolem_zaliczenia, ogolem_studenci)
  VALUES ('¯ywienie', 16, 2);

PROMPT pokoje_sekwencja...
DROP SEQUENCE pokoje_sekwencja;

CREATE SEQUENCE pokoje_sekwencja
  START WITH 20000
  INCREMENT BY 1;

PROMPT tabela pokoje..
DROP TABLE pokoje CASCADE CONSTRAINTS;

CREATE TABLE pokoje (
  pokoj_id       NUMBER(5) PRIMARY KEY,
  budynek        VARCHAR2(15),
  pokoj_numer    NUMBER(4),
  liczba_miejsc  NUMBER(4),
  opis           VARCHAR2(50)
  );
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 7', 201, 1000, 'Du¿a Sala Wyk³adowa');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 6', 101, 500, 'Ma³a Sala Wyk³adowa');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 6', 150, 50, 'Sala Konferencyjna A');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 6', 160, 50, 'Sala Konferencyjna B');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 6', 170, 50, 'Sala Konferencyjna C');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek Muzyki', 100, 10, 'Sala Do Æwiczeñ Muzycznych');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek Muzyki', 200, 1000, 'Sala Koncertowa');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 7', 300, 75, 'Sala Konferencyjna D');
INSERT INTO pokoje (pokoj_id, budynek, pokoj_numer, liczba_miejsc, opis)
  VALUES (pokoje_sekwencja.NEXTVAL, 'Budynek 7', 310, 50, 'Sala Konferencyjna E');

PROMPT tabela grupy...
DROP TABLE grupy CASCADE CONSTRAINTS;

CREATE TABLE grupy (
  wydzial           CHAR(3),
  kurs              NUMBER(3),
  opis              VARCHAR2(2000),
  maks_l_studentow  NUMBER(3),
  biez_l_studentow  NUMBER(3),
  liczba_zaliczen   NUMBER(1),
  pokoj_id          NUMBER(5),
CONSTRAINT grupy_wydzial_kurs
  PRIMARY KEY (wydzial, kurs),
CONSTRAINT grupy_pokoj_id
  FOREIGN KEY (pokoj_id) REFERENCES pokoje (pokoj_id)
);
INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('HIS', 101, 'Historia 101', 30, 11, 4, 20000);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('HIS', 301, 'Historia 301', 30, 0, 4, 20004);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('INF', 101, 'Informatyka 101', 50, 0, 4, 20001);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('EKN', 203, 'Ekonomia 203', 15, 0, 3, 20002);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('INF', 102, 'Informatyka 102', 35, 3, 4, 20003);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('MUZ', 410, 'Muzyka 410', 5, 4, 3, 20005);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('EKN', 101, 'Ekonomia 101', 50, 0, 4, 20007);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('¯YW', 307, '¯ywienie 307', 20, 2, 4, 20008);

INSERT INTO grupy(wydzial, kurs, opis, maks_l_studentow,
                   biez_l_studentow, liczba_zaliczen, pokoj_id)
  VALUES ('MUZ', 100, 'Muzyka 100', 100, 0, 3, NULL);

PROMPT tabela zarejestrowani_studenci...
DROP TABLE zarejestrowani_studenci CASCADE CONSTRAINTS;

CREATE TABLE zarejestrowani_studenci(
  student_id   NUMBER(5) NOT NULL,
  wydzial      CHAR(3)   NOT NULL,
  kurs         NUMBER(3) NOT NULL,
  ocena        CHAR(1),
CONSTRAINT zs_ocena
  CHECK (ocena IN ('A', 'B', 'C', 'D', 'E')),
CONSTRAINT zs_student_id
  FOREIGN KEY (student_id) REFERENCES studenci (id),
CONSTRAINT zs_wydzial_kurs
  FOREIGN KEY (wydzial, kurs)
REFERENCES grupy  (wydzial, kurs)
  );
INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10000, 'INF', 102, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10002, 'INF', 102, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10003, 'INF', 102, 'C');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10000, 'HIS', 101, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10001, 'HIS', 101, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10002, 'HIS', 101, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10003, 'HIS', 101, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10004, 'HIS', 101, 'C');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10005, 'HIS', 101, 'C');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10006, 'HIS', 101, 'E');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10007, 'HIS', 101, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10008, 'HIS', 101, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10009, 'HIS', 101, 'D');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10010, 'HIS', 101, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10008, '¯YW', 307, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10010, '¯YW', 307, 'A');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10009, 'MUZ', 410, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10006, 'MUZ', 410, 'E');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10011, 'MUZ', 410, 'B');

INSERT INTO zarejestrowani_studenci  (student_id, wydzial, kurs, 
                                      ocena)
  VALUES (10000, 'MUZ', 410, 'B');

PROMPT ZS_audyt...
DROP TABLE ZS_audyt;

CREATE TABLE ZS_audyt (
  zmiana_typ       CHAR(1)     NOT NULL,
  zmieniono_przez  VARCHAR2(8) NOT NULL,
  data_czas        DATE        NOT NULL,
  stary_student_id NUMBER(5),
  stary_wydzial    CHAR(3),
  stary_kurs       NUMBER(3),
  stara_ocena      CHAR(1),
  nowy_student_id  NUMBER(5),
  nowy_wydzial     CHAR(3),
  nowy_kurs        NUMBER(3),
  nowa_ocena       CHAR(1)
  );


PROMPT dziennik_bledow...
DROP TABLE dziennik_bledow;

CREATE TABLE dziennik_bledow (
  kod        NUMBER,
  komunikat   VARCHAR2(200),
  informacja  VARCHAR2(100)
  );


PROMPT tabela_tymcz...
DROP TABLE tabela_tymcz;

CREATE TABLE tabela_tymcz (
  kol_num    NUMBER,
  kol_znak   VARCHAR2(60)
  );

CREATE OR REPLACE TYPE TablicaLiczb AS TABLE OF NUMBER;
/

CREATE OR REPLACE TYPE LiczVar AS VARRAY(25) OF NUMBER;
/

CREATE OR REPLACE PACKAGE Indeksowane AS
  TYPE TablicaLiczb IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
END Indeksowane;
/

DROP TABLE ksiazki CASCADE CONSTRAINTS;

CREATE TABLE ksiazki(
   numer_katalogowy NUMBER(4)       PRIMARY KEY,
   tytul            VARCHAR2(40),
   autor1           VARCHAR2(40),
   autor2           VARCHAR2(40),
   autor3           VARCHAR2(40),
   autor4           VARCHAR2(40)
);

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1)
  VALUES (1000, 'Oracle8i Advanced PL/SQL Programming',
                'Urman, Scott');

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1, autor2, autor3)
  VALUES (1001, 'Oracle8i: A Beginner''s Guide',
                'Abbey, Michael', 'Corey, Michael J.',
                'Abramson, Ian');

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1, autor2, autor3,
                  autor4)
  VALUES (1002, 'Oracle8 Tuning',
                'Corey, Michael J.', 'Abbey, Michael',
                'Dechichio, Daniel J.', 'Abramson, Ian');

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1, autor2)
  VALUES (2001, 'A History of the World',
                'Arlington, Arlene', 'Verity, Victor');

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1)
  VALUES (3001, 'Bach and the Modern World', 'Foo, Fred');

INSERT INTO ksiazki (Numer_katalogowy, tytul, autor1)
  VALUES (3002, 'Introduction to the Piano',
                'Morenson, Mary');


DROP TYPE ListaKsiazek FORCE;

CREATE OR REPLACE TYPE ListaKsiazek AS VARRAY(10) OF NUMBER(4);

DROP TABLE grupy_materialy CASCADE CONSTRAINTS;

CREATE TABLE grupy_materialy (
  wydzial       CHAR(3),
  kurs          NUMBER(3),
  lektury_obowiazkowe ListaKsiazek
);


DROP TYPE ListaStudentow FORCE;

CREATE OR REPLACE TYPE ListaStudentow AS TABLE OF NUMBER(5);
/


DROP TABLE katalog_bibl CASCADE CONSTRAINTS;

CREATE TABLE katalog_bibl (
  Numer_katalogowy NUMBER(4),
    FOREIGN KEY (Numer_katalogowy) REFERENCES ksiazki(Numer_katalogowy),
  liczba_egz         NUMBER,
  liczba_wypozycz    NUMBER,
  wypozyczono_dla    ListaStudentow)
  NESTED TABLE wypozyczono_dla STORE AS wd_tab;


CREATE TABLE audyt_polaczen (
    nazwa_uzytkownika       VARCHAR2(30),
    operacja                VARCHAR2(30),
    datownik                DATE);
