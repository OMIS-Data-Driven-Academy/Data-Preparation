--
--  Same thing with verwaltungsquartier
--

select * from (
   select
      count(*),
      stadtkreis,
      verwaltungsquartier,
      count(*) over (partition by verwaltungsquartier) cnt_verwaltungsquartier
   from
      adressen_import
   group by
      stadtkreis,
      verwaltungsquartier
)
where
   cnt_verwaltungsquartier > 1;
