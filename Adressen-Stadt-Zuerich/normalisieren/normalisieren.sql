      --
      -- Finally: start normalizing data
      --

drop table adresse;
drop table statistische_zone;
drop table statistisches_quartier;
drop table verwaltungsquartier;
drop table stadtkreis;



create table st_zh.stadtkreis as
select distinct
    to_number(stadtkreis) nr
from
    adressen_import;

alter table st_zh.stadtkreis add constraint stadtkreis_pk primary key (nr);

select * from dba_tab_columns
where
   owner       = 'ST_ZH'      and
   table_name  = 'STADTKREIS'
;

---

create table st_zh.verwaltungsquartier as
select distinct
       verwaltungsquartier       name,
       to_number(stadtkreis)     stadtkreis
from
       adressen_import;

alter table st_zh.verwaltungsquartier
  add constraint verwaltungsquartier_pk
      primary key (name);

alter table st_zh.verwaltungsquartier
  add constraint verwaltungsquartier_fk_1
      foreign key (stadtkreis) references stadtkreis;

alter table st_zh.verwaltungsquartier
      modify stadtkreis not null;

select * from st_zh.verwaltungsquartier;

insert into st_zh.verwaltungsquartier (name, stadtkreis) values ('Uster', 13);
--
-- ORA-02291: integrity constraint (ST_ZH.VERWALTUNGSQUARTIER_FK_1) violated - parent key not found

----------------------------------------------


create table st_zh.statistisches_quartier as
select distinct
       cast(statistisches_quartier as varchar2(16))   name,
       verwaltungsquartier
from   adressen_import;

select *
from
   st_zh.statistisches_quartier
order by
   verwaltungsquartier;


alter table st_zh.statistisches_quartier
  add constraint statistisches_quartier_pk
      primary key (name);

alter table st_zh.statistisches_quartier
  add constraint statistisches_quartier_fk_1
      foreign key (verwaltungsquartier) references st_zh.verwaltungsquartier;

alter table st_zh.statistisches_quartier
      modify verwaltungsquartier not null;

-------------------------


create table st_zh.statistische_zone as
select distinct
    to_number(statistische_zone)                      nr,
    cast(statistisches_quartier as varchar2(16))      statistisches_quartier
from
    adressen_import;
       

select *
from
    st_zh.statistische_zone
order by
    statistisches_quartier,
    nr;


alter table st_zh.statistische_zone
  add constraint statistische_zone_pk
      primary key (nr);


alter table st_zh.statistische_zone
  add constraint statistische_zone_fk_1
      foreign key (statistisches_quartier) references statistisches_quartier;


alter table st_zh.statistische_zone
      modify statistisches_quartier not null;

--

select 
   max(length(lokalisationsname)) max_len_lokalisationsname,
   max(length(hausnummer       )) max_len_hausnummer
from
   adressen_import;

create table st_zh.adresse as
select distinct
       cast(lokalisationsname        as varchar2(30))  as strasse,
       cast(hausnummer               as varchar2( 5))  as hausnummer,
       to_number(statistische_zone)                    as statistische_zone
from
--     adressen_import;
       stzh_adresse_import_cnt where rn_addr = 1
;



select * from st_zh.adresse;


alter table st_zh.adresse
      add ( adresse as (strasse || ' ' || hausnummer));


alter table st_zh.adresse
  add constraint stzh_adresse_pk
      primary key (adresse);


alter table st_zh.adresse modify (
      strasse           not null,
      hausnummer        not null,
      statistische_zone not null
);


alter table st_zh.adresse
  add constraint adresse_fk
      foreign key (statistische_zone) references st_zh.statistische_zone;



select
   kr.nr        stadtkreis,
   vq.name      verwaltungsquartier,
   qu.name      statistisches_quartier,
   sz.nr        statistische_zone,
   ad.adresse   adresse
from
   st_zh.stadtkreis                 kr                                                     join
   st_zh.verwaltungsquartier        vq on kr.nr                = vq.stadtkreis             join
   st_zh.statistisches_quartier     qu on vq.name              = qu.verwaltungsquartier    join
   st_zh.statistische_zone          sz on qu.name              = sz.statistisches_quartier join
   st_zh.adresse                    ad on ad.statistische_zone = sz.nr
;

   
select
    kr.nr               stadtkreis,
    vq.name             verwaltungsquartier,
    qu.name             statistisches_quartier,
    sz.nr               statistische_zone,
    count(*)            cnt,
    --
    grouping(kr.nr)     gr_kreis,
    grouping(vq.name)   gr_verwaltungsquartier,
    grouping(qu.name)   gr_statistisches_quartier,
    grouping(sz.nr)     gr_statistische_zone,
    --
    grouping_id(kr.nr, vq.name, qu.name, sz.nr) gr_id
from
    st_zh.stadtkreis                 kr                                                     join
    st_zh.verwaltungsquartier        vq on kr.nr                = vq.stadtkreis             join
    st_zh.statistisches_quartier     qu on vq.name              = qu.verwaltungsquartier    join
    st_zh.statistische_zone          sz on qu.name              = sz.statistisches_quartier join
    st_zh.adresse                    ad on ad.statistische_zone = sz.nr
group by
rollup (
--  cube   (
     kr.nr   ,
     vq.name ,
     qu.name ,
     sz.nr
  )
----------------------------------------------
-- grouping sets (
--   (kr.nr, vq.name, qu.name, sz.nr),
--   (       vq.name                ),
--   ()                              
-- )
----------------------------------------------
-- having
--     grouping_id(kr.nr, vq.name, qu.name, sz.nr) > 0
--  --    grouping(kr.nr) + grouping(vq.name) + grouping(qu.name) +  grouping(sz.nr)    >= 1
----------------------------------------------
order by
   stadtkreis,
   verwaltungsquartier,
   statistisches_quartier,
   statistische_zone
;
