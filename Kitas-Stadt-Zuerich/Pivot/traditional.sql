create view sd_zv_kitas_schulkreis_pivot as
select
   jahr,
   belegungsfaktor,
   ---------------------------------------------------------------------------------------------------------------
   max(case when skname = 'Gesamte Stadt'                    then anz_bp_sk        end) bp_stadt                 ,
   max(case when skname = 'Gesamte Stadt ohne Zürichberg'    then anz_bp_sk        end) bp_stadt_ohne_zuerichberg,
   max(case when skname = 'Glattal'                          then anz_bp_sk        end) bp_glattal               ,
   max(case when skname = 'Letzi'                            then anz_bp_sk        end) bp_letzi                 ,
   max(case when skname = 'Limmattal'                        then anz_bp_sk        end) bp_limmattal             ,
   max(case when skname = 'Schwamendingen'                   then anz_bp_sk        end) bp_schwammendingen       ,
   max(case when skname = 'Uto'                              then anz_bp_sk        end) bp_uto                   ,
   max(case when skname = 'Waidberg'                         then anz_bp_sk        end) bp_waidberg              ,
   max(case when skname = 'Zürichberg'                       then anz_bp_sk        end) bp_zuerichberg           ,
   ---------------------------------------------------------------------------------------------------------------
   max(case when skname = 'Gesamte Stadt'                    then anz_kinder_va    end) va_stadt                 ,
   max(case when skname = 'Gesamte Stadt ohne Zürichberg'    then anz_kinder_va    end) va_stadt_ohne_zuerichberg,
   max(case when skname = 'Glattal'                          then anz_kinder_va    end) va_glattal               ,
   max(case when skname = 'Letzi'                            then anz_kinder_va    end) va_letzi                 ,
   max(case when skname = 'Limmattal'                        then anz_kinder_va    end) va_limmattal             ,
   max(case when skname = 'Schwamendingen'                   then anz_kinder_va    end) va_schwammendingen       ,
   max(case when skname = 'Uto'                              then anz_kinder_va    end) va_uto                   ,
   max(case when skname = 'Waidberg'                         then anz_kinder_va    end) va_waidberg              ,
   max(case when skname = 'Zürichberg'                       then anz_kinder_va    end) va_zuerichberg           ,
   ---------------------------------------------------------------------------------------------------------------
   max(case when skname = 'Gesamte Stadt'                    then versorgungsquote end) vq_stadt                 ,
   max(case when skname = 'Gesamte Stadt ohne Zürichberg'    then versorgungsquote end) vq_stadt_ohne_zuerichberg,
   max(case when skname = 'Glattal'                          then versorgungsquote end) vq_glattal               ,
   max(case when skname = 'Letzi'                            then versorgungsquote end) vq_letzi                 ,
   max(case when skname = 'Limmattal'                        then versorgungsquote end) vq_limmattal             ,
   max(case when skname = 'Schwamendingen'                   then versorgungsquote end) vq_schwammendingen       ,
   max(case when skname = 'Uto'                              then versorgungsquote end) vq_uto                   ,
   max(case when skname = 'Waidberg'                         then versorgungsquote end) vq_waidberg              ,
   max(case when skname = 'Zürichberg'                       then versorgungsquote end) vq_zuerichberg           
from
   sd_zv_kitas_schulkreis
group by
   jahr,
   belegungsfaktor  -- <-- We already know that belegungsfaktor is dependent on year, so it's groupable
;

select * from sd_zv_kitas_schulkreis_pivot;
