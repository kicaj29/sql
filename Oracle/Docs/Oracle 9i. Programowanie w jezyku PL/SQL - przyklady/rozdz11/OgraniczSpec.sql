REM OgraniczSpec.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten wyzwalacz powoduje zg³oszenie b³êdu tabeli mutuj¹cej ORA-4091.

CREATE OR REPLACE TRIGGER OgraniczSpec
  /* Dla ka¿dej specjalnoœci ogranicza liczbê studentów do 5. Je¿eli limit zostanie    
     przekroczony, wywo³any zostanie b³¹d za poœrednictwem procedury            
     raise_application_error. */
  BEFORE INSERT OR UPDATE OF specjalnosc ON studenci
  FOR EACH ROW
DECLARE
  z_Maks_l_Studentow CONSTANT NUMBER := 5;
  z_Biez_l_Studentow NUMBER;
BEGIN
  -- Okreœlenie bie¿¹cej liczby studentów dla tej specjalnoœci.
SELECT COUNT(*)
    INTO z_Biez_l_Studentow
    FROM studenci
    WHERE specjalnosc = :new.specjalnosc;

  -- Je¿eli nie ma wolnych miejsc, wywo³aj b³¹d.
  IF z_Biez_l_Studentow + 1 > z_Maks_l_Studentow THEN
    RAISE_APPLICATION_ERROR(-20000, 
      'Za du¿o studentów dla specjalnoœci ' || :new.specjalnosc);
  END IF;
END OgraniczSpec;
/

UPDATE studenci
  SET specjalnosc = 'Historia'
  WHERE ID = 10003;

REM Usuniêcie wyzwalacza, poniewa¿ nie dzia³a.
DROP TRIGGER OgraniczSpec;
