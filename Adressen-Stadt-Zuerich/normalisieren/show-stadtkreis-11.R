# par(bg='white')

library(ROracle)
ora_drv <- dbDriver('Oracle');
ora_con <- dbConnect(ora_drv, 'st_zh', 'st_zh', dbname = 'ora18');

stadtkreis_11 <- subset(stadtkreise, knr == 11);
plot(stadtkreis_11);

addr_aff_aff <- dbGetQuery(ora_con, "select to_number(easting) as x, to_number(northing) as y from adressen_import where verwaltungsquartier = 'Affoltern' and statistisches_quartier = 'Affoltern'");
addr_see_aff <- dbGetQuery(ora_con, "select to_number(easting) as x, to_number(northing) as y from adressen_import where verwaltungsquartier = 'Seebach'   and statistisches_quartier = 'Affoltern'");
addr_see_see <- dbGetQuery(ora_con, "select to_number(easting) as x, to_number(northing) as y from adressen_import where verwaltungsquartier = 'Seebach'   and statistisches_quartier = 'Seebach'  ");
addr_oer_oer <- dbGetQuery(ora_con, "select to_number(easting) as x, to_number(northing) as y from adressen_import where verwaltungsquartier = 'Oerlikon'  and statistisches_quartier = 'Oerlikon' ");

coordinates(addr_aff_aff) <- ~X+Y;
coordinates(addr_see_aff) <- ~X+Y;
coordinates(addr_see_see) <- ~X+Y;
coordinates(addr_oer_oer) <- ~X+Y;

addr_aff_aff@proj4string = stadtkreise@proj4string;
addr_see_aff@proj4string = stadtkreise@proj4string;
addr_see_see@proj4string = stadtkreise@proj4string;
addr_oer_oer@proj4string = stadtkreise@proj4string;

points(addr_aff_aff, col='#0000ff', pch=16, cex=0.3)
points(addr_see_see, col='#00ff00', pch=16, cex=0.3)
points(addr_oer_oer, col='#000000', pch=16, cex=0.3)
points(addr_see_aff, col='#ff0000', pch=16, cex=0.3)

legend(
   'topleft',
    legend = c('Affoltern/Affoltern', 'Seebach/Seebach', 'Oerlikon/Oerlikon', 'Seebach/Affoltern'),
#   col    = c('#000000'            , '#00ff00'        , '#000000'          , '#ff0000'          ),
    fill   = c('#000000'            , '#00ff00'        , '#000000'          , '#ff0000'          )
);

