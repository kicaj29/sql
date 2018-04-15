--****************************************************************************************************************
--1. SCALANIE INDEKS”W

--Jedynie indeksy pojedyÒczych kolumn podlegajπ scaleniu
drop table EMP1
create table EMP1(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP1 add constraint PK_EMP1 primary key(dept_no)
create index IDX_EMP1_01 on EMP1 (EMP_NO, EMP_NAME)

--Jeøeli indeks jednokoulmnowy jest indeksem klucza unikatowego lub g≥Ûwnego, sprawia to, øe indeks jednokolumowy
--ma pierwszeÒstwo przed indeksem wielokolumnowym
select * from EMP1 WHERE emp_name = 'JACEK' and emp_no = 127 and dept_no = 12

select * from EMP1 WHERE dept_no = 12 and emp_no = 127
select * from EMP1 WHERE emp_name = 'JACEK' and dept_no = 12
--Nie da siÍ scaliÊ indeksu wielokolumnowego z innym indekse. Moøna scalaÊ tylko indeksy jednokolumnowe.
--UWAGA: moøna scalaÊ wielokolumnowe, wskazÛwka -> INDEX_JOIN
--Przyk≥ad scalenia indeksÛw jednokolumnowych
drop table EMP2
create table EMP2(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP2 add constraint PK_EMP2 primary key(dept_no)
create index IDX_EMP2_01 on EMP2 (EMP_NO)
create index IDX_EMP2_02 on EMP2 (EMP_NAME)

--Tu nastπpi scalenie wszystkich trzech indeksÛw (jednak w planie tego nie widaÊ!!!)
select * from EMP2 WHERE emp_name = 'JACEK' and emp_no = 127 and dept_no = 12

--****************************************************************************************************************
--2. JEØELI WSZYSTKIE KOLUMNY NALEØ•CE DO PEWNEGO INDEKSU ZOSTA£Y WYMIENIONE W WHERE TO TAKI INDEKS
--   MA PIERWSZE—STWO PRZED INNYMI (w przypadku, ktÛrych odwo≥anie nastπpi≥o tylko do czÍúci ich kolumn)
drop table EMP3
create table EMP3(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4),
cost_center number(4)
)
alter table EMP3 add constraint PK_EMP3 primary key(dept_no)
create index IDX_EMP3_01 on EMP3 (EMP_NO, EMP_NAME, COST_CENTER)

select * from EMP3 WHERE dept_no = 12 and emp_no = 127

--*****************************************************************************************************************
--3. JEØELI WIELE INDEKS”W ODPOWIADA SPECYFIKACJI WYRAØENIA WHERE I WSZYSTKIE POSIADAJ• TAK• SAM• LICZB  KOLUMN
--   W”WCZAS ZOSTANIE UØYTY INDEKS UTWORZONY JAKO OSTATNI

--UWAGA: jeøeli jest PK lub indeks unikalny w where (ale "pe≥ny") to i tak weümie zawsze PK lub indeks unikalny!!!
drop table EMP4
create table EMP4(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4),
cost_center number(4)
)
alter table EMP4 add constraint PK_EMP4 primary key(dept_no, emp_name)
create index IDX_EMP4_01 on EMP4 (EMP_NO, COST_CENTER)
create index IDX_EMP4_02 on EMP4 (dept_no, emp_name)

select * from EMP4 where emp_no = 2 and cost_center = 3 and dept_no = 1 and emp_name = 'JACEK'
select * from EMP4 where dept_no = 1 and emp_no = 2 and emp_name = 'JACEK'

--*****************************************************************************************************************
--4. JEØELI NAST PUJE DOST P DO WIELU KOLUMN INDEKSU PRZY UØYCIU OPERATORA =, TO MA ON PIERWSZE—STWO PRZED INNYMI
--   OPERATORAMI, TAKIMI JAK LIKE LUB BETWEEN. WYKORZYSTANIE DW”CH OPERATOR”W = DAJE PIERWSZE—STWO 
--   PRZED WYKORZYSTANIEM DW”CH OPERATOR”W = ORAZ JEDNEGO LIKE
drop table EMP5
create table EMP5(
dept_no number (4),
emp_name varchar2 (16),
emp_no number(4),
emp_category varchar2 (16),
emp_class varchar2 (16)
)
create index IDX_EMP5_01 on EMP5 (EMP_CATEGORY, EMP_CLASS, EMP_NAME)
create index IDX_EMP5_02 on EMP5 (EMP_NO, DEPT_NO)

select * from EMP5
where emp_name like 'GURRY%'
and dept_no = 12
and emp_category = 'CLERK'
and emp_class = 'C1'
and emp_no = 127

--*****************************************************************************************************************
--5. WYØSZY ODSETEK KOLUMN, DO JAKICH NAST PUJE ODWO£ANIE, DAJE PIERWSZE—STWO PRZED NIØSZYM ODSETKIEM.
--   OG”LNIE RZECZ BIOR•C - OPTMALIZATOR WYBIERZE TEN INDEKS, W PRZYPADKU KT”REGO OKREåLI SI  NAJWYØSZY ODSETEK 
--   POSIADANYCH KOLUMN. UWAGA: "pe≥ne" PK lub indeks unikalny i tak ma zawsze pierwszeÒstwo!!!
drop table EMP6
create table EMP6(
dept_no number (4),
emp_name varchar2 (16),
emp_no number(4),
emp_category varchar2 (16),
emp_class varchar2 (16)
)
create index IDX_EMP6_01 on EMP6 (EMP_NAME,  EMP_CLASS, EMP_CATEGORY)
create index IDX_EMP6_02 on EMP6 (EMP_NO, DEPT_NO)

select * from EMP6 where emp_name = 'GURRY' and emp_no = 127 and emp_class = 'C1'
--****************************************************************************************************************
--6. JEØELI DWIE TABELE PODLEGAJ• Z£•CZENIU, OPTYMALIZATOR REGU£OWY MUSI WYBRA∆ TABEL  STERUJ•C• (DRIVING).
--   WYBRANA TABELA MOØE MIE∆ OGROMNY WP£YW NA WYDAJNOå∆. DZIEJE SI  TAK SZCZEG”LNIE WTEDY, GDY OPTYMALIZAOTR
--   ZDECYDUJE O UØYCIU P TLI ZAGNIEØDØONYCH (NESTED LOOPS). NAJPIERW ZOSTANIE ZWR”CONY WIERSZ POCHODZ•CY Z
--   TABELI STERUJ•CEJ, A P”èNIEJ ODPOWIADAJ•CE WIERSZE ZOSTAN• WYBRANE Z DRUGIEJ TABELI. WAØN• KWEST• JEST 
--   ZAPEWNIENIE TEGO, ABY Z TABELI STERUJ•CEJ ZOSTA£A WYBRANA JAK NAJMNIEJSZA LICZBA WIERSZY.

--   REGU£Y WYBIERANIA TABELI STARUJ•CEJ:

--   1. Posiadanie klucza unikatowego lub g≥Ûwnego.
--   2. Indeks, w przypadku ktÛrego dostÍp do jego wszystkich kolumn odbywa siÍ przy uøyciu operatora =, ma
--      pierwszeÒstwo przed indeksem, z ktÛrego wybierana jest tylko czÍúÊ kolumn.  
--   3. Tabela, ktÛra posiada wyøszy odsetek swoich kolumn w indeksie ma pierwszeÒstwo przed tabelπ o mniejszym
--      odsetku kolumn w indeksie.
--   4. Tabela zwierajπca indkes dwukolumnowy, do ktÛrego nastÍpuje odwo≥anie w wyraøeniu WHERE zapytania, ma
--      pierwszeÒstwo przed tabelπ zawierajπcπ dwa indeksy jednokolumnowe.
--   5. Jeúli dwie tabele posiadajπ takπ samπ liczbÍ kolumn w indeksie, wtedy tabela sterujπca to ta, ktÛrπ 
--      jako ostatniπ wymieniono we frazie FROM. 

drop table EMP7
create table EMP7(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP7 add constraint PK_EMP7 primary key(dept_no)
create index IDX_EMP7_01 on EMP7 (EMP_NO, EMP_NAME)

drop table EMP8
create table EMP8(
col number(4),
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP8 add constraint PK_EMP8 primary key(col, dept_no)
alter table EMP8 add constraint FK_EMP8_01 FOREIGN key (dept_no) references EMP7(dept_no)
create index IDX_EMP8_01 on EMP8 (EMP_NO, EMP_NAME)

select *
from emp8 e8, emp7 e7
where e8.DEPT_NO = e7.DEPT_NO and e8.COL = 1

--****************************************************************************************************************
--7. JEØELI W WYRAØENIU WHERE POJAWIA SI  KOLUMNA, KT”RA STANOWI KOLUMN  WIOD•C• PEWNEGO INDEKSU, TO OPTYMALIZATOR
--   REGU£OWY UØYJE W£AåNIE TEGO INDEKSU. WYJ•TKIEM JEST SYTUACJA, GDY W WYRAØENIU WHERE NA WIOD•C• KOLUMN  INDEKSU
--   NA£OØY SI  OKREåLON• FUNKCJ 
drop table EMP9
create table EMP9(
emp_name varchar2 (16),
emp_category varchar2 (16),
emp_class varchar2 (16)
)
create index IDX_EMP9_01 on EMP9 (EMP_NAME,  EMP_CLASS, EMP_CATEGORY)
create index IDX_EMP9_02 on EMP9 (EMP_CLASS,  EMP_NAME, EMP_CATEGORY)

select * from emp9 e9 where e9.EMP_NAME = 'ABC'
select * from emp9 e9 where ltrim(e9.EMP_NAME) = 'ABC'
