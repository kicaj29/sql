REM JuzOtwarty.sql
REM Rozdzia³ 6., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje powstanie b³êdu ORA-6511.

DECLARE
  z_StudentID studenci.ID%TYPE;

  CURSOR k_WszystkieIDStudentow IS
    SELECT ID FROM studenci;
BEGIN
    OPEN k_WszystkieIDStudentow;

  -- Próba ponownego otwarcia kursora spowoduje b³¹d ORA-6511.
  OPEN k_WszystkieIDStudentow;
END;
/

