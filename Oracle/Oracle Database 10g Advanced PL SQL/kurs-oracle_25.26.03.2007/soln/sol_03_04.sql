CREATE TYPE typ_cr_card AS OBJECT  --create object
 (card_type  VARCHAR2(25),
  card_num   NUMBER);
/
CREATE TYPE typ_cr_card_nst -- define nested table type
  AS TABLE OF typ_cr_card;
/
ALTER TABLE customers ADD
  credit_cards typ_cr_card_nst
   NESTED TABLE credit_cards STORE AS c_c_store_tab;
