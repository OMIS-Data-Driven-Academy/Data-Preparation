select
   jahr,
   belegungsfaktor,
   bp.[Gesamte Stadt]                   as bp_stadt,
   bp.[Gesamte Stadt ohne Zürichberg]   as bp_stadt_ohne_zuerichberg,
   bp.[Glattal]                         as bp_glattal,
   bp.[Letzi]                           as bp_letzi,
   bp.[Limmattal]                       as bp_limmattal,
   bp.[Schwamendingen]                  as bp_schwammendingen,
   bp.[Uto]                             as bp_uto,
   bp.[Waidberg]                        as bp_waidberg,
   bp.[Zürichberg]                      as bp_zuerichberg
from (
  select
     jahr,
     belegungsfaktor,
     skname,
     anz_bp_sk
  from
     sd_zv_kitas_schulkreis
) as src
pivot (
   max(anz_bp_sk)
   for skname in (
     [Gesamte Stadt]                   ,
     [Gesamte Stadt ohne Zürichberg]   ,
     [Glattal]                         ,
     [Letzi]                           ,
     [Limmattal]                       ,
     [Schwamendingen]                  ,
     [Uto]                             ,
     [Waidberg]                        ,
     [Zürichberg]
  )
) as bp
;
