REM PetleKolekcji.sql
REM Rozdzia³ 8., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten blok demonstruje uzycie metod FIRST, LAST, NEXT oraz PRIOR.

set serveroutput on

DECLARE
     TYPE t_TablicaZnakow IS TABLE OF CHAR(1);
     z_Znaki t_TablicaZnakow := 
     t_TablicaZnakow('M', 'a', 'd', 'a', 'm', ',',' ',
                'I', '''', 'm', ' ', 'A', 'd', 'a', 'm');

     z_Indeks INTEGER;
BEGIN
  -- Pêtla w przód od pierwszego do ostatniego elementu tabeli.
  z_Indeks := z_Znaki.FIRST;
  WHILE z_Indeks <= z_Znaki.LAST LOOP
       DBMS_OUTPUT.PUT(z_Znaki(z_Indeks));
       z_Indeks := z_Znaki.NEXT(z_Indeks);
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;

  -- Pêtla w ty³ od ostatniego do pierwszego elementu tabeli.
  z_Indeks := z_Znaki.LAST;
  WHILE z_Indeks >= z_Znaki.FIRST LOOP
       DBMS_OUTPUT.PUT(z_Znaki(z_Indeks));
       z_Indeks := z_Znaki.PRIOR(z_Indeks);
  END LOOP;
       DBMS_OUTPUT.NEW_LINE;
END;
/

