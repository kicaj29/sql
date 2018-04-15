REM BladLokalny.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok ilustruje nieprawid�owe po�o�enie podprogramu.

DECLARE
    /* Najpierw zadeklarujemy funkcj� FormatujNazwisko. Spowoduje to wygenerowanie
       b��du kompilacji, poniewa� lokalne podprogramy powinny by� poprzedzone 
       pozosta�ymi deklaracjami */
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
   -- Pocz�tek g��wnego bloku.
    BEGIN
      NULL;
END;
/