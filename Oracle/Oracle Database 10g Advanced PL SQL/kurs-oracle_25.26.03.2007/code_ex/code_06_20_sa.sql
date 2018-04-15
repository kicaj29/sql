CONNECT oe/oe
SELECT   COUNT(*), account_mgr_id
FROM     customers
GROUP BY account_mgr_id;
