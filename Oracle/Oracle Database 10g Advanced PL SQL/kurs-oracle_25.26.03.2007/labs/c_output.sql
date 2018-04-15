CREATE OR REPLACE PROCEDURE c_output(p_in IN BINARY_INTEGER)

IS

i BINARY_INTEGER;

BEGIN

i:=call_c(p_in);

DBMS_OUTPUT.PUT_LINE('The total tax is: '|| i);

END c_output;

/
