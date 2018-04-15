REM ZglosBlad.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje dzia�anie nieobs�u�onych wyj�tk�w
REM oraz zmiennych wyjsciowych.

/* Przedstawia zachowanie nieobs�ugiwanych wyj�tk�w oraz zmiennych
     wyj�ciowych (OUT). Je�eli parametr p_Zglos przyjmuje warto�� TRUE, 
     nast�puje zg�oszenie b��du. Je�eli parametr p_Zglos ma warto��
     FALSE, wtedy procedura ko�czy si� pomy�lnie. */
CREATE OR REPLACE PROCEDURE ZglosBlad (
  p_Zglos IN BOOLEAN := TRUE,
  p_ParametrA OUT NUMBER) AS
BEGIN
  p_ParametrA := 7;
  IF p_Zglos THEN
    /* Nawet je�eli parametrowi p_ParametrA przypiszemy 7, ten
       nieobs�ugiwany wyj�tek spowoduje natychmiastowe zwr�cenie  
       sterowania, bez zwracania 7 parametrowi aktualnemu 
       skojarzonemu z parametrem p_ParametrA. */
    RAISE DUP_VAL_ON_INDEX;
  ELSE
    /* Nast�puje wyj�cie z procedury bez b��du. Parametr rzeczywisty
       przyjmie warto�� 7. */
    RETURN;
  END IF;
END ZglosBlad;
/

set serveroutput on
DECLARE
  z_ZmTymcz NUMBER := 1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Warto�� pocz�tkowa: ' || z_ZmTymcz);
  ZglosBlad(FALSE, z_ZmTymcz);
  DBMS_OUTPUT.PUT_LINE('Warto�� po pomy�lnym wywo�aniu: ' ||
                       z_ZmTymcz);

  z_ZmTymcz := 2;
  DBMS_OUTPUT.PUT_LINE('Warto�� przed drugim wywo�aniem: ' || z_ZmTymcz);
  ZglosBlad(TRUE, z_ZmTymcz);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Warto�� po niepomy�lnym wywo�aniu: ' ||
                         z_ZmTymcz);
END;
/
