REM DodajNowegoStudenta.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje sk�adowan� procedur� i spos�b jej wywo�ywania.

CREATE OR REPLACE PROCEDURE DodajNowegoStudenta (
  p_Imie        studenci.imie%TYPE,
  p_Nazwisko    studenci.nazwisko%TYPE,
  p_Specjalnosc studenci.specjalnosc%TYPE) AS
BEGIN
  -- Wstawienie nowego wiersza do tabeli studenci. Zastosowanie sekwencji
  -- studenci_sekwencja wygenerowania nowego identyfikatora ID studenta 
  -- oraz warto�ci 0 dla biezace_zaliczenia.
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
