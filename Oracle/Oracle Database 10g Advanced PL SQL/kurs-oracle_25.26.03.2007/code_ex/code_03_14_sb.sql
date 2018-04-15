CREATE TABLE POrder (  -- create database table
     ordid	NUMBER(5),
     supplier	NUMBER(5),
     requester	NUMBER(4),
     ordered	DATE,
     items	typ_item_nst)
     NESTED TABLE items STORE AS item_stor_tab
/
