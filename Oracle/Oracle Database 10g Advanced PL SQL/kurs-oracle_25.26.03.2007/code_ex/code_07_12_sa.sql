DECLARE
  TYPE      typ_replist IS VARRAY(100) OF NUMBER;
  TYPE      typ_numlist IS TABLE OF 
              orders.order_total%TYPE;
  repids    typ_replist := 
              typ_replist(153, 155, 156, 161);
  totlist   typ_numlist;
  c_big_total CONSTANT NUMBER := 60000;
BEGIN
  FORALL i IN repids.FIRST..repids.LAST
    UPDATE  orders
    SET     order_total = .95 * order_total
    WHERE   sales_rep_id = repids(i)
    AND     order_total > c_big_total
    RETURNING order_total BULK COLLECT INTO Totlist;
 END;
/
