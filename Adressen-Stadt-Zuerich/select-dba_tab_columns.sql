select
   column_name    ,
   data_type      ,
-- density        ,
   num_nulls      ,
   num_buckets    ,
   last_analyzed  ,
   histogram      ,
   identity_column,
   sample_size   
from
   dba_tab_columns
where
   owner      = 'ST_ZH'             and
   table_name = 'ADRESSEN_IMPORT'
order by
   column_id;


begin
  dbms_stats.delete_table_stats(
    ownname => 'ST_ZH',
    tabname => 'ADRESSEN_IMPORT'
  );
end;
/
