--
-- Table is created, but constraints are missing.
--

select
   ordinal_position,
   column_name,
   data_type,
   is_nullable
from
   information_schema.columns
where
   table_name    = 'kita_jahr' and
   table_catalog = 'st_zh'
;

select
   constraint_type,
   constraint_name
from
   information_schema.table_constraints
where
   table_name         = 'kita_jahr' and
   constraint_catalog = 'st_zh';

   


alter table kita_jahr alter column jahr integer not null;
alter table kita_jahr add primary key(jahr);

alter table kita_jahr alter column belegungsfaktor float not null;


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
   con.table_name         = 'kita_jahr' and
   con.constraint_catalog = 'st_zh';
