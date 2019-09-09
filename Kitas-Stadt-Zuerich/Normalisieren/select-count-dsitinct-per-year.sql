--
--   Wieviele verschiedene Belegungsfaktoren pro Jahr?
--
select
   jahr,
   count(distinct belegungsfaktor) cnt_different_bf
from
   sd_zv_kitas_schulkreis
group by
   jahr
-- having
--    count(distinct belegungsfaktor) > 1
;

;begin transaction;

select @@trancount;

update sd_zv_kitas_schulkreis
set
   belegungsfaktor = 1.23
where
   jahr    =  2011 and
    skname = 'Letzi';

; rollback work;
