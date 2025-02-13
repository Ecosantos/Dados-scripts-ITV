#-------------------------------------------------
# Script limpeza de dados Daphnopsis curso Zuidema 2025
#
#--------------------------------------------------

gc()
rm(list=ls())

# Packages
library(openxlsx)
library(tidyverse)
library(knitr)
library(kableExtra)

# Data
year2022_raw<-read.xlsx("Dados Daphnopsis Nov2024.xlsx",colNames=T,detectDates=T,sheet="Maio2022")
year2023<-year2023_raw<-read.xlsx("Dados Daphnopsis Nov2024.xlsx",colNames=T,detectDates=T,sheet="Maio2023")
year2024<-year2024_raw<-read.xlsx("Dados Daphnopsis Nov2024.xlsx",colNames=T,detectDates=T,sheet="Junho2024")


source("Scripts/Data cleaning.R")


# Total individuals
length(unique(c(y22_23$Tag,y23_24$Tag)))

data.frame(
  Metric=c("Height","DAS"),
  Mean=c(
    # Mean Height and DAS
    mean(c(year2022$Height,year2023$Height,year2024$Height)),
    mean(c(year2022$DAS,year2023$DAS,year2024$DAS))),
  SD=c(
    # SD Height and DAS
    sd(c(year2022$Height,year2023$Height,year2024$Height)),
    sd(c(year2022$DAS,year2023$DAS,year2024$DAS))),
  MAX=c(
    # MAX Height and DAS
    max(c(year2022$Height,year2023$Height,year2024$Height)),
    max(c(year2022$DAS,year2023$DAS,year2024$DAS))))


# Individuos femininos


y23_24%>%head()


final23_24<-y23_24%>%
  mutate(surv=ifelse(is.na(Height_t1),0,1))%>%
  mutate(rep=ifelse(Estg_Rep_t0%in% c("Vegetativo",is.na(Estg_Rep_t0)),0,1))           


table(final23_24$Estg_Rep_t0,final23_24$rep)

dir()
write.csv(final23_24,"Daphnopsis23_24 - Zuidema.csv")
