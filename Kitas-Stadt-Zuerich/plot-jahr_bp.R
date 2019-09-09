with (

  res[res$skname == 'Gesamte Stadt', ],

  plot(
    jahr                     ,
    anz_bp_sk                ,
    type      = 'l'          ,
    lwd       =  3           ,
    col       = '#3344cc'    , # 'green',
    xlab      = 'Jahr'       ,
    ylab      = 'Anzahl Betreuungsplätze / Schulkreis'
  )

);
