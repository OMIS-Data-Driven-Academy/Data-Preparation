select
   jahr,
   skname,
   anz_bp_sk,
   anz_kinder_va,
   belegungsfaktor,
   anz_bp_sk / anz_kinder_va * belegungsfaktor,
   versorgungsquote,
   convert(varchar(15), versorgungsquote)         versorgungsquote_char              --- convert to character
from
   sd_zv_kitas_schulkreis
where 
   round(anz_bp_sk / anz_kinder_va * belegungsfaktor, 4) <> versorgungsquote;


select
   jahr,
   skname,
   anz_bp_sk,
   anz_kinder_va,
   belegungsfaktor,
   anz_bp_sk / anz_kinder_va * belegungsfaktor,
   versorgungsquote,
   dbo.regexp_replace( -- https://renenyffenegger.ch/notes/development/databases/SQL-Server/T-SQL/functions/regexp/index
     convert(varchar(15), versorgungsquote),
     '\d*\.',
     ''
   ) nachkommastellen
from
   sd_zv_kitas_schulkreis
where 
   round(anz_bp_sk / anz_kinder_va * belegungsfaktor, 4) <> versorgungsquote;

-- TODO: len

select
   jahr,
   skname,
   anz_bp_sk,
   anz_kinder_va,
   belegungsfaktor,
   anz_bp_sk / anz_kinder_va * belegungsfaktor  versorgungsquote_calc,
   versorgungsquote
from
   sd_zv_kitas_schulkreis
where 
   round(
      anz_bp_sk / anz_kinder_va * belegungsfaktor,
      len(
         dbo.regexp_replace(convert(varchar(15),versorgungsquote),
         '\d*\.',
         '')
      )  -- Runden auf Nachkommastellen
   ) <> versorgungsquote;
