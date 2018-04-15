CREATE OR REPLACE PROCEDURE my_profiler 
(p_comment1 IN VARCHAR2, p_comment2 IN VARCHAR2) 
IS
  v_return_code    NUMBER;
BEGIN
--start the profiler
  v_return_code:=DBMS_PROFILER.START_PROFILER
    (p_comment1, p_comment2);
  dbms_output.put_line 
    ('Result from START: '||v_return_code);

-- now run a program...
  credit_card_pkg.update_card_info (130, 'AM EX', 121212121212);
--flush the collected data to the dictionary tables
  v_return_code := DBMS_PROFILER.FLUSH_DATA; 
  dbms_output.put_line 
    ('Result from FLUSH: '||v_return_code);
--stop profiling
  v_return_code := DBMS_PROFILER.STOP_PROFILER;
  dbms_output.put_line 
    ('Result from STOP: '||v_return_code);
END;
/
