DECLARE      -- this example uses a fetch from the database
  v_accounting_project typ_ProjectList;
BEGIN
  SELECT  projects
    INTO  v_accounting_project
    FROM  department
    WHERE dept_id = 10; 
--...
END;
/
