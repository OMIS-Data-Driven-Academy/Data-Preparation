select
   column_name,
   is_nullable,
   data_type,
   numeric_precision,
   numeric_precision_radix,
   numeric_scale,
   character_set_name,
   collation_name,
   character_maximum_length,
   character_octet_length
from
   information_schema.columns
where
   table_schema = 'dbo'           and
   table_name   = 'data_type_test'
order by
   ordinal_position;


select collationproperty('Croatian_CI_AI', 'codepage') as propertyValue;
--
-- 1250: Mittel- und osteuropäische Sprachen 
--

select collationproperty('SQL_Latin1_General_CP1_CI_AS', 'codepage') as propertyValue;
select collationproperty('SQL_Latin1_General_CP1_CI_AS', 'LCID'    ) as propertyValue;

select
   prop.nam + ': '                                             as propertyName,
   collationproperty('SQL_Latin1_General_CP1_CI_AS', prop.nam) as propertyValue
from
  ( values('codepage'       ),
          ('LCID'           ),
          ('ComparisonStyle'),
          ('Version'        )) as prop(nam);

