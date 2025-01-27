#mapping carajasia indiv in plots. 
#para relatorio nov 2024

packages<-c("dplyr", "tidyr", "reshape2", "tibble", "ggplot2", "maptools", "qgraph", "devtools", 
            "treespat", "SpatDiv", "spatstat", "dbmss")

# Install and load
for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }
  require(package, character.only = TRUE)
}

tt<-read.csv2(file = "Data/Carajasia_atual.csv")

str(tt)

tt<-tt%>%
  mutate(across(c(X, Y, alt, alt24, dia_x, dia_y, dia_x24, dia_y24), as.numeric),
         across(c(Plot, Col_data, Status_23, Status24, Status_combined), as.factor))

#num primeiro momento, nao vamos ver recrutamento e sim mortalidade plotado.

tt<-tt%>%
  filter( Status_23 %in% c("Immature", "Reprodutivo", "new"))
str(tt)

tt2<-  tt%>%
  filter( Status_23 %in% c("Immature", "Reprodutivo"))

#### Convert the points to a ppp object ####
points_plot1<-tt[tt$Plot%in%c('1'), ]
points_plot2<-tt2[tt2$Plot%in%c('2'), ]
points_plot3<-tt2[tt2$Plot%in%c('3'), ]
points_plot4<-tt[tt$Plot%in%c('4'), ]
points_plot5<-tt[tt$Plot%in%c('5'), ]

points_plot6<-tt[tt$Plot%in%c('6'), ]
points_plot7<-tt[tt$Plot%in%c('7'), ]
points_plot8<-tt[tt$Plot%in%c('8'), ]
points_plot9<-tt[tt$Plot%in%c('9'), ]
points_plot10<-tt[tt$Plot%in%c('10'), ]

#Plot de classes diametro p/ família
points.wmppp_plot1 <- wmppp(data.frame(X=points_plot1$X, Y=points_plot1$Y,
                                       PointType=points_plot1$Status_combined2,
                                       PointWeight= points_plot1$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT1<-autoplot(points.wmppp_plot1)

points.wmppp_plot2 <- wmppp(data.frame(X=points_plot2$X, Y=points_plot2$Y,
                                       PointType=points_plot2$Status_combined2,
                                       PointWeight= points_plot2$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT2<-autoplot(points.wmppp_plot2)


library("RColorBrewer")
display.brewer.all()

display.brewer.pal(n = 9, name = 'RdYlBu')
brewer.pal(n = 9, name = 'RdYlBu')

display.brewer.pal(n = 9, name = 'PuBu')
brewer.pal(n = 9, name = 'PuBu')


PLOT2 <- autoplot(points.wmppp_plot2) +
  scale_color_manual(values = c("R_dead" = "#FDAE61", "R_live" = "#D73027",
                                "I_dead" = "#ABD9E9", "I_live" = "#4575B4", 
                                "new" = "#41AB5D"))+
  theme_bw()

is.na(points_plot2$dia_x)

points.wmppp_plot3 <- wmppp(data.frame(X=points_plot3$X, Y=points_plot3$Y,
                                       PointType=points_plot3$Status_combined,
                                       PointWeight= points_plot3$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT3<-autoplot(points.wmppp_plot3) +
  scale_color_manual(values = c("R_dead" = "#FDAE61", "R_live" = "#D73027",
                                "I_dead" = "#ABD9E9", "I_live" = "#4575B4", 
                                "new" = "#41AB5D"))
