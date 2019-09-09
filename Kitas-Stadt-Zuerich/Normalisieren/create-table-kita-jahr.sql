drop table if exists kita_jahr;

--
-- Don't pay attention to »error«
--   The executeQuery must return
--   an a result set.
--
select distinct
   jahr,
   belegungsfaktor
into
   kita_jahr
from
   sd_zv_kitas_schulkreis
;


select * from kita_jahr;
