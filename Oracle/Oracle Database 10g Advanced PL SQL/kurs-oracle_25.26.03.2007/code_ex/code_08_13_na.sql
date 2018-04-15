SET SERVEROUT ON
CREATE OR REPLACE PROCEDURE first_one 
IS
BEGIN
  dbms_output.put_line(
    substr(dbms_utility.format_call_Stack, 1, 255));
END;
/

CREATE OR REPLACE PROCEDURE second_one 
IS
BEGIN
  null;
  first_one;
END;
/

CREATE OR REPLACE PROCEDURE third_one 
IS
BEGIN
  null;
  null;
  second_one;
END;
/
