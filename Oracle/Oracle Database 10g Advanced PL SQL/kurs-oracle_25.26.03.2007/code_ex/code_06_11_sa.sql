CONNECT oe/oe

CREATE OR REPLACE PACKAGE orders_app_pkg
IS
 PROCEDURE set_app_context;
END;
/
CREATE OR REPLACE PACKAGE BODY orders_app_pkg
IS
 c_context CONSTANT VARCHAR2(30) := 'ORDER_CTX';
 PROCEDURE set_app_context 
 IS
    v_user VARCHAR2(30);
 BEGIN
  SELECT user INTO v_user FROM dual;
  DBMS_SESSION.SET_CONTEXT
   (c_context, 'ACCOUNT_MGR', v_user);
 END;
END;
/
