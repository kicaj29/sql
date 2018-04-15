select job, what from dba_jobs where what like '%KC_CENN%'


execute dbms_refresh.refresh('"SYSADM"."KC_CENNIK_SWIADCZENIA_W"')

KC_CENNIK_SWIADCZENIA_W - to view zmaterializowane

