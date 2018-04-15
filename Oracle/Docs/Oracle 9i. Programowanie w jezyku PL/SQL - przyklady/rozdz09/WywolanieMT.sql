REM WywolanieMT.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt prezentuje wywo�ania procedury TestTryb.

set serveroutput on

DECLARE
  z_We NUMBER := 1;
  z_Wy NUMBER := 2;
  z_WeWy NUMBER := 3;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Przed wywo�aniem TestTryb:');
  DBMS_OUTPUT.PUT_LINE('z_We = ' || z_We ||
                       '  z_Wy = ' || z_Wy ||
                       '  z_WeWy = ' || z_WeWy);

  TestTryb(z_We, z_Wy, z_WeWy);

  DBMS_OUTPUT.PUT_LINE('Po wywo�aniu TestTryb:');
  DBMS_OUTPUT.PUT_LINE('  z_We = ' || z_We ||
                       '  z_Wy = ' || z_Wy ||
                       '  z_WeWy = ' || z_WeWy);
END;
/


-- Wywo�anie procedury TestTryb z litera�em w miejcu parametru p_ParametrWe.  Jest to poprawne.
DECLARE
  z_Wy NUMBER := 2;
  z_WeWy NUMBER := 3;
BEGIN
  TestTryb(1, z_Wy, z_WeWy);
END;
/

-- Je�eli jednak zamienimy litera�em zmienn� z_Wy lub z_WeWy, powstanie 
-- b�ad kompilacji:

DECLARE
    z_WeWy NUMBER := 3;
BEGIN
   TestTryb(1, 2, z_WeWy);
END;
/

