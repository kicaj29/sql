REM calkowite.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad przezentuje r�ne typy ca�kowite.

DECLARE
  z_CalkBin BINARY_INTEGER;
BEGIN
  -- Przypisanie maksymalnej warto�ci do zmiennej z_CalkBin.
  z_CalkBin := 2147483647;
    
  -- Dodanie 1 do zmiennej z_CalkBin (co spowoduje przepe�nienie), a nast�pnie
  -- odj�cie jedynki. Wynik tego obliczenia mie�ci si�
  -- w zakresie typu danych BINARY_INTEGER, zatem b��d
  -- nie pojawi si�.
  z_CalkBin := z_CalkBin + 1 - 1;
END;
/

DECLARE
  z_PLSCalk PLS_INTEGER;
BEGIN
  -- Przypisanie maksymalnej warto�ci do zmiennej z_PLSCalk.
  z_PLSCalk := 2147483647;
     
  -- Dodanie 1 do zmiennej z_PLSCalk (co spowoduje przepe�nienie), a nast�pnie
  -- odj�cie jedynki. Chocia� wynik obliczenia mie�ci si� w zakresie
  -- danych typu PLS_INTEGER, to jednak warto�� po�rednia
  -- nie, zatem powstanie b��d ORA-1426.
  z_PLSCalk := z_PLSCalk + 1 - 1;
END;
/
