select * from arv_adressen_p limit 100;


--
-- We need to have a NUMERIC hausnummer in order to be able to sort it.
-- Thus, we need to remove the letters from the hausnummer:
--


drop table if exists hausnummern;

create table hausnummern as
select
   plz,
   ortschaftsname,
   strassenname,
   hausnummer,
   cast(regexp_replace(hausnummer, '[a-z]', '') as decimal(5,1)) hausnummer_
from
   arv_adressen_p;

select * from hausnummern limit 100;

select * from (
   select
      a.plz,
      a.ortschaftsname,
      a.strassenname,
      lag ( hausnummer, 7) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_7,
      lag ( hausnummer, 6) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_6,
      lag ( hausnummer, 5) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_5,
      lag ( hausnummer, 4) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_4,
      lag ( hausnummer, 3) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_3,
      lag ( hausnummer, 2) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_2,
      lag ( hausnummer, 1) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lag_1,
          a.hausnummer,
      lead( hausnummer, 1) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_1,
      lead( hausnummer, 2) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_2,
      lead( hausnummer, 3) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_3,
      lead( hausnummer, 4) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_4,
      lead( hausnummer, 5) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_5,
      lead( hausnummer, 6) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_6,
      lead( hausnummer, 7) over (partition by ortschaftsname, strassenname order by hausnummer_ ) lead_7
   from
      hausnummern a
) s
where
   s.hausnummer =  14   and
   s.lag_1      = '12'
-- s.lag_1_     < '13'  and
-- s.lead_1_    > '13'
;


drop table if exists hausnummern_rn;

create table hausnummern_rn as
select
   row_number() over (partition by ortschaftsname, strassenname order by hausnummer_, hausnummer) rn,
   plz           ,
   ortschaftsname,
   strassenname  ,
   hausnummer    ,
   hausnummer_
from
   hausnummern;


select *
from
   hausnummern_rn
where
   strassenname   = 'Bankstrasse' and
   ortschaftsname = 'Uster'
order by
   rn;

-- MySQL does not understand...
select
   max(plz           ) keep (dense_rank first order by rn desc),
   max(ortschaftsname) keep (dense_rank first order by rn desc),
   max(strassenname  ) keep (dense_rank first order by rn desc),
   max(hausnummer_   ) keep (dense_rank first order by rn desc)
from
   hausnummern_rn;

--
-- Which street with most addresses?
--
select * from hausnummern_rn where rn = (select max(rn) from hausnummern_rn);


--
-- Show hausnummern of längste Strasse
--
select * from hausnummern_rn
where
   (strassenname, ortschaftsname) = (
      select
         strassenname, ortschaftsname
      from 
         hausnummern_rn
      where
         rn = (select max(rn) from hausnummern_rn)
    )
order by
  rn;


drop table if exists strassen_ohne_13;

create table strassen_ohne_13 as
select
   s.plz,
   s.ortschaftsname,
   s.strassenname,
   s.hausnummer,
   s.rn_lt_13,
   s.rn_gt_13,
   s.hausnummer_,
   s.rn
from (
   select
       h.*,
       max(case when hausnummer  = '13' then rn else null end) over (partition by ortschaftsname, strassenname) rn_eq_13,
       max(case when hausnummer_ <  13  then rn else null end) over (partition by ortschaftsname, strassenname) rn_lt_13,
       min(case when hausnummer_ >  13  then rn else null end) over (partition by ortschaftsname, strassenname) rn_gt_13
   from
       hausnummern_rn h
-- where
--    strassenname   = 'Bankstrasse' and
--    ortschaftsname = 'Uster'
--    ortschaftsname = 'Rorbas' and
--    strassenname   = 'Allmendstrasse'
-- order by
--    rn
) s
where
  s.rn_eq_13 is     null  and
  s.rn_lt_13 is not null  and
  s.rn_gt_13 is not null
order by
   ortschaftsname,
   strassenname,
   hausnummer_
;   


select *
from
   strassen_ohne_13
where
-- strassenname   = 'Bankstrasse' and
-- ortschaftsname = 'Uster'
   ortschaftsname = 'Rorbas' and
   strassenname   = 'Allmendstrasse'
;
    


drop table if exists strassen_ohne_13_pivot;

create table strassen_ohne_13_pivot
as
    select
       min(plz) plz,
       ortschaftsname,
       strassenname,
       max(case when a.rn_lt_13 = rn + 6 then hausnummer end) lt_7,
       max(case when a.rn_lt_13 = rn + 5 then hausnummer end) lt_6,
       max(case when a.rn_lt_13 = rn + 4 then hausnummer end) lt_5,
       max(case when a.rn_lt_13 = rn + 3 then hausnummer end) lt_4,
       max(case when a.rn_lt_13 = rn + 2 then hausnummer end) lt_3,
       max(case when a.rn_lt_13 = rn + 1 then hausnummer end) lt_2,
       max(case when a.rn_lt_13 = rn + 0 then hausnummer end) lt_1,
       --
       max(case when rn > 0 then case when a.rn_gt_13 = rn - 0 then hausnummer end end) gt_1,
       max(case when rn > 1 then case when a.rn_gt_13 = rn - 1 then hausnummer end end) gt_2,
       max(case when rn > 2 then case when a.rn_gt_13 = rn - 2 then hausnummer end end) gt_3,
       max(case when rn > 3 then case when a.rn_gt_13 = rn - 3 then hausnummer end end) gt_4,
       max(case when rn > 4 then case when a.rn_gt_13 = rn - 4 then hausnummer end end) gt_5,
       max(case when rn > 5 then case when a.rn_gt_13 = rn - 5 then hausnummer end end) gt_6,
       max(case when rn > 6 then case when a.rn_gt_13 = rn - 6 then hausnummer end end) gt_7
    from
       strassen_ohne_13 a
    group by
       ortschaftsname,
       strassenname
;

select * from strassen_ohne_13_pivot
where
   ortschaftsname = 'Rorbas' and
   strassenname   = 'Allmendstrasse'
;


drop table if exists strassen_ohne_13_cnt;

create table strassen_ohne_13_cnt as
select
   count(*) cnt,
   lt_7,
   lt_6,
   lt_5,
   lt_4,
   lt_3,
   lt_2,
   lt_1,
   --
   gt_1,
   gt_2,
   gt_3,
   gt_4,
   gt_5,
   gt_6,
   gt_7
from
   strassen_ohne_13_pivot
where
  lt_2  = '11' and lt_1  = '12' and
  gt_1  = '14' and gt_2  = '15'
group by
   lt_7,
   lt_6,
   lt_5,
   lt_4,
   lt_3,
   lt_2,
   lt_1,
   --
   gt_1,
   gt_2,
   gt_3,
   gt_4,
   gt_5,
   gt_6,
   gt_7
 ;

select * from strassen_ohne_13_cnt order by cnt desc;

