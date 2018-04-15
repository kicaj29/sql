REM ZglosBlad.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta procedura ilustruje dzia³anie nieobs³u¿onych wyj¹tków
REM oraz zmiennych wyjsciowych.

/* Przedstawia zachowanie nieobs³ugiwanych wyj¹tków oraz zmiennych
     wyjœciowych (OUT). Je¿eli parametr p_Zglos przyjmuje wartoœæ TRUE, 
     nastêpuje zg³oszenie b³êdu. Je¿eli parametr p_Zglos ma wartoœæ
     FALSE, wtedy procedura koñczy siê pomyœlnie. */
CREATE OR REPLACE PROCEDURE ZglosBlad (
  p_Zglos IN BOOLEAN := TRUE,
  p_ParametrA OUT NUMBER) AS
BEGIN
  p_ParametrA := 7;
  IF p_Zglos THEN
    /* Nawet je¿eli parametrowi p_ParametrA przypiszemy 7, ten
       nieobs³ugiwany wyj¹tek spowoduje natychmiastowe zwrócenie  
       sterowania, bez zwracania 7 parametrowi aktualnemu 
       skojarzonemu z parametrem p_ParametrA. */
    RAISE DUP_VAL_ON_INDEX;
  ELSE
    /* Nastêpuje wyjœcie z procedury bez b³êdu. Parametr rzeczywisty
       przyjmie wartoœæ 7. */
    RETURN;
  END IF;
END ZglosBlad;
/

set serveroutput on
DECLARE
  z_ZmTymcz NUMBER := 1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Wartoœæ pocz¹tkowa: ' || z_ZmTymcz);
  ZglosBlad(FALSE, z_ZmTymcz);
  DBMS_OUTPUT.PUT_LINE('Wartoœæ po pomyœlnym wywo³aniu: ' ||
                       z_ZmTymcz);

  z_ZmTymcz := 2;
  DBMS_OUTPUT.PUT_LINE('Wartoœæ przed drugim wywo³aniem: ' || z_ZmTymcz);
  ZglosBlad(TRUE, z_ZmTymcz);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Wartoœæ po niepomyœlnym wywo³aniu: ' ||
                         z_ZmTymcz);
END;
/
