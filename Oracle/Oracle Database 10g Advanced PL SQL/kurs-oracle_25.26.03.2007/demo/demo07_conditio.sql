REM Author: Dan Gabel 25-May-99
REM
REM Purpose:
REM THIS DEMO SHOWS THAT IN A CONDTION STATEMENT
REM "IF CONDITION 1 AND CONDITION 2 THEN"
REM THE COMPILER DOES NOT EVALUATE CONDITION 2
REM IF CONDITION 1 IS FALSE.
REM The plan is to compare a "long" condition
REM and a "short" condition to see if the compiler
REM evaluates both conditions before applying the
REM "and/or" operator.
REM
REM Revision History: 
REM                               Code modified to replace call 
REM                               to DBMS_UTILITY with procedure
REM                               get_time, to obtain the time to
REM                               execute conditional code

set serveroutput on

DECLARE
-- timing variables for long condition first
  t1            CHAR(5);
  t2            CHAR(5);
  v_diff1       NUMBER := -1;
-- timing variables for long condition second
  t3            CHAR(5);
  t4            CHAR(5);
  v_diff2       NUMBER := -1;
-- procedure to get current time
PROCEDURE get_time (t OUT NUMBER) IS
BEGIN
    SELECT TO_CHAR(SYSDATE, 'SSSSS') INTO t FROM dual;
END;
-- set up of a Local Module
FUNCTION f_long  
   RETURN boolean
IS
   v_x 	NUMBER;
BEGIN
   FOR v_int in 1..9999999 LOOP
      v_x := v_x+1;
   END LOOP;
   RETURN false;
END f_long;
-- start of executable to test this
BEGIN
   get_time(t1);     -- time to execute if 1st condition is long
   IF  f_long AND 1=2 THEN
      null;
   end if;
   get_time(t2);
   v_diff1 := t2 - t1;
   dbms_output.put_line('Function condition first: '|| v_diff1);
--
   get_time(t3);  -- time to execute if 2nd condition is long
   IF  1=2 AND f_long THEN  
      null;
   end if;
   get_time(t4);
   v_diff2 := t4 - t3;
   dbms_output.put_line('Function condition last: '|| v_diff2);
END;
/

