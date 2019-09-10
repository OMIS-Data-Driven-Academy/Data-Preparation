--
-- 1:n relation between stadtkreis and statistisches_quartier
--

select count(*) from (
   select
      *
   from
     adressen_import a join
     adressen_import b on a.statistisches_quartier = b.statistisches_quartier and
                          a.stadtkreis            != b.stadtkreis
);


--
-- What is the order of an SQL statement?
--
select * from (
   select
      count(*),
      stadtkreis,
      statistisches_quartier,
      count(*) over (partition by statistisches_quartier) cnt_statistisches_quartier
   from
      adressen_import
   group by
      stadtkreis,
      statistisches_quartier
)
where
   cnt_statistisches_quartier > 1
;


select * from adressen_import;
update adressen_import set statistisches_quartier = 'Fluntern' where adresse = 'Fellenbergstrasse 267';
rollback;

update adressen_import
set
   statistisches_quartier = 'Hirslanden'
where
   adresse = 'Rieterstrasse 32';
   
rollback;
