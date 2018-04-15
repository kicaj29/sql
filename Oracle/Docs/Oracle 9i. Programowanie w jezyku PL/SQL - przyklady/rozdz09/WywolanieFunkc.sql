REM WywolanieFunkc.sql
REM Rozdzia³ 9., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt prezentuje sposób wywo³ywania funkcji sk³adowanych.

set serveroutput on

DECLARE
     CURSOR k_Zajecia IS
        SELECT wydzial, kurs
          FROM grupy;
    BEGIN
      FOR z_RekordZajec IN k_Zajecia LOOP
    -- Wyœwietlenie wszystkich zajêæ, na których pozosta³o ma³o wolnych miejsc.
    IF PrawieKomplet(z_RekordZajec.wydzial,
                  z_RekordZajec.kurs) THEN
       DBMS_OUTPUT.PUT_LINE (
                          z_RekordZajec.wydzial || ' ' ||
                         z_RekordZajec.kurs || ' jest prawie pe³na!');
      END IF;
   END LOOP;
 END;
/

