--
-- set MYSQL_PWD=rene
-- "%programfiles%\MySQL\MySQL Server 8.0\bin\mysql.exe" --skip-column-names --show-warnings --local-infile -u rene kt_zh < import-data.sql
--

set session sql_mode = 'strict_trans_tables,no_engine_substitution,traditional';

select concat(now(), ': Loading arv_adressen_p');

load data local infile '../ARV_ADRESSEN_P-sorted.csv'
   into table arv_adressen_p
   fields terminated by ',' 
   optionally enclosed          by '"'
   lines terminated  by '\r\n'
   ignore 1 rows
(
   bfsnr            ,
   onrp             ,
   plz              ,
   zusatzziffern    ,
   ortschaftsname   ,
   kanton           ,
   strassenname     ,
   hausnummer       ,
-- geomy            ,
-- geomx            ,
   geomy            ,
   geomx            ,
   status           ,
   status_gp        ,
   parz_nr          ,
   gvz_nr           ,
  @gwr_egid         ,
   gwr_edid         ,
   gebaeudeart      ,
   quelle           ,
   e                ,
   n                
)
set
--   gwr_egid = case when @gwr_egid = '' or not then null else @gwr_egid end
     gwr_egid = case when not regexp_like(@gwr_egid, '^\\d+$') then null else @gwr_egid end
;

select concat('count(arv_adressen_p    ) = ', count(*)) from arv_adressen_p     having count(*) !=   297772;

create index arv_adressen_p_ix_gwr_edid on arv_adressen_p(gwr_egid);

