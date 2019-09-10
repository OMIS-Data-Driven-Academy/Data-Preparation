library(rgdal  )
library(ROracle)

stzh_data_root  <- paste0(Sys.getenv('github_root'),  'data.stadt-zuerich.ch\\');
stadtkreise     <- readOGR (paste0(stzh_data_root, 'dataset/stadtkreise'), 'Stadtkreis');


par(mar=c(0, 0, 0, 0))
plot(stadtkreise);


ora_drv <- dbDriver('Oracle')
ora_con <- dbConnect(ora_drv, 'st_zh', 'st_zh', dbname = 'ora18')


addr_strasse   <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%strasse'
    )
   ");
coordinates(addr_strasse  ) <- ~X+Y
addr_strasse  @proj4string = stadtkreise@proj4string
points(addr_strasse , col='#777777', pch=16, cex=0.1)


addr_weg <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%weg'
    )
   ");
coordinates(addr_weg) <- ~X+Y
addr_weg@proj4string = stadtkreise@proj4string
points(addr_weg, col='#ff9933', pch=16, cex=0.3)



addr_gasse <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%gasse'     or
       lower(lokalisationsname) like '%gässchen'  or
       lower(lokalisationsname) like '%gässli'    or
       lower(lokalisationsname) like '%gassen'   
    )
   ");
coordinates(addr_gasse) <- ~X+Y
addr_gasse@proj4string = stadtkreise@proj4string
points(addr_gasse, col='#c3a483', pch=16, cex=0.3)



addr_acker <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%acher'     or
       lower(lokalisationsname) like '%acker'     or
       lower(lokalisationsname) like '%äcker'     or
       lower(lokalisationsname) like '%feld'    
    )
   ");
coordinates(addr_acker) <- ~X+Y
addr_acker@proj4string = stadtkreise@proj4string
points(addr_acker, col='#804000', pch=16, cex=0.3)

addr_wiese <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%wiese'     or
       lower(lokalisationsname) like '%wiesen' 
    )
   ");
coordinates(addr_wiese) <- ~X+Y
addr_wiese@proj4string = stadtkreise@proj4string
points(addr_wiese, col='#009933', pch=16, cex=0.3)


addr_bruecke <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%quai'   or
       lower(lokalisationsname) like '%brücke' or
       lower(lokalisationsname) like '%steg'
    )
   ");
coordinates(addr_bruecke) <- ~X+Y
addr_bruecke@proj4string = stadtkreise@proj4string
points(addr_bruecke, col='#4d4dff', pch=16, cex=0.3)

addr_promenade <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%promenade' or
       lower(lokalisationsname) like '%allee'
    )
   ");
coordinates(addr_promenade) <- ~X+Y
addr_promenade@proj4string = stadtkreise@proj4string
points(addr_promenade, col='#ff00ff', pch=16, cex=0.3)

addr_ried <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like '%ried'
    )
   ");
coordinates(addr_ried) <- ~X+Y
addr_ried@proj4string = stadtkreise@proj4string
points(addr_ried, col='#99ffcc', pch=16, cex=0.3)


addr_badenerstrasse <- dbGetQuery(ora_con,
   "select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1 and (
       lower(lokalisationsname) like 'badenerstrasse'
    )
   ");
coordinates(addr_badenerstrasse) <- ~X+Y
addr_badenerstrasse@proj4string = stadtkreise@proj4string
points(addr_badenerstrasse, col='#000000', pch=16, cex=0.5)
