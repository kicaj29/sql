UPDATE TABLE
  (SELECT p.items FROM  pOrder p
   WHERE  p.ordid = 800) i
SET     VALUE(i) = typ_item(99, 999)
WHERE   i.prodid = 88;
