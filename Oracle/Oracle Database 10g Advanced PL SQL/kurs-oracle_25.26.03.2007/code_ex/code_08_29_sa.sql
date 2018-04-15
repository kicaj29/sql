COL proc_name       format a10
COL event_comment   format a15
COL event_proc_name format a16

SELECT proc_name, proc_line, 
       event_proc_name, event_comment  
FROM sys.plsql_trace_events
WHERE event_proc_name = 'P5'
OR PROC_NAME = 'P5';
