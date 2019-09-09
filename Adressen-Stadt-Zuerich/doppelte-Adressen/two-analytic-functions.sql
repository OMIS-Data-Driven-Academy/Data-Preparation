select
   count(*) over (partition by adresse ) cnt_addr,
   count(*) over (partition by gwr_egid) cnt_egid,
   s.adresse,
   s.gwr_egid
from
   adressen_import s
order by
-- count(*) over (partition by adresse ) desc, s.adresse , s.gwr_egid
   count(*) over (partition by gwr_egid) desc, s.gwr_egid, s.adresse
;
