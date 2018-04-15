DECLARE
	cursor cur_cust is
		select cust_first_name, credit_limit
		from customers
		where credit_limit > 4000;
begin
	for v_cut_record in cur_cust
		loop
			DBMS_OUTPUT.PUT_LINE(v_cut_record.cust_first_name || ' ' || v_cut_record.credit_limit);
		end loop;
end;

---------------

DECLARE		
begin
	for v_cut_record in (select cust_first_name, credit_limit from customers where credit_limit > 4000)
		loop
			DBMS_OUTPUT.PUT_LINE(v_cut_record.cust_first_name || ' ' || v_cut_record.credit_limit);
		end loop;
end;