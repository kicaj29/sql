REM if2.sql
REM Rozdzia³ 3, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Instrukcja IF w tym bloku zawiera wiêcej ni¿ jedn¹ instrukcjê
REM dla pojedynczego warunku.

DECLARE
  z_LiczbaMiejsc pokoje.liczba_miejsc%TYPE;
  z_Komentarz VARCHAR2(35);
BEGIN
  /* Pobranie liczby miejsc w pokoju identyfikowanym przez ID 20008.
     Zapamiêtanie wyniku w zmiennej z_LiczbaMiejsc. */
  SELECT liczba_miejsc
    INTO z_LiczbaMiejsc
    FROM pokoje
    WHERE pokoj_id = 20008;
  IF z_LiczbaMiejsc < 50 THEN
    z_Komentarz := 'Dosyæ ma³y';
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Mi³y i przytulny');
  ELSIF z_LiczbaMiejsc < 100 THEN
    z_Komentarz := 'Trochê wiêkszy';
    INSERT INTO tabela_tymcz (kol_znak)
      VALUES ('Pokój swobody');
    ELSE
      z_Komentarz := 'Du¿o przestrzeni';
  END IF;
END;
/