CREATE OR REPLACE PROCEDURE report_credit
  (p_email    customers.cust_last_name%TYPE,
   p_credit_limit customers.credit_limit%TYPE)
IS
  TYPE  typ_name IS TABLE OF customers%ROWTYPE 
    INDEX BY customers.cust_email%TYPE;
  v_by_cust_email   typ_name;
  i VARCHAR2(30);

  PROCEDURE load_arrays IS
  BEGIN
    FOR rec IN  (SELECT * FROM customers 
                 WHERE cust_email IS NOT NULL) LOOP
        v_by_cust_email (rec.cust_email) := rec;
    END LOOP;
  END;

BEGIN
  load_arrays;
  dbms_output.put_line 
    ('For credit amount of: ' || p_credit_limit);
  IF v_by_cust_email(p_email).credit_limit > p_credit_limit
        THEN dbms_output.put_line ( 'Customer '|| 
          v_by_cust_email(p_email).cust_last_name || 
          ': ' || v_by_cust_email(p_email).cust_email ||
          ' has credit limit of: ' ||
          v_by_cust_email(p_email).credit_limit);
  END IF;
END report_credit;
/

EXECUTE report_credit('Prem.Walken@BRANT.COM', 100)
