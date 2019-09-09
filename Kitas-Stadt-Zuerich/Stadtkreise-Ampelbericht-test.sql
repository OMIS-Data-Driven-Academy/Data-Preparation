--
-- Run in Studio!
--

begin transaction;

update
   dbo.sd_zv_kitas_schulkreis
set
   skname = 'Gesamte Stadt ohne Zürichberg'
where
   skname = 'Gesamte Stadt ohne Züriberg'
;

select * from schulkreis_ampel;
  
rollback;

select * from schulkreis_ampel;
