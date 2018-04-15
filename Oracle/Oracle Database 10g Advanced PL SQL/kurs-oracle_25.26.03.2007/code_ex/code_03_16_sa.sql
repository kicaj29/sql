CREATE TYPE typ_Project AS OBJECT(  --create object
   project_no NUMBER(2), 
   title      VARCHAR2(35),
   cost       NUMBER(7,2))
/
CREATE TYPE typ_ProjectList AS VARRAY (50) OF typ_Project
	  -- define VARRAY type
/
