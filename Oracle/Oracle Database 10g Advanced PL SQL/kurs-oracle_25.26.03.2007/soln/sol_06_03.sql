CONNECT oe/oe

CREATE OR REPLACE PACKAGE sales_orders_pkg
IS
 PROCEDURE set_app_context;
 FUNCTION the_predicate
  (p_schema VARCHAR2, p_name VARCHAR2)
   RETURN VARCHAR2;
END sales_orders_pkg;    -- package spec
/

CREATE OR REPLACE PACKAGE BODY sales_orders_pkg
IS
  c_context CONSTANT VARCHAR2(30) := 'SALES_ORDERS_CTX';
  c_attrib  CONSTANT VARCHAR2(30) := 'SALES_REP';

PROCEDURE set_app_context 
  IS
    v_user VARCHAR2(30);
BEGIN
  SELECT user INTO v_user FROM dual;
  DBMS_SESSION.SET_CONTEXT
    (c_context, c_attrib, v_user);
END set_app_context;

FUNCTION the_predicate 
(p_schema VARCHAR2, p_name VARCHAR2) 
RETURN VARCHAR2
IS
  v_context_value VARCHAR2(100) := 
     SYS_CONTEXT(c_context, c_attrib);
  v_restriction VARCHAR2(2000);
BEGIN
  IF v_context_value LIKE 'SR%'  THEN
    v_restriction := 
     'SALES_REP_ID = 
      SUBSTR(''' || v_context_value || ''', 3, 3)'; 
  ELSE 
    v_restriction := null;
  END IF;
  RETURN v_restriction;
END the_predicate;  
 
END sales_orders_pkg; -- package body
/
