REM PozaZakresem.sql
REM Rozdzia� 7.1, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten przyk�ad ilustruje zakres wyj�tk�w.

BEGIN
   DECLARE
     w_WyjatekZdefPrzezUzytk EXCEPTION;
     BEGIN
       RAISE w_WyjatekZdefPrzezUzytk;
     END;
   EXCEPTION
     /* Wyj�tek w_WyjatekZdefPrzezUzytk jest tutaj poza zakresem - mo�e by�
       obs�u�ony jedynie przez program obs�ugi wyj�tk�w OTHERS*/
     WHEN OTHERS THEN
      /* Ponowne zg�oszenie wyj�tku, kt�ry zostanie propagowany do �rodowiska
         wywo�uj�cego */
      RAISE;
END;
/

CREATE OR REPLACE PACKAGE Globalne AS
  /*Ten pakiet zawiera deklaracje globalne. Obiekty tutaj zadeklarowane b�d� widoczne  
    przez kwalifikowane odwo�ania dla ka�dego innego bloku lub procedury. Nale�y zwr�ci�
    uwag�, �e ten pakiet nie zawiera tre�ci. */

  /* Wyj�tek zdefiniowany przez u�ytkownika */
  w_WyjatekZdefPrzezUzytk EXCEPTION;
END Globalne;
/

BEGIN
  BEGIN
    RAISE Globalne.w_WyjatekZdefPrzezUzytk;
  END;
EXCEPTION
  /* Poniewa� wyj�tek w_WyjatekZdefPrzezUzytk jest w dalszym ci�gu 
     widoczny, mo�na go obs�u�y� jawnie. */
  WHEN Globalne.w_WyjatekZdefPrzezUzytk THEN
 /* Ponowne zg�oszenie wyj�tku, kt�ry zostanie propagowany do �rodowiska wywo�uj�cego */
  RAISE;
END;
/
