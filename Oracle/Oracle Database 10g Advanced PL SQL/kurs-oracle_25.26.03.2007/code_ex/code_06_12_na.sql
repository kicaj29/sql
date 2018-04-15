-- You need to run code_06_12 first, to set up the AM users.


GRANT EXECUTE ON oe.orders_app_pkg 
  TO AM145, AM147, AM148, AM149;

CONNECT AM145/oracle

EXECUTE oe.orders_app_pkg.set_app_context

SELECT SYS_CONTEXT('ORDER_CTX', 'ACCOUNT_MGR') FROM dual;
