-- dynamiczny SQL
-- kursor na ³añcuchu znakowym

create table SYSADM.KC_OF_WERSJE_UMOW_WYCOF_ROZB
(
  KOD_UMOWY                 VARCHAR2(24) not null,
  NR_WERSJI                 NUMBER(4) not null,
  DATA_AKT                  DATE default sysdate,
  OPERATION_USER            VARCHAR2(32) default user
)
tablespace KC_LMT_COMMON_DATA_128;
  
create or replace procedure sysadm.P_KC_OF_WYCOFAJ_ROZBICIE_MIES(p_sKodUmowy varchar2, p_nNrWersji number) is
PRAGMA AUTONOMOUS_TRANSACTION;
           
       sKodUmowy                                                 VARCHAR2(24); 
       nNrWersji                                                 NUMBER(4);  
       nNrWersjiPrev                                             NUMBER(4);
       sKodUslugiPrev                                            VARCHAR2(16);
       nPorzadekPrev                                             NUMBER(4);
       sKodSwiadczPrev                                           VARCHAR2(16);
       sKodFiliiPrev                                             VARCHAR2(16);
       sKodOddzialuPrev                                          VARCHAR2(16);        
       sKodKasyModyfPrev                                         VARCHAR2(4);
       nKodPrev                                                  NUMBER(16);
       sKodKasyModyf                                             VARCHAR2(4);
       nKod                                                      NUMBER(16);
       sUpdateOuLiczUslugiFilie                                  VARCHAR2(4096);
       sComma                                                    VARCHAR2(1);  
       nSumOfertLiczbaPrev                                       NUMBER(12,2);
       nSumUmowaLiczbaPrev                                       NUMBER(12,2);
       nSumOfertLiczba                                           NUMBER(12,2);
       nSumUmowaLiczba                                           NUMBER(12,2);
       hsql                                                      SYSADM.PCK_KC_CONST.TYPE_CURSOR_SQL;
       sSelectWersjeUmow                                         VARCHAR2(1024);
       
       --kursory
       cursor c_UslugiFiliePrev is
       select uf.KOD_KASY_MODYF, uf.KOD, uf.KOD_USLUGI, uf.PORZADEK, uf.KOD_SWIADCZ, uf.KOD_FILII, uf.KOD_ODDZIALU
       from sysadm.KC_OU_USLUGI_FILIE uf
       where uf.KOD_UMOWY = sKodUmowy and uf.NR_WERSJI = nNrWersjiPrev;
                   
begin
       sSelectWersjeUmow := ' select wu.KOD_UMOWY, wu.NR_WERSJI from sysadm.KC_OU_WERSJE_UMOW wu ';
       if p_sKodUmowy is null or p_nNrWersji is null then
          sSelectWersjeUmow := sSelectWersjeUmow || ' where to_date( wu.DATA_AKT, ''YYYY-MM-DD'') >= to_date( ''2006-07-25'', ''YYYY-MM-DD'') ';
       else
          sSelectWersjeUmow := sSelectWersjeUmow || ' where wu.KOD_UMOWY = :1 and wu.NR_WERSJI = :2 ';
       end if;       
       sSelectWersjeUmow := sSelectWersjeUmow || ' group by wu.KOD_UMOWY, wu.NR_WERSJI ';
       sSelectWersjeUmow := sSelectWersjeUmow || ' order by wu.KOD_UMOWY, wu.NR_WERSJI ';

       if p_sKodUmowy is null or p_nNrWersji is null then
          open hsql for sSelectWersjeUmow;
       else
          open hsql for sSelectWersjeUmow using in p_sKodUmowy, in p_nNrWersji;
       end if;
       
       loop
         fetch hsql into sKodUmowy, nNrWersji;
         exit when hsql%NOTFOUND;     
         nNrWersjiPrev := nNrWersji - 1; 
         if nNrWersjiPrev > 1 then
            insert into sysadm.KC_OF_WERSJE_UMOW_WYCOF_ROZB(KOD_UMOWY, NR_WERSJI, DATA_AKT, OPERATION_USER )            
            values ( sKodUmowy, nNrWersji, sysdate, user );
            open c_UslugiFiliePrev;
            loop                
                --odczytujê z poprzedniej wersji
                fetch c_UslugiFiliePrev into sKodKasyModyfPrev, nKodPrev, sKodUslugiPrev, nPorzadekPrev, sKodSwiadczPrev,
                                             sKodFiliiPrev, sKodOddzialuPrev;                                                
                exit when c_UslugiFiliePrev%NOTFOUND; 

                --odczytujê z bie¿¹cej wersji
                select uf.KOD_KASY_MODYF, uf.KOD
                into sKodKasyModyf, nKod
                from sysadm.KC_OU_USLUGI_FILIE uf
                where uf.KOD_UMOWY = sKodUmowy and uf.NR_WERSJI = nNrWersji and uf.KOD_USLUGI = sKodUslugiPrev
                      and uf.PORZADEK = nPorzadekPrev and uf.KOD_SWIADCZ = sKodSwiadczPrev and uf.KOD_FILII = sKodFiliiPrev
                      and ( uf.KOD_ODDZIALU = sKodOddzialuPrev or ( uf.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) )
                      and rownum = 1;

                --odczytujê z poprzedniej wersji
                select sum(lufPrev.OFERTA_LICZBA), sum(lufPrev.UMOWA_LICZBA)
                into nSumOfertLiczbaPrev, nSumUmowaLiczbaPrev
                from sysadm.KC_OU_LICZ_USLUGI_FILIE lufPrev
                where lufPrev.KOD_KASY_MODYF = sKodKasyModyfPrev and lufPrev.KOD = nKodPrev
                      and exists ( 
                                   select 1 from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                                   where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod
                                         and luf.MIESIAC = lufPrev.MIESIAC
                                 );
                --odczytujê z bie¿¹cej wersji
                select sum(luf.OFERTA_LICZBA), sum(luf.UMOWA_LICZBA)
                into nSumOfertLiczba, nSumUmowaLiczba
                from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKodPrev;
                                                

                --budujemy update
                if nSumOfertLiczba = nSumOfertLiczbaPrev or nSumUmowaLiczba = nSumUmowaLiczbaPrev then
                
                   sComma := '';
                   sUpdateOuLiczUslugiFilie := ' update sysadm.KC_OU_LICZ_USLUGI_FILIE luf set (';
                   if nSumOfertLiczba = nSumOfertLiczbaPrev then
                       sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' luf.OFERTA_LICZBA ';
                       sComma := ',';
                   end if;
                   if nSumUmowaLiczba = nSumUmowaLiczbaPrev then 
                      sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || sComma || ' luf.UMOWA_LICZBA ';
                   end if;
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' ) = ( select  ';

                   if nSumOfertLiczba = nSumOfertLiczbaPrev then
                      sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' nvl(lufPrev.OFERTA_LICZBA, 0) ';
                   end if;
                   if nSumUmowaLiczba = nSumUmowaLiczbaPrev then 
                      sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || sComma || ' lufPrev.UMOWA_LICZBA ';
                   end if;
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' from sysadm.KC_OU_LICZ_USLUGI_FILIE lufPrev ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' where lufPrev.KOD_KASY_MODYF = :1 ';                 
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and lufPrev.KOD = :2 ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and lufPrev.MIESIAC = luf.MIESIAC ) ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' where luf.KOD_KASY_MODYF = :3 ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and luf.KOD = :4 ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and exists ( select 1 from sysadm.KC_OU_LICZ_USLUGI_FILIE lufPrev1 ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' where lufPrev1.KOD_KASY_MODYF = :5 ';                 
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and lufPrev1.KOD = :6 ';
                   sUpdateOuLiczUslugiFilie := sUpdateOuLiczUslugiFilie || ' and lufPrev1.MIESIAC = luf.MIESIAC ) ';
                                                                                                                  
                   execute immediate sUpdateOuLiczUslugiFilie 
                           using sKodKasyModyfPrev, nKodPrev, sKodKasyModyf, nKod, sKodKasyModyfPrev, nKodPrev;
               end if;                                
            end loop;
            close c_UslugiFiliePrev;       
            
            --po zmodyfikowaniu liczby na poziomie miesiêcy, filii mo¿na zmodyfkowaæ liczby na poziomie miesiêcy
            update sysadm.KC_OU_LICZ_USLUGI lu 
            set ( lu.OFERTA_LICZBA, lu.UMOWA_LICZBA ) = 
            (
                select sum(luf.OFERTA_LICZBA), sum(luf.UMOWA_LICZBA)
                from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                where luf.KOD_UMOWY= lu.KOD_UMOWY and luf.NR_WERSJI = lu.NR_WERSJI 
                      and luf.KOD_USLUGI = lu.KOD_USLUGI and luf.PORZADEK = lu.PORZADEK and luf.MIESIAC = lu.MIESIAC
            )
            where lu.KOD_UMOWY = sKodUmowy and lu.NR_WERSJI = nNrWersji;        
            
            --teraz update po planie
            update sysadm.KC_OU_PLAN_USLUGI_FILIE puf
            set ( puf.LICZBA ) = nvl(
                    (
                      select luf.UMOWA_LICZBA
                      from sysadm.KC_OU_LICZ_USLUGI_FILIE luf, sysadm.KC_OU_USLUGI_FILIE uf
                      where uf.KOD_UMOWY = sKodUmowy and uf.NR_WERSJI = nNrWersji and
                            uf.KOD_USLUGI = puf.KOD_USLUGI and uf.PORZADEK = puf.PORZADEK 
                            and uf.KOD_SWIADCZ = puf.KOD_SWIADCZ and uf.KOD_FILII = puf.KOD_FILII
                            and ( uf.KOD_ODDZIALU = puf.KOD_ODDZIALU or ( uf.KOD_ODDZIALU is null and puf.KOD_ODDZIALU is null) )
                            and uf.KOD_KASY_MODYF = luf.KOD_KASY_MODYF and uf.KOD = luf.KOD
                            and luf.MIESIAC = puf.MIESIAC
                      ), puf.LICZBA )
            where puf.KOD_UMOWY = sKodUmowy;
            
            update sysadm.KC_OU_PLAN_USLUG pu
            set pu.LICZBA = nvl(
                            ( 
                              select nvl(sum(puf.LICZBA), 0 )
                              from sysadm.KC_OU_PLAN_USLUGI_FILIE puf
                              where puf.KOD_UMOWY = sKodUmowy and puf.KOD_USLUGI = pu.KOD_USLUGI and puf.PORZADEK = pu.PORZADEK
                                    and puf.MIESIAC = pu.MIESIAC
                            ), pu.LICZBA )
            where pu.KOD_UMOWY = sKodUmowy;
         end if;
       end loop;
       close hsql;
commit;
end;


















