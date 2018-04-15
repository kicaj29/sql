REM case.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje u¿ycie instrukcji CASE.

set serveroutput on

DECLARE
  z_Specjalnosc studenci.specjalnosc%TYPE;
  z_NazwaKursu VARCHAR2(10);
BEGIN
  -- Pobranie specjalnoœci dla okreœlonego studenta
  SELECT specjalnosc
    INTO z_Specjalnosc
    FROM studenci
    WHERE ID = 10011;

  -- Wybranie kursu na podstawie specjalnoœci
  IF z_Specjalnosc = 'Informatyka' THEN
    z_NazwaKursu := 'INF 101';
  ELSIF z_Specjalnosc = 'Ekonomia' THEN
    z_NazwaKursu := 'EKN 203';
  ELSIF z_Specjalnosc = 'Historia' THEN
    z_NazwaKursu := 'HIS 101';
  ELSIF z_Specjalnosc = 'Muzyka' THEN
    z_NazwaKursu := 'MUZ 100';
  ELSIF z_Specjalnosc = '¯ywienie' THEN
    z_NazwaKursu := '¯YW 307';
  ELSE
    z_NazwaKursu := 'Nieznany';
  END IF;
  DBMS_OUTPUT.PUT_LINE(z_NazwaKursu);
END;
/

DECLARE
  z_Specjalnosc studenci.specjalnosc%TYPE;
  z_NazwaKursu VARCHAR2(10);
BEGIN
  -- Pobranie specjalnoœci dla okreœlonego studenta
  SELECT specjalnosc
    INTO z_Specjalnosc
    FROM studenci
    WHERE ID = 10011;

  -- Wybranie kursu na podstawie specjalnoœci
  CASE z_Specjalnosc
    WHEN 'Informatyka' THEN
      z_NazwaKursu := 'INF 101';
    WHEN 'Ekonomia' THEN
      z_NazwaKursu :='EKN 203';
    WHEN 'Historia' THEN
      z_NazwaKursu := 'HIS 101';
    WHEN 'Muzyka' THEN
      z_NazwaKursu := 'MUZ 100';
    WHEN '¯ywienie' THEN
      z_NazwaKursu := '¯YW 307';
    ELSE
      z_NazwaKursu := 'Nieznany';
  END CASE;

  DBMS_OUTPUT.PUT_LINE(z_NazwaKursu);
END;
/

DECLARE
  z_ZmTest NUMBER := 1;
BEGIN
  -- Poniewa¿ ¿adna z klauzul WHEN nie okreœla warunku dla wartoœci 1
  -- zatem wykonanie tego kodu spowoduje powstanie b³êdu ORA-6592.
  CASE z_ZmTest
     WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Dwa!');
     WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Trzy!');
     WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Cztery!');
  END CASE;
END;
/


DECLARE
  z_ZmTest NUMBER := 1;
BEGIN
  -- Ta instrukcja CASE jest oznaczona pêtl¹.
  <<MojCase>>
  CASE z_ZmTest
    WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('Jeden!');
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Dwa!');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Trzy!');
    WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Cztery!');
  END CASE MojCase;
END;
/

DECLARE
  z_Test1 NUMBER := 2;
  z_Test2 VARCHAR2(20) := 'Do widzenia';
BEGIN
  CASE
    WHEN z_Test1 = 1 THEN
      DBMS_OUTPUT.PUT_LINE('Jeden!');
      DBMS_OUTPUT.PUT_LINE('Jeszcze jeden!');
    WHEN z_Test1 > 1 THEN
      DBMS_OUTPUT.PUT_LINE('> 1!');
      DBMS_OUTPUT.PUT_LINE('Wci¹¿ > 1!');
    WHEN z_Test2 = 'Do widzenia' THEN
      DBMS_OUTPUT.PUT_LINE('Do widzenia!');
      DBMS_OUTPUT.PUT_LINE('¯egnam!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('¯aden z warunków nie jest spe³niony');
   END CASE;
END;
/

