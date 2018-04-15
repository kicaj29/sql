DECLARE 
  SUBTYPE Accumulator IS NUMBER; 
  v_amount  NUMBER(4,2); 
  v_total   Accumulator; 
BEGIN
  v_amount := 99.99;
  v_total  := 100.00;
  dbms_output.put_line('Amount is: ' || v_amount);
  dbms_output.put_line('Total is: '  || v_total);
  v_total := v_amount;
  dbms_output.put_line('This works too: '  ||
  v_total);
  --  v_amount := v_amount + 1; Will show value error
END;
/
