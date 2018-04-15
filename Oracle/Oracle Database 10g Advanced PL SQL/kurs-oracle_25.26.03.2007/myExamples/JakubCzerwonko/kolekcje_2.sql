CREATE TYPE typ_cr_card AS OBJECT  --create object
 (
  card_type  varchar2(25),
  card_num   NUMBER
 )
/
CREATE TYPE typ_cr_card_nst -- define nested table type
  AS TABLE OF typ_cr_card
/

ALTER TABLE customers ADD
  (
    credit_cards typ_cr_card_nst)
    nested TABLE credit_cards STORE AS c_c_store_tab
;

CREATE OR REPLACE PACKAGE credit_card_pkg
IS
  PROCEDURE update_card_info
    (p_cust_id NUMBER, p_card_type VARCHAR2, p_card_no VARCHAR2);
  
  PROCEDURE display_card_info
    (p_cust_id NUMBER);
END credit_card_pkg;  -- package spec
/

CREATE OR REPLACE PACKAGE BODY credit_card_pkg
IS

  PROCEDURE update_card_info
    (p_cust_id NUMBER, p_card_type VARCHAR2, p_card_no VARCHAR2)
  IS
    v_card_info typ_cr_card_nst;
    i INTEGER;
  BEGIN
    SELECT credit_cards
      INTO v_card_info
      FROM customers
      WHERE customer_id = p_cust_id;
    IF v_card_info.EXISTS(1) THEN  
 -- cards exist, add more
  
 -- fill in code here

    ELSE -- no cards for this customer, construct one

 -- fill in code here 

    END IF;
  END update_card_info;


  PROCEDURE display_card_info
    (p_cust_id NUMBER)
  IS
    v_card_info typ_cr_card_nst;
    i INTEGER;
  BEGIN
    SELECT credit_cards
      INTO v_card_info
      FROM customers
      WHERE customer_id = p_cust_id;

 -- fill in code here to display the nested table
 -- contents

  END display_card_info;  
END credit_card_pkg;  -- package body
/



EXECUTE credit_card_pkg.display_card_info(120)

EXECUTE credit_card_pkg.update_card_info(120, 'Visa', 11111111)

SELECT credit_cards 
FROM   customers 
WHERE  customer_id = 120;

EXECUTE credit_card_pkg.display_card_info(120)

EXECUTE credit_card_pkg.update_card_info(120, 'MC', 2323232323)

EXECUTE credit_card_pkg.update_card_info (120, 'DC', 4444444)


EXECUTE credit_card_pkg.display_card_info(120)



SELECT c1.customer_id, c1.cust_last_name, c2.*
FROM   customers c1, TABLE(c1.credit_cards) c2
WHERE  customer_id = 120;




