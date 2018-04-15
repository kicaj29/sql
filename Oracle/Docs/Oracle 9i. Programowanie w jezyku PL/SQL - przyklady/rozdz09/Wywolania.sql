REM Wywolania.sql
REM Rozdzia� 9., Scott Urman - Oracle9i Programowanie w j�zyku PL/SQL
REM Ten skrypt demonstruje instrukcj� CALL.

set serveroutput on

CREATE OR REPLACE PROCEDURE CallProc1(p1 IN VARCHAR2 := NULL) AS
  BEGIN
     DBMS_OUTPUT.PUT_LINE('procedura CallProc1 wywo�ana z parametrem ' || p1);
END CallProc1;
/

CREATE OR REPLACE PROCEDURE CallProc2(p1 IN OUT VARCHAR2) AS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('Procedura CallProc2 wywo�ana z parametrem ' || p1);
    p1 := p1 || ' zako�czy�a dzia�anie!';
END CallProc2;
/

CREATE OR REPLACE FUNCTION CallFunc(p1 IN VARCHAR2)
   RETURN VARCHAR2 AS
   BEGIN
     DBMS_OUTPUT.PUT_LINE('Procedura CallFunc wywo�ana z parametrem ' || p1);
     RETURN p1;
END CallFunc;
/

set serveroutput on

-- Kilka poprawnych wywo�a� bezpo�rednio z SQL.
CALL CallProc1('Witajcie!');
CALL CallProc1();
VARIABLE z_Wynik VARCHAR2(50);
CALL CallFunc('Witajcie!') INTO :z_Wynik;
PRINT z_Wynik
CALL CallProc2(:z_Wynik);
PRINT z_Wynik

-- Takie wywo�anie jest niepoprawne
BEGIN
    CALL CallProc1();
END;
 /

-- Ale te wywo�ania s� poprawne
DECLARE
   z_Wynik VARCHAR2(50);
BEGIN
    EXECUTE IMMEDIATE 'CALL CallProc1(''Hello from PL/SQL'')';
    EXECUTE IMMEDIATE
       'CALL CallFunc(''Pozdrowienia z j�zyka PL/SQL'') INTO :z_Wynik'
       USING OUT z_Wynik;
END;
/