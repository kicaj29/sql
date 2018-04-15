REM WygenerujIDStudenta.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Te wyzwalacze prezentuja zastosowanie identyfikatora korelacji :new


/* Ta operacja nie powiedzie siê, poniewa¿ nie okreœliliœmy klucza podstawowego */
INSERT INTO studenci (imie, nazwisko)
  VALUES ('Lolita', 'Lazarus');

CREATE OR REPLACE TRIGGER WygenerujIDStudenta
  BEFORE INSERT OR UPDATE ON studenci
  FOR EACH ROW
BEGIN
  /* Wype³nienie pola ID tabeli studenci nastêpn¹ wartoœci¹ z sekwencji 
     studenci_sekwencja. ID jest kolumn¹ tabeli studenci, zatem 
     :new.ID jest prawid³owym odwo³aniem. */
  SELECT studenci_sekwencja.nextval
    INTO :new.ID
    FROM dual;
END WygenerujIDStudenta;
/

/* Teraz ta operacja powiedzie siê. */
INSERT INTO studenci (imie, nazwisko)
  VALUES ('Lolita', 'Lazarus');

/* Ta operacja tak¿e siê powiedzie. */
INSERT INTO studenci (ID, imie, nazwisko)
  VALUES (-7, 'Zelda', 'Zoom');

/* Ta wersja wykorzystuje klauzulê REFERENCING w celu zmiany nazwy :new na
   :nowy_student. */

CREATE OR REPLACE TRIGGER WygenerujIDStudenta
  BEFORE INSERT OR UPDATE ON studenci
  REFERENCING new AS nowy_student
  FOR EACH ROW
BEGIN
  /* Wype³nienie pola ID tabeli studenci nastêpn¹ wartoœci¹ z sekwencji 
     studenci_sekwencja. ID jest kolumn¹ tabeli studenci, zatem 
     :new.ID jest prawid³owym odwo³aniem. */
  SELECT studenci_sekwencja.nextval
    INTO :nowy_student.ID
    FROM dual;
END WygenerujIDStudenta;
/
