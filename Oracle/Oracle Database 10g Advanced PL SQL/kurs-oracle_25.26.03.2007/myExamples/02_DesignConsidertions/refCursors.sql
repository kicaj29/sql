CREATE OR REPLACE PACKAGE cust_data AS
TYPE typ_cust_rec IS RECORD
  (cust_id NUMBER(6), custname VARCHAR2(20), 
   credit   NUMBER(9,2), cust_email VARCHAR2(30));
TYPE rt_cust IS REF CURSOR RETURN typ_cust_rec;
PROCEDURE get_cust
 (p_custid IN NUMBER, p_cv_cust IN OUT rt_cust);
END;

CREATE OR REPLACE PACKAGE BODY cust_data AS
 PROCEDURE get_cust
   (p_custid IN NUMBER, p_cv_cust IN OUT rt_cust)
 IS
 BEGIN
   OPEN p_cv_cust FOR
SELECT customer_id, cust_first_name, credit_limit, cust_email 
     FROM customers
     WHERE customer_id = p_custid;
-- CLOSE p_cv_cust
 END;
END;


create or REPLACE function fTestRefCursor(p_rc CUST_DATA.RT_CUST) return varchar2
is
tc cust_data.TYP_CUST_REC;
begin
     fetch p_rc into tc;
     return tc.custname;
end;

--1
--Jak mo¿na napisaæ zapytanie, aby w parametrze fTestRefCursor mo¿na by³o u¿ywaæ kolumn z tabeli c?
select c.CUSTOMER_ID aa, c.CUST_FIRST_NAME, c.CUST_LAST_NAME,
fTestRefCursor(cursor(select customer_id, cust_first_name, credit_limit, cust_email  from customers where customer_id = 194))
from customers c


--2
declare
  id number;
  --nale¿y okreœliæ zakres dla zmiennej txt
  txt varchar2(32);
begin
  id := 194;
  select 
  fTestRefCursor(cursor(select customer_id, cust_first_name, credit_limit, cust_email  from customers where customer_id = id ))
  into txt
  from customers c where rownum = 1;
  DBMS_OUTPUT.PUT_LINE(txt);
end;   