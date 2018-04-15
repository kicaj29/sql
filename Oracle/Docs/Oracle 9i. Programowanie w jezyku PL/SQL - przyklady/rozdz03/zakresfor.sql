REM zakresfor.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zakres indeksu dla p�tli FOR.

DECLARE
  z_Licznik  NUMBER := 7;
BEGIN
  -- Wstawienie warto�ci 7 do tabeli tabela_tymcz.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
  -- Ta p�tla ponownie deklaruje zmienn� z_Licznik jako dan� typu BINARY_INTEGER,
  -- co ukrywa deklaracj� z_Licznik jako dan� typu NUMBER.
FOR z_Licznik IN 20..30 LOOP
  -- Wewn�trz p�tli zmienna z_Licznik ma warto�� w zakresie od 20 do 30.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
  END LOOP;
  -- Wstawienie nast�pnych 7 wierszy do tabeli tabela_tymcz.
  INSERT INTO tabela_tymcz (kol_num)
    VALUES (z_Licznik);
END;
/
