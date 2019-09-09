drop   view if exists sd_zv_kitas_schulkreis_gesamte_stadt;

create view sd_zv_kitas_schulkreis_gesamte_stadt as
select
   jahr,
   anz_bp_sk,
   lead(anz_bp_sk) over (order by jahr) anz_bp_sk_naechstes_jahr,  
   lag (anz_bp_sk) over (order by jahr) anz_bp_sk_voriges_jahr
from
   sd_zv_kitas_schulkreis
where
   skname = 'Gesamte Stadt'
;

select * from sd_zv_kitas_schulkreis_gesamte_stadt;
