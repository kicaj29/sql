SELECT *
  FROM TABLE(SELECT d.projects
               FROM department d
               WHERE d.dept_id = 10);

SELECT d.dept_id, CURSOR(SELECT * FROM TABLE(d.projects)) 
FROM   department d;
