REM OgraniczSpec.sql
REM Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten wyzwalacz powoduje zg�oszenie b��du tabeli mutuj�cej ORA-4091.

CREATE OR REPLACE TRIGGER OgraniczSpec
  /* Dla ka�dej specjalno�ci ogranicza liczb� student�w do 5. Je�eli limit zostanie    
     przekroczony, wywo�any zostanie b��d za po�rednictwem procedury            
     raise_application_error. */
  BEFORE INSERT OR UPDATE OF specjalnosc ON studenci
  FOR EACH ROW
DECLARE
  z_Maks_l_Studentow CONSTANT NUMBER := 5;
  z_Biez_l_Studentow NUMBER;
BEGIN
  -- Okre�lenie bie��cej liczby student�w dla tej specjalno�ci.
SELECT COUNT(*)
    INTO z_Biez_l_Studentow
    FROM studenci
    WHERE specjalnosc = :new.specjalnosc;

  -- Je�eli nie ma wolnych miejsc, wywo�aj b��d.
  IF z_Biez_l_Studentow + 1 > z_Maks_l_Studentow THEN
    RAISE_APPLICATION_ERROR(-20000, 
      'Za du�o student�w dla specjalno�ci ' || :new.specjalnosc);
  END IF;
END OgraniczSpec;
/

UPDATE studenci
  SET specjalnosc = 'Historia'
  WHERE ID = 10003;

REM Usuni�cie wyzwalacza, poniewa� nie dzia�a.
DROP TRIGGER OgraniczSpec;
