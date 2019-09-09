select * from adressen_import fetch first 10 rows only;

--
-- What does this statement do?
-- What does this statement do in Oracle?
--
select
   count(         *  ),
   count(         art),
   count(distinct art)
from
   adressen_import;
