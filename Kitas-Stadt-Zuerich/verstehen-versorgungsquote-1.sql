--
--   Versorgungsquote:
--      Anzahl Vorschulkinder im Verhältnis
--      zum Total der kita-Plätze unter
--      Berücksichtigung des Belegungsfaktors
--
select
   ( 4280.5 *      -- anz_bp_sk       : Total der Kita-Plätze (?)
        1.46       -- belegungsfaktor
   ) / 17268       -- anz_kinder_va   : Anzahl Vorschulkinder (?)
   -
--   =
    0.3615         -- versorgungsquote:
