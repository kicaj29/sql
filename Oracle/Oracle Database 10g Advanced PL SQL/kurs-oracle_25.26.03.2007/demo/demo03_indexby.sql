--Purpose: demonstrate the use of cursors and INDEX BY Table
--         attributes available in Oracle 7.3 and higher.
--Created: Dan Gabel  03-MAR-98
--Modified: Nancy Greenberg 13-JAN-02 to use sample schema
--Steps:   Run this script file, make sure serveroutput is set on first

DECLARE
   v_customer_id customers.customer_id%TYPE;
   v_last_name customers.cust_last_name%TYPE;

   TYPE vc2_tab_ty IS table of v_last_name%TYPE
                      index by binary_integer;

   v_last_name_tab vc2_tab_ty;
   v_tab_total_rows binary_integer :=0;
   v_first v_last_name%TYPE;
   v_last v_first%TYPE;
   v_cur_row_count binary_integer;
   v_prior  binary_integer;

   CURSOR customer_name_cur 
          is SELECT customer_id, cust_last_name 
             FROM customers;
BEGIN
   OPEN customer_name_cur;
      FOR idx IN 1..320 LOOP
        FETCH customer_name_cur INTO v_customer_id, v_last_name;
        v_last_name_tab(v_customer_id) := v_last_name;
        v_tab_total_rows := v_last_name_tab.count;
        v_first := v_last_name_tab(v_last_name_tab.first);
        v_last := v_last_name_tab(v_last_name_tab.last);
        v_prior := v_last_name_tab.PRIOR(v_last_name_tab.last);
      END LOOP;
      v_cur_row_count := customer_name_cur%rowcount;
   CLOSE customer_name_cur;
   DBMS_OUTPUT.PUT_LINE ('Number of Rows in Cursor is: '
			 ||to_char(v_cur_row_count));
   DBMS_OUTPUT.PUT_LINE ('First value in Table Variable is: '
			 ||v_first);
   DBMS_OUTPUT.PUT_LINE ('Last value in Table Variable is: '
			 ||v_last);
   DBMS_OUTPUT.PUT_LINE ('Total values in Table Variable is: '
			 ||to_char(v_tab_total_rows));
   DBMS_OUTPUT.PUT_LINE ('Prior to last index value is: '
			 ||to_char(v_prior));
END;
/
