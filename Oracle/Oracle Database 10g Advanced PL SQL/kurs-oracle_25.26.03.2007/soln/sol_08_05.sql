SELECT runid, run_owner, run_date, run_comment,
       run_comment1, run_total_time
FROM   plsql_profiler_runs;

SELECT runid, unit_number, unit_type,
       unit_owner, unit_name
FROM   plsql_profiler_units inner
JOIN   plsql_profiler_runs
USING  ( runid );

SELECT line#, total_occur, total_time, 
       min_time, max_time
FROM   plsql_profiler_data
WHERE  runid = 1 AND unit_number = 2;
