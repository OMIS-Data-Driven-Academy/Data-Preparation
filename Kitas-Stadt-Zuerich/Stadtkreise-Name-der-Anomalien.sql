--
-- Select Schulkreisnamen der Anomalien.
--
select
   count(*)     as cnt_of_cnt,
   cnt,
   max(skname)  as skname
from (
   select
      count(*)  as cnt,
      skname
   from
      dbo.sd_zv_kitas_schulkreis
   group by
      skname
) c
group by
   cnt
having
   count(*) = 1;
