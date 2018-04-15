REM ProstaKlasa.sql
REM Rozdzia³ 2, Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt utworzy prost¹ klasê Javy.  Uruchomienie klasy wymaga
REM systemu Oracle8i lub wersji nowszej.

CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED "ProstaKlasa" AS
  class ProstaKlasa
  {
    static public void Witaj()
    {
      System.out.println("Pozdrowienia z Prostej!");
    }
  }
/

CREATE OR REPLACE PROCEDURE ProsteOpak AS
  LANGUAGE Java
  NAME 'ProstaKlasa.Witaj()';
/
