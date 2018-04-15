BEGIN
  -- Insert an order
  INSERT INTO pOrder
    (ordid, supplier, requester, ordered, items)
    VALUES (1000, 12345, 9876, SYSDATE, NULL);
  -- insert the items for the order created
  INSERT INTO TABLE (SELECT items
                   FROM   pOrder
                   WHERE  ordid = 1000)
    VALUES(typ_item(99, 129.00));
END;
/
