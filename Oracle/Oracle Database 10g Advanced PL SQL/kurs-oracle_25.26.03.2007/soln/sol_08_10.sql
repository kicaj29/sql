COLUMN event_comment   format a28
COLUMN event_proc_name format a18
COLUMN proc_name       format a17


SELECT proc_name, proc_line,
         event_proc_name, event_comment
FROM sys.plsql_trace_events
WHERE event_unit = 'CREDIT_CARD_PKG';





