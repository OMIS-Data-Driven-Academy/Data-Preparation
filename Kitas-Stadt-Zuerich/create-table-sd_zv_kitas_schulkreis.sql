use st_zh;
go

create table dbo.sd_zv_kitas_schulkreis (
   jahr             integer     ,
   skname           varchar( 50),
   anz_bp_sk        float,
   anz_kinder_va    float,
   belegungsfaktor  float,
   versorgungsquote float
);
go
