REM Warunkowe.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje u¿ycie instrukcji warunkowej.

DECLARE
  z_LiczbaStudentow NUMBER;
BEGIN
  -- Uzyskanie ca³kowitej liczby studentów z bazy danych.
  SELECT COUNT(*)
    INTO z_LiczbaStudentow
    FROM studenci;
    
  -- Na podstawie tej wartoœci wstaw  w³aœciwy wiersz do tabeli tabela_tymczasowa.
  IF z_LiczbaStudentow = 0 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Brak zarejestrowanych studentów');
  ELSIF z_LiczbaStudentow < 5 THEN 
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano zaledwie kilku studentów');
  ELSIF z_LiczbaStudentow < 10 THEN
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano nieco wiêcej studentów');
  ELSE
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Zarejestrowano wielu studentów');
  END IF;
END;
/


