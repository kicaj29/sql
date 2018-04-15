REM TestNoCopy.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ta procedura ilustruje dzia�anie modyfikatora NOCOPY
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
/* Ilustruje dzia�anie nieobs�u�onych wyj�tk�w oraz
 * zmiennych wyj�ciowych (OUT). Je�eli parametr p_Zglos ma warto�� TRUE, 
 * wtedy zostanie zg�oszony nieobs�ugiwany wyj�tek. Je�eli parametr p_Zglos ma warto�� FALSE,
 * w�wczas procedura pomy�lnie ko�czy dzia�anie.
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
  DBMS_OUTPUT.PUT_LINE('Warto�� pocz�tkowa: ' || z_ZmTymcz);
  ZglosBlad(FALSE, z_ZmTymcz);
  DBMS_OUTPUT.PUT_LINE('Warto�� po pomy�lnym wywo�aniu procedury: ' ||
                       z_ZmTymcz);

  z_ZmTymcz := 2;
  DBMS_OUTPUT.PUT_LINE('Warto�� przed 2 wywo�aniem: ' || z_ZmTymcz);
  ZglosBlad(TRUE, z_ZmTymcz);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Warto�� po niepomy�lnym wywo�aniu: ' ||
                         z_ZmTymcz);
END;
/