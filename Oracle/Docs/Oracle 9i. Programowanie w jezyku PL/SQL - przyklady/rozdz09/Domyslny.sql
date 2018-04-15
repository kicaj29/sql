REM Domyslny.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta wersja procedury DodajNowegoStudenta pobiera parametr domyœlny.

CREATE OR REPLACE PROCEDURE DodajNowegoStudenta (
  p_Imie  studenci.imie%TYPE,
  p_Nazwisko   studenci.nazwisko%TYPE,
  p_Specjalnosc      studenci.specjalnosc%TYPE DEFAULT 'Ekonomia') AS
BEGIN
  -- Wstawienie nowego wiersza do tabeli studenci Zastosowanie
  -- sekwencji studenci_sekwencja do wygenerowania nowego ID studenta 
  -- oraz wartoœci 0 dla pola biezace_zaliczenia.
  INSERT INTO studenci VALUES (studenci_sekwencja.nextval, 
    p_Imie, p_Nazwisko, p_Specjalnosc, 0);

  COMMIT;
END DodajNowegoStudenta;
/

BEGIN
  DodajNowegoStudenta('Simon', 'Salovitz');
END;
/

BEGIN
  DodajNowegoStudenta(p_Imie => 'Veronica',
                p_Nazwisko => 'Vassily');
END;
/

ROLLBACK;
