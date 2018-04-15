DECLARE
  v_address cust_address_typ;
BEGIN
  SELECT cust_address
    INTO v_address
    FROM customers
    WHERE customer_id = 101;
  DBMS_OUTPUT.PUT_LINE (v_address.street_address);
END;
/
