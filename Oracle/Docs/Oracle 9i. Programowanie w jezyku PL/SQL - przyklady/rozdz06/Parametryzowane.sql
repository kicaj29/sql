REM Parametryzowane.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje deklaracjê kursora z parametrami.

DECLARE
  CURSOR k_Grupy(p_Wydzial grupy.wydzial%TYPE,
                 p_Kurs grupy.kurs%TYPE) IS
  SELECT * 
    FROM grupy
    WHERE wydzial = p_Wydzial 
    AND kurs = p_Kurs;

BEGIN
  OPEN k_Grupy('HIS', 101);
END;
/
