REM WygenerujIDStudenta.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Te wyzwalacze prezentuja zastosowanie identyfikatora korelacji :new


/* Ta operacja nie powiedzie si�, poniewa� nie okre�lili�my klucza podstawowego */
INSERT INTO studenci (imie, nazwisko)
  VALUES ('Lolita', 'Lazarus');

CREATE OR REPLACE TRIGGER WygenerujIDStudenta
  BEFORE INSERT OR UPDATE ON studenci
  FOR EACH ROW
BEGIN
  /* Wype�nienie pola ID tabeli studenci nast�pn� warto�ci� z sekwencji 
     studenci_sekwencja. ID jest kolumn� tabeli studenci, zatem 
     :new.ID jest prawid�owym odwo�aniem. */
  SELECT studenci_sekwencja.nextval
    INTO :new.ID
    FROM dual;
END WygenerujIDStudenta;
/

/* Teraz ta operacja powiedzie si�. */
INSERT INTO studenci (imie, nazwisko)
  VALUES ('Lolita', 'Lazarus');

/* Ta operacja tak�e si� powiedzie. */
INSERT INTO studenci (ID, imie, nazwisko)
  VALUES (-7, 'Zelda', 'Zoom');

/* Ta wersja wykorzystuje klauzul� REFERENCING w celu zmiany nazwy :new na
   :nowy_student. */

CREATE OR REPLACE TRIGGER WygenerujIDStudenta
  BEFORE INSERT OR UPDATE ON studenci
  REFERENCING new AS nowy_student
  FOR EACH ROW
BEGIN
  /* Wype�nienie pola ID tabeli studenci nast�pn� warto�ci� z sekwencji 
     studenci_sekwencja. ID jest kolumn� tabeli studenci, zatem 
     :new.ID jest prawid�owym odwo�aniem. */
  SELECT studenci_sekwencja.nextval
    INTO :nowy_student.ID
    FROM dual;
END WygenerujIDStudenta;
/
