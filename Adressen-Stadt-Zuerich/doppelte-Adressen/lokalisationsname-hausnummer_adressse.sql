select * from st_zh.adressen_import;

select
   *
from
   st_zh.adressen_import
where
   lokalisationsname || ' ' || hausnummer != adresse;


--
-- ---> adresse is redundant
--
