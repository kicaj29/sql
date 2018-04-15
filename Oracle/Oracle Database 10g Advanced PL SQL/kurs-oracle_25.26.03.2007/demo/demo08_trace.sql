--Purpose: Demonstrate using DBMS_TRACE
--Created: Nancy Greenberg  24-Jan-2000
--Modified:NHG 13-JAN-2002 to use Sample Schema
--Steps:   Run the script below. 
--         This script follows the steps shown in the book to use DBMS_TRACE
--         and examine a trace file.

SET ECHO OFF
CLEAR SCREEN
PAUSE Press enter to alter your session and turn PL/SQL debug on:

ALTER SESSION SET PLSQL_DEBUG = TRUE
/

PAUSE Press enter to create a procedure called RAISE_LIST_PRICE:

CREATE OR REPLACE PROCEDURE raise_list_price
(p_supplier NUMBER, p_increase NUMBER)
IS
  v_count    NUMBER;
  v_discount NUMBER;
  e_no_prods EXCEPTION;
BEGIN
  SELECT count(product_id)
  INTO   v_count
  FROM   product_information
  WHERE  supplier_id = p_supplier;
  IF v_count > 20 THEN
    v_discount := p_increase - .10;
  ELSIF v_count > 15 THEN
    v_discount := p_increase - .05;
  ELSIF v_count > 10 THEN
    v_discount := p_increase - .25;
  ELSE
    v_discount := p_increase;
  END IF;
  UPDATE product_information 
    SET list_price = list_price * v_discount
    WHERE supplier_id = p_supplier;
  IF SQL%ROWCOUNT = 0 THEN
    RAISE e_no_prods;
  END IF;
EXCEPTION
  WHEN e_no_prods THEN
    NULL;
END raise_list_price;
/

PAUSE Press enter to display the source code for RAISE_LIST_PRICE:
LIST
PAUSE Press enter to turn DBMS_TRACE.SET_PLSQL_TRACE on:
SET ECHO ON
EXECUTE DBMS_TRACE.SET_PLSQL_TRACE(DBMS_TRACE.TRACE_ALL_CALLS + DBMS_TRACE.TRACE_ALL_EXCEPTIONS)
SET ECHO OFF
PAUSE Press enter to execute the RAISE_LIST_PRICE procedure and generate the trace info
EXECUTE raise_list_price(101, .95)
PAUSE Press enter to end the tracing:

SET ECHO ON
EXECUTE DBMS_TRACE.CLEAR_PLSQL_TRACE
SET ECHO OFF
Pause For version 8.1.6 AND HIGHER, query SYS.plsql_trace_runs and SYS.plsql_trace_events tables

Pause For version 8.1.5 examine the trace file in the UDUMP directory 
