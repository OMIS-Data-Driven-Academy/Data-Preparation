select
   count(*)    cnt,
   stadtkreis
from
   adressen_import
group by
   stadtkreis
order by
   stadtkreis;
