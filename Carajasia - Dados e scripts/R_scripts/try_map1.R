# nov 2024: tentativa de mapear. espacializar o recrutamento 
# do ciclo 23-24

library(dplyr)

library(ggplot2)
library(gridExtra)
library(ggpubr)

cc<-read.csv2(file = "Data/C_map.csv")
str(cc)

# Specify the column indices you want to transform
cols_to_convert <- c(4:5, 7:8, 12:21)

# Apply as.numeric to the selected columns
cc[ , cols_to_convert] <- lapply(cc[ , cols_to_convert], as.numeric)

cc$Col_data<-as.factor(cc$Col_data)
cc$status<-as.factor(cc$status)
cc$TAG<-as.factor(cc$TAG)
cc$Q_Yellow<-as.factor(cc$Q_Yellow)
cc$Plot<-as.factor(cc$Plot)

reprod23<-cc%>%
  filter(dia_x>40| dia_y>40)%>%
  filter(status=="Reprodutivo")

write.table(reprod23, "./Data/reprod23.csv", row.names=F, sep=",", dec=".")

new_recruits24<-read.csv2(file = "Data/new_24.csv")
str(new_recruits24)

cols_to_convert <- c(3:4, 6:7, 11:21)
new_recruits24[ , cols_to_convert] <- lapply(new_recruits24[ , cols_to_convert], as.numeric)

new_recruits24$status<-as.factor(new_recruits24$status)
new_recruits24$Status24<-as.factor(new_recruits24$Status24)
new_recruits24$Col_data<-as.factor(new_recruits24$Col_data)
new_recruits24$Plot<-as.factor(new_recruits24$Plot)

#a planilha q tem os 2 ...

tt<-read.csv2(file = "Data/all_try2.csv")
str(tt)

cols_to_convert <- c(3:4, 6:7, 11:19)
tt[ , cols_to_convert] <- lapply(tt[ , cols_to_convert], as.numeric)

tt$status<-as.factor(tt$status)
tt$status24<-as.factor(tt$status_24)
tt$Col_data<-as.factor(tt$Col_data)
tt$Plot<-as.factor(tt$Plot)

tt<-tt%>%
  filter(Plot%in% c("1", "2", "3", "4", "5"))


ggplot(tt, aes(x = X_q, y = Y_q, color = status, group=status, fill=status)) +
  geom_point(size = 3, alpha = 0.7) +  # Adjust point size and transparency as needed
  facet_wrap(~ Plot) +              # Separate by plot


  ggplot(tt, aes(x = X_q, y = Y_q, color = status, fill = status, size = dia_x)) +
  geom_point(alpha = 0.7) +  # Alpha adjusts point transparency
  facet_wrap(~ Plot) +
  scale_size_continuous(range = c(1, 6)) +  # Adjust the range for point size as needed
  labs(size = "dia_x") +
  theme_minimal()

ggplot(tt, aes(x = X_q, y = Y_q)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = 0.4) +  # Density fill
  geom_point(aes(color = status, size = dia_x), alpha = 0.7) +          # Point size by diameter
  scale_size_continuous(range = c(1, 5)) +                                 # Adjust point size range
  scale_fill_viridis_c() +                                                 # Adjust color palette for density
  facet_wrap(~ Plot) +
  labs(size = "dia_x", fill = "Density") +
  theme_minimal()

#### Convert the points to a ppp object ####
points_plot1<-tt[tt$Plot%in%c('1'), ]
points_plot2<-tt[tt$Plot%in%c('2'), ]
points_plot3<-tt[tt$Plot%in%c('3'), ]
points_plot4<-tt[tt$Plot%in%c('4'), ]
points_plot5<-tt[tt$Plot%in%c('5'), ]

points_plot6<-dataset[dataset$Plot%in%c('6'), ]
points_plot7<-dataset[dataset$Plot%in%c('7'), ]
points_plot8<-dataset[dataset$Plot%in%c('8'), ]
points_plot9<-dataset[dataset$Plot%in%c('9'), ]
points_plot10<-dataset[dataset$Plot%in%c('10'), ]

#Plot de classes diametro p/ família
points.wmppp_plot1 <- wmppp(data.frame(X=points_plot1$X, Y=points_plot1$Y,
                                       PointType=points_plot1$status,
                                       PointWeight= points_plot1$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT1<-autoplot(points.wmppp_plot1)

points.wmppp_plot2 <- wmppp(data.frame(X=points_plot2$X, Y=points_plot2$Y,
                                       PointType=points_plot2$status,
                                       PointWeight= points_plot2$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT2<-autoplot(points.wmppp_plot2)
  

points.wmppp_plot3 <- wmppp(data.frame(X=points_plot3$X, Y=points_plot3$Y,
                                       PointType=points_plot3$status,
                                       PointWeight= points_plot3$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT3<-autoplot(points.wmppp_plot3)

points.wmppp_plot4 <- wmppp(data.frame(X=points_plot4$X, Y=points_plot4$Y,
                                       PointType=points_plot4$status,
                                       PointWeight= points_plot4$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT4<-autoplot(points.wmppp_plot4)

points.wmppp_plot5 <- wmppp(data.frame(X=points_plot5$X, Y=points_plot5$Y,
                                       PointType=points_plot5$status,
                                       PointWeight= points_plot5$dia_x),
                            window=owin(c(0,100),c(0,100)))

PLOT4<-autoplot(points.wmppp_plot5)