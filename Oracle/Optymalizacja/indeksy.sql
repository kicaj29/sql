create table tabelaTestIndex
(
kolN1 number,
kolN2 number,
kolS1 varchar2(16)
)
alter table tabelaTestIndex
add constraint PK_tabelaTestIndex primary key (kolN1, kolN2)
insert into tabelaTestIndex ( kolN1, kolN2 ) values ( 1, 1 )

create table tabelaTestWewnetrzna
(
id number,
kolN1 number,
kolN2 number,
opis varchar2(16)
)
create index idx_tabelaTestWewnetrzna_01 on tabelaTestWewnetrzna (kolN1, kolN2)
drop index idx_tabelaTestWewnetrzna_01

alter table tabelaTestWewnetrzna
add constraint PK_tabelaTestWewnetrzna primary key(id)

alter table tabelaTestWewnetrzna
add constraint FK_tabelaTestWewnetrzna_01 foreign key ( kolN1, kolN2 )
referencing tabelaTestIndex( kolN1, kolN2 )

select * 
from tabelaTestIndex z, tabelaTestWewnetrzna w
where w.koln1 = z.koln1 and w.koln2 = z.koln2



--w³¹czenie gromadzenia statystyk wykorzystania indeksu????
alter index monitoring usage PK_tabelaTestIndex

select * from v$locked_object
select * from dba_objects where object_id = 30468

select * from all_indexes
select * from user_indexes
select * from dba_indexes



