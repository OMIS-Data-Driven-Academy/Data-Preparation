drop table if exists data_type_test;

create table data_type_test (
   ganzZahl              integer,
   text                  varchar (20) collate Croatian_CI_AI,
   internationaler_text  nvarchar(20),
   datum                 date,
   datum_mit_zeit        datetime 
);
