CREATE OR REPLACE PROCEDURE show_context_info
IS
  v_context_info DBMS_SESSION.AppCtxTabTyp;
  v_info_count PLS_INTEGER;
  v_index PLS_INTEGER;
BEGIN
  DBMS_SESSION.LIST_CONTEXT(
    v_context_info, v_info_count);
  v_index := v_context_info.first;
  LOOP
    EXIT WHEN v_index IS NULL;
    DBMS_OUTPUT.PUT_LINE(v_context_info(v_index).namespace || '. ' ||
                         v_context_info(v_index).attribute || '. ' ||
                         v_context_info(v_index).value);
    v_index := v_context_info.NEXT(v_index);
  END LOOP;
END;
/

EXECUTE show_context_info
