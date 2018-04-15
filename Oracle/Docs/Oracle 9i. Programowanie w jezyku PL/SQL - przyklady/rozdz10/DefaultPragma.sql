REM DefaultPragma.sql
REM Rozdzia³ 10., Scott Urman - Oracle9i Programowanie w jêzyku PL/SQL
REM W tym pakiecie wykorzystano s³owo kluczowe DEFAULT w wywo³aniu 
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

  -- Ta funkcja narusza regu³ê okreœlon¹ domyœln¹ dyrektyw¹ pragma.
  FUNCTION f3 RETURN NUMBER IS
  BEGIN
    INSERT INTO tabela_tymcz (kol_num, kol_znak)
      VALUES (1, 'F3!');
    RETURN 3;
  END F3;
END DefaultPragma;
/

show errors
