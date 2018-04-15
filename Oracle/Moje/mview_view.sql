select query from dba_mviews where mview_name like '%KC_CENNIK_SWIADCZENIA_W%'


select text from DBA_VIEWS where view_name like '%VKC_OU_UMOWY_SW%'



create materialized view MVKC_SL_USLUGI_FILTR
refresh force on demand
start with to_date('08-11-2007 12:00:00', 'dd-mm-yyyy hh24:mi:ss') next
trunc (sysdate,'hh24') + 1/24
as
select 'PODWYZKA' as OBSZAR, c.ROK, c.RODZAJ_WYDATKU, s.KOD, s.NAZWA,
s.TYP_UMOWY
from sysadm.KC_CENNIK c, sysadm.KC_SL_USLUGI s
where s.ROK = c.ROK and s.KOD = c.KOD_USLUGI
and s.ROK in (2006,2007,2008) and s.KOD like '%9999.%.03'
union
select 'PODWYZKA1' as OBSZAR, c.ROK, c.RODZAJ_WYDATKU, s.KOD, s.NAZWA,
s.TYP_UMOWY
from sysadm.KC_CENNIK c, sysadm.KC_SL_USLUGI s
where s.ROK = c.ROK and s.KOD = c.KOD_USLUGI
and s.ROK in (2006,2007,2008) and s.KOD like '%9999.%.03' and s.KOD not in
('03.9999.006.03','03.9999.007.03','03.9999.008.03','03.9999.009.03',
'08.9999.001.03')
union
select 'PODWYZKA2' as OBSZAR, c.ROK, c.RODZAJ_WYDATKU, s.KOD, s.NAZWA,
s.TYP_UMOWY
from sysadm.KC_CENNIK c, sysadm.KC_SL_USLUGI s
where s.ROK = c.ROK and s.KOD = c.KOD_USLUGI
and s.ROK in (2007,2008) and s.KOD  in ('03.9999.006.03','03.9999.007.03',
'03.9999.008.03','03.9999.009.03','08.9999.001.03')



dbms_refresh.refresh('"CL_PORTAL"."MVCL_KC_KO_KONKURSY_V1"');