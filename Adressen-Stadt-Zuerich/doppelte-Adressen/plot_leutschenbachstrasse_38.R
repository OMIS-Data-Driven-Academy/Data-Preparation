#
#  Leutschenbachstrasse 38
#

library(OpenStreetMap);
library(rgdal)

lat_upper_left  = 47.416; # 47.417;
lon_upper_left  =  8.552; # 8.550;
lat_lower_right = 47.414; # 47.413;
lon_lower_right =  8.556;

dev.off();
dev.new();

map_osm  <- openmap(
               c(lat_upper_left , lon_upper_left ),
               c(lat_lower_right, lon_lower_right),
               type = 'osm'
);
plot(map_osm );

coord_verification <- data.frame (
   lat = c(lat_upper_left, lat_lower_right),
   lon = c(lon_upper_left, lon_lower_right) 
#  lat = c(lon_upper_left, lon_lower_right), # Longitues, really
#  lon = c(lat_upper_left, lat_lower_right)  # Latitudes, really
#  lat = c(lon_upper_left),
#  lon = c(lat_upper_left)
);

  coordinates(coord_verification) <- ~lon+lat;
# coordinates(coord_verification) <- ~lat+lon

proj4string(coord_verification) <- CRS("+init=epsg:4326")
points(spTransform(coord_verification,osm()), col='blue', pch=19, cex=5)

# -------- Open Street map

coords <- data.frame (
   lon = c( 8.55336768885581, 8.55464266203301),
   lat = c(47.4147105656297 , 47.4154560068639)
#  lat = c( 8.55336768885581, 8.55464266203301),  # Longitudes, really
#  lon = c(47.4147105656297 , 47.4154560068639)   # Latitudes, really
);
  coordinates(coords) <- ~lon+lat;
# coordinates(coords) <- ~lat+lon
proj4string(coords)<-CRS("+init=epsg:4326");
points(spTransform(coords, osm()), col='red', pch=19, cex=5)

# -------- Bing map

map_bing <- openmap(
               c(lat_upper_left , lon_upper_left ),
               c(lat_lower_right, lon_lower_right),
               type = 'bing'
);
plot(map_bing );

points(spTransform(coords, osm()), col='red', pch=19, cex=5)

# -------- Stamen map (watercolor)

map_stamen_watercolor <- openmap(
               c(lat_upper_left , lon_upper_left ),
               c(lat_lower_right, lon_lower_right),
               type = 'stamen-watercolor'
);
plot(map_stamen_watercolor );

points(spTransform(coords, osm()), col='#e98332', pch=19, cex=5);
