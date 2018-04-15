REM update.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje kilka instrukcji UPDATE.

DECLARE
  z_Specjalnosc           studenci.specjalnosc%TYPE;
  z_WiecejZaliczen        NUMBER := 3;
BEGIN
  -- Ta instrukcja UPDATE doda 3 do pola biezace_zaliczenia
  -- dla wszystkich studentow, którzy studiuj¹ Historie.
  z_Specjalnosc := 'Historia';
  UPDATE studenci
    SET biezace_zaliczenia = biezace_zaliczenia + z_WiecejZaliczen
    WHERE specjalnosc = z_Specjalnosc;

  -- Ta instrukcja UPDATE spowoduje zmodyfikowanie obu kolumn tabeli
  -- tabela_tymcz dla wszystkich wierszy.
  UPDATE tabela_tymcz
     SET kol_num = 1, kol_znak = 'abcd'; 
END;
/

