CREATE OR REPLACE FUNCTION DaneGrupy (
  /* Zwraca nast�puj�ce warto�ci:
     'Pe�na' je�eli grupa jest pe�na, 
     'Ma�o wolnych miejsc' je�eli stan liczebny grupy jest wi�kszy ni� 
      80% grupy pe�nej,
     'Du�o wolnych miejsc' je�eli stan liczebny grupy jest wi�kszy ni� 
      60% grupy pe�nej,
     'Bardzo du�o wolnych miejsc' je�eli stan liczebny grupy jest 
      mniejszy ni� 60% grupy pe�nej, oraz
     'Pusta' je�eli nie ma zarejestrowanych student�w. */
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN VARCHAR2 IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow     NUMBER;
  z_ProcentUkpl         NUMBER;
BEGIN
  -- Uzyskaj bie��c� i maksymalna liczb� student�w dla wybranego 
  -- kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Obliczenie bie��cego procentu.
  z_ProcentUkpl := z_Biez_L_Studentow / z_Maks_L_Studentow * 100;

  IF z_ProcentUkpl = 100 THEN
    RETURN 'Pe�na';
  ELSIF z_ProcentUkpl > 80 THEN
    RETURN 'Ma�o wolnych miejsc';
  ELSIF z_ProcentUkpl > 60 THEN
    RETURN 'Du�o wolnych miejsc';
  ELSIF z_ProcentUkpl > 0 THEN
    RETURN 'Bardzo du�o wolnych miejsc';
  ELSE
    RETURN 'Pusta';
  END IF;
END DaneGrupy;
/
