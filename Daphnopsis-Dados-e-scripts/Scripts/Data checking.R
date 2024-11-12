#"#########################################################
#           Data checking
#
#
#"#########################################################


#"----------------------------------------------------------
# Check colnames among tables
#"----------------------------------------------------------
#Compare 2022 to 2023
colnames(year2022)[(colnames(year2022)%in%colnames(year2023))=="FALSE"]

#Compare 2023 to 2024
colnames(year2023)[(colnames(year2023)%in%colnames(year2024))=="FALSE"]

#Compare 2022 to 2024
colnames(year2022)[(colnames(year2022)%in%colnames(year2024))=="FALSE"]



#"----------------------------------------------------------
#"  Checking Tags
#"----------------------------------------------------------

table(year2022$Tag_Num)[(table(year2022$Tag_Num)>2)=="TRUE"]
table(year2023$Old_tag)[(table(year2023$Old_tag)>2)=="TRUE"]
table(year2023$New_Tag)[(table(year2023$New_Tag)>2)=="TRUE"]      
table(year2024$New_Tag)[(table(year2024$New_Tag)>2)=="TRUE"]      
table(year2024$Old_tag)[(table(year2024$Old_tag)>2)=="TRUE"]  