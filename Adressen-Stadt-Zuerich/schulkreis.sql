select
    count(*),
    schulkreis
from
    st_zh.adressen_import
group by
    schulkreis;
