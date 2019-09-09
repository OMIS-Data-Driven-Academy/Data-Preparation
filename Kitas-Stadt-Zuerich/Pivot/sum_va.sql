select
   va_stadt_ohne_zuerichberg,
   va_glattal , va_letzi , va_limmattal , va_schwammendingen , va_uto , va_waidberg,
   va_glattal + va_letzi + va_limmattal + va_schwammendingen + va_uto + va_waidberg
from
   sd_zv_kitas_schulkreis_pivot;


select
   sum(anz_kinder_va)
from
   sd_zv_kitas_schulkreis
where
   jahr = 2017 and
   skname not like 'Gesamte Stadt%';
