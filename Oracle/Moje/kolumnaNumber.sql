create table tmp_number
( kol number)

insert into tmp_number(kol) values(123.2)
insert into tmp_number(kol) values(123.245454646456)
select * from tmp_number


------------------------------------------------------------------------------------------------------------------
create table tabela_tmp
(kol number(5,4))

select * from tabela_tmp


insert into tabela_tmp (kol) values (1.1565757)


insert into tabela_tmp (kol) values (round(21.12,4))
select round(21.12,4) from dual

insert into tabela_tmp (kol) values (9)

drop table tabela_tmp
