DESCRIBE pOrder

INSERT INTO porder
  VALUES (500, 50, 5000, sysdate,
     typ_item_nst(typ_item (55, 555)));

INSERT INTO porder
  VALUES (800, 80, 8000, sysdate,
    typ_item_nst (typ_item (88, 888)));
