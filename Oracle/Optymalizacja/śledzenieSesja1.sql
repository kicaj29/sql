select sid, SERIAL#, logon_time from v$session
where osuser = 'KOWALSKI-9L6Y6K\kicaj'

alter session set sql_trace = false

execute dbms_system.set_sql_trace_in_session(10, 138, true)


select * from tabelatestindex
