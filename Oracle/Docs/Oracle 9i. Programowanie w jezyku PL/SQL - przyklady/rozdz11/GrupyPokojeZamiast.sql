REM GrupyPokojeZamiast.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM To jest kompletny wyzwalacz zast�puj�cy.

CREATE OR REPLACE TRIGGER GrupyPokojeZamiast
  INSTEAD OF INSERT OR UPDATE OR DELETE ON grupy_pokoje
  FOR EACH ROW
DECLARE
  z_pokojID pokoje.pokoj_id%TYPE;
  z_UaktualnijGrupy BOOLEAN := FALSE;
  z_UaktualnijPokoje BOOLEAN := FALSE;

  -- Funkcja lokalna zwracaj�ca identyfikator pokoju, na podstawie numeru budynku
  -- oraz numeru pokoju.  Funkcja zwraca b��d ORA-20000, je�eli nie znaleziono
  -- numeru budynku lub numeru pokoju.
  FUNCTION pobierzIDpokoju(p_Budynek IN pokoje.budynek%TYPE,
                     p_pokoj IN pokoje.pokoj_numer%TYPE)
    RETURN pokoje.pokoj_id%TYPE IS

    z_pokojID pokoje.pokoj_id%TYPE;
  BEGIN
    SELECT pokoj_id
      INTO z_pokojID
      FROM pokoje
      WHERE budynek = p_Budynek
      AND pokoj_numer = p_pokoj;
    RETURN z_pokojID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'Nie znaleziono pokoju');
  END pobierzIDpokoju;

  -- Procedura lokalna sprawdzaj�ca, czy grupa identyfikowana przez
  -- p_Wydzial oraz p_Kurs istnieje.  Je�eli nie, zg�aszany jest b��d
  -- ORA-20001.
  PROCEDURE sprawdzGrupe(p_Wydzial IN grupy.wydzial%TYPE,
                        p_Kurs IN grupy.kurs%TYPE) IS
    z_Pomocnicza NUMBER;
  BEGIN
    SELECT 0
      INTO z_Pomocnicza
      FROM grupy
      WHERE wydzial = p_Wydzial
      AND kurs = p_Kurs;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
        p_Wydzial || ' ' || p_Kurs || ' nie istnieje');
  END sprawdzGrupe;

BEGIN
  IF INSERTING THEN
    -- Ten fragment w zasadzie przypisuje grup� do okre�lonego pokoju. Logika tego 
    -- fragmentu jest identyczna jak przypadek "uaktualnij pokoje" poni�ej:  Najpierw
    -- okre�lamy identyfikator pokoju:
      z_pokojID := pobierzIDpokoju(:new.budynek, :new.pokoj_numer);

      -- Nast�pnie uaktualniamy tabel� grupy wprowadzaj�c nowy identyfikator.
      UPDATE GRUPY
        SET pokoj_id = z_pokojID
        WHERE wydzial = :new.wydzial
        AND kurs = :new.kurs;

  ELSIF UPDATING THEN
    -- Sprawdzamy, czy uaktualniamy tabel� grupy, czy tabel� pokoje.
    z_UaktualnijGrupy := (:new.wydzial != :old.wydzial) OR
                         (:new.kurs != :old.kurs);
    z_UaktualnijPokoje := (:new.budynek != :old.budynek) OR
                       (:new.pokoj_numer != :old.pokoj_numer);

    IF (z_UaktualnijGrupy) THEN
      -- W takim przypadku zmieniamy grup� przypisan� do okre�lonego
      -- pokoju.  Najpierw sprawdzamy, czy nowa grupa istnieje.
      sprawdzGrupe(:new.wydzial, :new.kurs);

      -- Pobieramy identyfikator pokoju,
      z_pokojID := pobierzIDpokoju(:old.budynek, :old.pokoj_numer);

      -- Nast�pnie zerujemy pok�j dla starej grupy,
      UPDATE grupy
        SET pokoj_id = NULL
        WHERE wydzial = :old.wydzial
        AND kurs = :old.kurs;

      -- Wreszcie przypisujemy stary pok�j do nowej grupy.
      UPDATE grupy
        SET pokoj_id = z_pokojID
        WHERE wydzial = :new.wydzial
        AND kurs = :new.kurs;
    END IF;

    IF z_UaktualnijPokoje THEN
      -- W tym fragmencie zmieniamy pok�j dla danej grupy.  Logika tego fragmentu
      -- jest identyczna jak przypadek "wstawiania" powy�ej, poza tym, �e uaktualniamy
      -- tabel� grupy warto�ci� :old zamiast :new.
      -- Najpierw okre�lamy identyfikator pokoju.
      z_pokojID := pobierzIDpokoju(:new.budynek, :new.pokoj_numer);

      -- Nast�pnie uaktualniamy tabel� grupy wprowadzaj�c nowy identyfikator.
      UPDATE GRUPY
        SET pokoj_id = z_pokojID
        WHERE wydzial = :old.wydzial
        AND kurs = :old.kurs;
    END IF;

  ELSE
    -- W tym fragmencie chcemy wyzerowa� przypisanie grupy do pokoju bez konieczno�ci
    -- usuwania wierszy z powi�zanych tabel.
    UPDATE grupy
      SET pokoj_id = NULL
      WHERE wydzial = :old.wydzial
      AND kurs = :old.kurs;
  END IF;
END GrupyPokojeZamiast;
/
show errors

set echo off
REM Najpierw pobierzemy wiersze z wszystkich trzech obiekt�w, w celu sprawdzenia pocz�tkowych warto�ci
PROMPT pocz�tkowa zawarto�� tabeli grupy:
SELECT wydzial, kurs, pokoj_id
  FROM grupy
  ORDER BY pokoj_id;

PROMPT pocz�tkowa zawarto�� tabeli pokoje:
SELECT pokoj_id, budynek, pokoj_numer
  FROM pokoje
  ORDER BY pokoj_id;

PROMPT pocz�tkowa zawarto�� perspektywy grupy_pokoje:
SELECT *
  FROM grupy_pokoje;

REM Teraz wstawimy wiersze do perspektywy grupy_pokoje.  Ta operacja spowoduje uaktualnienie
REM tabeli grupy.
PROMPT Operacja INSERT dla perspektywy grupy_pokoje...
INSERT INTO grupy_pokoje
  VALUES ('MUZ', 100, 'Budynek Muzyki', 200);

REM Jeszcze raz pobierzemy dane z tabeli.
PROMPT grupy po wykonaniu operacji INSERT:
SELECT wydzial, kurs, pokoj_id
  FROM grupy
  ORDER BY pokoj_id;

PROMPT tabela pokoje po wykonaniu operacji insert:
SELECT pokoj_id, budynek, pokoj_numer
  FROM pokoje
  ORDER BY pokoj_id;

PROMPT Perspektywa grupy_pokoje po operacji insert:
SELECT *
  FROM grupy_pokoje;

REM Uaktualniamy perspektyw� grupy_pokoje.  Spowoduje to odpowiednie modyfikacje
REM tabeli grupy.
PROMPT Modyfikacja perspektywy grupy_pokoje...
UPDATE grupy_pokoje
  SET wydzial = '�YW', kurs = 307
  WHERE budynek = 'Budynek 7' AND pokoj_numer = 201;

REM I jeszcze raz pobieramy dane.
PROMPT Zawarto�� tabeli grupy po operacji UPDATE:
SELECT wydzial, kurs, pokoj_id
  FROM grupy
  ORDER BY pokoj_id;

PROMPT Zawarto�� tabeli pokoje po operacji UPDATE:
SELECT pokoj_id, budynek, pokoj_numer
  FROM pokoje
  ORDER BY pokoj_id;

PROMPT Zawarto�� perspektywy grupy_pokoje po operacji UPDATE:
SELECT *
  FROM grupy_pokoje;

REM Usuni�cie wierszy z perspektywy grupy_pokoje.
REM Usuwamy wiersze z grupy_pokoje...
DELETE FROM grupy_pokoje
  WHERE budynek = 'Budynek 6';

REM I jeszcze raz pobieramy dane.
PROMPT Zawarto�� tabeli grupy po operacji DELETE:
SELECT wydzial, kurs, pokoj_id
  FROM grupy
  ORDER BY pokoj_id;

PROMPT Zawarto�� tabeli pokoje po operacji DELETE:
SELECT pokoj_id, budynek, pokoj_numer
  FROM pokoje
  ORDER BY pokoj_id;

PROMPT Zawarto�� perspektywy grupy_pokoje po operacji DELETE:
SELECT *
  FROM grupy_pokoje;


REM Cofni�cie wykonanych zmian.
rollback;