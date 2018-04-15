REM DrukujStudentow.sql
REM Rozdzia³ 1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje u¿ycie procedury sk³adowanej.


set serveroutput on

CREATE OR REPLACE PROCEDURE DrukujStudentow(
  p_Spec IN studenci.specjalnosc%TYPE) AS

  CURSOR k_Studenci IS
    SELECT imie, nazwisko
      FROM studenci
      WHERE specjalnosc = p_Spec;
BEGIN
  FOR z_StudentRek IN k_Studenci LOOP
    DBMS_OUTPUT.PUT_LINE(z_StudentRek.imie || ' ' ||
                         z_StudentRek.nazwisko);
  END LOOP;
END;
/


