--An error will occur after executing this code as c_tax.c doesn't exists.
DECLARE
  CURSOR cur_orders IS
  SELECT order_id, order_total 
  FROM   orders;
  v_tax  NUMBER(8,2);
BEGIN
  FOR order_record IN cur_orders 
  LOOP
    v_tax := tax_amt(order_record.order_total);
    DBMS_OUTPUT.PUT_LINE('Total tax: ' || v_tax);
  END LOOP;
END;
/
