drop table if exists kita_schulkreis;

select
   distinct
   skname
into
   kita_schulkreis
from
   sd_zv_kitas_schulkreis
where
   skname not like 'Gesamte Stadt%';

select * from kita_schulkreis;

select
   ordinal_position,
   column_name,
   data_type,
   is_nullable
from
   information_schema.columns
where
   table_name    = 'kita_schulkreis' and
   table_catalog = 'st_zh'
;

--
-- Best practices…
--
alter table kita_schulkreis alter column skname varchar(50) not null;
alter table kita_schulkreis add primary key(skname);
