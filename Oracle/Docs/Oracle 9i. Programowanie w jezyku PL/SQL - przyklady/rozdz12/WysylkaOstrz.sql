REM WysylkaOstrz.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje wysy³anie ostrze¿eñ za pomoc¹ pakietu DBMS_ALERT.

set serveroutput on

DECLARE
  z_NazwaOstrz VARCHAR2(30) := 'MojeOstrzezenie';
BEGIN
  -- Ostrze¿enia wysy³a siê za pomoc¹ procedury SIGNAL.
  DBMS_ALERT.SIGNAL(z_NazwaOstrz, 'Uwaga!  Uwaga!  Uwaga!');
  
  -- Ostrze¿enie nie zostanie wys³ane dopóki nie wydamy instrukcji COMMIT.
  COMMIT;
END;
/
