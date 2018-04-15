create or replace function get_credit
(v_id in CUSTOMERS.CUSTOMER_ID%TYPE) return number is
v_credit CUSTOMERS.CREDIT_LIMIT%TYPE := 0;
begin
	select credit_limit
   into v_credit
	from CUSTOMERS
	where customer_id = v_id;
	return v_id;
end get_credit;

--ways to execute function
--1
declare
	v_credit customers.CREDIT_LIMIT%type;
begin
	v_credit := get_credit(101);
end;

--2  (tylko sqlplusw???)
execute DBMS_OUTPUT.PUT_LINE(get_credit(101));

--3	UWAGA: kosztu nie bêdzie w planie wykonania !!!
select get_credit(customer_id) from customers

