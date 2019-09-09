library(ggplot2)

ggplot(
    res,
    aes(x = jahr,
        y = anz_bp_sk)
) + 
geom_line(aes(colour = skname))
