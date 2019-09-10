select * from (
   select
      count(*),
      stadtkreis,
      schulkreis,
      count(*) over (partition by schulkreis) cnt_schulkreis -- In how many stadtkreis is THIS schulkreis?
   from
      adressen_import
   group by
      stadtkreis,
      schulkreis
)
where
   cnt_schulkreis > 1;
--
-- The result suggests a 1:n relationship between schulkreis to stadtkreis.
--

select * from (
   select
      count(*),
      stadtkreis,
      schulkreis,
      count(*) over (partition by stadtkreis) cnt_stadtkreis -- In how many schulkreis is THIS stadtkreis.
   from
      adressen_import
   group by
      stadtkreis,
      schulkreis
)
where
   cnt_stadtkreis > 1;
