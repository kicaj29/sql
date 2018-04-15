REM Parametryzowane.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje deklaracj� kursora z parametrami.

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
