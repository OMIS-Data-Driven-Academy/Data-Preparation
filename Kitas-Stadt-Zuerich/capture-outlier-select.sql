select
-- power(anz_bp_sk_end / anz_bp_sk_start, 1.000/dauer_periode),
   *
from
   sd_zv_kitas_schulkreis_gesamte_stadt_v
where
   power(anz_bp_sk_end / anz_bp_sk_start, 1.000/dauer_periode)  -- Durschnittliche Zuwachsrate (geometrisch gemittelt)       TODO: precision
      not between zuwachs_rate * 0.8 and zuwachs_rate * 1.2     -- zuwachs_rate ist variabel pro Jahr.

