###### --------------------------------------------------###
########-------------Spatial analisys--------------#######

##################### --SETS--  #####################
rm(list=ls())  
setwd('C:/Users/users/OneDrive/ACADEMIA/POS-DOCS - Geral/ITV - Pará/Projeto - Demo/Dados/2023/Abril')
set.seed(2023)

####-------------------------PACKAGES------------------------- ##########
packages<-c("dplyr", "tidyr", "reshape2", "tibble", "ggplot2", "maptools", "qgraph", "devtools", 
  "treespat", "SpatDiv", "spatstat", "dbmss")

# Install and load
for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }
  require(package, character.only = TRUE)
}

####Dados gerais####
dataset<-read.csv2("Data/Carajasia_04_2023.csv", stringsAsFactors = FALSE, dec='.')
str(dataset)
dataset$status<-as.factor(dataset$status)

cols_to_convert <- c(4:5, 7:8, 11:18)
dataset[ , cols_to_convert] <- lapply(dataset[ , cols_to_convert], as.numeric)
##Functions##
source('multiplot.R')

#### Convert the points to a ppp object ####
points_plot1<-dataset[dataset$Plot%in%c('1'), ]
points_plot2<-dataset[dataset$Plot%in%c('2'), ]
points_plot3<-dataset[dataset$Plot%in%c('3'), ]
points_plot4<-dataset[dataset$Plot%in%c('4'), ]
points_plot5<-dataset[dataset$Plot%in%c('5'), ]

points_plot6<-dataset[dataset$Plot%in%c('6'), ]
points_plot7<-dataset[dataset$Plot%in%c('7'), ]
points_plot8<-dataset[dataset$Plot%in%c('8'), ]
points_plot9<-dataset[dataset$Plot%in%c('9'), ]
points_plot10<-dataset[dataset$Plot%in%c('10'), ]



#Plot1:####
####Análises espaciais###
points.ppp_plot1 <- ppp(points_plot1$X, points_plot1$Y,
                       window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot1)
plot(points.ppp_plot1)

#nearest neighbour
near_plot1<-nndist(points.ppp_plot1)
summary(near_plot1)

m_plot1 <- nnwhich(points.ppp_plot1)
m2_plot1 <- nnwhich(points.ppp_plot1, k=2)

#Plot nearest neighbour links
b_plot1 <- points.ppp_plot1[m_plot1]
plot(points.ppp_plot1)
arrows(points.ppp_plot1$x, points.ppp_plot1$y, 
       b_plot1$x, b_plot1$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot1, 5), main = "Plot1")

contour(density(points.ppp_plot1,5), axes=FALSE)

#Plot de classes diametro p/ família
points.wmppp_plot1 <- wmppp(data.frame(X=points_plot1$X, Y=points_plot1$Y,
                                      PointType=points_plot1$status,
                                      PointWeight= points_plot1$diam),
                           window=owin(c(0,100),c(0,100)))

PLOT1<-autoplot(points.wmppp_plot1)

#Plot2:####

####Análises espaciais###
points.ppp_plot2 <- ppp(points_plot2$X, points_plot2$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot2)
plot(points.ppp_plot2)

#nearest neighbour
near_plot2<-nndist(points.ppp_plot2)
summary(near_plot2)

m_plot2 <- nnwhich(points.ppp_plot2)
m2_plot2 <- nnwhich(points.ppp_plot2, k=2)

#Plot nearest neighbour links
b_plot2 <- points.ppp_plot2[m_plot2]
plot(points.ppp_plot2)
arrows(points.ppp_plot2$x, points.ppp_plot2$y, 
       b_plot2$x, b_plot2$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot2, 5), main = 'Plot2')

contour(density(points.ppp_plot2,5), axes=FALSE)

#Plot de classes diametro p/ família
points.wmppp_plot2 <- wmppp(data.frame(X=points_plot2$X, Y=points_plot2$Y,
                                       PointType=points_plot2$status,
                                       PointWeight= points_plot2$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT2<-autoplot(points.wmppp_plot2)

#Plot3:####

####Análises espaciais###
points.ppp_plot3 <- ppp(points_plot3$X, points_plot3$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot3)
plot(points.ppp_plot3)

#nearest neighbour
near_plot3<-nndist(points.ppp_plot3)
summary(near_plot3)

m_plot3 <- nnwhich(points.ppp_plot3)
m2_plot3 <- nnwhich(points.ppp_plot3, k=2)

#Plot nearest neighbour links
b_plot3 <- points.ppp_plot3[m_plot3]
plot(points.ppp_plot3)
arrows(points.ppp_plot3$x, points.ppp_plot3$y, 
       b_plot3$x, b_plot3$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot3, 5))

contour(density(points.ppp_plot3,5), axes=FALSE)

#Plot de classes diametro p/ família
points.wmppp_plot3 <- wmppp(data.frame(X=points_plot3$X, Y=points_plot3$Y,
                                       PointType=points_plot3$status3,
                                       PointWeight= points_plot3$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT3<-autoplot(points.wmppp_plot3)


#Plot4:####

####Análises espaciais###
points.ppp_plot4 <- ppp(points_plot4$X, points_plot4$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot4)
plot(points.ppp_plot4)

#nearest neighbour
near_plot4<-nndist(points.ppp_plot4)
summary(near_plot4)

m_plot4 <- nnwhich(points.ppp_plot4)
m2_plot4 <- nnwhich(points.ppp_plot4, k=2)

#Plot nearest neighbour links
b_plot4 <- points.ppp_plot4[m_plot4]
plot(points.ppp_plot4)
arrows(points.ppp_plot4$x, points.ppp_plot4$y, 
       b_plot4$x, b_plot4$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot4, 5))

contour(density(points.ppp_plot4,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot4<-na.omit(points_plot4)
points.wmppp_plot4 <- wmppp(data.frame(X=points_plot4$X, Y=points_plot4$Y,
                                       PointType=points_plot4$status3,
                                       PointWeight= points_plot4$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT4<-autoplot(points.wmppp_plot4)

#Plot5:####

####Análises espaciais###
points.ppp_plot5 <- ppp(points_plot5$X, points_plot5$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot5)
plot(points.ppp_plot5)

#nearest neighbour
near_plot5<-nndist(points.ppp_plot5)
summary(near_plot5)

m_plot5 <- nnwhich(points.ppp_plot5)
m2_plot5 <- nnwhich(points.ppp_plot5, k=2)

#Plot nearest neighbour links
b_plot5 <- points.ppp_plot5[m_plot5]
plot(points.ppp_plot5)
arrows(points.ppp_plot5$x, points.ppp_plot5$y, 
       b_plot5$x, b_plot5$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot5,5))

contour(density(points.ppp_plot5,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot5<-na.omit(points_plot5)
points.wmppp_plot5 <- wmppp(data.frame(X=points_plot5$X, Y=points_plot5$Y,
                                       PointType=points_plot5$status3,
                                       PointWeight= points_plot5$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT5<-autoplot(points.wmppp_plot5)


#Plot6:####

####Análises espaciais###
points.ppp_plot6 <- ppp(points_plot6$X, points_plot6$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot6)
plot(points.ppp_plot6)

#nearest neighbour
near_plot6<-nndist(points.ppp_plot6)
summary(near_plot6)

m_plot6 <- nnwhich(points.ppp_plot6)
m2_plot6 <- nnwhich(points.ppp_plot6, k=2)

#Plot nearest neighbour links
b_plot6 <- points.ppp_plot6[m_plot6]
plot(points.ppp_plot6)
arrows(points.ppp_plot6$x, points.ppp_plot6$y, 
       b_plot6$x, b_plot6$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot6,5))

contour(density(points.ppp_plot6,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot6<-na.omit(points_plot6)
points.wmppp_plot6 <- wmppp(data.frame(X=points_plot6$X, Y=points_plot6$Y,
                                       PointType=points_plot6$status3,
                                       PointWeight= points_plot6$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT6<-autoplot(points.wmppp_plot6)


#Plot7:####

####Análises espaciais###
points.ppp_plot7 <- ppp(points_plot7$X, points_plot7$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot7)
plot(points.ppp_plot7)

#nearest neighbour
near_plot7<-nndist(points.ppp_plot7)
summary(near_plot7)

m_plot7 <- nnwhich(points.ppp_plot7)
m2_plot7 <- nnwhich(points.ppp_plot7, k=2)

#Plot nearest neighbour links
b_plot7 <- points.ppp_plot7[m_plot7]
plot(points.ppp_plot7)
arrows(points.ppp_plot7$x, points.ppp_plot7$y, 
       b_plot7$x, b_plot7$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot7,5))

contour(density(points.ppp_plot7,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot7<-na.omit(points_plot7)
points.wmppp_plot7 <- wmppp(data.frame(X=points_plot7$X, Y=points_plot7$Y,
                                       PointType=points_plot7$status3,
                                       PointWeight= points_plot7$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT7<-autoplot(points.wmppp_plot7)

#Plot8:####

####Análises espaciais###
points.ppp_plot8 <- ppp(points_plot8$X, points_plot8$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot8)
plot(points.ppp_plot8)

#nearest neighbour
near_plot8<-nndist(points.ppp_plot8)
summary(near_plot8)

m_plot8 <- nnwhich(points.ppp_plot8)
m2_plot8 <- nnwhich(points.ppp_plot8, k=2)

#Plot nearest neighbour links
b_plot8 <- points.ppp_plot8[m_plot8]
plot(points.ppp_plot8)
arrows(points.ppp_plot8$x, points.ppp_plot8$y, 
       b_plot8$x, b_plot8$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot8,5))

contour(density(points.ppp_plot8,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot8<-na.omit(points_plot8)
points.wmppp_plot8 <- wmppp(data.frame(X=points_plot8$X, Y=points_plot8$Y,
                                       PointType=points_plot8$status3,
                                       PointWeight= points_plot8$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT8<-autoplot(points.wmppp_plot8)

#Plot9:####

####Análises espaciais###
points.ppp_plot9 <- ppp(points_plot9$X, points_plot9$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot9)
plot(points.ppp_plot9)

#nearest neighbour
near_plot9<-nndist(points.ppp_plot9)
summary(near_plot9)

m_plot9 <- nnwhich(points.ppp_plot9)
m2_plot9 <- nnwhich(points.ppp_plot9, k=2)

#Plot nearest neighbour links
b_plot9 <- points.ppp_plot9[m_plot9]
plot(points.ppp_plot9)
arrows(points.ppp_plot9$x, points.ppp_plot9$y, 
       b_plot9$x, b_plot9$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot9,5))

contour(density(points.ppp_plot9,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot9<-na.omit(points_plot9)
points.wmppp_plot9 <- wmppp(data.frame(X=points_plot9$X, Y=points_plot9$Y,
                                       PointType=points_plot9$status3,
                                       PointWeight= points_plot9$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT9<-autoplot(points.wmppp_plot9)


#Plot10:####

####Análises espaciais###
points.ppp_plot10 <- ppp(points_plot10$X, points_plot10$Y,
                        window=owin(c(0,100),c(0,100)))
summary(points.ppp_plot10)
plot(points.ppp_plot10)

#nearest neighbour
near_plot10<-nndist(points.ppp_plot10)
summary(near_plot10)

m_plot10 <- nnwhich(points.ppp_plot10)
m2_plot10 <- nnwhich(points.ppp_plot10, k=2)

#Plot nearest neighbour links
b_plot10 <- points.ppp_plot10[m_plot10]
plot(points.ppp_plot10)
arrows(points.ppp_plot10$x, points.ppp_plot10$y, 
       b_plot10$x, b_plot10$y, angle=15, length=0.15, col="red")

#Density plot:
plot(density(points.ppp_plot10,5))

contour(density(points.ppp_plot10,5), axes=FALSE)

#Plot de classes diametro p/ família
points_plot10<-na.omit(points_plot10)
points.wmppp_plot10 <- wmppp(data.frame(X=points_plot10$X, Y=points_plot10$Y,
                                       PointType=points_plot10$status3,
                                       PointWeight= points_plot10$diam),
                            window=owin(c(0,100),c(0,100)))

PLOT10<-autoplot(points.wmppp_plot10)


##MULTPLOT####
multiplot(PLOT1,PLOT2, PLOT3, PLOT4,PLOT5,cols=2) 
          
multiplot(PLOT6,PLOT7,PLOT8,PLOT9,PLOT10,cols=2)


###Indices de diferenciação####

DIFF(points_plot2,
     .x = X,
     .y = Y,
     .mark = dia,
     xmax = 100,
     ymax = 100,
     shape = 'square',
     max.k = 5,
     .groups=c('Q_Yellow'))

DDOM(diam,
     .x = x,
     .y = y,
     .mark = pas,
     xmax = 50,
     ymax = 50,
     shape = 'square',
     max.k = 10,
     .groups=c('area'))

MING(diam,
     .x = x,
     .y = y,
     .species=sp,
     xmax = 50,
     ymax = 50,
     shape = 'square',
     max.k = 10,
     .groups=c('area'))


DIFF(diam_eug,
     .x = x,
     .y = y,
     .mark = pas,
     xmax = 50,
     ymax = 50,
     shape = 'square',
     max.k = 10,
     .groups=c('area'))


##Espécies mais abundante####

##E_dysenterica###
#10
points_10BV_sp1<-points_10_BV[points_10_BV$sp%in%'Eugenia_dysenterica', ]
points_10FP_sp1<-points_10_FP[points_10_FP$sp%in%'Eugenia_dysenterica', ]

points.ppp10_BV_sp1 <- ppp(points_10BV_sp1$x, points_10BV_sp1$y, 
                       window=owin(c(0,50),c(0,50)))

plot(points_10BV_sp1$x, points_10BV_sp1$y)

points.ppp10_FP_sp1 <- ppp(points_10FP_sp1$x, points_10FP_sp1$y, 
                           window=owin(c(0,50),c(0,50)))

plot(points_10FP_sp1$x, points_10FP_sp1$y)


# Calculate the Ripley's K function
K_10_BV_sp1 <- Kest(points.ppp10_BV_sp1, correction = "iso")
G_10_BV_sp1 <- pcf(points.ppp10_BV_sp1, correction = "iso")

K_10_FP_sp1 <- Kest(points.ppp10_FP_sp1, correction = "iso")
G_10_FP_sp1 <- pcf(points.ppp10_FP_sp1, correction = "iso")

# Plot the Ripley's K function
plot(K_10_BV_sp1)
plot(K_10_FP_sp1)

plot(G_10_BV_sp1)
plot(G_10_FP_sp1)

##25
points_25BV_sp1<-points_25_BV[points_25_BV$sp%in%'Eugenia dysenterica', ]
points_25FP_sp1<-points_25_FP[points_25_FP$sp%in%'Eugenia dysenterica', ]

points.ppp25_BV_sp1 <- ppp(points_25BV_sp1$x, points_25BV_sp1$y, 
                           window=owin(c(0,50),c(0,50)))

plot(points_25BV_sp1$x, points_25BV_sp1$y)

points.ppp25_FP_sp1 <- ppp(points_25FP_sp1$x, points_25FP_sp1$y, 
                           window=owin(c(0,50),c(0,50)))

plot(points_25FP_sp1$x, points_25FP_sp1$y)


# Calculate the Ripley's K function
K_25_BV_sp1 <- Kest(points.ppp25_BV_sp1, correction = "iso")
G_25_BV_sp1 <- pcf(points.ppp25_BV_sp1, correction = "iso")

K_25_FP_sp1 <- Kest(points.ppp25_FP_sp1, correction = "iso")
G_25_FP_sp1 <- pcf(points.ppp25_FP_sp1, correction = "iso")

# Plot the Ripley's K function
plot(K_25_BV_sp1)
plot(K_25_FP_sp1)

plot(G_25_BV_sp1)
plot(G_25_FP_sp1)

##SD
points_SDBV_sp1<-points_SD_BV[points_SD_BV$sp%in%'Eugenia dysenterica', ]
points_SDFP_sp1<-points_SD_FP[points_SD_FP$sp%in%'Eugenia dysenterica', ]

points.pppSD_BV_sp1 <- ppp(points_SDBV_sp1$x, points_SDBV_sp1$y, 
                           window=owin(c(0,50),c(0,50)))

plot(points_SDBV_sp1$x, points_SDBV_sp1$y)

points.pppSD_FP_sp1 <- ppp(points_SDFP_sp1$x, points_SDFP_sp1$y, 
                           window=owin(c(0,50),c(0,50)))

plot(points_SDFP_sp1$x, points_SDFP_sp1$y)


# Calculate the Ripley's K function
K_SD_BV_sp1 <- Kest(points.pppSD_BV_sp1, correction = "iso")
G_SD_BV_sp1 <- pcf(points.pppSD_BV_sp1, correction = "iso")

K_SD_FP_sp1 <- Kest(points.pppSD_FP_sp1, correction = "iso")
G_SD_FP_sp1 <- pcf(points.pppSD_FP_sp1, correction = "iso")

# Plot the Ripley's K function
plot(K_SD_BV_sp1)
plot(K_SD_FP_sp1)

plot(G_SD_BV_sp1)
plot(G_SD_FP_sp1)
