--patch dla opola
select * from sysadm.KC_OF_WYCOF_ROZB_STAT
drop table SYSADM.KC_OF_WYCOF_ROZB_STAT
create table SYSADM.KC_OF_WYCOF_ROZB_STAT
(
  KOD_UMOWY                 VARCHAR2(24) not null,
  NR_WERSJI                 NUMBER(4) not null,
  KOD_USLUGI                VARCHAR2(16) not null,
  PORZADEK                  NUMBER(4) not null,
  KOD_SWIADCZ               VARCHAR2(16) not null,
  KOD_FILII                 VARCHAR2(16) not null,
  KOD_ODDZIALU              VARCHAR2(16),
  MIESIAC                   NUMBER(2),
  UMOWA_LICZBA_OLD          NUMBER(12,2),
  UMOWA_LICZBA_NEW          NUMBER(12,2),
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

  TYPE anTypeUmowaLiczba IS VARRAY(12) OF NUMBER(12,2);
  
  anUmowaLiczba             anTypeUmowaLiczba := anTypeUmowaLiczba(0,0,0,0,0,0,0,0,0,0,0,0);
  anUmowaLiczbaPopAneksy    anTypeUmowaLiczba := anTypeUmowaLiczba(0,0,0,0,0,0,0,0,0,0,0,0);           
  anModyfMiesiac            anTypeUmowaLiczba := anTypeUmowaLiczba(1,2,3,4,5,6,7,8,9,10,11,12);           
  
       nNrWersji                                                 NUMBER(4);  
       nNrWersjiMax                                              NUMBER(4);
       sKodUslugi                                                VARCHAR2(16);
       nPorzadek                                                 NUMBER(4);
       sKodSwiadcz                                               VARCHAR2(16);
       sKodFilii                                                 VARCHAR2(16);
       sKodOddzialu                                              VARCHAR2(16);        
       sKodKasyModyf                                             VARCHAR2(4);
       nKod                                                      NUMBER(16);
       nSumPlanLiczba                                            NUMBER(12,2);
       nSumOfertLiczba                                           NUMBER(12,2);
       nSumUmowaLiczba                                           NUMBER(12,2);
       nUmowaMiesiacOd                                           NUMBER(2);
       nUmowaMiesiacDo                                           NUMBER(2);
       sZmodyfLiczUslugiFilie                                    CHAR(1);
       nMiesiac                                                  NUMBER(2);
       nUmowaLiczba                                              NUMBER(12,2);
       nUmowaLiczbaNext                                          NUMBER(12,2);
       nSumUmowaLiczbaPopAneksy                                  NUMBER(12,2);
       sUpdatedLiczUslugiFilie                                   CHAR(1);                        
  
  cursor c_Uslugi is
  select u.KOD_USLUGI, u.PORZADEK
  from sysadm.KC_OU_USLUGI u
  where u.KOD_UMOWY = p_sKodUmowy and u.NR_WERSJI = nNrWersji;
  
  cursor c_UslugiFilie is
  select uf.KOD_KASY_MODYF, uf.KOD, uf.KOD_SWIADCZ, uf.KOD_FILII, uf.KOD_ODDZIALU
  from sysadm.KC_OU_USLUGI_FILIE uf
  where uf.KOD_UMOWY = p_sKodUmowy and uf.NR_WERSJI = nNrWersji 
    and uf.KOD_USLUGI = sKodUslugi and uf.PORZADEK = nPorzadek;
  
  cursor c_LiczUslugiFilie is
  select luf.MIESIAC, luf.UMOWA_LICZBA
  from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
  where luf.KOD_KASY_MODYF = sKodKasyModyf and luf.KOD = nKod
  order by luf.MIESIAC;
  
begin
  select max(wu.NR_WERSJI)
  into nNrWersjiMax
  from sysadm.KC_OU_WERSJE_UMOW wu
  where wu.kod_umowy = p_sKodUmowy;
  
  nNrWersji := 2;
  while (nNrWersji <= nNrWersjiMax) loop
    --KC_OU_USLUGI
    open c_Uslugi;    
    loop
      fetch c_Uslugi into sKodUslugi, nPorzadek;
      exit when c_Uslugi%NOTFOUND;
      --KC_OU_USLUGI_FILIE
      open c_UslugiFilie;
      loop
        fetch c_UslugiFilie into sKodKasyModyf, nKod, sKodSwiadcz, sKodFilii, sKodOddzialu;
        exit when c_UslugiFilie%NOTFOUND;
        sUpdatedLiczUslugiFilie := 'N';
        --KC_OU_LICZ_USLUGI_FILIE
        open c_LiczUslugiFilie;
        loop
          fetch c_LiczUslugiFilie into nMiesiac, nUmowaLiczba;
          exit when c_LiczUslugiFilie%NOTFOUND;
          anUmowaLiczba(nMiesiac) := nUmowaLiczba;
          --BARDZO WA¯NY SELECT!!! 
          begin         
            select luf.UMOWA_LICZBA
            into nUmowaLiczba
            from sysadm.KC_OU_LICZ_USLUGI_FILIE luf, sysadm.KC_OU_USLUGI_FILIE uf
            where uf.KOD_UMOWY = p_sKodUmowy and uf.NR_WERSJI < nNrWersji
              and uf.KOD_USLUGI = sKodUslugi and uf.PORZADEK = nPorzadek 
              and uf.KOD_SWIADCZ = sKodSwiadcz and uf.KOD_FILII = sKodFilii
              and ( uf.KOD_ODDZIALU = sKodOddzialu or ( uf.KOD_ODDZIALU is null and sKodOddzialu is null ) )
              and uf.KOD_KASY_MODYF = luf.KOD_KASY_MODYF and uf.KOD = luf.KOD and luf.MIESIAC = nMiesiac
              and rownum = 1
            order by uf.NR_WERSJI desc;
            anUmowaLiczbaPopAneksy(nMiesiac) := nUmowaLiczba;                                
            exception 
              when no_data_found then
                anUmowaLiczbaPopAneksy(nMiesiac) :=0;             
          end;
        end loop;        
        close c_LiczUslugiFilie;            
        --sprawdzam czy suma siê zgadza
        nMiesiac := 1;
        nSumUmowaLiczba := 0;
        nSumUmowaLiczbaPopAneksy := 0;
        while nMiesiac <= 12 loop
          if anUmowaLiczba(nMiesiac) is not null then          
            nSumUmowaLiczba := nSumUmowaLiczba + anUmowaLiczba(nMiesiac);
          else
            anUmowaLiczba(nMiesiac) := 0;
          end if;
          if anUmowaLiczbaPopAneksy(nMiesiac) is not null then
            nSumUmowaLiczbaPopAneksy := nSumUmowaLiczbaPopAneksy + anUmowaLiczbaPopAneksy(nMiesiac);
          else
            anUmowaLiczbaPopAneksy(nMiesiac) := 0;
          end if;
          nMiesiac := nMiesiac + 1;
        end loop;
        
        --je¿eli suma siê zgadza to robiê update tylko na tych miesi¹cach, w których jest ró¿nica
        if nSumUmowaLiczba = nSumUmowaLiczbaPopAneksy then
          nMiesiac := 1;
          while nMiesiac < 12 loop
            if anUmowaLiczba(nMiesiac) != anUmowaLiczbaPopAneksy(nMiesiac) then
               nUmowaLiczba := anUmowaLiczbaPopAneksy(nMiesiac);
              --poprawiamy aneks
              update sysadm.KC_OU_LICZ_USLUGI_FILIE 
              set UMOWA_LICZBA = nUmowaLiczba
              where KOD_KASY_MODYF = sKodKasyModyf and KOD = nKod and MIESIAC = nMiesiac;
              sUpdatedLiczUslugiFilie := 'T';
            
              insert into SYSADM.KC_OF_WYCOF_ROZB_STAT
              (KOD_UMOWY, NR_WERSJI, KOD_USLUGI, PORZADEK, KOD_SWIADCZ, KOD_FILII, KOD_ODDZIALU, MIESIAC, 
               UMOWA_LICZBA_OLD, UMOWA_LICZBA_NEW, POPRAWIONO_LUF_A) 
              values
              (p_sKodUmowy, nNrWersji, sKodUslugi, nPorzadek, sKodSwiadcz, sKodFilii, sKodOddzialu, nMiesiac,
               anUmowaLiczba(nMiesiac), anUmowaLiczbaPopAneksy(nMiesiac), 'T' );
             
              --poprawiamy plan
              update sysadm.KC_OU_PLAN_USLUGI_FILIE puf
              set puf.LICZBA = nUmowaLiczba
              where puf.KOD_UMOWY = p_sKodUmowy and puf.KOD_USLUGI = sKodUslugi and puf.PORZADEK = nPorzadek
                 and puf.KOD_SWIADCZ = sKodSwiadcz and puf.KOD_FILII = sKodFilii
                 and ( puf.KOD_ODDZIALU = sKodOddzialu or ( puf.KOD_ODDZIALU is null and sKodOddzialu is null ) )
                 and puf.MIESIAC = nMiesiac;
             
              update sysadm.KC_OF_WYCOF_ROZB_STAT
              set POPRAWIONO_LUF_P = 'T'
              where KOD_UMOWY = p_sKodUmowy and NR_WERSJI = nNrWersji and KOD_USLUGI = sKodUslugi and PORZADEK = nPorzadek
                and KOD_SWIADCZ = sKodSwiadcz and  KOD_FILII = sKodFilii 
                and ( KOD_ODDZIALU = sKodOddzialu or (KOD_ODDZIALU is null and sKodOddzialu is null )) 
                and MIESIAC = nMiesiac; 
              anModyfMiesiac(nMiesiac) := nMiesiac;                                       
           else
             anModyfMiesiac(nMiesiac) := 0;
           end if;
          nMiesiac := nMiesiac + 1;
        end loop;                  
       end if; 
      end loop;
      close c_UslugiFilie;
      
      if sUpdatedLiczUslugiFilie = 'T' then
        nMiesiac := 1;
        while nMiesiac <= 12 loop
          if anModyfMiesiac(nMiesiac) != 0 then
            --poprawiam aneks - tylko w tym miesi¹cu, w którym wyst¹pi³y zmiany
            update sysadm.KC_OU_LICZ_USLUGI lu 
            set (lu.UMOWA_LICZBA ) = nvl(
            (
              select sum(luf.UMOWA_LICZBA)
              from sysadm.KC_OU_LICZ_USLUGI_FILIE luf
              where luf.KOD_UMOWY= lu.KOD_UMOWY and luf.NR_WERSJI = lu.NR_WERSJI 
                    and luf.KOD_USLUGI = lu.KOD_USLUGI and luf.PORZADEK = lu.PORZADEK and luf.MIESIAC = lu.MIESIAC
             ), lu.UMOWA_LICZBA )
             where lu.KOD_UMOWY = p_sKodUmowy and lu.NR_WERSJI = nNrWersji 
                   and lu.KOD_USLUGI = sKodUslugi and lu.PORZADEK = nPorzadek and lu.MIESIAC = anModyfMiesiac(nMiesiac);

             update sysadm.KC_OF_WYCOF_ROZB_STAT
             set POPRAWIONO_LU_A = 'T'
             where KOD_UMOWY = p_sKodUmowy and NR_WERSJI = nNrWersji and KOD_USLUGI = sKodUslugi and PORZADEK = nPorzadek
               and MIESIAC = anModyfMiesiac(nMiesiac);

            --poprawiam plan - tylko w tym miesi¹c, w którym wyst¹pi³y zmiany
            update sysadm.KC_OU_PLAN_USLUG pu
            set pu.LICZBA = nvl(
            ( 
              select nvl(sum(puf.LICZBA), 0 )
              from sysadm.KC_OU_PLAN_USLUGI_FILIE puf
              where puf.KOD_UMOWY = p_sKodUmowy and puf.KOD_USLUGI = pu.KOD_USLUGI and puf.PORZADEK = pu.PORZADEK
                    and puf.MIESIAC = pu.MIESIAC
            ), pu.LICZBA )
            where pu.KOD_UMOWY = p_sKodUmowy and pu.KOD_USLUGI = sKodUslugi and pu.PORZADEK = nPorzadek 
                  and pu.MIESIAC = anModyfMiesiac(nMiesiac);

            update sysadm.KC_OF_WYCOF_ROZB_STAT
            set POPRAWIONO_LU_P = 'T'
            where KOD_UMOWY = p_sKodUmowy and NR_WERSJI = nNrWersji and KOD_USLUGI = sKodUslugi and PORZADEK = nPorzadek
                  and MIESIAC = anModyfMiesiac(nMiesiac);                        
          end if;
          nMiesiac := nMiesiac + 1;
        end loop;
     end if;
    end loop;
    close c_Uslugi;
    nNrWersji := nNrWersji + 1;
  end loop;
  commit;
end;  
