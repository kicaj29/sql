REM ProstaKlasa.sql
REM Rozdzia� 2, Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt utworzy prost� klas� Javy.  Uruchomienie klasy wymaga
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
