--
--  Can plz be assigned to statistische_zone?
--
select
   count(*)              ,
   plz                   ,
   stadtkreis            ,
   statistisches_quartier,
   verwaltungsquartier   ,
   statistische_zone     ,
   --
   count(distinct plz) over (partition by stadtkreis            ) cnt_stadtkreis,
   count(distinct plz) over (partition by statistisches_quartier) cnt_statistisches_quartier,
   count(distinct plz) over (partition by verwaltungsquartier   ) cnt_verwaltungsquartier,
   count(distinct plz) over (partition by statistische_zone     ) cnt_statistische_zone,
   count(distinct stadtkreis            ) over (partition by plz) cnt_stadtkreis_,
   count(distinct statistisches_quartier) over (partition by plz) cnt_statistisches_quartier_,
   count(distinct verwaltungsquartier   ) over (partition by plz) cnt_verwaltungsquartier_,
   count(distinct statistische_zone     ) over (partition by plz) cnt_statistische_zone_
from
   adressen_import
group by
   plz,
   stadtkreis,
   statistisches_quartier,
   verwaltungsquartier,
   statistische_zone
order by
   plz,
   stadtkreis,
   statistisches_quartier,
   verwaltungsquartier,
   statistische_zone
;
