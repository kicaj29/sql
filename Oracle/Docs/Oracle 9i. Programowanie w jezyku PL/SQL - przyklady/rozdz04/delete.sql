REM delete.sql
REM Rozdzia� 4., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje instrukcj� DELETE.

DECLARE
  z_LStudentowDoUsuniecia  NUMBER;
BEGIN
  z_LStudentowDoUsuniecia := 10;
  -- Usuni�cie danych o zaj�ciach, dla kt�rych nie ma wystarczaj�cej liczby 
  -- zarejestrowanych student�w.
  DELETE FROM grupy
    WHERE biez_l_studentow < z_LStudentowDoUsuniecia;

  -- Usu� dane dotycz�ce ka�dego studenta studiuj�cego Ekonomi�, kt�ry 
  -- nie posiada jeszcze �adnych zalicze�.
  DELETE FROM studenci
    WHERE biezace_zaliczenia = 0
    AND   specjalnosc = 'Ekonomia';
END;
/
