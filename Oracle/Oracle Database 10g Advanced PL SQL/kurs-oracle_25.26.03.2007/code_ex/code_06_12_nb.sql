-- You need to run code_06_12 first, to set up the AM users.

CONNECT AM147/oracle

EXECUTE oe.orders_app_pkg.set_app_context

SELECT SYS_CONTEXT('ORDER_CTX', 'ACCOUNT_MGR') FROM dual;
