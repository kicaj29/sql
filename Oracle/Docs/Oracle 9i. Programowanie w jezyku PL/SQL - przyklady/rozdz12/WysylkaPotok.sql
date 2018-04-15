REM WysylkaPotok.sql
REM Rozdzia³ 12., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje zastosowanie pakietu DBMS_PIPE w celu wys³ania
REM wiadomoœci.

DECLARE
  z_NazwaPotoku VARCHAR2(30) := 'MojPotok';
  z_Status INTEGER;
BEGIN
  -- Za³adowanie informacji do potoku. Bêd¹ wys³ane bie¿¹ca data oraz
  -- wartoœæ typu NUMBER i VARCHAR2.
  DBMS_PIPE.PACK_MESSAGE(SYSDATE);
  DBMS_PIPE.PACK_MESSAGE(123456);
  DBMS_PIPE.PACK_MESSAGE('To jest wiadomoœæ przes³ana przez potok!');
  
  -- Mo¿na teraz wys³aæ wiadomoœæ.
  z_Status := DBMS_PIPE.SEND_MESSAGE(z_NazwaPotoku);
  IF z_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('B³¹d ' || z_Status || 
                         ' podczas wysy³ania wiadomoœci');
  END IF;
END;
/