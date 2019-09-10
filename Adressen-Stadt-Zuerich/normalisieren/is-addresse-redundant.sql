select
   count(*) cnt
from 
   stzh_adresse_import_cnt
where
                 lokalisationsname || ' ' || hausnummer  != adresse
-- concat(concat(lokalisationsname,   ' '),  hausnummer) != adresse
;
