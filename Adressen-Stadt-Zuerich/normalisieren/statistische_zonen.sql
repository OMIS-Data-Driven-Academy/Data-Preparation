select
   count(*),
   statistische_zone
from
   adressen_import
group by
   statistische_zone;



--
--  ~ Addressen pro statistische Zone
--
select
   count(*),
   statistische_zone,
   stadtkreis 
--        min(adresse)  adresse_example,
--        max(adresse)  adresse_example
from
   adressen_import
group by
   statistische_zone,
   stadtkreis
order by
   count(*);


select * from adressen_import where statistische_zone not like stadtkreis  || '%';

--
-- 
--


select * from (
   select
      count(*)                                       cnt_adressen,
      stadtkreis,
      statistisches_quartier,
      verwaltungsquartier,
      statistische_zone,
      count(*) over (partition by statistische_zone) cnt_statistische_zonen
   from
      adressen_import
   group by
      stadtkreis,
      statistisches_quartier,
      verwaltungsquartier,
      statistische_zone   
)
where
   cnt_statistische_zonen > 1


--
--  Going to fix error
--
select
   count(*),
   statistisches_quartier,
   verwaltungsquartier
from
   adressen_import
where
   statistisches_quartier in ('Affoltern', 'Seebach')
group by
   statistisches_quartier,
   verwaltungsquartier
;


update adressen_import
set
   verwaltungsquartier = 'Affoltern'
where
   statistisches_quartier = 'Affoltern' and
   verwaltungsquartier    = 'Seebach';

commit;
