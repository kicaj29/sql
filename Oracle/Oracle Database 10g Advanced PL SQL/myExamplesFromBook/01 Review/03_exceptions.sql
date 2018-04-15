declare
	v_lname VARCHAR2(15);
begin
	select cust_last_name into v_lname from customers where cust_first_name = 'Ally';
EXCEPTION
	when too_many_rows then
		begin
			DBMS_OUTPUT.PUT_LINE('Your select statement retrieved multiple rows. Consider using a cursor. ');
		end;
end;
	