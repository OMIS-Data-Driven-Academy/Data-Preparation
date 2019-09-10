select
   count(*),
   lokalisationsname
from
   adressen_import
where
   lower(lokalisationsname) not like '%strasse'   and
   lower(lokalisationsname) not like '%weg'       and
   lower(lokalisationsname) not like '%quai'      and
   lower(lokalisationsname) not like '%brücke'    and
   lower(lokalisationsname) not like '%gasse'     and
   lower(lokalisationsname) not like '%gasse'     and
   lower(lokalisationsname) not like '%gassen'    and    
   lower(lokalisationsname) not like '%gässli'    and    
   lower(lokalisationsname) not like '%gässchen'  and    
   lower(lokalisationsname) not like '%ring'      and
   lower(lokalisationsname) not like '%steg'      and
   lower(lokalisationsname) not like '%lände'     and
   lower(lokalisationsname) not like '%acher'     and
   lower(lokalisationsname) not like '%acker'     and
   lower(lokalisationsname) not like '%feld'      and    
   lower(lokalisationsname) not like '%äcker'     and
   lower(lokalisationsname) not like '%hof'       and    
   lower(lokalisationsname) not like '%rain'      and    
   lower(lokalisationsname) not like '%berg'      and    
   lower(lokalisationsname) not like '%ried'      and    
   lower(lokalisationsname) not like '%weid'      and    
   lower(lokalisationsname) not like '%promenade' and    
   lower(lokalisationsname) not like '%allee'     and    
   lower(lokalisationsname) not like '%markt'     and    
   lower(lokalisationsname) not like '%platz'     and    
   lower(lokalisationsname) not like '%halde'     and    
   lower(lokalisationsname) not like '%wiese'     and    
   lower(lokalisationsname) not like '%wiesen'    and    
   lower(lokalisationsname) not like '%matt'      and    
   lower(lokalisationsname) not like '%statt'     and    
   lower(lokalisationsname) not like '%holz'      and    
   lower(lokalisationsname) not like '%steig'     and    
   lower(lokalisationsname) not like '%graben'    and    
   lower(lokalisationsname) not like '%garten'    and    
   lower(lokalisationsname) not like '%wies'      and    
   lower(lokalisationsname) not like '%zelg'      and  
   lower(lokalisationsname) not like 'am %'       and
   lower(lokalisationsname) not like 'im %'       and
   lower(lokalisationsname) not like 'an der %'   and
   lower(lokalisationsname) not like 'in der %'
group by
   lokalisationsname
order by
   reverse(lokalisationsname)
