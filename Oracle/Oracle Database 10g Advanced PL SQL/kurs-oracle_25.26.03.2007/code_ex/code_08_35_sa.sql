EXECUTE my_profiler('Benchmark: 1', 'This is the first run!')

SELECT runid, run_owner, run_date, run_comment,
       run_comment1, run_total_time
FROM   plsql_profiler_runs;
