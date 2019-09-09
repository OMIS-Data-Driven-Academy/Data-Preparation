bulk insert dbo.sd_zv_kitas_schulkreis
   from 'c:\Users\OMIS.Rene\github\Academy\Data-Preparation\Kitas-Stadt-Zuerich\sd_zv_kitas_schulkreis.csv'
with (
   firstRow        =      2 ,
   lastRow         =    118 , -- Because last row is empty !
   codepage        = '65001', -- CSV is UTF8 encoded.
   format          = 'CSV'  ,
   fieldterminator = ','   
-- rowTerminator   = '0x0a',
-- DATAFILETYPE    = 'char'
);
go
