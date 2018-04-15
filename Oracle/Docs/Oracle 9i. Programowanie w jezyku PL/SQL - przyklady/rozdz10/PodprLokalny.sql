REM PodprLolalny.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten blok demonstruje podprogram lokalny,

set serveroutput on

DECLARE
      CURSOR k_WszyscyStudenci IS
         SELECT imie, nazwisko
             FROM studenci;
      z_NazwiskoSformatowane VARCHAR2(50);
      /* Funkcja, kt�ra zwraca po��czenie imienia i nazwiska,
      rozdzielone spacj�. */
     FUNCTION FormatujNazwisko(p_Imie IN VARCHAR2,
                               p_Nazwisko IN VARCHAR2)
        RETURN VARCHAR2 IS
     BEGIN
        RETURN p_Imie || ' ' || p_Nazwisko;
     END FormatujNazwisko;
    -- Pocz�tek g��wnego bloku.
    BEGIN
       FOR z_RekordStudenta IN k_WszyscyStudenci LOOP
         z_NazwiskoSformatowane :=
            FormatujNazwisko(z_RekordStudenta.imie,
                             z_RekordStudenta.nazwisko);
           DBMS_OUTPUT.PUT_LINE(z_NazwiskoSformatowane);
       END LOOP;
     END;
/