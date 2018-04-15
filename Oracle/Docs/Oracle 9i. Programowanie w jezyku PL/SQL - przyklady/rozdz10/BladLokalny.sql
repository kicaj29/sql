REM BladLokalny.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok ilustruje nieprawid³owe po³o¿enie podprogramu.

DECLARE
    /* Najpierw zadeklarujemy funkcjê FormatujNazwisko. Spowoduje to wygenerowanie
       b³êdu kompilacji, poniewa¿ lokalne podprogramy powinny byæ poprzedzone 
       pozosta³ymi deklaracjami */
    FUNCTION FormatujNazwisko(p_Imie IN VARCHAR2,
                              p_Nazwisko IN VARCHAR2)
       RETURN VARCHAR2 IS
    BEGIN
       RETURN p_Imie || ' ' || p_Nazwisko;
    END FormatujNazwisko;
 
    CURSOR k_WszyscyStudenci IS
        SELECT imie, nazwisko
            FROM studenci;
      z_NazwiskoSformatowane VARCHAR2(50);
   -- Pocz¹tek g³ównego bloku.
    BEGIN
      NULL;
END;
/