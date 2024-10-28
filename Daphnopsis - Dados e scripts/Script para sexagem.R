###############################################################
#	Identificação sexual de indivíduos de Daphnopsis
#--------------------------------------------------------------
# Contexto: A identificação do sexo dos indivíduos depende da flor,
#	como nem todos os indivíduos florescem ao mesmo tempo,
#		a sexagem é realizada ao longo do tempo
#--------------------------------------------------------------
#		Script por Gabriel Santos
#			22 Março 2024
#		ssantos.gabriel@gmail.com
########################################################

#Packages
library(openxlsx)
library(tidyverse)

#Load data
## "sheet" é o nome da planilha
maio2022<-read.xlsx(file.choose(),colNames=T,detectDates=T,sheet="Maio2022")
maio2023<-read.xlsx(file.choose(),colNames=T,detectDates=T,sheet="Maio2023")

#Normaliza as colunas
maio2022<-maio2022%>%rename("Tag"="Tag..Num.")%>%mutate(Tag=as.factor(Tag))
maio2022<-maio2022%>%rename("Tag"="Old.tag")%>%mutate(Tag=as.factor(Tag))

#--------------------------------------------------------------------------
#	Para a sexagem é necesário realizar em duas etapas,
#		já que a ordem das tags pode se modificar ao longo do tempo.
#	Primeiro fazemos com uma e depois com a outra. 
#--------------------------------------------------------------------------
#				EXEMPLO
#--------------------------------------------------------------------------
#Preencher o sexo da planilha 1 com informações da planilha 2
#  left_join(
#	planilha1,planilha2,by="Tag")%>%
#		mutate(Sexo.out=coalesce(Sexo.x,Sexo.y))
#
#Preencher o sexo da planilha 2 com informações da planilha 1
#  left_join(
#	planilha2,planilha1,by="Tag")%>%
#		mutate(Sexo.out=coalesce(Sexo.x,Sexo.y))
#--------------------------------------------------------------------------

left_join(
maio2023%>%select(Old.tag,Sexo)%>%rename("Tag"="Old.tag")%>%mutate(Tag=as.factor(Tag)),
maio2022%>%select(Tag..Num.,Sexo)%>%rename("Tag"="Tag..Num.")%>%mutate(Tag=as.factor(Tag)),
by="Tag")%>%
mutate(Sexo.out=coalesce(Sexo.x,Sexo.y))

