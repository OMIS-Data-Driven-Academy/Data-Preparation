select
   count(*)                                                   cnt,
              sum(validate_conversion(hausnummer as number))  cnt_numeric,
   count(*) - sum(validate_conversion(hausnummer as number))  cnt_non_numeric
from
   stzh_adresse_import_cnt
where
   rn_addr = 1;


select *
from
   stzh_adresse_import_cnt
where
   validate_conversion(hausnummer as number) = 0 and
   rn_addr = 1;


select
   count(*) - sum(validate_conversion(hausnummer_sort as number)) cnt_non_numeric
from
   stzh_adresse_import_cnt
where
   rn_addr = 1;

select *
from
   stzh_adresse_import_cnt
where
   rn_addr = 1                                   and
   validate_conversion(hausnummer as number) = 0 and
   not regexp_like(hausnummer, '^\d+\w+$')
;
