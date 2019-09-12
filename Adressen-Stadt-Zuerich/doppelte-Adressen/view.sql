create or replace view st_zh.stzh_adresse_import_cnt as
select
   s.*,
   count     (*) over (partition by adresse                       ) cnt_addr,
   row_number( ) over (partition by adresse order by gwr_egid desc) rn_addr ,
   count     (*) over (partition by gwr_egid                      ) cnt_egid
from
   adressen_import s
;

select * from stzh_adresse_import_cnt where cnt_addr > 1;
select * from stzh_adresse_import_cnt where cnt_addr > 1 and rn_addr = 1;

create or replace view st_zh.stzh_doppelte_adressen as
select
   cnt_1.adresse,
   --
   cnt_1.easting_wgs  easting_wgs_1,
   cnt_2.easting_wgs  easting_wgs_2,
   cnt_1.northing_wgs northing_wgs_1,
   cnt_2.northing_wgs northing_wgs_2,
   --
   cnt_1.easting  easting_1,
   cnt_2.easting  easting_2,
   cnt_1.northing northing_1,
   cnt_2.northing northing_2
from
   stzh_adresse_import_cnt  cnt_1                                     join
   stzh_adresse_import_cnt  cnt_2 on cnt_1.adresse = cnt_2.adresse
where
   cnt_1.rn_addr = 1 and
   cnt_2.rn_addr = 2;



select
   adresse,
   easting_1 , easting_2 ,
   northing_1, northing_2,
   round(
     sqrt( power(easting_2  - easting_1 , 2) + 
           power(northing_2 - northing_1, 2)
         ),
     2)                                                dist
from
   stzh_doppelte_adressen
order by
   dist desc
;
