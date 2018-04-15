REM WywolanieMT.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt prezentuje wywo³ania procedury TestTryb.

set serveroutput on

DECLARE
  z_We NUMBER := 1;
  z_Wy NUMBER := 2;
  z_WeWy NUMBER := 3;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Przed wywo³aniem TestTryb:');
  DBMS_OUTPUT.PUT_LINE('z_We = ' || z_We ||
                       '  z_Wy = ' || z_Wy ||
                       '  z_WeWy = ' || z_WeWy);

  TestTryb(z_We, z_Wy, z_WeWy);

  DBMS_OUTPUT.PUT_LINE('Po wywo³aniu TestTryb:');
  DBMS_OUTPUT.PUT_LINE('  z_We = ' || z_We ||
                       '  z_Wy = ' || z_Wy ||
                       '  z_WeWy = ' || z_WeWy);
END;
/


-- Wywo³anie procedury TestTryb z litera³em w miejcu parametru p_ParametrWe.  Jest to poprawne.
DECLARE
  z_Wy NUMBER := 2;
  z_WeWy NUMBER := 3;
BEGIN
  TestTryb(1, z_Wy, z_WeWy);
END;
/

-- Je¿eli jednak zamienimy litera³em zmienn¹ z_Wy lub z_WeWy, powstanie 
-- b³ad kompilacji:

DECLARE
    z_WeWy NUMBER := 3;
BEGIN
   TestTryb(1, 2, z_WeWy);
END;
/

