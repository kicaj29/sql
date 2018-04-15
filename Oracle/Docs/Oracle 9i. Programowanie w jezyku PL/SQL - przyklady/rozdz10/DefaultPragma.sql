REM DefaultPragma.sql
REM Rozdzia� 10., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM W tym pakiecie wykorzystano s�owo kluczowe DEFAULT w wywo�aniu 
REM dyrektywy pragma RESTRICT_REFERENCES.

CREATE OR REPLACE PACKAGE DefaultPragma AS
  FUNCTION F1 RETURN NUMBER;
  PRAGMA RESTRICT_REFERENCES(F1, RNDS, RNPS);

  PRAGMA RESTRICT_REFERENCES(DEFAULT, WNDS, WNPS, RNDS, RNPS);
  FUNCTION F2 RETURN NUMBER;

  FUNCTION F3 RETURN NUMBER;
END DefaultPragma;
/

CREATE OR REPLACE PACKAGE BODY DefaultPragma AS
  FUNCTION F1 RETURN NUMBER IS
  BEGIN
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (1, 'F1!');
    RETURN 1;
  END F1;

  FUNCTION F2 RETURN NUMBER IS
  BEGIN
    RETURN 2;
  END F2;

  -- Ta funkcja narusza regu�� okre�lon� domy�ln� dyrektyw� pragma.
  FUNCTION f3 RETURN NUMBER IS
  BEGIN
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (1, 'F3!');
    RETURN 3;
  END F3;
END DefaultPragma;
/

show errors
