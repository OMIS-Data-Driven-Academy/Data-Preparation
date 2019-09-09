--
--  Reduktion des vorherigen Select Results auf weniger Records
--
select
   count(*) as cnt_of_cnt,
   cnt
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
  cnt;


--
--  Reduktion des vorherigen Select Results auf weniger Records
--
select
   count(*) as cnt_of_cnt,
   cnt
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
