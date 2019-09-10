#
#  https://github.com/ReneNyffenegger/open-data.Kanton-Zuerich/blob/master/scripts/street-number-13/distribution.R
#
library(RMySQL)
library(tidyverse)

mySQL_kt_zh = dbConnect(MySQL(), user='rene', password='rene', dbname='kt_zh', host='localhost')

streetNumberCount <- dbGetQuery (mySQL_kt_zh, "
select
   count(*)       as Anzahl,
   hausnummer     as Hausnummer
from
   kt_zh.arv_adressen_p
group by
   hausnummer
having
   count(*) > 2800
");

streetNumberCount$Hausnummer <- as.numeric(streetNumberCount$Hausnummer);

ggplot(
    data = streetNumberCount,
    aes(Hausnummer, Anzahl)
  ) +
  geom_bar(stat='identity', fill='#ff9933') +
  geom_text(aes(label = Hausnummer, vjust= -1), size=2.5) +
  theme(axis.title.x=element_blank(),
        axis.text.x =element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank()
  );

