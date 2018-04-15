REM limit.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok prezentuje operator kolekcji - LIMIT.

DECLARE
     z_Tabela TablicaLiczb := TablicaLiczb(1, 2, 3);
     z_Varray LiczVar := LiczVar(1234, 4321);
BEGIN
  -- Wyœwietlenie maksymalnej i aktualnej liczby elementów w kolekcji.
  DBMS_OUTPUT.PUT_LINE('Maksymalna liczba elementow tablicy Varray: ' || z_Varray.LIMIT);
  DBMS_OUTPUT.PUT_LINE('Aktualna liczba elementów tablicy Varray: ' || z_Varray.COUNT);
  IF z_Tabela.LIMIT IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Maksymalna liczba elementów z_Tabela : NULL');
  ELSE
      DBMS_OUTPUT.PUT_LINE('Maksymalna liczba elementów z_Tabela: ' || z_Tabela.LIMIT);
  END IF;
  DBMS_OUTPUT.PUT_LINE('Aktualna liczba elementów z_Tabela: ' || z_Tabela.COUNT);
END;
/