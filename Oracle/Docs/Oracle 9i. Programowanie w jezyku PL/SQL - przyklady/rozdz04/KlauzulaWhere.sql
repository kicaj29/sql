REM KlauzulaWhere.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje kilka r�nych kaluzul WHERE.

DECLARE
  z_Wydzial CHAR(3);
BEGIN
  z_Wydzial := 'INF';
  -- Usu� wszystkie zaj�cia wydzia�u Informatyka
  DELETE FROM grupy
    WHERE wydzial = z_Wydzial;
END;
/

DECLARE
  Wydzial CHAR(3);
BEGIN
  Wydzial := 'INF';
  -- Usu� wszystkie zaj�cia wydzia�u Informatyka
  DELETE FROM grupy
    WHERE wydzial = Wydzial;
END;
/

<<l_BlokDelete>>
DECLARE
  Wydzial CHAR(3);
BEGIN
  Wydzial := 'INF';
  -- Usu� wszystkie zaj�cia wydzia�u Informatyka
  DELETE FROM grupy
    WHERE wydzial = l_BlokDelete.Wydzial;
END;
/

DECLARE
  z_Wydzial VARCHAR2(4);
BEGIN
  z_Wydzial := 'INF ';
  -- Usu� wszystkie zaj�cia wydzia�u Informatyka
  DELETE FROM grupy
    WHERE wydzial = z_Wydzial;
END;
/
