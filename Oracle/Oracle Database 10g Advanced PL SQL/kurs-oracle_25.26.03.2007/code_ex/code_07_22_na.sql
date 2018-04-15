DECLARE
  TYPE OrdRec IS RECORD ( 
  v_order_id     NUMBER(6),
  v_order_total  REAL);
  v_middle_total REAL;
FUNCTION nth_highest_total (n INTEGER) RETURN OrdRec IS
  order_info OrdRec;
BEGIN   --...
  RETURN order_info;  -- return record
END;
BEGIN                 -- call function
  v_middle_total := nth_highest_total(10).v_order_total;
--...
END;
/
