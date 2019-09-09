select
   skname
from
   dbo.sd_zv_kitas_schulkreis
where
   jahr = 2006;
--
-- 9 »Schulkreise«
--
-- 13 Jahre
--
-- 9 * 13 = 117
--

select
   skname,
   count(*) over () cnt
from
   dbo.sd_zv_kitas_schulkreis
where
   jahr = 2006;

select count(*) from dbo.sd_zv_kitas_schulkreis
