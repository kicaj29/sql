REM zakresfor.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje zakres indeksu dla pêtli FOR.

DECLARE
  z_Licznik  NUMBER := 7;
BEGIN
  -- Wstawienie wartoœci 7 do tabeli tabela_tymcz.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
  -- Ta pêtla ponownie deklaruje zmienn¹ z_Licznik jako dan¹ typu BINARY_INTEGER,
  -- co ukrywa deklaracjê z_Licznik jako dan¹ typu NUMBER.
FOR z_Licznik IN 20..30 LOOP
  -- Wewn¹trz pêtli zmienna z_Licznik ma wartoœæ w zakresie od 20 do 30.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
  END LOOP;
  -- Wstawienie nastêpnych 7 wierszy do tabeli tabela_tymcz.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
END;
/
