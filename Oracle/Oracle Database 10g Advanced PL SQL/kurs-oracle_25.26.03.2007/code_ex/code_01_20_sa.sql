SET SERVEROUTPUT ON
DECLARE
  CURSOR cur_cust IS 
   SELECT cust_first_name, credit_limit
   FROM customers
   WHERE credit_limit > 4000; 
BEGIN
   FOR v_cust_record IN cur_cust 
    LOOP
     DBMS_OUTPUT.PUT_LINE
     (v_cust_record.cust_first_name ||' '||
      v_cust_record.credit_limit);   
    END LOOP; 
END;
/
