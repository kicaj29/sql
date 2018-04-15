REM WywolajCzytStud.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje wywo�anie procedury TrwaloscPakietu.CzytajStudentow.


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
