CREATE OR REPLACE PACKAGE mytypes
IS
  SUBTYPE   Counter IS INTEGER;  -- based on INTEGER type
  TYPE typ_TimeRec IS RECORD (minutes INTEGER, hours
  INTEGER);
  SUBTYPE Time IS typ_TimeRec;   -- based on RECORD type
  SUBTYPE ID_Num IS customers.customer_id%TYPE; 
  CURSOR cur_cust IS SELECT * FROM customers;
  SUBTYPE CustFile IS cur_cust%ROWTYPE; -- based on cursor   
END mytypes;
/
