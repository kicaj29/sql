create table kicaj.tabelaTrig01
(
kol1 number(16),
kol2 number(16),
kol3 number(16)
)

insert into kicaj.tabelaTrig01 values (1,2,3)

--tu mo¿na modyfikowaæ wartoœci :new.X ( te wartoœci zostan¹ wstawione do tabeli )
create or replace trigger trg_tabelaTrig01_BU before update on kicaj.tabelaTrig01 for each row
begin
     dbms_output.put_line( 'befor update kol2 new ' || to_char(:new.kol2) );
     dbms_output.put_line( 'befor update kol2 old ' || to_char(:old.kol2) );
     :new.kol2 := :new.kol2 + 1;
--to siê nie wykona ( bêdzie b³¹d wykonania ):
--     if :new.kol2 = 333 then
--        rollback;
--     end if;
end;


--tu NIE mo¿na modyfikowaæ wartoœci :new.X ( te wartoœci zosta³y ju¿ wstawione do tabeli )
create or replace trigger trg_tabelaTrig01_AU after update on kicaj.tabelaTrig01 for each row
begin
     dbms_output.put_line( 'after update kol2 new ' || to_char(:new.kol2) );
     dbms_output.put_line( 'after update kol2 old ' || to_char(:old.kol2) );
--to siê nie wykona ( bêdzie b³¹d wykonania ):
--     if :new.kol2 = 333 then
--        rollback;
--     end if;
end;


update kicaj.tabelatrig01
set kol2 = 332
where kol1 = 1

select * from kicaj.tabelatrig01

