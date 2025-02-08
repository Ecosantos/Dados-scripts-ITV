#'===============================
#     Limpeza e exportação de dados
# Para a disciplina do Zuidema - 2025
#'===============================
#'

library(readxl)
library(tidyverse)
rm(list=ls())

#'------------------------------------
#'  Carajasia
#'------------------------------------
# Original dataset
#"...\Dados-scripts-ITV\Carajasia - Dados e scripts\Censos\Carajasia 2023-2024.xlsx"

Carajasia <- read_excel("C:/Artigos e resumos publicados submetidos ideias/Notes/9 - ITV/Dados-scripts-ITV/Carajasia - Dados e scripts/Censos/Carajasia 2023-2024.xlsx", 
            sheet = "Carajasia 2023-2024 Clean", 
            col_types = c("text", "text", "text", 
              "text", "numeric", "text", "numeric", 
              "numeric", "numeric", "numeric", 
              "numeric", "numeric", "numeric", 
              "numeric", "text", "text", "text"))                  
Carajasia


table(Carajasia$Status)
table(Carajasia$Status0)

Carajasia2<-Carajasia%>%
  mutate(Status0 = case_when(         # Um indivíduo estava como esqueleto e depois se mostrou reprodutivo no ano seguinte
                  Status0 == "Esqueleto" & Status == "Reprodutivo" ~ "Jovem",
                  TRUE ~ Status0))%>%
    filter(!(Status0 %in% c("Esqueleto", "not found", "Not found","Morreu")))%>%  #Remove indivíduos que estavam em estado de esqueleto (= Mortos)
  mutate(size=(dia_x0+dia_y0)/2)%>%    # Média de diâmetro ano t
  mutate(size_next=(dia_x+dia_y)/2)%>% # Média de diâmetro ano t+1
  mutate(Status0=case_when(
                  Status0 =="adulto ano passado" ~ "Reprodutivo",
                  Status0 =="não reprodutivo" ~"Jovem",
                  TRUE~Status0))%>%
  mutate(Status=case_when(
                  Status=="Esqueleto" ~ "Morreu",
                  TRUE~Status))%>%
  mutate(repro=ifelse(Status0=="Reprodutivo",1,0))%>%
  mutate(survival =ifelse(Status %in% c("Reprodutivo","Jovem"),1,0))%>%
  mutate(id=row_number())



Carajasia2%>%glimpse()
table(Carajasia2$Status)
table(Carajasia2$Status0,useNA="always") #NA significa individuos novos

table(Carajasia2$survival,useNA="always")
table(Carajasia2$repro,useNA="always")
table(Carajasia2$survival)

Carajasia_final<-Carajasia2%>%
  select(id,size,size_next,repro,survival)
  

#write.csv(Carajasia2,"Carajasia_zuidema2025.csv")


