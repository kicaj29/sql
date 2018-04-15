CREATE OR REPLACE FUNCTION get_credit
  (v_id customers.customer_id%TYPE) RETURN NUMBER IS
   v_credit customers.credit_limit%TYPE := 0;
BEGIN
  SELECT credit_limit
  INTO   v_credit
  FROM   customers         
  WHERE  customer_id = v_id;
  RETURN v_credit;
END get_credit;
/
