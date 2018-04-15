REM KlauzulaWhere.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje kilka ró¿nych kaluzul WHERE.

DECLARE
  z_Wydzial CHAR(3);
BEGIN
  z_Wydzial := 'INF';
  -- Usuñ wszystkie zajêcia wydzia³u Informatyka
  DELETE FROM grupy
    WHERE wydzial = z_Wydzial;
END;
/

DECLARE
  Wydzial CHAR(3);
BEGIN
  Wydzial := 'INF';
  -- Usuñ wszystkie zajêcia wydzia³u Informatyka
  DELETE FROM grupy
    WHERE wydzial = Wydzial;
END;
/

<<l_BlokDelete>>
DECLARE
  Wydzial CHAR(3);
BEGIN
  Wydzial := 'INF';
  -- Usuñ wszystkie zajêcia wydzia³u Informatyka
  DELETE FROM grupy
    WHERE wydzial = l_BlokDelete.Wydzial;
END;
/

DECLARE
  z_Wydzial VARCHAR2(4);
BEGIN
  z_Wydzial := 'INF ';
  -- Usuñ wszystkie zajêcia wydzia³u Informatyka
  DELETE FROM grupy
    WHERE wydzial = z_Wydzial;
END;
/
