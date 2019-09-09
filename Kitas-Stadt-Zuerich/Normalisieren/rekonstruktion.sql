--
-- Data to be reconstructed from normalized table:
--
select * from sd_zv_kitas_schulkreis


--
-- Proof of concept...
--
select
   j.jahr,
   s.skname,
   s.anz_bp_sk,
   s.anz_kinder_va,
   j.belegungsfaktor,
   round(anz_bp_sk / anz_kinder_va * belegungsfaktor, 4) versorgungsquote
from
   kita_jahr                j                     inner join
   kita_schulkreis_daten    s on j.jahr = s.jahr
;


--
-- Trying hierarchies
--
drop table if exists kita_schulkreis_hierarchy;
create table kita_schulkreis_hierarchy (
   skname        varchar(50) not null,
   sknameParent  varchar(50)     null,
   primary key (skname),
   foreign key (sknameParent) references kita_schulkreis_hierarchy
);

insert into kita_schulkreis_hierarchy values ('Gesamte Stadt'                ,  null          );
insert into kita_schulkreis_hierarchy values ('Gesamte Stadt ohne Zürichberg', 'Gesamte Stadt');
insert into kita_schulkreis_hierarchy values ('Zürichberg'                   , 'Gesamte Stadt');

insert into kita_schulkreis_hierarchy
select
   skname,
  'Gesamte Stadt ohne Zürichberg'
from
   kita_schulkreis
where
   skname <> 'Zürichberg';

select * from kita_schulkreis_hierarchy;

----------------------------

with r (jahr, skname, anz_bp_sk, anz_kinder_va) as (
  select
     j.jahr,
     s.skname                   ,
     s.anz_bp_sk     ,
     s.anz_kinder_va 
  from
     kita_jahr                 j                       inner join
     kita_schulkreis_daten     s on j.jahr   = s.jahr  inner join
     kita_schulkreis_hierarchy h on s.skname = h.skname
)
select * from r
;


drop table if exists kita_reconstructed;

with r (jahr, skname, anz_bp_sk, anz_kinder_va) as (
  select
     j.jahr,
     s.skname                   ,
     s.anz_bp_sk     ,
     s.anz_kinder_va 
  from
     kita_jahr                 j                       inner join
     kita_schulkreis_daten     s on j.jahr   = s.jahr
UNION ALL
   select
     r.jahr,
     h.sknameParent,
     r.anz_bp_sk    ,
     r.anz_kinder_va
  from
     r                                                       join
     kita_schulkreis_hierarchy h on r.skname = h.skname
)
select
   jahr,
   skname,
   sum(anz_bp_sk)     anz_bp_sk,
   sum(anz_kinder_va) anz_kinder_va
into
   kita_reconstructed
from
   r                               --- TODO: join with kita_schulkreis for versorgungsquote and calculation
where
   skname is not null
group by
   jahr,
   skname
;


select jahr, skname, anz_bp_sk, anz_kinder_va from kita_reconstructed      except
select jahr, skname, anz_bp_sk, anz_kinder_va from sd_zv_kitas_schulkreis;

select jahr, skname, anz_bp_sk, anz_kinder_va from sd_zv_kitas_schulkreis  except
select jahr, skname, anz_bp_sk, anz_kinder_va from kita_reconstructed;

--
--
--

select
   o.jahr,
   o.skname,
   case when o.anz_bp_sk     <> r.anz_bp_sk     then convert(varchar(15), o.anz_bp_sk    ) + ' <> ' + convert(varchar(15), r.anz_bp_sk    ) end diff_anz_bp_sk,
   case when o.anz_kinder_va <> r.anz_kinder_va then convert(varchar(15), o.anz_kinder_va) + ' <> ' + convert(varchar(15), r.anz_kinder_va) end diff_anz_kinder_va
from
   sd_zv_kitas_schulkreis o                                  /* left */ join
   kita_reconstructed     r on o.jahr        = r.jahr and
                               o.skname      = r.skname
where
   o.anz_bp_sk     <> r.anz_bp_sk      or
   o.anz_kinder_va <> r.anz_kinder_va
;


--
-- Es fehlen noch
--    - belegungsfaktor
--    - versorgungsquote
--

select
   o.jahr,
   o.skname,
   case when o.anz_bp_sk        <> r.anz_bp_sk                     then convert(varchar(15), o.anz_bp_sk      ) + ' <> ' + convert(varchar(15), r.anz_bp_sk      ) end diff_anz_bp_sk,
   case when o.anz_kinder_va    <> r.anz_kinder_va                 then convert(varchar(15), o.anz_kinder_va  ) + ' <> ' + convert(varchar(15), r.anz_kinder_va  ) end diff_anz_kinder_va,
-- ----
   case when o.belegungsfaktor  <> j.belegungsfaktor               then convert(varchar(15), o.belegungsfaktor) + ' <> ' + convert(varchar(15), j.belegungsfaktor) end diff_belegungsfaktor,
   case when o.versorgungsquote <> 
             round(r.anz_bp_sk / r.anz_kinder_va * j.belegungsfaktor, 4)
             then convert(varchar(15), o.versorgungsquote) + ' <> ' +
                  convert(varchar(15), round(r.anz_bp_sk / r.anz_kinder_va * j.belegungsfaktor, 4)) end diff_versorgungsquote
from
   sd_zv_kitas_schulkreis o                                  /* left */ join
   kita_reconstructed     r on o.jahr        = r.jahr and
                               o.skname      = r.skname                 join
   kita_jahr              j on r.jahr        = j.jahr
where
   o.anz_bp_sk        <> r.anz_bp_sk                  or
   o.anz_kinder_va    <> r.anz_kinder_va              or
   o.belegungsfaktor  <> j.belegungsfaktor            or
   o.versorgungsquote <> round(r.anz_bp_sk / r.anz_kinder_va * j.belegungsfaktor, 4)
;
