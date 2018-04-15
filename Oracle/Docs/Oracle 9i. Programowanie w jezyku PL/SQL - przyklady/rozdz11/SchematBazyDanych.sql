REM SchematBazyDanych.sql
REM Rozdzia³ 11., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM Ten skrypt demonstruje dwa wyzwalacze systemowe.

-- Najpierw utworzymy u¿ytkowników UzytkownikA i UzytkownikB.  Byæ mo¿e bêdzie trzeba
-- zmieniæ has³o systemowe i/lub informacje dotycz¹ce przestrzeni tabel.
connect system/manager

CREATE USER UzytkownikA IDENTIFIED BY UzytkownikA;
GRANT connect, resource, ADMINISTER DATABASE TRIGGER TO UzytkownikA;

CREATE USER UzytkownikB IDENTIFIED BY UzytkownikB;
GRANT connect, resource, ADMINISTER DATABASE TRIGGER TO UzytkownikB;

connect przyklad/przyklad
GRANT INSERT ON tabela_tymcz TO UzytkokwnikA;
GRANT INSERT ON tabela_tymcz TO UzytkownikB;

connect UzytkownikA/UzytkownikA
CREATE OR REPLACE TRIGGER ZarejestrujPolaczeniaUzytkA
  AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO przyklad.tabela_tymcz
    VALUES (1, 'uruchomiono wyzwalacz ZarejestrujPolaczeniaUzytkA!');
END ZarejestrujPolaczeniaUzytkA;
/

connect UzytkownikB/UzytkownikB
CREATE OR REPLACE TRIGGER ZarejestrujPolaczeniaUzytkB
  AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO przyklad.tabela_tymcz
    VALUES (1, 'uruchomiono wyzwalacz ZarejestrujPolaczeniaUzytkB!');
END ZarejestrujPolaczeniaUzytkB;
/

connect przyklad/przyklad
CREATE OR REPLACE TRIGGER ZarejestrujPolaczWszystkich
  AFTER LOGON ON DATABASE
BEGIN
  INSERT INTO przyklad.tabela_tymcz
    VALUES (1, 'uruchomiono wyzwalacz ZarejestrujPolaczeniaWszystkich!');
END ZarejestrujPolaczWszystkich;
/

REM Po³¹czymy siê jako trzech u¿ytkowników i sprawdzimy zawartoœæ tabeli tabela_tymcz.
connect UzytkownikA/UzytkownikA
connect UzytkownikB/UzytkownikB
connect przyklad/przyklad

SELECT * FROM tabela_tymcz;

REM Dezaktywujemy wyzwalacze i zerujemy zawartoœæ tabeli.
connect UzytkownikA/UzytkownikA
ALTER TRIGGER ZarejestrujPolaczeniaUzytkA DISABLE;
connect UzytkownikB/UzytkownikB
ALTER TRIGGER ZarejestrujPolaczeniaUzytkB DISABLE;
connect przyklad/przyklad
ALTER TRIGGER ZarejestrujPolaczeniaWszystkich DISABLE;
DELETE tabela_tymcz;
COMMIT;
