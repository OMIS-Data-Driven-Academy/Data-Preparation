select
   count(*),
   verwaltungsquartier,
   statistisches_quartier
from
   adressen_import
group by
   verwaltungsquartier,
   statistisches_quartier
order by
   verwaltungsquartier
-- statistisches_quartier
;
--
-- A 1:n relationship between verwaltungsquartier and statistisches_quartier
-- seems likely.
--

--
-- Affoltern is the only statistisches_quartier with two verwaltungsquartier.
--
select
    count(*),
    verwaltungsquartier,
    statistisches_quartier,
    count(*) over (partition by statistisches_quartier) cnt
from
    adressen_import
group by
    verwaltungsquartier,
    statistisches_quartier
order by
    count(*) over (partition by statistisches_quartier) desc
--  statistisches_quartier;



select
   count(*),
   verwaltungsquartier,
   statistisches_quartier
from
   adressen_import
where
   stadtkreis = 11
group by
   verwaltungsquartier,
   statistisches_quartier;
--
--  Should statistisches_quartier be changed to Seebach or
--         verwaltungsquartier  to Affoltern  ????
--

--
--  Similar query
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
   
--
-- Something's probably wrong with the 178 addresses.
--
