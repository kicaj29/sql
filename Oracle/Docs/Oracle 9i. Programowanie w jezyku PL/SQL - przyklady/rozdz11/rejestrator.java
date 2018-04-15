// Rejestrator.java
// Rozdzia� 11., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
// Ta klasa zarejestruje informacje na temat po�acze� i roz��cze�
// w tabeli audyt_polaczen.

import java.sql.*;
import oracle.jdbc.driver.*;

public class Rejestrator {
  public static void RejestrowaniePolaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domy�lnego po��czenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'POLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzaj�cej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }

  public static void RejestrowanieRozlaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domy�lnego po��czenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'ROZLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzaj�cej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }
}
