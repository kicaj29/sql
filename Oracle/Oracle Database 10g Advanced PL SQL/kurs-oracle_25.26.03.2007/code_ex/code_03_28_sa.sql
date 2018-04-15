SELECT d1.dept_id, d1.budget, d2.*
FROM   department d1, TABLE(d1.projects) d2;
