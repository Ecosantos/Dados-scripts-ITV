#######################################################
## Day 1. Population matrix models                   ##
## Uses; vector & matrix acai & mahogany             ##
## Analyses: growth, elastiity, harvesting           ##
#######################################################

# Set working directory
rm(list = ls())
#setwd("C:/Users/Zuide015/OneDrive - Wageningen University & Research/Pieter/Teaching/IPM course/2025 Fortaleza IPM/Day1_Monday")

#Packages
#install.packages("popbio")
#install.packages("popdemo")
#install.packages("Rcompadre")
library(popbio)
library(popdemo)
library(Rcompadre)   #Original estava como RcompaRdre com R entre "a" e "d" 


#Data
#Load transition matrix and vector
A  <- as.matrix(read.table(file = "Euterpe_matrix.csv", sep=",", header = FALSE))
n0  <- as.matrix(read.table(file = "Euterpe_vector.csv", sep=",", header = FALSE))

##################################
# Acai matrix models             #
# Step 1. Explore data           #
##################################

# Explore the matrix
A

# Stasis
diag(A)
# Progression
diag(A[-1,])
# Reproduction
A[1,9:11]

# Explore and plot the vector
barplot(t(n0),names.arg=1:11, xlab = "Size class",ylab = "Abundance per class (/ha)")

###################################
# Step 2. Population projections  #
###################################

#Matrix projection, short
n <- pop.projection(A,n0,10)
n
plot(n$pop.sizes,xlab = "Time in projection (y)", ylab = "Population size")

#Matrix projection, long
n <- pop.projection(A,n0,150)
n
plot(n$pop.sizes,xlab = "Time in projection (y)", ylab = "Population size")


######################################################
# Step 3. Asymptotic pop growth and stable structure #
######################################################

# Asymptotic population growth rate over 150 years
plot(n$pop.changes,xlab = "Time in projection (y)", ylab = "Relative population change")

# Get the population growth rate during the last year
n$pop.changes[149]

# Get the asymptotic population growth, which is indepedent of initial structure
lambda(A)

# Compare the asymptotic population growth with the growth after 150 years
n$pop.changes[149] - lambda(A)

# Relative structure
relstructure <-matrix(NA, nrow=11, ncol=150)
for (i in 1:149) relstructure[,i] <- n$stage.vectors[,i]/n$pop.sizes[i]
barplot(relstructure, names = (1:150), xlab = "Time in projection (y)",ylab = "Abundance per class (/ha)", legend.text=1:11)

# Size distributions at start, 10 years, 150 years and stable size distribution
par(mfrow=c(2,2)) 
barplot(n$stage.vectors[,1]/n$pop.sizes[1],names=seq(1:11), xlab="category", ylab="proportion of individuals", main = "Year 0") 
barplot(n$stage.vectors[,10]/n$pop.sizes[10],names=seq(1:11), xlab="category", ylab="proportion of individuals", main = "Year 10") 
barplot(n$stage.vectors[,150]/n$pop.sizes[150],names=seq(1:11), xlab="category", ylab="proportion of individuals", main = "Year 150") 
barplot(stable.stage(A),names=seq(1:11), xlab="category", ylab="proportion of individuals", main = "stable stage")  
par(mfrow=c(1,1))

######################################
# Step 4. Elasticity anlaysis & ages #
######################################

# Elasticity analysis
E <- elasticity(A)
E

# The sum of elasticities in 1
sum(E)

# To compare the importance across categories
Ecol <- colSums(E)
barplot(Ecol,names.arg=1:11, xlab = "Size class",ylab = "Elasticity per class")

# To compare the importance across types of transitions
Estasis <- sum(diag(E))
Eprogression <- sum(diag(E[-1,]))
Efecund <- sum(E[1,2:11])

pie(c(Estasis,Eprogression,Efecund), labels=c("Elast_stasis","Elast_progression","Elast_fecund"))

# Generation time
generation.time(A)

######################################
# Mahogany matrix models             #
# Step 5. Load data and check        #
######################################

# Load the matrix for the control
C<-as.matrix(read.table(file = "Mahogany_C.csv", sep=",", header = FALSE))
# Load the matrix for the low silviculture
LS<-as.matrix(read.table(file = "Mahogany_LS.csv", sep=",", header = FALSE))
# Load the vector with the starting distribution
n0<-as.matrix(read.table(file = "Mahogany_n0.csv", sep=",", header = FALSE))

# Check the matrices
C
LS

# You can also check the differences  
C-LS

# Plot the population structure
barplot(t(n0),names.arg=1:10, xlab = "Size class",ylab = "Abundance per class")

####################################
# Step 6. Do logging projections   #
####################################

# Copy of n0
n0_har <- n0

# Apply 80% harvesting in the vector
n0_har[10,1]<-(n0[10,1]*0.2) # 80% of the trees >70 cm DBH are harvested 

# Simulate the population for 9 years (so 10 time steps in R)
n1_9<-pop.projection(LS,n0_har,10)  
n1_9

# Extract the population structure at year 9
n9<-as.matrix(n1_9$stage.vectors[,10], nrow=10, ncol=1)
n9

# Simulate the population for 11 years (so 12 time steps in R)
n10_20<-pop.projection(C,n9,12)  # Está 12 mas na verdade deveriar ser 11!
# Have a look at the projected populations
n10_20$stage.vectors

# Plot
plot(c(sum(n0),n1_9$pop.sizes,n10_20$pop.sizes),xlab = "Time in projection (y)", ylab = "Population size")

# Calculate the available number of trees for harvesting at the end
0.8*n10_20$stage.vectors[10,12]

# The following code is to changing the logging intensity to 50%
n0_har50 <- n0
n0_har50[10,1]<-(n0[10,1]*0.5) # 50% of the trees >70 cm DBH are harvested 
n1_9_50<-pop.projection(LS,n0_har50,10)  
n9_50<-as.matrix(n1_9_50$stage.vectors[,10], nrow=10, ncol=1)
n10_20_50<-pop.projection(C,n9_50,12)
n10_20_50
n10_20_50$stage.vectors[10,12]*0.5

#####################################
# Step 7. Compare logging scenarios #
#####################################

# Below is a loop that calculates all scenarios and puts these in a table

# Create empty vector to save results
results <- c()

# Loop that includes logging intensity (loop 1) and cycle (loop 2)
for (intensity in c(0.8,0.5)){
  for (cycle in c(12,22)){
    n0_har <- n0
    n0_har[10,1]<-(n0[10,1]*(1-intensity))  
    # Use new population structure to project 9 years with matrix LS
    n1_9<-pop.projection(LS,n0_har,10)
    n9<-as.matrix(n1_9$stage.vectors[,10], nrow=10, ncol=1) # Pop structure at year 9
    
    # Project for 11 or 21 years with matrix C
    n10_20<-pop.projection(C,n9,cycle)
    # Number of trees that can be logged
    logged_trees <- intensity * n10_20$stage.vectors[10,cycle]
    
    # Calculate percentage
    start_trees <- n0[10,1] * intensity
    percentage <- round(logged_trees/start_trees*100, 0)
    results <- c(results, percentage)
  }
}

# Put results in matrix
Result_Table <- matrix(ncol = 2, nrow = 2)
Result_Table[1,1] <- results[1]
Result_Table[1,2] <- results[2]
Result_Table[2,1] <- results[3]
Result_Table[2,2] <- results[4]

# Add names to columns and rows
colnames(Result_Table) <- c("20 years", "30 years")
rownames(Result_Table) <- c("80%", "50%")

Result_Table

#####################################
# Step 8. Compadre database access  #
#####################################

# Load the complete database with matrix models for plants
compadre <- cdb_fetch("compadre") # or use 'comadre' for the animal database
class(compadre)
compadre$mat

unique(compadre$SpeciesAccepted[compadre$OrganismType=="Tree"])

# Get a list of unique tree or palm species names 
unique(compadre$metadata$SpeciesAccepted[compadre$metadata$OrganismType=="Tree"])
unique(compadre$metadata$SpeciesAccepted[compadre$metadata$OrganismType=="Palm"])

# Extract metadata from a particular species, e.g.: the Euterpe palm 
eut_prec_meta <- subset(compadre$metadata, compadre$metadata$SpeciesAccepted == "Euterpe precatoria")

# Extract matrices from this species
eut_prec_mat <- subset(compadre$mat, compadre$metadata$SpeciesAccepted == "Euterpe precatoria")

# Check for availablity of matrices from another species, e.g.: African cherry
prun_afr_meta <- subset(compadre$metadata, SpeciesAccepted == "Prunus africana")
prun_afr_mat <- subset(compadre$mat, compadre$metadata$SpeciesAccepted == "Prunus africana")

# Check how many matrices are available & where
prun_afr_meta
# Check where and when matrices have been obtained 
prun_afr_meta$Country
prun_afr_meta$Authors
prun_afr_meta$StudyStart
prun_afr_meta$StudyEnd

# Check the matrices
prun_afr_mat

# Select the A-type matrices, which contain all transitions 
# U only contains stasis and growth; F only contains sexual reproduction; 
# C only contains clonal reproduction
# For the second population, the A matric is:
prun_afr_2_matA <- prun_afr_mat[[2]]$matA

# We can now do analyses on this matrix
lambda(prun_afr_2_matA)
elasticity(prun_afr_2_matA)
             
# If you are interested in the animal matrix models, then 
# load the complete database with matrix models for animals
comadre <- cdb_fetch("comadre") 
unique(comadre$OrganismType)

# Here is a list of all mammal species in alphabetic order 
sort(unique(comadre$SpeciesAccepted[comadre$OrganismType=="Mammalia"]))

#####################################
# Step 9. Density dependent for deer#
#####################################

#Data
#Load transition matrix and vector
A  <- as.matrix(read.table(file = "deer_mat.csv", sep=",", header = FALSE))
A
lambda(A)

n0  <- as.matrix(read.table(file = "deer_vec.csv", sep=",", header = FALSE))
n0

# Project without density dependence
nt <- pop.projection(A,n0,21)
nt$pop.changes

# Implement density dependence, for population of 175 individuals 
K=200 # carrying capacity
ar_max=0.2044*2 # maximum reproduction rate for A individuals
sr_max=0.2614*2 # maximum reproduction rate for S individuals
A_dd <- A
A_dd[1,2] <- ar_max * (1-175/K)
A_dd[1,3] <- sr_max * (1-175/K)
nt_dd_11 <- pop.projection(A_dd,nt$stage.vectors[,11],2)
nt_dd_11$pop.changes
nt$pop.changes[11]

# Implement density dependence, for 20 years
nt_dd_sum <- sum(n0)
nt_dd <- n0
deer_dd <- data.frame(t=0:20,pop_NO_dd=nt$pop.sizes,pop_dd=NA)
deer_dd$pop_dd[1] <- nt_dd_sum

for (t in 1:20) {
  A_dd <- A
  A_dd[1,2] <- ar_max * (1-nt_dd_sum/K)
  A_dd[1,3] <- sr_max * (1-nt_dd_sum/K)
  proj_dd <- pop.projection(A_dd,nt_dd,2)
  nt_dd <-as.matrix(proj_dd$stage.vectors[,2], nrow=3, ncol=1)
  nt_dd_sum <- sum(nt_dd)
  deer_dd$pop_dd[t+1] <- nt_dd_sum
}

plot(deer_dd$t,deer_dd$pop_NO_dd,xlab = "Time in projection (y)", ylab = "Population size",col='darkgreen', pch=19)
points(deer_dd$t,deer_dd$pop_dd,col='blue', pch=19)
abline(h=K, col="blue")
legend(1,550,legend=c('No density dependence', 'With density dependence'), 
       pch=c(19, 19), col=c('darkgreen', 'blue'))


n0  <- as.matrix(read.table(file = "deer_vec.csv", sep=",", header = FALSE))
nt_dd_sum <- sum(n0)
nt_dd <- n0
deer_dd <- data.frame(t=0:20,pop_NO_dd=nt$pop.sizes,pop_dd=NA)
deer_dd$pop_dd[1] <- nt_dd_sum
