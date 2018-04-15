SELECT runid, unit_number, unit_type, unit_owner, unit_name
FROM   plsql_profiler_units inner JOIN plsql_profiler_runs
USING ( runid );
