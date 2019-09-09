begin
  dbms_stats.gather_table_stats (
     ownname          => 'ST_ZH'          , -- VARCHAR2, 
     tabname          => 'ADRESSEN_IMPORT', -- VARCHAR2, 
     estimate_percent =>  null            , -- null
     method_opt       => 'FOR ALL COLUMNS SIZE 100'-- VARCHAR2 DEFAULT get_param('METHOD_OPT'),
  );
end;
/
