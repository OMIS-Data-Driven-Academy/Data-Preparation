--
-- Problem: versorgungsquote is not always rounded to 4 decimal places!
--
select
   jahr,
   skname,
   anz_bp_sk,
   anz_kinder_va,
   belegungsfaktor,
   versorgungsquote,
   anz_bp_sk / anz_kinder_va * belegungsfaktor
from
   sd_zv_kitas_schulkreis
where 
   round(anz_bp_sk / anz_kinder_va * belegungsfaktor, 4) <> versorgungsquote;
