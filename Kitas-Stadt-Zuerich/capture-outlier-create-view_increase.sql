drop   view if exists sd_zv_kitas_schulkreis_gesamte_stadt_v;
create view sd_zv_kitas_schulkreis_gesamte_stadt_v as
select
   jahr,
   anz_bp_sk,
   anz_bp_sk - anz_bp_sk_voriges_jahr               as zuwachs_anz    , 
   anz_bp_sk / anz_bp_sk_voriges_jahr               as zuwachs_rate   ,
  (anz_bp_sk / anz_bp_sk_voriges_jahr - 1) * 100    as zuwachs_perc   ,
   first_value(anz_bp_sk) over (order by jahr     ) as anz_bp_sk_start,
   first_value(anz_bp_sk) over (order by jahr desc) as anz_bp_sk_end  ,
   max(jahr     ) over() - min(jahr     ) over()    as dauer_periode
from
   sd_zv_kitas_schulkreis_gesamte_stadt
;

select *
from
   sd_zv_kitas_schulkreis_gesamte_stadt_v
order by
   jahr;

select
    jahr,
    anz_bp_sk,
    cast (zuwachs_anz  as decimal(6,1)) zuwachs_anz ,
    cast (zuwachs_rate as decimal(5,2)) zuwachs_rate,
    cast (zuwachs_perc as decimal(5,1)) zuwachs_perc
from
   sd_zv_kitas_schulkreis_gesamte_stadt_v
order by
   jahr;
