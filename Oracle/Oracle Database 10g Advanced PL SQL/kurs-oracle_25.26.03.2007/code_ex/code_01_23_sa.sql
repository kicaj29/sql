DECLARE
  v_lname VARCHAR2(15);
BEGIN
  SELECT cust_last_name INTO v_lname FROM customers
  WHERE cust_first_name='Ally'; 
  DBMS_OUTPUT.PUT_LINE ('Ally''s last name is : '||v_lname);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
  DBMS_OUTPUT.PUT_LINE (' Your select statement retrieved multiple rows. Consider using a cursor.');
END;
/
