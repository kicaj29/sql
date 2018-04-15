REM Zamiast.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje zastosowanie wyzwalaczy zast�puj�cych
REM wprowadzonych w systemie Oracle8.

CREATE OR REPLACE VIEW grupy_pokoje AS
  SELECT wydzial, kurs, budynek, pokoj_numer
  FROM pokoje, grupy
  WHERE pokoje.pokoj_id = grupy.pokoj_id;

SELECT * FROM grupy_pokoje;

PROMPT Nieprawid�owa operacja insert...
INSERT INTO grupy_pokoje (wydzial, kurs, budynek, pokoj_numer)
     VALUES ('MUZ', 100, 'Budynek Muzyki', 200);

CREATE TRIGGER InsertGrupyPokoje
  INSTEAD OF INSERT ON grupy_pokoje
DECLARE
  z_pokojID pokoje.pokoj_id%TYPE;
BEGIN
  -- Najpierw okre�limy identyfikator pokoju
  SELECT pokoj_id
    INTO z_pokojID
    FROM pokoje
    WHERE budynek = :new.budynek
    AND pokoj_numer = :new.pokoj_numer;

  -- Teraz uaktualnimy tabel� grupy
  UPDATE GRUPY
    SET pokoj_id = z_pokojID
    WHERE wydzial = :new.wydzial
    AND kurs = :new.kurs;
END GrupyPokojeInsert;
/

PROMPT Udana operacja insert...
INSERT INTO grupy_pokoje (wydzial, kurs, budynek, pokoj_numer)
     VALUES ('MUZ', 100, 'Budynek Muzyki', 200);

SELECT * FROM grupy_pokoje;
