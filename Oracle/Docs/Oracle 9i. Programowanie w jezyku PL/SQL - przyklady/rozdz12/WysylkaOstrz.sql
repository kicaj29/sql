REM WysylkaOstrz.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje wysy�anie ostrze�e� za pomoc� pakietu DBMS_ALERT.

set serveroutput on

DECLARE
  z_NazwaOstrz VARCHAR2(30) := 'MojeOstrzezenie';
BEGIN
  -- Ostrze�enia wysy�a si� za pomoc� procedury SIGNAL.
  DBMS_ALERT.SIGNAL(z_NazwaOstrz, 'Uwaga!  Uwaga!  Uwaga!');
  
  -- Ostrze�enie nie zostanie wys�ane dop�ki nie wydamy instrukcji COMMIT.
  COMMIT;
END;
/
