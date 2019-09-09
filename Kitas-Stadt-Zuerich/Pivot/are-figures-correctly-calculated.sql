--
-- RUN IN STUDIO
--
select
   jahr,
   ---------------------------------------------------------------------------------------------------------------------------------------------
             bp_stadt                                                                                                         bp_stadt          ,
                         bp_stadt_ohne_zuerichberg + bp_zuerichberg                                                           bp_stadt_berechnet,
   case when bp_stadt <> bp_stadt_ohne_zuerichberg + bp_zuerichberg  then 'BP Stadt not OK!' end                              bp_stadt_ok       ,
             --
             bp_stadt_ohne_zuerichberg,
             bp_glattal + bp_letzi + bp_limmattal + bp_schwammendingen + bp_uto + bp_waidberg bp_stadt_ohne_zuerichberg_berechnet,
   case when bp_glattal + bp_letzi + bp_limmattal + bp_schwammendingen + bp_uto + bp_waidberg <> bp_stadt_ohne_zuerichberg then 'BP Ohne Zürichberg not OK!' end ok,
             -- 
   case when bp_stadt_ohne_zuerichberg + bp_zuerichberg <> bp_stadt then 'BP not OK!' end
   ---------------------------------------------------------------------------------------------------------------------------------------------
             va_stadt,
             va_stadt_ohne_zuerichberg + va_zuerichberg                                                va_stadt_berechnet,
   case when va_stadt <> va_stadt_ohne_zuerichberg + va_zuerichberg  then 'VA Stadt Not OK!' end       va_stadt_differenz,
             va_stadt_ohne_zuerichberg,
             va_glattal + va_letzi + va_limmattal + va_schwammendingen + va_uto + va_waidberg va_stadt_ohne_zuerichberg_berechnet,
   case when va_glattal + va_letzi + va_limmattal + va_schwammendingen + va_uto + va_waidberg <> va_stadt_ohne_zuerichberg then 'VA ohne Zürichberg not OK!' end,
   case when va_stadt_ohne_zuerichberg + va_zuerichberg <> va_stadt then 'not OK!' end
   ---------------------------------------------------------------------------------------------------------------------------------------------
--           vq_stadt,
--           vq_stadt_ohne_zuerichberg + vq_zuerichberg,
-- case when vq_stadt <> vq_stadt_ohne_zuerichberg + vq_zuerichberg  then 'Not OK!' end,
--           vq_stadt_ohne_zuerichberg,
--           vq_glattal + vq_letzi + vq_limmattal + vq_schwammendingen + vq_uto + vq_waidberg,
-- case when vq_glattal + vq_letzi + vq_limmattal + vq_schwammendingen + vq_uto + vq_waidberg <> vq_stadt_ohne_zuerichberg then 'Not OK!' end,
-- case when vq_stadt_ohne_zuerichberg + vq_zuerichberg <> vq_stadt then 'Not OK!' end
   ----
from
   sd_zv_kitas_schulkreis_pivot;
