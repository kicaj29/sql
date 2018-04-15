DECLARE v_credit customers.credit_limit%type;
BEGIN
  v_credit := get_credit(101);
  dbms_output.put_line(v_credit);
END;
/
