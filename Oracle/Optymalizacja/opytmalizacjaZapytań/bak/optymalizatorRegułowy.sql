--****************************************************************************************************************
--1. SCALANIE INDEKS�W

--Jedynie indeksy pojedy�czych kolumn podlegaj� scaleniu
drop table EMP1
create table EMP1(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP1 add constraint PK_EMP1 primary key(dept_no)
create index IDX_EMP1_01 on EMP1 (EMP_NO, EMP_NAME)

--Je�eli indeks jednokoulmnowy jest indeksem klucza unikatowego lub g��wnego, sprawia to, �e indeks jednokolumowy
--ma pierwsze�stwo przed indeksem wielokolumnowym
select * from EMP1 WHERE emp_name = 'JACEK' and emp_no = 127 and dept_no = 12

select * from EMP1 WHERE dept_no = 12 and emp_no = 127
select * from EMP1 WHERE emp_name = 'JACEK' and dept_no = 12
--Nie da si� scali� indeksu wielokolumnowego z innym indekse. Mo�na scala� tylko indeksy jednokolumnowe.
--UWAGA: mo�na scala� wielokolumnowe, wskaz�wka -> INDEX_JOIN
--Przyk�ad scalenia indeks�w jednokolumnowych
drop table EMP2
create table EMP2(
dept_no number(4),
emp_name varchar2(16),
emp_no number(4)
)
alter table EMP2 add constraint PK_EMP2 primary key(dept_no)
create index IDX_EMP2_01 on EMP2 (EMP_NO)
create index IDX_EMP2_02 on EMP2 (EMP_NAME)

--Tu nast�pi scalenie wszystkich trzech indeks�w (jednak w planie tego nie wida�!!!)
select * from EMP2 WHERE emp_name = 'JACEK' and emp_no = 127 and dept_no = 12

--****************************************************************************************************************
--2. JE�ELI WSZYSTKIE KOLUMNY NALE��CE DO PEWNEGO INDEKSU ZOSTA�Y WYMIENIONE W WHERE TO TAKI INDEKS
--   MA PIERWSZE�STWO PRZED INNYMI (w przypadku, kt�rych odwo�anie nast�pi�o tylko do cz�ci ich kolumn)
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
--3. JE�ELI WIELE INDEKS�W ODPOWIADA SPECYFIKACJI WYRA�ENIA WHERE I WSZYSTKIE POSIADAJ� TAK� SAM� LICZB� KOLUMN
--   W�WCZAS ZOSTANIE U�YTY INDEKS UTWORZONY JAKO OSTATNI

--UWAGA: je�eli jest PK lub indeks unikalny w where (ale "pe�ny") to i tak we�mie zawsze PK lub indeks unikalny!!!
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
--4. JE�ELI NAST�PUJE DOST�P DO WIELU KOLUMN INDEKSU PRZY U�YCIU OPERATORA =, TO MA ON PIERWSZE�STWO PRZED INNYMI
--   OPERATORAMI, TAKIMI JAK LIKE LUB BETWEEN. WYKORZYSTANIE DW�CH OPERATOR�W = DAJE PIERWSZE�STWO 
--   PRZED WYKORZYSTANIEM DW�CH OPERATOR�W = ORAZ JEDNEGO LIKE
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
--5. WY�SZY ODSETEK KOLUMN, DO JAKICH NAST�PUJE ODWO�ANIE, DAJE PIERWSZE�STWO PRZED NI�SZYM ODSETKIEM.
--   OG�LNIE RZECZ BIOR�C - OPTMALIZATOR WYBIERZE TEN INDEKS, W PRZYPADKU KT�REGO OKRE�LI SI� NAJWY�SZY ODSETEK 
--   POSIADANYCH KOLUMN. UWAGA: "pe�ne" PK lub indeks unikalny i tak ma zawsze pierwsze�stwo!!!
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
--6. JE�ELI DWIE TABELE PODLEGAJ� Z��CZENIU, OPTYMALIZATOR REGU�OWY MUSI WYBRA� TABEL� STERUJ�C� (DRIVING).
--   WYBRANA TABELA MO�E MIE� OGROMNY WP�YW NA WYDAJNO��. DZIEJE SI� TAK SZCZEG�LNIE WTEDY, GDY OPTYMALIZAOTR
--   ZDECYDUJE O U�YCIU P�TLI ZAGNIE�D�ONYCH (NESTED LOOPS). NAJPIERW ZOSTANIE ZWR�CONY WIERSZ POCHODZ�CY Z
--   TABELI STERUJ�CEJ, A PӏNIEJ ODPOWIADAJ�CE WIERSZE ZOSTAN� WYBRANE Z DRUGIEJ TABELI. WA�N� KWEST� JEST 
--   ZAPEWNIENIE TEGO, ABY Z TABELI STERUJ�CEJ ZOSTA�A WYBRANA JAK NAJMNIEJSZA LICZBA WIERSZY.

--   REGU�Y WYBIERANIA TABELI STARUJ�CEJ:

--   1. Posiadanie klucza unikatowego lub g��wnego.
--   2. Indeks, w przypadku kt�rego dost�p do jego wszystkich kolumn odbywa si� przy u�yciu operatora =, ma
--      pierwsze�stwo przed indeksem, z kt�rego wybierana jest tylko cz�� kolumn.  
--   3. Tabela, kt�ra posiada wy�szy odsetek swoich kolumn w indeksie ma pierwsze�stwo przed tabel� o mniejszym
--      odsetku kolumn w indeksie.
--   4. Tabela zwieraj�ca indkes dwukolumnowy, do kt�rego nast�puje odwo�anie w wyra�eniu WHERE zapytania, ma
--      pierwsze�stwo przed tabel� zawieraj�c� dwa indeksy jednokolumnowe.
--   5. Je�li dwie tabele posiadaj� tak� sam� liczb� kolumn w indeksie, wtedy tabela steruj�ca to ta, kt�r� 
--      jako ostatni� wymieniono we frazie FROM. 

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
--7. JE�ELI W WYRA�ENIU WHERE POJAWIA SI� KOLUMNA, KT�RA STANOWI KOLUMN� WIOD�C� PEWNEGO INDEKSU, TO OPTYMALIZATOR
--   REGU�OWY U�YJE W�A�NIE TEGO INDEKSU. WYJ�TKIEM JEST SYTUACJA, GDY W WYRA�ENIU WHERE NA WIOD�C� KOLUMN� INDEKSU
--   NA�O�Y SI� OKRE�LON� FUNKCJ�
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
