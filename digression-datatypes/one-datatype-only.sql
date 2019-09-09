--
-- Remember to switch two bytes in Unicode
--
select
   ganzZahl                                       ganzZahl, 
   cast(ganzZahl             as varbinary(20))    ganzZahl_hex,
   text                                           text,
   cast(text                 as varbinary(20))    text_hex,
   internationaler_text                           internationaler_text,
   cast(internationaler_text as varbinary(20))    internationaler_text_hex,
   datum                                          datum,
   cast(datum                as varbinary(20))    datum_hex,
   datum_mit_zeit                                 datum_mit_zeit,
   cast(datum_mit_zeit       as varbinary(20))    datum_mit_zeit_hex
from
   data_type_test;

select
   cast(0x48656C6C6F            as  varchar ) as hello,
   cast(0x480065006C006C006F00  as nvarchar ) as Nhello,
   cast(0x604F7D59              as nvarchar ) as ni_hao,
   cast(0x813F0B                as  date    ) as dt_2019_04_05,
   cast(0x0000AA2601104144      as  datetime) as dm_2019_04_05_16_31_15;

select
   cast(0x4134             as integer ) sixteen_thousand_and_something,
   cast(0x4134             as varchar ) A4,
   cast(0x41003400         as nvarchar) A4_unicode,
   cast(0x44412b           as date    ) april_8th_2019,
   cast(0x44412b           as varchar ) DA_plus,
   cast(0x604f7d59         as integer ) xxx,
   cast(0x604f7d59         as varchar ) hmmmm,
   cast(0x604f7d59         as nvarchar) ni_hao;

select
   cast(0x000000           as date     ) date_0,
   cast(0x010000           as date     ) date_1,
   cast(0x0000000000000000 as datetime ) datetime_0,
   cast(0x0000000000000001 as datetime ) datetime_1,
   cast(0x0000000000000002 as datetime ) datetime_2,
   cast(0x0000000000000003 as datetime ) datetime_3,
   cast(0x0000000000000004 as datetime ) datetime_4,
   cast(0x0000000000000005 as datetime ) datetime_5,
   cast(0x0000000000000006 as datetime ) datetime_6,
   cast(0x0000000000000007 as datetime ) datetime_7;


