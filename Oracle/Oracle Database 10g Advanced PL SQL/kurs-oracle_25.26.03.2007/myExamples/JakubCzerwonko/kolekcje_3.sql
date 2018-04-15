
DECLARE
  cur pck_exercise.rt_cust;
  id NUMBER;
  fname VARCHAR2(20);
BEGIN 
  OPEN cur FOR SELECT * FROM customers;

  
  SELECT tab.customer_id, tab.customer_first_name 
  INTO id, fname
  from table(pck_exercise.foo2(cur)) tab;
  
  Dbms_Output.put_line(id || ' ' || fname);
  
  CLOSE cur;
END;
/
