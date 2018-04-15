DECLARE
  CURSOR cur_update 
  IS SELECT * FROM customers 
  WHERE credit_limit < 5000 FOR UPDATE;
BEGIN
  FOR v_rec IN cur_update
    LOOP
      UPDATE customers 
      SET credit_limit = credit_limit + 200
      WHERE CURRENT OF cur_update;
    END LOOP;
END;
/
