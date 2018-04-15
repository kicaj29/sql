DECLARE
    v_rows      mytypes.Counter;
    v_customers mytypes.Counter;
    SUBTYPE   Accumulator IS NUMBER; 
    v_total     Accumulator(6,2);
	BEGIN
    SELECT COUNT(*) INTO v_customers FROM customers;
    SELECT COUNT(*) INTO v_rows FROM orders;
    v_total := v_customers + v_rows;
    DBMS_OUTPUT.PUT_LINE('Total rows from 2 tables: '||
    v_total);
EXCEPTION
    WHEN value_error THEN
    DBMS_OUTPUT.PUT_LINE('Error in data type.');
END;
/
