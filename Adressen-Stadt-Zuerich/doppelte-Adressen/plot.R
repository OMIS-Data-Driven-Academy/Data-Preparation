library(rgdal)
library(ROracle)

stzh_data_root  <- paste0(Sys.getenv('github_root'),  'data.stadt-zuerich.ch\\');
kt_zh_data_root <- paste0(Sys.getenv('github_root'),  'open-data.Kanton-Zuerich/')
stadtkreise     <- readOGR (paste0(stzh_data_root, 'dataset/stadtkreise'), 'Stadtkreis');

par(mar=c(0, 0, 0, 0))
plot(stadtkreise)

ora_drv <- dbDriver('Oracle');
ora_con <- dbConnect(ora_drv, 'st_zh', 'st_zh', dbname = 'ora18');
addr_double <- dbGetQuery(ora_con,
   'select
       to_number(easting_1 ) as x,
       to_number(northing_1) as y,
       adresse
    from
       stzh_doppelte_adressen');

coordinates(addr_double) <- ~X+Y;
addr_double@proj4string = stadtkreise@proj4string;
points(addr_double, col='red', pch=16, cex=0.3);

#
#  --  Show all addresses
#

addr_all <- dbGetQuery(ora_con,
   'select
       to_number(easting ) as x,
       to_number(northing) as y
    from
       stzh_adresse_import_cnt
    where
       rn_addr = 1');

coordinates(addr_all) <- ~X+Y;
addr_all@proj4string = stadtkreise@proj4string;

plot(stadtkreise);
points(addr_all   , col  =rgb(red = 0.1, blue = 0.5, green = 0.3, alpha = 0.3), pch=16, cex=0.1);
points(addr_double, col='red'                                                 , pch=16, cex=0.3);


#
#  What building is in the lake?
#
id_addr = identify(addr_double@coords, n = 1, plot = FALSE);
addr_double$ADRESSE[id_addr];


#
#  So, plot the lake of Zurich, too
#
kt_zh_WB_SEEN_F_stadt_zuerich <- readOGR(paste0(kt_zh_data_root, 'dataset/offentliche-oberflachengewasser/Stadt-Zuerich' ), 'WB_SEEN_F');

plot(kt_zh_WB_SEEN_F_stadt_zuerich,
   col = rgb(0.4, 0.7, 1),
   lwd = 0.1,
   add = TRUE
);

#
#  Zürich by night
#
par(bg='black');
plot(stadtkreise, col='black', border='#003300');
points(addr_all, col=rgb(red = 0.7 + runif(length(addr_all)) / 10*3, green = 0.5 + runif(length(addr_all)) / 10 *2, blue = 0.1, alpha = 0.2), pch=16, cex=0.1)

par(bg='white');
