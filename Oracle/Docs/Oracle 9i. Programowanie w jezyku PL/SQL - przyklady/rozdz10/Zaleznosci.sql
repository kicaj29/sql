REM Zaleznosci.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt ilustruje dzia³anie zale¿nych obiektów
REM ró¿nych typów.

-- Najpierw utworzymy prost¹ tabelê
 CREATE TABLE prosta_tabela (f1 NUMBER);

-- Teraz utworzymy pakiet z procedur¹, która bêdzie odwo³ywaæ siê do tabeli   
--  prosta_tabela.
CREATE OR REPLACE PACKAGE Zaleznosci AS
    PROCEDURE Przyklad(p_Wart IN NUMBER);
END Zaleznosci;
/

CREATE OR REPLACE PACKAGE BODY Zaleznosci AS
    PROCEDURE Przyklad(p_Wart IN NUMBER) IS
     BEGIN
        INSERT INTO prosta_tabela VALUES (p_Wart);
     END Przyklad;
END Zaleznosci;
/

 -- Teraz utworzymy procedurê, która wywo³uje pakiet Zaleznosci.
CREATE OR REPLACE PROCEDURE Zalezna(p_Wart IN NUMBER) AS
 BEGIN
    Zaleznosci.Przyklad(p_Wart + 1);
END Zalezna;
/

-- Sformu³owanie zapytania do perspektywy user_objects, aby sprawdziæ, czy
-- wszystkie obiekty s¹ poprawne.
 SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI','PROSTA_TABELA');

-- Modyfikacja jedynie treœci pakietu. Zwróæmy uwagê, ¿e nag³ówek
-- pozostaje niezmieniony.
CREATE OR REPLACE PACKAGE BODY Zaleznosci AS
    PROCEDURE Przyklad(p_Wart IN NUMBER) IS
    BEGIN
       INSERT INTO prosta_tabela VALUES (p_Wart - 1);
    END Przyklad;
END Zaleznosci;
/

-- Perspektywa user_objects pokazuje teraz, ¿e procedura Zalezna jest w dalszym 
-- ci¹gu poprawna.
  SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI', 'PROSTA_TABELA');

-- Nawet je¿eli usuniemy tabelê, to spowoduje to utratê wa¿noœci wy³¹cznie
-- treœci pakietu.
DROP TABLE prosta_tabela;
SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI','PROSTA_TABELA');
