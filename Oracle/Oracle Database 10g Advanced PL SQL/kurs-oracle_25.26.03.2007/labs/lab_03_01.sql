CREATE TYPE typ_item AS OBJECT  --create object
 (prodid  NUMBER(5),
  price   NUMBER(7,2) )
/
CREATE TYPE typ_item_nst -- define nested table type
  AS TABLE OF typ_item
/
CREATE TABLE POrder (  -- create database table
     ordid	NUMBER(5),
     supplier	NUMBER(5),
     requester	NUMBER(4),
     ordered	DATE,
     items	typ_item_nst)
     NESTED TABLE items STORE AS item_stor_tab
/
