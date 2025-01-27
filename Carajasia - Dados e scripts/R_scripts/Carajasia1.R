#### tentativa matriz carajasia #######
#### 
library(popbio)
library(dplyr)

demo<-read.csv2(file = "Data/carajasia_popbio2.csv")
#data popbio2 ta arrumado!


head(demo)
str(demo)

demo[demo==0]<-"dead" 
demo$diam<-as.numeric(demo$diam)
demo$stage2<-as.factor(demo$stage2)


#fecundidade

demo_R<-demo%>%
  filter(stage2=="reprod")

demo_R<-demo_R%>%
  mutate(fert = case_when(
    diam < 20 ~ 334 / 225,
    diam >= 20 & diam <= 40 ~ 334 / 985,
    diam >= 41 & diam <= 60 ~334/ 1616,
    diam >= 61 & diam <= 80 ~334/ 3000,
    diam > 80 ~ 334/3700
  ))

demo_J<-demo%>%
  filter(stage2=="immature")%>%
  mutate(fert=0)
demo_S<-demo%>%
  filter(stage2=="seed")%>%
  mutate(fert=0)

demo<-bind_rows(demo_R, demo_J, demo_S)

#fec <- read.csv2(file = "Data/cara_fecund.csv")

per.capita <- sum(fec$Fecundidade)/sum(demo$stage==3)# num de new recruits/reprod adults

####este passo acrescenta fecundidade per capita
demo$seedferts <- (ifelse(demo$stage==3, per.capita, 0))
demo[is.na(demo)] <- 0
head(demo)
class(demo$fert)

stages <- c( "1", "2","3") 

demo$stage <-ordered(demo$stage, stages)  
demo$fate  <- ordered(demo$fate,  levels = c(stages,"dead"))

library(popbio)
pc<-projection.matrix(demo, fertility=fert)

eigD <- eigen.analysis(pc)
eigD

###======###
#fazendo fertility sem seeds
#

demo2<-read.csv2(file = "Data/carajasia_popbio.csv")
#data popbio2 ta arrumado!


head(demo)
str(demo)

demo2[demo2==0]<-"dead" 


fec <- read.csv2(file = "Data/cara_fecund.csv")

per.capita <- sum(fec$Fecundidade)/sum(demo2$stage==3)# num de new recruits/reprod adults

####este passo acrescenta fecundidade per capita
demo2$seedferts <- (ifelse(demo2$stage==3, per.capita, 0))
demo2[is.na(demo)] <- 0
head(demo2)
class(demo$fert)

stages <- c(  "2","3") 

demo2$stage <-ordered(demo2$stage, stages)  
demo2$fate  <- ordered(demo2$fate,  levels = c(stages,"dead"))

library(popbio)
pc<-projection.matrix(demo2, fertility=seedferts)

eigD <- eigen.analysis(pc)
eigD
