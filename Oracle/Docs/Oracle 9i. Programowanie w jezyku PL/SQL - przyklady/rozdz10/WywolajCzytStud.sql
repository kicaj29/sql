REM WywolajCzytStud.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje wywo³anie procedury TrwaloscPakietu.CzytajStudentow.


set serveroutput on

DECLARE
  z_TabelaStudentow TrwaloscPakietu.t_TabelaStudentow;
  z_LiczWierszy NUMBER := TrwaloscPakietu.z_Maks_L_Wierszy;
  z_Imie studenci.imie%TYPE;
  z_Nazwisko studenci.nazwisko%TYPE;
BEGIN
  TrwaloscPakietu.CzytajStudentow(z_TabelaStudentow, z_LiczWierszy);
  DBMS_OUTPUT.PUT_LINE(' Pobrano ' || z_LiczWierszy || ' wierszy:');
  FOR z_Licznik IN 1..z_LiczWierszy LOOP
    SELECT imie, nazwisko
      INTO z_Imie, z_Nazwisko
      FROM studenci
      WHERE ID = z_TabelaStudentow(z_Licznik);
    DBMS_OUTPUT.PUT_LINE(z_Imie || ' ' || z_Nazwisko);
  END LOOP;
END;
/
