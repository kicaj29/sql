REM DupValOnIndex.sql
REM Rozdzia³ 7., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok powoduje zg³oszenie wyj¹tku DUP_VAL_ON_INDEX.

BEGIN
  INSERT INTO studenci(id, imie, nazwisko)  
    VALUES (10001, 'John', 'Smith');
  INSERT INTO studenci(id, imie, nazwisko)  
    VALUES (10001, 'Susan', 'Ryan');
END;
/
