REM WywolanieFunkc.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt prezentuje spos�b wywo�ywania funkcji sk�adowanych.

set serveroutput on

DECLARE
     CURSOR k_Zajecia IS
        SELECT wydzial, kurs
          FROM grupy;
    BEGIN
      FOR z_RekordZajec IN k_Zajecia LOOP
    -- Wy�wietlenie wszystkich zaj��, na kt�rych pozosta�o ma�o wolnych miejsc.
    IF PrawieKomplet(z_RekordZajec.wydzial,
                  z_RekordZajec.kurs) THEN
       DBMS_OUTPUT.PUT_LINE (
                          z_RekordZajec.wydzial || ' ' ||
                         z_RekordZajec.kurs || ' jest prawie pe�na!');
      END IF;
   END LOOP;
 END;
/

