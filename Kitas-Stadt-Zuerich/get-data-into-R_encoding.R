library(odbc)

#
#  https://stackoverflow.com/questions/56427447/encoding-problem-latin-1-utf-8-with-libraryodbc
#
st_zh <- dbConnect(odbc(),
               driver   ='SQL Server'               ,
               server   = Sys.getenv("COMPUTERNAME"),
               database ='st_zh'                    ,
#              encoding ='iso-8859-1'
#              encoding ='UTF-8'
#              encoding ='UTF-16'
);

st_zh;

res <- dbGetQuery(st_zh, "select * from sd_zv_kitas_schulkreis")
res;
res$skname;
unique(res$skname);

Encoding(res$skname) <- 'latin-1';
unique(res$skname);

Encoding(res$skname) <- 'UTF-8'
unique(res$skname);

res_stadtkreise_zuerich <- dbGetQuery(st_zh,"
   select distinct
      skname
   from
      sd_zv_kitas_schulkreis
   where
      skname like '%Zürich%'
      ");
res_stadtkreise_zuerich

st_zh <- dbConnect(odbc(),
               driver   ='SQL Server'               ,
               server   = Sys.getenv("COMPUTERNAME"),
               database ='st_zh'                    ,
               encoding ='iso-8859-1'   # # # Better...
#              encoding ='UTF-8'
#              encoding ='UTF-16'
);
