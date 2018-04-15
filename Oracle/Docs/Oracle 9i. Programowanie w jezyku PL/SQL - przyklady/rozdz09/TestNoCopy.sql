REM TestNoCopy.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ta procedura ilustruje dzia³anie modyfikatora NOCOPY
REM systemu Oracle8i.

CREATE OR REPLACE PROCEDURE TestNoCopy (
  p_ParametrWe    IN NUMBER,
  p_ParametrWy    OUT NOCOPY VARCHAR2,
  p_ParametrWeWy IN OUT NOCOPY CHAR) IS
BEGIN
  NULL;
END TestNoCopy;
/


-- ZglosBlad z NOCOPY
/* Ilustruje dzia³anie nieobs³u¿onych wyj¹tków oraz
 * zmiennych wyjœciowych (OUT). Je¿eli parametr p_Zglos ma wartoœæ TRUE, 
 * wtedy zostanie zg³oszony nieobs³ugiwany wyj¹tek. Je¿eli parametr p_Zglos ma wartoœæ FALSE,
 * wówczas procedura pomyœlnie koñczy dzia³anie.
 */

CREATE OR REPLACE PROCEDURE ZglosBlad (
  p_Zglos IN BOOLEAN,
  p_ParametrA OUT NOCOPY NUMBER) AS
BEGIN
  p_ParametrA := 7;
  IF p_Zglos THEN
    RAISE DUP_VAL_ON_INDEX;
  ELSE
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
  DBMS_OUTPUT.PUT_LINE('Wartoœæ po pomyœlnym wywo³aniu procedury: ' ||
                       z_ZmTymcz);

  z_ZmTymcz := 2;
  DBMS_OUTPUT.PUT_LINE('Wartoœæ przed 2 wywo³aniem: ' || z_ZmTymcz);
  ZglosBlad(TRUE, z_ZmTymcz);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Wartoœæ po niepomyœlnym wywo³aniu: ' ||
                         z_ZmTymcz);
END;
/