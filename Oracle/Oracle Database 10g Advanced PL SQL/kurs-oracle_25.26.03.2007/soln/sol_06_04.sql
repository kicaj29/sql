CONNECT /as sysdba

DECLARE
BEGIN
  DBMS_RLS.ADD_POLICY (
   'OE', 
   'ORDERS', 
   'OE_ORDERS_ACCESS_POLICY', 
   'OE', 
   'SALES_ORDERS_PKG.THE_PREDICATE', 
   'SELECT, INSERT, UPDATE, DELETE', 
   FALSE, 
   TRUE);
END;
/
