// Rejestrator.java
// Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
// Ta klasa zarejestruje informacje na temat po³aczeñ i roz³¹czeñ
// w tabeli audyt_polaczen.

import java.sql.*;
import oracle.jdbc.driver.*;

public class Rejestrator {
  public static void RejestrowaniePolaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domyœlnego po³¹czenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'POLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzaj¹cej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }

  public static void RejestrowanieRozlaczen(String uzytkID)
    throws SQLException {
    // Uzyskanie domyœlnego po³¹czenia JDBC 
    Connection polaczenie = new OracleDriver().defaultConnection();

    String CiagInsert =
      "INSERT INTO audyt_polaczen (nazwa_uzytkownika, operacja, datownik)" +
      "  VALUES (?, 'ROZLACZENIE', SYSDATE)";

   // Przygotowanie i wykonanie instrukcji przeprowadzaj¹cej wprowadzenie danych do bazy
    PreparedStatement InstrukcjaInsert =
      polaczenie.prepareStatement(CiagInsert);
    InstrukcjaInsert.setString(1, uzytkID);
    InstrukcjaInsert.execute();
  }
}
