1. 

drop table tab1
drop table tab2

create table tab1
(
	col1 varchar(100),
	col2 varchar(100)
);

create table tab2
(
	col1 varchar(100),
	col2 varchar(100)
);

insert into tab1(col1, col2) values ('val1.1a', 'val1.2a');
insert into tab1(col1, col2) values ('val1.1b', 'val1.2b');

insert into tab2(col1, col2) values ('val2.1', 'val2.2');
insert into tab2(col1, col2) values ('abc', '123');

select * from tab1;

select * from tab2;

--only for Oracle is works???
update tab1 set (col1, col2) = ( select col1, col2 from tab2 where col1 = 'abc' ) where col1 = 'val2.1';

select * from tab1;

select * from tab2;