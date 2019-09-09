select *
from
   dba_tab_columns
where
   owner      = 'ST_ZH'   and
   table_name = 'ADRESSEN_IMPORT';



select
  'select'                         || chr(10) ||
  '  count(*) cnt,'                || chr(10) ||
  '  ' || listagg(
            col,
            ',  '                  || chr(10)
          )
          within group (
             order by column_id
          )                        || chr(10) ||
  'from ' ||
     table_name ||
  ';'
from (
   select
      'count('          || column_name || ') c' || column_name  || ',' || chr(10) ||
      'count(distinct ' || column_name || ') d' || column_name  as col,
       column_id,
       table_name
   from
      dba_tab_columns
   where
      owner        = 'ST_ZH'            and
      table_name   = 'ADRESSEN_IMPORT'
)
group by
   table_name
;

--
-- ~\github\temp\screen-Oracle-DB\tq84_tab_col_count.sql
--
select * from rene.tq84_tab_col_count where owner = 'ST_ZH' and table_name = 'ADRESSEN_IMPORT';
--
--  Adresse ist nicht distinct.
--  GWR_EGID ist nicht distinct;
--
