DECLARE
  v_my_projects  typ_ProjectList;
  v_array_count  INTEGER;
  v_last_element INTEGER;
BEGIN
  SELECT projects INTO v_my_projects FROM department
    WHERE dept_id = 10;
  v_array_count := v_my_projects.COUNT ;
  dbms_output.put_line('The # of elements is: ' ||     
                        v_array_count);  
  v_my_projects.EXTEND ;   --make room for new project
  v_last_element := v_my_projects.LAST ;
  dbms_output.put_line('The last element is: ' || 
                        v_last_element);
  IF v_my_projects.EXISTS(5) THEN
    dbms_output.put_line('Element 5 exists!');
  ELSE
    dbms_output.put_line('Element 5 does not exist.');
  END IF;
END;
/
