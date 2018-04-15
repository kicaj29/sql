REM calkowite.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad przezentuje ró¿ne typy ca³kowite.

DECLARE
  z_CalkBin BINARY_INTEGER;
BEGIN
  -- Przypisanie maksymalnej wartoœci do zmiennej z_CalkBin.
  z_CalkBin := 2147483647;
    
  -- Dodanie 1 do zmiennej z_CalkBin (co spowoduje przepe³nienie), a nastêpnie
  -- odjêcie jedynki. Wynik tego obliczenia mieœci siê
  -- w zakresie typu danych BINARY_INTEGER, zatem b³¹d
  -- nie pojawi siê.
  z_CalkBin := z_CalkBin + 1 - 1;
END;
/

DECLARE
  z_PLSCalk PLS_INTEGER;
BEGIN
  -- Przypisanie maksymalnej wartoœci do zmiennej z_PLSCalk.
  z_PLSCalk := 2147483647;
     
  -- Dodanie 1 do zmiennej z_PLSCalk (co spowoduje przepe³nienie), a nastêpnie
  -- odjêcie jedynki. Chocia¿ wynik obliczenia mieœci siê w zakresie
  -- danych typu PLS_INTEGER, to jednak wartoœæ poœrednia
  -- nie, zatem powstanie b³¹d ORA-1426.
  z_PLSCalk := z_PLSCalk + 1 - 1;
END;
/
