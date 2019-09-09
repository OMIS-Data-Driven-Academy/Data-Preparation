select
   min(jahr)                 min_jahr,
   max(jahr)                 max_jahr,
   max(jahr) - min(jahr) + 1 anz_jahre
from
   dbo.sd_zv_kitas_schulkreis
;

;begin transaction;

delete from dbo.sd_zv_kitas_schulkreis where jahr = 2010;

; rollback;
