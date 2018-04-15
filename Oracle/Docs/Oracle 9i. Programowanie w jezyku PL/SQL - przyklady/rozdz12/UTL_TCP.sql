REM UTL_TCP.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje zastosowanie pakietu UTL_TCP. 

set echo on
set serveroutput on size 200000

DECLARE
  z_Polaczenie UTL_TCP.CONNECTION;
  z_ZapisanaLiczba PLS_INTEGER;
BEGIN
  -- Otwarcie po��czenia w porcie 80, b�d�cym standardowym portem HTTP
  z_Polaczenie := UTL_TCP.OPEN_CONNECTION('www.oracle.com', 80);

  -- Wys�anie ��dania HTTP
  z_ZapisanaLiczba := UTL_TCP.WRITE_LINE(z_Polaczenie, 'GET / HTTP/1.0');
  z_ZapisanaLiczba := UTL_TCP.WRITE_LINE(z_Polaczenie);
  
  -- Wy�wietlenie odczytanych pierwszych 10 wierszy 
  BEGIN
    FOR z_Licznik IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(UTL_TCP.GET_LINE(z_Polaczenie, TRUE));
    END LOOP;
  EXCEPTION
    WHEN UTL_TCP.END_OF_INPUT THEN
      NULL;
  END;
  
  UTL_TCP.CLOSE_CONNECTION(z_Polaczenie);
END;
/