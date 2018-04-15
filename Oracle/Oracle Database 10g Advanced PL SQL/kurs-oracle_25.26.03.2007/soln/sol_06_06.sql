CONNECT sr153/oracle

SELECT sales_rep_id, COUNT(*)
FROM   oe.orders
GROUP BY sales_rep_id;

CONNECT sr154/oracle

SELECT sales_rep_id, COUNT(*)
FROM   oe.orders
GROUP BY sales_rep_id;

CONNECT oe/oe


                                                                                
