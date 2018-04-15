REM OdbiorOstrz.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje odbieranie ostrze�e� za pomoc� pakietu DBMS_ALERT.

set serveroutput on

DECLARE
  z_NazwaOstrz VARCHAR2(30) := 'MojeOstrzezenie';
  z_Wiadomosc VARCHAR2(100);
  z_Status INTEGER;
BEGIN
  -- Aby odebra� ostrze�enie, trzeba najpierw zarejestrowa� zainteresowanie
  -- tym ostrze�eniem.
  DBMS_ALERT.REGISTER(z_NazwaOstrz);
  
  -- Teraz, po rejestracji, mo�na oczekiwa� na ostrze�enie.
  DBMS_ALERT.WAITONE(z_NazwaOstrz, z_Wiadomosc, z_Status);
  
  IF z_Status = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Otrzymano: ' || z_Wiadomosc);
  ELSE
    DBMS_OUTPUT.PUT_LINE('przekroczono limit czasu procedury WAITONE');
  END IF;
END;
/
