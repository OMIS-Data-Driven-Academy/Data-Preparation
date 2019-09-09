select
   count(*)  as cnt,
   skname
from
   dbo.sd_zv_kitas_schulkreis
group by
   skname
;
