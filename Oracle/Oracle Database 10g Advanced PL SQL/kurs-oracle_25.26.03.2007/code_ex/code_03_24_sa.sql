CREATE OR REPLACE PROCEDURE add_project (
  p_deptno      IN NUMBER,
  p_new_project IN typ_Project,
  p_position    IN NUMBER )  
IS
   v_my_projects typ_ProjectList;
BEGIN
  SELECT projects INTO v_my_projects FROM department
    WHERE dept_id = p_deptno FOR UPDATE OF projects;
  v_my_projects.EXTEND;   --make room for new project
  -- Move varray elements forward 
  FOR i IN REVERSE p_position..v_my_projects.LAST - 1 LOOP
    v_my_projects(i + 1) := v_my_projects(i);
  END LOOP;
  v_my_projects(p_position) := p_new_project; -- add new
                                              -- project
  UPDATE department SET projects = v_my_projects
    WHERE dept_id = p_deptno;
END add_project;
/
