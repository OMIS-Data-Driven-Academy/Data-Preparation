select
   count(*),
   adresse
from
   st_zh.adressen_import
group by
   adresse
having
   count(*) > 1
order by
   count(*) desc;

select * from st_zh.adressen_import where adresse = 'Badenerstrasse 527';
