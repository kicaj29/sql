REM OdbiorOstrz.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje odbieranie ostrze¿eñ za pomoc¹ pakietu DBMS_ALERT.

set serveroutput on

DECLARE
  z_NazwaOstrz VARCHAR2(30) := 'MojeOstrzezenie';
  z_Wiadomosc VARCHAR2(100);
  z_Status INTEGER;
BEGIN
  -- Aby odebraæ ostrze¿enie, trzeba najpierw zarejestrowaæ zainteresowanie
  -- tym ostrze¿eniem.
  DBMS_ALERT.REGISTER(z_NazwaOstrz);
  
  -- Teraz, po rejestracji, mo¿na oczekiwaæ na ostrze¿enie.
  DBMS_ALERT.WAITONE(z_NazwaOstrz, z_Wiadomosc, z_Status);
  
  IF z_Status = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Otrzymano: ' || z_Wiadomosc);
  ELSE
    DBMS_OUTPUT.PUT_LINE('przekroczono limit czasu procedury WAITONE');
  END IF;
END;
/
