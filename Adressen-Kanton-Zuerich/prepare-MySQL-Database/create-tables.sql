drop table if exists arv_adressen_p;

create table arv_adressen_p (
   bfsnr             integer            not null,
   onrp              varchar( 10)           null,
   plz               integer            not null,
   zusatzziffern     varchar(  2)       not null,
   ortschaftsname    varchar( 50)       not null,
   kanton            varchar( 50)           null,
   strassenname      varchar(100)       not null,
   hausnummer        varchar( 10)       not null, -- Hausnummer can also be empty (null in Oracle)
-- geomy             decimal(10, 3)     not null,
-- geomx             decimal(10, 3)     not null,
   geomy             double             not null,
   geomx             double             not null,
   status            varchar(10)            null,
   status_gp         varchar(100)           null,
   parz_nr           varchar(100)           null,
   gvz_nr            varchar(100)           null,
   gwr_egid          integer                null,
   gwr_edid          varchar(100)           null,
   gebaeudeart       varchar(100)           null,
   quelle            varchar(100)           null,
   e                 varchar(100)           null,
   n                 varchar(100)           null
-- e                 decimal(10, 3)     not null,
-- n                 decimal(10, 3)     not null
);
