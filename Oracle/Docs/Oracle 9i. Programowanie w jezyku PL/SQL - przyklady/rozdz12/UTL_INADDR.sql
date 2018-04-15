REM UTL_INADDR.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_INADR. 

set serveroutput on

DECLARE
  z_NazwaHosta VARCHAR2(100) := 'www.oracle.com';
BEGIN
  DBMS_OUTPUT.PUT_LINE('Adres  hosta ' || z_NazwaHosta || ' to ' ||
    UTL_INADDR.GET_HOST_ADDRESS(z_NazwaHosta));
  DBMS_OUTPUT.PUT_LINE('Nazwa lokalnego hosta to ' ||
    UTL_INADDR.GET_HOST_NAME);
END;
/

