REM NoMatch.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje zastosowanie atrybut�w kursora
REM dla niejawnego kursora SQL.

BEGIN
  UPDATE pokoje
    SET liczba_miejsc = 100
    WHERE pokoj_id = 99980;
  -- Je�eli �aden wiersz nie spe�nia warunku poprzedniej instrukcji UPDATE 
  -- wprowad� nowy wiersz do tabeli pokoje. 
  IF SQL%NOTFOUND THEN
    INSERT INTO pokoje (pokoj_id, liczba_miejsc)
      VALUES (99980, 100);
  END IF;
END;
/


BEGIN
  UPDATE pokoje
    SET liczba_miejsc = 100
    WHERE pokoj_id = 99980;
  -- Je�eli �aden wiersz nie spe�nia warunku poprzedniej instrukcji UPDATE 
  -- wprowad� nowy wiersz do tabeli pokoje. 
  IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO pokoje (pokoj_id, liczba_miejsc)
      VALUES (99980, 100);
  END IF;
END;
/
