CONNECT oe/oe

CREATE OR REPLACE PACKAGE orders_app_pkg
IS
 PROCEDURE show_app_context;
 PROCEDURE set_app_context;
 FUNCTION the_predicate
  (p_schema VARCHAR2, p_name VARCHAR2)
   RETURN VARCHAR2;
END orders_app_pkg;    -- package spec
/
