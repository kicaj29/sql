REM AutoPragma.sql
REM Rozdzia³ 4., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL

-- Dyrektywa pragma jest poprawna w bloku anonimowym najwy¿szego poziomu
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    COMMIT;
END;
/

-- ale nie jest poprawna w zagnie¿d¿onych blokach:
BEGIN
  DECLARE
    PRAGMA ANTONOMOUS_TRANSACTION;
  BEGIN
     COMMIT;
  END;
END;
/

-- jest poprawna zarówno w podprogramach lokalnych, jak i samodzielnych
CREATE OR REPLACE PROCEDURE Auto1 AS
   PRAGMA AUTONOMOUS_TRANSACTION;

PROCEDURE Lokalna IS
 PRAGMA AUTONOMOUS TYRANSACTION;
   BEGIN
     ROLLBACK;
END Lokalna;
BEGIN
   Lokalna;
   COMMIT;
END Auto1;
/

show errors

-- Jest poprawna w procedurze wewn¹trz pakietu.
CREATE OR REPLACE PACKAGE Auto2 AS
  PROCEDURE P;
END Auto2;
/

show errors

-- Ale nie jest poprawna na poziomie pakietu.
CREATE OR REPLACE PACKAGE Auto3 AS
  PRAGMA AUTONOMOUS_TRANSACTION;
   PROCEDURE P;
   PROCEDURE Q;
END Auto3;
/

show errors

