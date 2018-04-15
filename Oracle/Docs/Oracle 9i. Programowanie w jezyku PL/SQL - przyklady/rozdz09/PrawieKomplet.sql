REM PrawieKomplet.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje funkcj� sk�adowan�.

CREATE OR REPLACE FUNCTION PrawieKomplet (
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN BOOLEAN IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow NUMBER;
  z_WartoscWyniku    BOOLEAN;
  z_ProcentUkpl      CONSTANT NUMBER := 90;
BEGIN
  -- Uzyskanie bie��cej i maksymalnej liczby student�w dla po��danego kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Zwr�cenie warto�ci TRUE, je�eli stan liczebny student�w zarejestrowanych  
  -- na zaj�cia jest wi�kszy ni� procent warto�ci maksymalnej okre�lony przez zmienn�  
  -- z_Procent_Ukpl. W przeciwnym przypadku zwr�cenie warto�ci FALSE.
  IF (z_Biez_L_Studentow / z_Maks_L_Studentow * 100) > z_ProcentUkpl 
  THEN
    z_WartoscWyniku := TRUE;
  ELSE
    z_WartoscWyniku := FALSE;
  END IF;

  RETURN z_WartoscWyniku;
END PrawieKomplet;
/
