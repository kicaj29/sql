--Purpose: Compare explicit to implicit cursors
--Steps:   Run the script below. 
--         Compare explicit to implicit cursors.
--               
--         
--         

CREATE TABLE one_row_tab 
(x PRIMARY KEY)
ORGANIZATION INDEX AS SELECT 1 FROM dual;


PAUSE Create two procedures, one with an implicit cursor, the other with an explicit cursor (Press Enter)

SET ECHO ON

CREATE OR REPLACE PROCEDURE implicit 
IS 
  dummy PLS_INTEGER;
BEGIN
  FOR i IN 1  .. 50000 LOOP
    SELECT 1
      INTO dummy
      FROM one_row_tab;
  END LOOP;
END implicit;
/

CREATE OR REPLACE PROCEDURE explicit 
IS 
  CURSOR explicit_cur IS
    SELECT 1 
    FROM   one_row_tab;
  
  dummy PLS_INTEGER;

BEGIN
  FOR i IN 1  .. 50000 LOOP
    OPEN explicit_cur;
    FETCH explicit_cur
      INTO dummy;
    CLOSE explicit_cur;
  END LOOP;
END explicit;
/

SET ECHO OFF
SET TIMING ON

EXECUTE implicit
PAUSE Implicit routine results (Press Enter)


EXECUTE explicit
PAUSE Explicit routine results (Press Enter to end)


SET TIMING OFF
