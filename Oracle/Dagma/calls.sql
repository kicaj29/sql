DECLARE
  V_ID NUMBER;
  v_Return VARCHAR2(200);
BEGIN
  V_ID := 2;

  v_Return := POBIERZPRACOWNIKA(
    V_ID => V_ID
  );
  DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
END;
