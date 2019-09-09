select
   count(*) over (partition by adresse) cnt,
   s.*
from
   adressen_import s
order by
   count(*) over (partition by adresse) desc,
   adresse
;
