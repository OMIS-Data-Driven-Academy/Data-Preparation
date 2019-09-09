--
-- How did the table look again???
--
select * from sd_zv_kitas_schulkreis;

--
-- versorgungsquote is redundant.
-- belegungsfaktor is in kita_jahr
--

drop table if exists kita_schulkreis_daten;

select
   jahr,
   skname,
   anz_bp_sk,
   anz_kinder_va
into
   kita_schulkreis_daten
from
   sd_zv_kitas_schulkreis
where
   skname not like 'Gesamte Stadt%';
  
select * from kita_schulkreis_daten;

--
-- Best practices:
--

--
-- I am way toooo lazy to type the sql statements, let
-- SQL generate them.
-- Fortunately, information_schema.columns already has this information.
--
select
   ordinal_position,
   column_name,
   data_type,
   character_maximum_length,
   is_nullable,
   -----------------------------------------------------------------
   --
   -- Assemble »alter table … alter column … … not null« statements.
   --
  'alter table '  + table_name  +
 ' alter column ' + column_name + ' ' + data_type +
   case when character_maximum_length is not null then '(' + str(character_maximum_length) + ')' else '' end +
 ' not null;'                                                                                                     stmt
   -----------------------------------------------------------------
from
   information_schema.columns
where
   table_name    = 'kita_schulkreis_daten' and
   table_catalog = 'st_zh'
;

alter table kita_schulkreis_daten add primary key(jahr, skname);
alter table kita_schulkreis_daten add foreign key(jahr) references kita_jahr;
--
-- insert into kita_schulkreis_daten values (4, 'x', 4, 4);
--
alter table kita_schulkreis_daten add foreign key(skname) references kita_schulkreis;



--
-- Show columns of constraints (here: primary key)
--
select
   con.constraint_type,
   col.column_name
from
   information_schema.table_constraints       con   join
   information_schema.constraint_column_usage col on con.table_name      = col.table_name      and
                                                     con.constraint_name = col.constraint_name
where
   con.table_name         = 'kita_schulkreis_daten' and
   con.constraint_catalog = 'st_zh';

