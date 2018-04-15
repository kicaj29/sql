REM PrawieKomplet.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje funkcjê sk³adowan¹.

CREATE OR REPLACE FUNCTION PrawieKomplet (
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN BOOLEAN IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow NUMBER;
  z_WartoscWyniku    BOOLEAN;
  z_ProcentUkpl      CONSTANT NUMBER := 90;
BEGIN
  -- Uzyskanie bie¿¹cej i maksymalnej liczby studentów dla po¿¹danego kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Zwrócenie wartoœci TRUE, je¿eli stan liczebny studentów zarejestrowanych  
  -- na zajêcia jest wiêkszy ni¿ procent wartoœci maksymalnej okreœlony przez zmienn¹  
  -- z_Procent_Ukpl. W przeciwnym przypadku zwrócenie wartoœci FALSE.
  IF (z_Biez_L_Studentow / z_Maks_L_Studentow * 100) > z_ProcentUkpl 
  THEN
    z_WartoscWyniku := TRUE;
  ELSE
    z_WartoscWyniku := FALSE;
  END IF;

  RETURN z_WartoscWyniku;
END PrawieKomplet;
/
