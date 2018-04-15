select kod_swiadcz from ortn_real_wnioski
where (case kod_swiadcz when '020300'  then 1
      ELSE 2 END ) = 2