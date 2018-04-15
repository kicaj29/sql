REM WysylkaPotok.sql
REM Rozdzia� 12., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje zastosowanie pakietu DBMS_PIPE w celu wys�ania
REM wiadomo�ci.

DECLARE
  z_NazwaPotoku VARCHAR2(30) := 'MojPotok';
  z_Status INTEGER;
BEGIN
  -- Za�adowanie informacji do potoku. B�d� wys�ane bie��ca data oraz
  -- warto�� typu NUMBER i VARCHAR2.
  DBMS_PIPE.PACK_MESSAGE(SYSDATE);
  DBMS_PIPE.PACK_MESSAGE(123456);
  DBMS_PIPE.PACK_MESSAGE('To jest wiadomo�� przes�ana przez potok!');
  
  -- Mo�na teraz wys�a� wiadomo��.
  z_Status := DBMS_PIPE.SEND_MESSAGE(z_NazwaPotoku);
  IF z_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('B��d ' || z_Status || 
                         ' podczas wysy�ania wiadomo�ci');
  END IF;
END;
/