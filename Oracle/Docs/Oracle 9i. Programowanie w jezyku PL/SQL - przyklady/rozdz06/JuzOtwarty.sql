REM JuzOtwarty.sql
REM Rozdzia� 6., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje powstanie b��du ORA-6511.

DECLARE
  z_StudentID studenci.ID%TYPE;

  CURSOR k_WszystkieIDStudentow IS
    SELECT ID FROM studenci;
BEGIN
    OPEN k_WszystkieIDStudentow;

  -- Pr�ba ponownego otwarcia kursora spowoduje b��d ORA-6511.
  OPEN k_WszystkieIDStudentow;
END;
/

