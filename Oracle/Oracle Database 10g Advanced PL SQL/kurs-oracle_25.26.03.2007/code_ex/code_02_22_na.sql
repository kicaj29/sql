/* The block given in the lesson won't execute without the bind variables. First declare the following bind variables in SQL*Plus. */
variable cv_cust REFCURSOR
variable cv_orders REFCURSOR
/* After declaring the bind variables you can execute the block giving in the lesson. */
BEGIN
  OPEN :cv_cust FOR SELECT * FROM customers;
  OPEN :cv_orders FOR SELECT * FROM orders;
END;
/
