-- Create table
create table TABELA
(
  KOLSTRING   VARCHAR2(16),
  KOLNUMBER   NUMBER,
  KOLDATACZAS DATE
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
--z uwzglêdnieniem godzin
select * from tabela
where koldataczas <= '2006-04-04'

--bez uwzglêdniania godzin
select * from tabela
where to_date( koldataczas, 'YYYY-MM-DD') <= to_date( '2006-04-04', 'YYYY-MM-DD')

where to_date( data_akt, 'YY-MM-DD') = to_date( '2006-09-16', 'YY-MM-DD')


--http://www.stanford.edu/dept/itss/docs/oracle/9i/server.920/a96540/sql_elements4a.htm#48515
