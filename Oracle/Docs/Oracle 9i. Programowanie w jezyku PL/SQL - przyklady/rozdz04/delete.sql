REM delete.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje instrukcjê DELETE.

DECLARE
  z_LStudentowDoUsuniecia  NUMBER;
BEGIN
  z_LStudentowDoUsuniecia := 10;
  -- Usuniêcie danych o zajêciach, dla których nie ma wystarczaj¹cej liczby 
  -- zarejestrowanych studentów.
  DELETE FROM grupy
    WHERE biez_l_studentow < z_LStudentowDoUsuniecia;

  -- Usuñ dane dotycz¹ce ka¿dego studenta studiuj¹cego Ekonomiê, który 
  -- nie posiada jeszcze ¿adnych zaliczeñ.
  DELETE FROM studenci
    WHERE biezace_zaliczenia = 0
    AND   specjalnosc = 'Ekonomia';
END;
/
