REM DodajNowegoStudenta.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje sk³adowan¹ procedurê i sposób jej wywo³ywania.

CREATE OR REPLACE PROCEDURE DodajNowegoStudenta (
  p_Imie        studenci.imie%TYPE,
  p_Nazwisko    studenci.nazwisko%TYPE,
  p_Specjalnosc studenci.specjalnosc%TYPE) AS
BEGIN
  -- Wstawienie nowego wiersza do tabeli studenci. Zastosowanie sekwencji
  -- studenci_sekwencja wygenerowania nowego identyfikatora ID studenta 
  -- oraz wartoœci 0 dla biezace_zaliczenia.
  INSERT INTO studenci (ID, imie, nazwisko, specjalnosc, biezace_zaliczenia)
    VALUES (studenci_sekwencja.nextval, p_Imie, p_Nazwisko, p_Specjalnosc, 0);

  COMMIT;
END DodajNowegoStudenta;
/

BEGIN
  DodajNowegoStudenta ('Zelda', 'Zudnik', 'Informatyka'); 
END; 
/

ROLLBACK;
