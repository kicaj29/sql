REM limit.sql
REM Rozdzia� 8., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok prezentuje operator kolekcji - LIMIT.

DECLARE
     z_Tabela TablicaLiczb := TablicaLiczb(1, 2, 3);
     z_Varray LiczVar := LiczVar(1234, 4321);
BEGIN
  -- Wy�wietlenie maksymalnej i aktualnej liczby element�w w kolekcji.
  DBMS_OUTPUT.PUT_LINE('Maksymalna liczba elementow tablicy Varray: ' || z_Varray.LIMIT);
  DBMS_OUTPUT.PUT_LINE('Aktualna liczba element�w tablicy Varray: ' || z_Varray.COUNT);
  IF z_Tabela.LIMIT IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Maksymalna liczba element�w z_Tabela : NULL');
  ELSE
      DBMS_OUTPUT.PUT_LINE('Maksymalna liczba element�w z_Tabela: ' || z_Tabela.LIMIT);
  END IF;
  DBMS_OUTPUT.PUT_LINE('Aktualna liczba element�w z_Tabela: ' || z_Tabela.COUNT);
END;
/