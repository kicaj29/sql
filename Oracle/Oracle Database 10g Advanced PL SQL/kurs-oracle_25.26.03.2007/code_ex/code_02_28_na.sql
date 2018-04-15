DECLARE
  v_rows    mytypes.Counter; --use package subtype dfn
  v_customers  mytypes.Counter;
  v_start_time mytypes.Time;
  SUBTYPE    Accumulator IS NUMBER;
  v_total      Accumulator(4,2);  
SUBTYPE    Scale IS NUMBER(1,0);   -- constrained subtype
  v_x_axis     Scale;  -- magnitude range is -9 .. 9
BEGIN
  v_rows := 1;
  v_start_time.minutes := 15;
  v_start_time.hours   := 03;
 dbms_output.put_line('Start time is: '||  
 v_start_time.hours|| ':' || v_start_time.minutes);
END;
/
