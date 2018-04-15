REM PozaZakresem.sql
REM Rozdzia³ 7.1, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten przyk³ad ilustruje zakres wyj¹tków.

BEGIN
   DECLARE
     w_WyjatekZdefPrzezUzytk EXCEPTION;
     BEGIN
       RAISE w_WyjatekZdefPrzezUzytk;
     END;
   EXCEPTION
     /* Wyj¹tek w_WyjatekZdefPrzezUzytk jest tutaj poza zakresem - mo¿e byæ
       obs³u¿ony jedynie przez program obs³ugi wyj¹tków OTHERS*/
     WHEN OTHERS THEN
      /* Ponowne zg³oszenie wyj¹tku, który zostanie propagowany do œrodowiska
         wywo³uj¹cego */
      RAISE;
END;
/

CREATE OR REPLACE PACKAGE Globalne AS
  /*Ten pakiet zawiera deklaracje globalne. Obiekty tutaj zadeklarowane bêd¹ widoczne  
    przez kwalifikowane odwo³ania dla ka¿dego innego bloku lub procedury. Nale¿y zwróciæ
    uwagê, ¿e ten pakiet nie zawiera treœci. */

  /* Wyj¹tek zdefiniowany przez u¿ytkownika */
  w_WyjatekZdefPrzezUzytk EXCEPTION;
END Globalne;
/

BEGIN
  BEGIN
    RAISE Globalne.w_WyjatekZdefPrzezUzytk;
  END;
EXCEPTION
  /* Poniewa¿ wyj¹tek w_WyjatekZdefPrzezUzytk jest w dalszym ci¹gu 
     widoczny, mo¿na go obs³u¿yæ jawnie. */
  WHEN Globalne.w_WyjatekZdefPrzezUzytk THEN
 /* Ponowne zg³oszenie wyj¹tku, który zostanie propagowany do œrodowiska wywo³uj¹cego */
  RAISE;
END;
/
