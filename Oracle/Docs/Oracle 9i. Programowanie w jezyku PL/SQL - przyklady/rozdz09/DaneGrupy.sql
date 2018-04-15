CREATE OR REPLACE FUNCTION DaneGrupy (
  /* Zwraca nastêpuj¹ce wartoœci:
     'Pe³na' je¿eli grupa jest pe³na, 
     'Ma³o wolnych miejsc' je¿eli stan liczebny grupy jest wiêkszy ni¿ 
      80% grupy pe³nej,
     'Du¿o wolnych miejsc' je¿eli stan liczebny grupy jest wiêkszy ni¿ 
      60% grupy pe³nej,
     'Bardzo du¿o wolnych miejsc' je¿eli stan liczebny grupy jest 
      mniejszy ni¿ 60% grupy pe³nej, oraz
     'Pusta' je¿eli nie ma zarejestrowanych studentów. */
  p_Wydzial grupy.wydzial%TYPE,
  p_Kurs    grupy.kurs%TYPE)
  RETURN VARCHAR2 IS

  z_Biez_l_Studentow NUMBER;
  z_Maks_L_Studentow     NUMBER;
  z_ProcentUkpl         NUMBER;
BEGIN
  -- Uzyskaj bie¿¹c¹ i maksymalna liczbê studentów dla wybranego 
  -- kursu.
  SELECT biez_l_studentow, maks_l_studentow
    INTO z_Biez_L_Studentow, z_Maks_L_Studentow
    FROM grupy
    WHERE wydzial = p_Wydzial
    AND kurs = p_Kurs;

  -- Obliczenie bie¿¹cego procentu.
  z_ProcentUkpl := z_Biez_L_Studentow / z_Maks_L_Studentow * 100;

  IF z_ProcentUkpl = 100 THEN
    RETURN 'Pe³na';
  ELSIF z_ProcentUkpl > 80 THEN
    RETURN 'Ma³o wolnych miejsc';
  ELSIF z_ProcentUkpl > 60 THEN
    RETURN 'Du¿o wolnych miejsc';
  ELSIF z_ProcentUkpl > 0 THEN
    RETURN 'Bardzo du¿o wolnych miejsc';
  ELSE
    RETURN 'Pusta';
  END IF;
END DaneGrupy;
/
