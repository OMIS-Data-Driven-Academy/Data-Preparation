with doublettes as (
   select
      count(*) over (partition by adresse) cnt,
      s.adresse,
      s.northing,
      s.easting,
      s.northing_wgs,
      s.easting_wgs,
      s.rowid
   from
      adressen_import s
   order by
      count(*) over (partition by adresse) desc,
      adresse
)
select
   d1.adresse,
   sqrt(power(d1.northing - d2.northing, 2) + 
        power(d1.easting  - d2.easting , 2)
       )                                      distance,
   d1.easting,
   d1.northing,
   d2.easting,
   d2.northing,
   d1.easting_wgs,
   d1.northing_wgs,
   d2.easting_wgs,
   d2.northing_wgs
from
   doublettes   d1                                  join
   doublettes   d2 on d1.adresse = d2.adresse and
                      d1.rowid   < d2.rowid
where
   d1.cnt > 1 and
   d2.cnt > 1
order by
   sqrt(  power(d1.northing - d2.northing, 2) + power(d1.easting - d2.easting, 2)) desc
;
