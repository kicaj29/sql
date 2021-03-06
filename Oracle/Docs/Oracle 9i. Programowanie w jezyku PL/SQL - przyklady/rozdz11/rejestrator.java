// Rejestrator.java
// Rozdział 11., Scott Urman - Oracle9i Programowanie w języku PL/SQL
// Ta klasa zarejestruje informacje na temat połaczeń i rozłączeń
// w tabeli audyt_polaczen.

import java.sql.*;
import oracle.jdbc.driver.*;

public class Rejestrator {
  public static void RejestrowaniePolaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domyślnego połączenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'POLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzającej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }

  public static void RejestrowanieRozlaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domyślnego połączenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'ROZLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzającej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }
}
