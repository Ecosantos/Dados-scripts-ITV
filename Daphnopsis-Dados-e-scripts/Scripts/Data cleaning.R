#"#########################################################
#           Data Cleaning
#"#########################################################

#'==============================================================
#' Accessory function 
#'=============================================================================
# Sum multiple branches
sumBranch<-function(X){
  sapply(str_replace_all(X, "\\+", " + "), function(x) eval(parse(text = x)))
}


# CheckSex <- Update sex information from old (base) to new census(check)

check_sex <- function(base, check) {
  case_when(
    (base == "Indeterminado" | is.na(base)) & !is.na(check) & check != "Indeterminado" ~ check,
    base == "Masculina" & check == "Feminina" ~ "Troca de Sexo",
    base == "Feminina" & check == "Masculina" ~ "Troca de Sexo",
    TRUE ~ base
  )
}

#'==============================================================

importantCols<-c(
  "Plot","Site",
  "Tag_Num","Old_tag",'New_Tag',
  "Sexo","Estg_Rep",
  "Estg_Vida","Estg_Sex",
  "Height","DAS")

# Transform tags from character to number ----
year2022_raw$Tag_Num<-as.character(year2022_raw$Tag_Num)
year2023_raw$New_Tag<-as.character(year2023_raw$New_Tag)

# SUM BRANCHES and REMOVE THOSE WITHOUT DAS
## 2024

## 2022
year2022<-year2022_raw%>%
  mutate(DAS_x = sumBranch(DAS_x))%>%
  mutate(DAS_y = sumBranch(DAS_y))%>%
  filter(!is.na(DAS_x) | !is.na(DAS_y)  )%>%
  mutate(DAS=rowMeans(across(c("DAS_y", "DAS_x")), na.rm = FALSE))%>%
  select(all_of(intersect(importantCols, names(.))))

##2023
year2023<-year2023_raw%>%
  mutate(DAS_x = sumBranch(DAS_x))%>%
  mutate(DAS_y = sumBranch(DAS_y))%>%
  filter(!is.na(DAS_x) | !is.na(DAS_y)  )%>%
  mutate(DAS=rowMeans(across(c("DAS_y", "DAS_x")), na.rm = FALSE))%>%
  select(all_of(intersect(importantCols, names(.))))
#year2023%>%glimpse()

year2024<-year2024_raw%>%
  mutate(DAS_x = sumBranch(DAS_x))%>%
  mutate(DAS_y = sumBranch(DAS_y))%>%
  filter(!is.na(DAS_x) | !is.na(DAS_y)  )%>%
  mutate(DAS=rowMeans(across(c("DAS_y", "DAS_x")), na.rm = FALSE))%>%
  select(all_of(intersect(importantCols, names(.)))) 
#year2024%>%glimpse()


# Data merging ----
y22_23_raw<-full_join(year2022,year2023,by=c("Tag_Num"="Old_tag","Site","Plot"),suffix=c("_t0","_t1"))
y22_24_raw<-full_join(year2022,year2024,by=c("Tag_Num"="Old_tag","Site","Plot"),suffix=c("_t0","_t1"))
y23_24_raw<-full_join(year2023,year2024,by=c("Old_tag","New_Tag","Site","Plot"),suffix=c("_t0","_t1"))


# Final data cleaned ----
y22_24<-y22_24_raw%>%
  mutate(Tag=Tag_Num,
         Sexo=check_sex(base=Sexo_t0,check=Sexo_t1),
         Period="2022_2024")%>%
  group_by(Tag) %>%
  ungroup()%>%
  select(Period,Site,Plot,Tag,
          New_Tag,Sexo,
          starts_with("Sexo"),
          starts_with("Height"),
          starts_with("DAS"),
          starts_with("Estg_Rep"))
  
y22_23<-y22_23_raw%>%
  mutate(Tag=coalesce(New_Tag,Tag_Num),
         Sexo=check_sex(base=Sexo_t0,check=Sexo_t1),
         Period="2022_2024")%>%
  group_by(Tag) %>%
  ungroup()%>%
  select(Period,Site,Plot,Tag,Tag_Num,
         New_Tag,Sexo,
         starts_with("Sexo"),
         starts_with("Height"),
         starts_with("DAS"),
         starts_with("Estg_Rep"))

y23_24<-y23_24_raw%>%
  mutate(Tag=coalesce(New_Tag,Old_tag),
  Sexo=check_sex(base=Sexo_t0,check=Sexo_t1),
Period="2022_2024")%>%
  group_by(Tag) %>%
  ungroup()%>%
  select(Period,Site,Plot,Tag,
         New_Tag,Sexo,
         starts_with("Sexo"),
         starts_with("Height"),
         starts_with("DAS"),
         starts_with("Estg_Rep"))




y22_23$DAS_2022/y22_23$DAS_2023
y23_24$DAS_2023/y23_24$DAS_2024
