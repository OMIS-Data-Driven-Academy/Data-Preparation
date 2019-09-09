--
-- Notify us if year is missing
--

create view jahr_ampel as
select
   case when s.anz_jahre <> s.cnt_dist_jahr
        then 'Problem mit Jahren'
        else 'Jahre scheinen OK' end        msg
from (
  select
  -- min(jahr)                 min_jahr ,
  -- max(jahr)                 max_jahr ,
     max(jahr) - min(jahr) + 1 anz_jahre,
     count(distinct jahr )     cnt_dist_jahr
  from
     dbo.sd_zv_kitas_schulkreis
)
s
;

select * from jahr_ampel;

-- Update one record
-- select %%physloc%%, t.* from dbo.sd_zv_kitas_schulkreis t;

select @@trancount;
;begin transaction;
select @@trancount;

update dbo.sd_zv_kitas_schulkreis set jahr = 2005 where jahr = 2006 and skname = 'Gesamte Stadt';
select * from jahr_ampel;

delete from dbo.sd_zv_kitas_schulkreis where jahr = 2009;
select * from jahr_ampel;

;rollback transaction;
select @@trancount;
select * from jahr_ampel;
