DELETE FROM TABLE
 (SELECT p.items FROM pOrder p WHERE p.ordid = 500) i 
WHERE i.prodid = 55;
