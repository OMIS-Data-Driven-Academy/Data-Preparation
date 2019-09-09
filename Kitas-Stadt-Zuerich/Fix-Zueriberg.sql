update
   dbo.sd_zv_kitas_schulkreis
set
   skname = 'Gesamte Stadt ohne Zürichberg'
where
   skname = 'Gesamte Stadt ohne Züriberg'
;

select * from schulkreis_ampel;
