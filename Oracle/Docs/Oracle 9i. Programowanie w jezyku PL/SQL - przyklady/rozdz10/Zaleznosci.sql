REM Zaleznosci.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt ilustruje dzia�anie zale�nych obiekt�w
REM r�nych typ�w.

-- Najpierw utworzymy prost� tabel�
 CREATE TABLE prosta_tabela (f1 NUMBER);

-- Teraz utworzymy pakiet z procedur�, kt�ra b�dzie odwo�ywa� si� do tabeli   
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

 -- Teraz utworzymy procedur�, kt�ra wywo�uje pakiet Zaleznosci.
CREATE OR REPLACE PROCEDURE Zalezna(p_Wart IN NUMBER) AS
 BEGIN
    Zaleznosci.Przyklad(p_Wart + 1);
END Zalezna;
/

-- Sformu�owanie zapytania do perspektywy user_objects, aby sprawdzi�, czy
-- wszystkie obiekty s� poprawne.
 SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI','PROSTA_TABELA');

-- Modyfikacja jedynie tre�ci pakietu. Zwr��my uwag�, �e nag��wek
-- pozostaje niezmieniony.
CREATE OR REPLACE PACKAGE BODY Zaleznosci AS
    PROCEDURE Przyklad(p_Wart IN NUMBER) IS
    BEGIN
       INSERT INTO prosta_tabela VALUES (p_Wart - 1);
    END Przyklad;
END Zaleznosci;
/

-- Perspektywa user_objects pokazuje teraz, �e procedura Zalezna jest w dalszym 
-- ci�gu poprawna.
  SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI', 'PROSTA_TABELA');

-- Nawet je�eli usuniemy tabel�, to spowoduje to utrat� wa�no�ci wy��cznie
-- tre�ci pakietu.
DROP TABLE prosta_tabela;
SELECT object_name, object_type, status
     FROM user_objects
     WHERE object_name IN ('ZALEZNA', 'ZALEZNOSCI','PROSTA_TABELA');
