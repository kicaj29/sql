DECLARE -- this example assigns another collection    
        -- variable directly
  v_accounting_project typ_ProjectList;
  v_backup_project     typ_ProjectList;
BEGIN
  SELECT  projects
    INTO  v_accounting_project
    FROM  department
    WHERE dept_id = 10; 
  v_backup_project := v_accounting_project;
END;
/
