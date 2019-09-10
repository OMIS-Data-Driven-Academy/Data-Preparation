--
-- We need some theory.
--

create table some_numbers (
   num varchar2(20)
);

insert into some_numbers values (     '42'    );
insert into some_numbers values (     '42.9'  );
insert into some_numbers values (     '42,9'  );
insert into some_numbers values ( '123 456'   );
insert into some_numbers values ('123''456.18');

select
   num,
   case when validate_conversion(num as number                     ) = 1 then '✓' else '✗' end yes_no,
   case when validate_conversion(num as number, '999G999G999D99999') = 1 then '✓' else '✗' end yes_no_fmt
from
   some_numbers
;

--
-- nls_numeric_characters:
--   first character: decimal marker
--   first character: thousand marker
--
alter session set nls_numeric_characters = ', ' ;
alter session set nls_numeric_characters = '.,' ;
alter session set nls_numeric_characters = '.''';  -- .'  really.


select to_number('123 456'                                            ) num from dual;
select to_number('123 456', '999G999'                                 ) num from dual;
select to_number('123 456', '999G999', 'NLS_NUMERIC_CHARACTERS='', ''') num from dual;


drop table some_numbers purge;

create table some_dates (
   dt varchar2(20)
);

insert into some_dates values ('20180828'           );
insert into some_dates values ('28/08/2018'         );
insert into some_dates values ('08/28/2018'         );
insert into some_dates values ('2018-08-18'         );
insert into some_dates values ('28.08.2018'         );
insert into some_dates values ('2018.08.28'         );
insert into some_dates values ('2018-08-28 22:23:15');
insert into some_dates values ('28.8.2018'          );
insert into some_dates values ('28.8.18'            );

alter session set nls_date_format = 'mm/dd/yyyy';

select
   dt,
   case when validate_conversion(dt as date                     ) = 1 then '✓' else '✗' end yes_no,
   case when validate_conversion(dt as date, 'yyyymmdd'         ) = 1 then '✓' else '✗' end yes_no_ymt
from
   some_dates;

alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';

select to_date('28.8.18'   ) from dual;
select to_date('2018-08-18') from dual;
select to_date('28/08/2018') from dual;
