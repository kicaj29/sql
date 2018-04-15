-- Create table
create table pracownicy
(
  id       number,
  nazwisko varchar2(50)
)
tablespace EXAMPLE
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table pracownicy
  add constraint pk primary key (ID);
