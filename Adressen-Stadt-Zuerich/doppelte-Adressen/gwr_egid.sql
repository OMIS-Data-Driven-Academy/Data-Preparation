select
   count(*) over (partition by adresse, gwr_egid) cnt,
-- s.rowid,
   s.*
from
   adressen_import s
order by
   count(*) over (partition by adresse, gwr_egid) desc;

--
-- Distance between points of Allmendstrasse 140
--
select
   sqrt(
      power(2681637.688 - 2681609.223, 2) +
      power(1243680.176 - 1243638.521, 2)
   )
from
   dual;
