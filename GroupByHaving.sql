drop table invoice;

create table invoice
(
	value_gross int,
	value_net int,
	client_name varchar(100)
);

insert into invoice(value_gross, value_net, client_name) values (2, 4, 'Jacek');
insert into invoice(value_gross, value_net, client_name) values (1, 1, 'Jacek');
insert into invoice(value_gross, value_net, client_name) values (1, 1, 'Jan');
insert into invoice(value_gross, value_net, client_name) values (5, 7, 'Jan');

select * from invoice;

select SUM(value_gross) gross , SUM(value_net) net, client_name 
from invoice
group by client_name
having SUM(value_gross) > 3;