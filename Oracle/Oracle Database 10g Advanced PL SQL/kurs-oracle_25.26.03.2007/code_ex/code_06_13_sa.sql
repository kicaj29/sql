-- Note: If you have run script code_06_10_sa, you do not need to run this
--       script.

CONNECT /AS sysdba

CREATE CONTEXT order_ctx USING oe.orders_app_pkg;
