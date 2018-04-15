REM Warunkowe.sql
REM Rozdzia� 1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje u�ycie instrukcji warunkowej.

DECLARE
  z_LiczbaStudentow NUMBER;
BEGIN
  -- Uzyskanie ca�kowitej liczby student�w z bazy danych.
  SELECT COUNT(*)
    INTO z_LiczbaStudentow
    FROM studenci;
    
  -- Na podstawie tej warto�ci wstaw  w�a�ciwy wiersz do tabeli tabela_tymczasowa.
  IF z_LiczbaStudentow = 0 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Brak zarejestrowanych student�w');
  ELSIF z_LiczbaStudentow < 5 THEN 
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano zaledwie kilku student�w');
  ELSIF z_LiczbaStudentow < 10 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano nieco wi�cej student�w');
  ELSE
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano wielu student�w');
  END IF;
END;
/


