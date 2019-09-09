create view schulkreis_ampel as
select case when exists (
    select
       count(*)     as cnt_of_cnt,
       cnt,
       max(skname)  as skname
    from (
       select
          count(*)  as cnt,
          skname
       from
          dbo.sd_zv_kitas_schulkreis
       group by
          skname
    ) c
    group by
       cnt
    having
       count(*) = 1
) then
   'Du hast ein Datenproblem!'
else
   'Auf den ersten Blick scheinen die Daten ok.'
end as Datenqualitaet;

select * from schulkreis_ampel;
