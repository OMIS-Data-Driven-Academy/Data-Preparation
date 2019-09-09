--                                (int   ,varchar   , nvarchar    ,  date       ,  datetime            );
insert into data_type_test values (  1,  'Hello'    ,  'Hello'    , '2019-04-05', '2019-04-05T16:31:15');
insert into data_type_test values (  2,  'Bye'      ,  'Bye'      , '2019-04-06', '2019-04-05T16:31:16');
insert into data_type_test values (  3,  'René'     ,  'René'     , '2019-04-07', '2019-04-05T16:31:17');
insert into data_type_test values (  4,  'René'     , N'René'     , '2019-04-08', '2019-04-05T16:31:18');
insert into data_type_test values (  5,  'nǐ hǎo'   ,  '你好'     , '2019-04-09', '2019-04-05T16:31:19');
insert into data_type_test values (  6,  'nǐ hǎo'   , N'你好'     , '2019-04-10', '2019-04-05T16:31:20');
insert into data_type_test values (  7, N'你好'     , N'你好'     , '2019-04-11', '2019-04-05T16:31:21');
insert into data_type_test values (  8,  'Doviđenja', N'Doviđenja', '2019-04-12', '2019-04-05T16:31:22'); -- Goodbye in croatian
insert into data_type_test values (  9, N'Doviđenja', N'Doviđenja', '2019-04-13', '2019-04-05T16:31:23'); 

select * from data_type_test;

