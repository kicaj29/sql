--patch dla opola
create table SYSADM.KC_OF_WYCOF_ROZB_STAT
(
  KOD_UMOWY                 VARCHAR2(24) not null,
  NR_WERSJI                 NUMBER(4) not null,
  KOD_USLUGI                VARCHAR2(16) not null,
  PORZADEK                  NUMBER(4) not null,
  KOD_SWIADCZ               VARCHAR2(16) not null,
  KOD_FILII                 VARCHAR2(16) not null,
  KOD_ODDZIALU              VARCHAR2(16),
  POPRAWIONO_LUF_A          CHAR(1),
  POPRAWIONO_LUF_P          CHAR(1),
  POPRAWIONO_LU_A           CHAR(1),
  POPRAWIONO_LU_P           CHAR(1),  
  DATA_AKT                  DATE default sysdate,
  OPERATION_USER            VARCHAR2(32) default user
)
tablespace KC_LMT_COMMON_DATA_128;

create index sysadm.IDX_KC_OF_WYCOF_ROZB_STAT on SYSADM.KC_OF_WYCOF_ROZB_STAT 
(KOD_UMOWY,NR_WERSJI,KOD_USLUGI,PORZADEK,KOD_SWIADCZ,KOD_FILII)
tablespace KC_LMT_IDX_4096;  

create or replace procedure sysadm.P_KC_OF_WYCOFAJ_ROZBICIE_MIES(p_sKodUmowy varchar2) is
PRAGMA AUTONOMOUS_TRANSACTION;
           
       sKodUmowy                                                 VARCHAR2(24); 
       nNrWersji                                                 NUMBER(4);  
       nNrWersjiPrev                                             NUMBER(4);
       nNrWersjiNext                                             NUMBER(4);       
       nNrWersjiMax                                              NUMBER(4);
       nNrWersjiPrevTmp                                          NUMBER(4);
       sKodUslugi                                                VARCHAR2(16);
       nPorzadek                                                 NUMBER(4);
       sKodSwiadcz                                               VARCHAR2(16);
       sKodFilii                                                 VARCHAR2(16);
       sKodOddzialu                                              VARCHAR2(16);        
       sKodKasyModyfPrev                                         VARCHAR2(4);
       nKodPrev                                                  NUMBER(16);
       sKodKasyModyf                                             VARCHAR2(4);
       nKod                                                      NUMBER(16);
       sUpdateOuLiczUslugiFilie                                  VARCHAR2(4096);
       sComma                                                    VARCHAR2(1);  
       nSumOfertLiczbaPrev                                       NUMBER(12,2);
       nSumUmowaLiczbaPrev                                       NUMBER(12,2);
       nSumPlanLiczba                                            NUMBER(12,2);
       nSumOfertLiczba                                           NUMBER(12,2);
       nSumUmowaLiczba                                           NUMBER(12,2);
       hsql                                                      SYSADM.PCK_KC_CONST.TYPE_CURSOR_SQL;
       sSelectWersjeUmow                                         VARCHAR2(1024);
       nUmowaMiesiacOd                                           NUMBER(2);
       nUmowaMiesiacDo                                           NUMBER(2);
       nUmowaMiesiacOdPrev                                       NUMBER(2);
       nUmowaMiesiacDoPrev                                       NUMBER(2);
       sZmodyfLiczUslugiFilie                                    CHAR(1);
       nMiesiac                                                  NUMBER(2);
       nUmowaLiczba                                              NUMBER(12,2);
       nUmowaLiczbaNext                                          NUMBER(12,2);
       nNrWersjiFirstBad                                         NUMBER(4);
                                
  
  cursor c_Uslugi is
  select u.KOD_USLUG, u.PORZADEK
  from sysadm.KC_OU_USLUGI u
  where u.KOD_UMOWY = p_sKodUmowy and u.NR_WERSJI = nNrWersji;
  
  cursor c_LiczUslugiFilie is
  select uf.KOD_USLUGI, uf.PORZADEK, uf.KOD_SWIADCZ, uf.KOD_FILII, uf.KOD_ODDZIALU, luf.MIESIAC, luf.UMOWA_LICZBA
  from sysadm.KC_OU_LICZ_USLUGI_FILIE luf, sysadm.KC_OU_USLUGI_FILIE uf
  where uf.KOD_UMOWY = p_sKodUmowy and uf.NR_WERSJI = nNrWersji
        and luf.KOD_KASY_MODYF = uf.KOD_KASY_MODYF and luf.KOD = uf.KOD;
  
begin
  --wpierw wyznaczam pierwszy zepsuty aneks
  select max(wu.NR_WERSJI)
  into nNrWersjiMax
  from sysadm.KC_OU_WERSJE_UMOW wu
  where wu.kod_umowy = p_sKodUmowy;
  
  nNrWersjiFirstBad := 0;
  nNrWersji := 2
  while (nNrWersji <= nNrWersjiMax) and (nNrWersjiFirstBad = 0)
    open c_LiczUslugiFilie;  
    loop
      fetch c_LiczUslugiFilie into sKodUslugi, nPorzadek, sKodSwiadcz, sKodFilii, sKodOddzialu, nMiesiac, nUmowaLiczba;
      exit when c_LiczUslugiFilie%NOTFOUND;
      --pobieram z nastêpnej wersji
      nUmowaLiczbaNext := null;
      select luf.UMOWA_LICZBA
      into nUmowaLiczbaNext
      from sysadm.KC_OU_LICZ_USLUGI_FILIE luf, sysadm.KC_OU_USLUGI_FILIE uf
      where uf.KOD_UMOWY = p_sKodUmowy and uf.NR_WERSJI = nNrWersji + 1
        and uf.KOD_USLUGI = sKodUslugi and uf.PORZADEK = nPorzadek and uf.KOD_SWIADCZ = sKodSwiadcz 
        and uf.KOD_FILII = sKodFilii 
        and ( uf.KOD_ODDZIALU = sKodOddzialu or ( uf.KOD_ODDZIALU is null and sKodOddzialu is null ) )
        and luf.KOD_KASY_MODYF = uf.KOD_KASY_MODYF and luf.KOD = uf.KOD and luf.MIESIAC = nMiesiac; 
      if nUmowaLiczba != nUmowaLiczbaNext and nUmowaLiczbaNext is not null then
        nNrWersjiFirstBad := nNrWersji + 1;
        exit;
      end if;      
    end loop;  
    close c_LiczUslugiFilie;
    nNrWersji := nNrWersji + 1;          
  end while; 
  --je¿eli znaleziono pierwsz¹ z³¹ wersjê ( czyli tak¹ w której jest rozbicie statystyczne )
  if nNrWersjiFirstBad != 0 then
    nNrWersji := nNrWersjiFirstBad;
    open c_Uslugi
    loop
      fetch c_Uslugi into sKodUslugi, nPorzadek;
      exit when 
    end loop;
    close c_Uslugi;
    
    open c_LiczUslugiFilie;
    loop
      fetch c_LiczUslugiFilie into sKodUslugi, nPorzadek, sKodSwiadcz, sKodFilii, sKodOddzialu, nMiesiac, nUmowaLiczba;
      exit when c_LiczUslugiFilie%NOTFOUND;
      

      --pobieram porawn¹ liczbê
      select luf.UMOWA_LICZBA
      from 
    end loop;
    close c_LiczUslugiFilie;
  end if;
  commit;
end;


                                                                                                                                                 
       sSelectWersjeUmow := ' select wu.KOD_UMOWY, wu.NR_WERSJI, wu.UMOWA_MIESIAC_OD, wu.UMOWA_MIESIAC_DO from sysadm.KC_OU_WERSJE_UMOW wu ';
       if p_sKodUmowy is null or p_nNrWersji is null then
          sSelectWersjeUmow := sSelectWersjeUmow || ' where to_date( wu.DATA_AKT, ''YYYY-MM-DD'') >= to_date( ''2006-07-25'', ''YYYY-MM-DD'') ';
       else
          sSelectWersjeUmow := sSelectWersjeUmow || ' where wu.KOD_UMOWY = :1 and wu.NR_WERSJI = :2 ';
       end if;       
       sSelectWersjeUmow := sSelectWersjeUmow || ' order by wu.KOD_UMOWY, wu.NR_WERSJI';

       if p_sKodUmowy is null or p_nNrWersji is null then
          open hsql for sSelectWersjeUmow;
       else
          open hsql for sSelectWersjeUmow using in p_sKodUmowy, in p_nNrWersji;
       end if;
       --ten loop ma wykona siê tylko raz!!!!!! - ZMIENIÆ TO
       loop
         fetch hsql into sKodUmowy, nNrWersji, nUmowaMiesiacOd, nUmowaMiesiacDo;
         exit when hsql%NOTFOUND;     
         
         
         nNrWersjiPrev := nNrWersji - 1; 
         if nNrWersjiPrev > 1 then
            
            --miesi¹ce umowy poprzedniego aneksu
            select wu.UMOWA_MIESIAC_OD, wu.UMOWA_MIESIAC_DO
            into nUmowaMiesiacOdPrev, nUmowaMiesiacDoPrev
            from sysadm.KC_OU_WERSJE_UMOW wu
            where wu.KOD_UMOWY = sKodUmowy and wu.NR_WERSJI = nNrWersjiPrev;
            
            -- odczytujê us³ugi z poprzedniej wersji
            open c_UslugiPrev;
            loop
                fetch c_UslugiPrev into sKodUslugiPrev, nPorzadekPrev;
                exit when c_UslugiPrev%NOTFOUND;
                sZmodyfLiczUslugiFilie := 'N';
                
                --odczytujê miejsca dla us³ug poprzedniej wersji
                
                open c_UslugiFiliePrev;
                loop
                    fetch c_UslugiFiliePrev into sKodKasyModyfPrev, nKodPrev, sKodSwiadczPrev,
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

                    --odczytujê z poprzednich wersji
                    nNrWersjiPrevTmp := nNrWersjiPrev
                    
                    while nNrWersjiPrevTmp > 0
                    
                    end while;
                    
                    select sum(lufPrev.UMOWA_LICZBA)
                    into nSumUmowaLiczbaPrev
                    from sysadm.KC_OU_LICZ_USLUGI_FILIE lufPrev
                    where lufPrev.KOD_KASY_MODYF = sKodKasyModyfPrev and lufPrev.KOD = nKodPrev
                          and exists ( 
                                     select 1 from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                                     where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod
                                           and luf.MIESIAC = lufPrev.MIESIAC
                                      );

                   --odczytujê z bie¿¹cej wersji
                   select sum(luf.UMOWA_LICZBA)
                   into nSumUmowaLiczba
                   from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                   where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKodPrev;
                                                                                                                                       
                   if nSumUmowaLiczba = nSumUmowaLiczbaPrev + nvl(nSumPlanLiczba, 0) then
                   --aneks - na podstawie poprzedniej wersji                            
                      update sysadm.KC_OU_LICZ_USLUGI_FILIE luf set ( luf.UMOWA_LICZBA ) = nvl( 
                            ( select lufPrev.UMOWA_LICZBA 
                              from sysadm.KC_OU_LICZ_USLUGI_FILIE lufPrev
                              where lufPrev.KOD_KASY_MODYF = sKodKasyModyfPrev and lufPrev.KOD = nKodPrev and lufPrev.MIESIAC = luf.MIESIAC 
                             ), luf.UMOWA_LICZBA )
                      where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod;   
                                                            
                   --aneks - na podstawie planu
                      update sysadm.KC_OU_LICZ_USLUGI_FILIE luf set ( luf.UMOWA_LICZBA ) = nvl(
                             ( select puf.LICZBA
                               from sysadm.KC_OU_PLAN_USLUGI_FILIE puf
                               where puf.KOD_UMOWY = sKodUmowy and puf.KOD_USLUGI = sKodUslugiPrev and puf.PORZADEK = nPorzadekPrev
                                     and puf.KOD_SWIADCZ = sKodSwiadczPrev and puf.KOD_FILII = sKodFiliiPrev 
                                     and ( puf.KOD_ODDZIALU = sKodOddzialuPrev or ( puf.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) )
                                     and puf.MIESIAC NOT between nUmowaMiesiacOdPrev and nUmowaMiesiacDoPrev
                                     and puf.MIESIAC between nUmowaMiesiacOd and nUmowaMiesiacDo and puf.MIESIAC = luf.MIESIAC
                              ), luf.UMOWA_LICZBA )
                      where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod;   
                      
                      insert into sysadm.KC_OF_WYCOF_ROZB_STAT wrs 
                      ( KOD_UMOWY, NR_WERSJI, KOD_USLUGI, PORZADEK, KOD_SWIADCZ, KOD_FILII, KOD_ODDZIALU, POPRAWIONO_LUF_A)
                      values
                      ( sKodUmowy, nNrWersji, sKodUslugiPrev, nPorzadekPrev, sKodSwiadczPrev, sKodFiliiPrev, sKodOddzialuPrev, 'T' );
                                                            
                   --plan
                     update sysadm.KC_OU_PLAN_USLUGI_FILIE puf
                     set ( puf.LICZBA ) = nvl(
                     (
                        select luf.UMOWA_LICZBA
                        from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                        where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod and luf.MIESIAC = puf.MIESIAC
                     ), puf.LICZBA )
                     where puf.KOD_UMOWY = sKodUmowy and puf.KOD_USLUGI = sKodUslugiPrev and puf.PORZADEK = nPorzadekPrev 
                           and puf.KOD_SWIADCZ = sKodSwiadczPrev and puf.KOD_FILII = sKodFiliiPrev 
                           and ( puf.KOD_ODDZIALU = sKodOddzialuPrev or ( puf.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) )
                           and puf.MIESIAC between nUmowaMiesiacOd and nUmowaMiesiacDo;

                     update sysadm.KC_OF_WYCOF_ROZB_STAT wrs
                     set wrs.POPRAWIONO_LUF_P = 'T'
                     where wrs.KOD_UMOWY = sKodUmowy and wrs.NR_WERSJI = nNrWersji and wrs.KOD_USLUGI = sKodUslugiPrev
                     and wrs.PORZADEK = nPorzadekPrev and wrs.KOD_SWIADCZ = sKodSwiadczPrev and wrs.KOD_FILII = sKodFiliiPrev
                     and ( wrs.KOD_ODDZIALU = sKodOddzialuPrev or ( wrs.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) );
                     
                    sZmodyfLiczUslugiFilie := 'T';                                                                                                                   
                  end if;                                                   
                end loop;
                close c_UslugiFiliePrev;
                if sZmodyfLiczUslugiFilie = 'T' then 
                   --aneks
                   update sysadm.KC_OU_LICZ_USLUGI lu 
                   set (lu.UMOWA_LICZBA ) = nvl(
                   (
                    select sum(luf.UMOWA_LICZBA)
                    from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
                    where luf.KOD_UMOWY= lu.KOD_UMOWY and luf.NR_WERSJI = lu.NR_WERSJI 
                          and luf.KOD_USLUGI = lu.KOD_USLUGI and luf.PORZADEK = lu.PORZADEK and luf.MIESIAC = lu.MIESIAC
                   ), lu.UMOWA_LICZBA )
                   where lu.KOD_UMOWY = sKodUmowy and lu.NR_WERSJI = nNrWersji and lu.KOD_USLUGI = sKodUslugiPrev 
                   and lu.PORZADEK = nPorzadekPrev;
                   
                   update sysadm.KC_OF_WYCOF_ROZB_STAT wrs
                   set wrs.POPRAWIONO_LU_A = 'T'
                   where wrs.KOD_UMOWY = sKodUmowy and wrs.NR_WERSJI = nNrWersji and wrs.KOD_USLUGI = sKodUslugiPrev
                   and wrs.PORZADEK = nPorzadekPrev and wrs.KOD_SWIADCZ = sKodSwiadczPrev and wrs.KOD_FILII = sKodFiliiPrev
                   and ( wrs.KOD_ODDZIALU = sKodOddzialuPrev or ( wrs.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) );

                   --plan
                   update sysadm.KC_OU_PLAN_USLUG pu
                   set pu.LICZBA = nvl(
                            ( 
                              select nvl(sum(puf.LICZBA), 0 )
                              from sysadm.KC_OU_PLAN_USLUGI_FILIE puf
                              where puf.KOD_UMOWY = sKodUmowy and puf.KOD_USLUGI = pu.KOD_USLUGI and puf.PORZADEK = pu.PORZADEK
                                    and puf.MIESIAC = pu.MIESIAC
                            ), pu.LICZBA )
                   where pu.KOD_UMOWY = sKodUmowy and pu.KOD_USLUGI = sKodUslugiPrev and pu.PORZADEK = nPorzadekPrev;                                    
                   
                   update sysadm.KC_OF_WYCOF_ROZB_STAT wrs
                   set wrs.POPRAWIONO_LU_P = 'T'
                   where wrs.KOD_UMOWY = sKodUmowy and wrs.NR_WERSJI = nNrWersji and wrs.KOD_USLUGI = sKodUslugiPrev
                   and wrs.PORZADEK = nPorzadekPrev and wrs.KOD_SWIADCZ = sKodSwiadczPrev and wrs.KOD_FILII = sKodFiliiPrev
                   and ( wrs.KOD_ODDZIALU = sKodOddzialuPrev or ( wrs.KOD_ODDZIALU is null and sKodOddzialuPrev is null ) );
                   
                end if;
            end loop;
            close c_UslugiPrev;                                                                     
         end if;
       end loop;
       close hsql;
commit;
end;


















