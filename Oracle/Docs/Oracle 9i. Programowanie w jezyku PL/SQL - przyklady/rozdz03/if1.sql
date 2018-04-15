REM if1.sql
REM Rozdzia� 3, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje instrukcj� IF.

DECLARE
  z_LiczbaMiejsc pokoje.liczba_miejsc%TYPE;
  z_Komentarz VARCHAR2(35);
BEGIN
  /* Pobranie liczby miejsc w pokoju identyfikowanym przez ID 20008.
     Zapami�tanie wyniku w zmiennej z_LiczbaMiejsc. */
  SELECT liczba_miejsc
    INTO z_LiczbaMiejsc
    FROM pokoje
    WHERE pokoj_id = 20008;
  IF z_LiczbaMiejsc < 50 THEN
    z_Komentarz := 'Dosy� ma�y';
  ELSIF z_LiczbaMiejsc < 100 THEN
    z_Komentarz := 'Troch� wi�kszy';
  ELSE
    z_Komentarz := 'Du�o przestrzeni';
  END IF;
END;
/
/
