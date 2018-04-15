create table tab1
( kol1 number,
  kol2 number )
  
alter table tab1 add constraint pk_tab1 primary key  (kol1, kol2)
alter table tab1 drop constraint pk_tab1 cascade
  
  create table tab2
( kol1 number,
  kol2 number )
  
alter table tab2 add constraint fk_tab2 foreign key (kol1, kol2) references tab1 (kol1, kol2)

insert into tab2 (kol1, kol2 ) values ( null, 1)
insert into tab2 (kol1, kol2 ) values ( 2, 1)

select * from tab2