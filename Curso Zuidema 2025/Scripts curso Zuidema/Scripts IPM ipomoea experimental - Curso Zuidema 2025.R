##################################################
# CONSTRUÇÃO DE IPM Para IPOMOEA - EXERCICIO ZUIDEMA
##################################################
## Day 2. IPM construction                      ##
## Data; Bolivian acai (Euterpe precatoria)     ##
## Analyses: vital rate models and IPM contruct ##
##################################################

# Clean workspace
rm(list = ls()) # Empty workspace 
#setwd("C:/Users/Zuide015/OneDrive - Wageningen University & Research/Pieter/Teaching/IPM course/2025 Fortaleza IPM/Day2_Tuesday")

# Packages
library(stats)
library(dplyr)
library(nlme)
library(ipmr)
library(ggplot2)
library(tidyr) 

# Load data on Euterpe precatoria palms
dff <- read.csv2("ipo_ipm.csv")
head(dff)


dff%>%glimpse()

dff$size_h<-as.numeric(dff$size_h)
dff$size_nexth<-as.numeric(dff$size_nexth)


dff$size<-as.numeric(dff$size_h)
dff$size_next<-as.numeric(dff$size_nexth)


dff%>%glimpse()


dff$repro<-dff$reprod

##################################
# Step 1. Explore data           #
##################################

head(dff)
dim(dff)
hist(dff$size) # in m palm height
hist(dff$size_next)
hist(dff$size_next-dff$size)

hist(dff$repro)
hist(dff$survival)

ggplot(dff, aes(x = size, y = size_next,col=as.factor(repro))) + 
  geom_point() 

ggplot(dff, aes(x = size, y = size_next-size,col=as.factor(repro))) + 
  geom_point() 




##################################
# Step 2. Create growth models   #
##################################
dff_cl <- dff   #Mantive assim por facilidade mas no original outliers eram removidos

# Growth model 1 = linear model of sizenext ~ size
grow_mod_1 <- lm(size_next ~ size, data = dff_cl) 
summary(grow_mod_1)

ggplot(dff_cl, aes(x = size, y = size_next)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")

# Growth model 2 = quadratic model
# Uses curve fitting to keep structure as size_next ~ size 
grow_mod_2 <- nls(size_next ~ size + a + b*size + c*size^2, data = dff_cl, start=list(a=1, b=1, c=1),control=nls.control(warnOnly = T))
summary(grow_mod_2)


# To compare the 3 models we calculate their fitted data
#compare_grow_mod <- dff_cl %>% 
#  select(id, size,size_next) %>% 
#  drop_na(size, size_next) %>% 
#  mutate(resid_model_1=resid(grow_mod_1),resid_model_2=resid(grow_mod_2),resid_model_3=resid(grow_mod_3))


# Compare goodness of fit of three models  
AIC(grow_mod_1,grow_mod_2)

grow_sd_mod_1  <- sd(resid(grow_mod_1))
grow_sd_mod_2  <- sd(resid(grow_mod_2))

##################################
# Step 3. Create survival models #
##################################


dff_cl2 <- dff %>% 
  drop_na(survival)

# 3 Logistic regression models for survival 

# Survival model 1 = constant survival
surv_mod_1 <- glm(survival ~ 1, data = dff_cl2, family = binomial())
summary(surv_mod_1)

# Survival model 2 =  survival as linear function
surv_mod_2 <- glm(survival ~ size, data = dff_cl2, family = binomial())
summary(surv_mod_2)
# size is not significant

# Survival model 3 =  survival as quadratic function
surv_mod_3 <- glm(survival ~ size + size^2, data = dff_cl2, family = binomial())
summary(surv_mod_3)

# Plot survival models
ggplot(dff_cl2, aes(x = size, y = survival)) + 
  geom_point() +
  geom_line(aes(y=fitted(surv_mod_1)),col="red",linewidth=1) +
  geom_line(aes(y=fitted(surv_mod_2)),col="purple",linewidth=1) +
  geom_line(aes(y=fitted(surv_mod_3)),col="blue",linewidth=1) +
  labs(y = "Palm survival (/y)",x = "Palm height (m)",
       title="3 survival models: constant (red), logistic (purple), cuadratic logistic (blue)")

# Compare goodness of fit of three models  
AIC(surv_mod_1,surv_mod_2,surv_mod_3)

######################################
# Step 4. Create reproduction models #
######################################

# Clean data: leave out individuals without size measurements
dff_cl3 <- dff %>% 
  drop_na(size)

# 3 Logistic regression models for probability of reproduction

# Model 1: constant reproduction probability
repr_mod_1 <- glm(repro ~ 1, data = dff_cl3, family = binomial())
summary(repr_mod_1)

# Model 2: logistic model of reproduction probability against size
repr_mod_2 <- glm(repro ~ size, data = dff_cl3, family = binomial())
summary(repr_mod_2)

# Model 3: logistic model reproduction probability against size & size^2
repr_mod_3 <- glm(repro ~ size + size^2, data = dff_cl3, family = binomial())
summary(repr_mod_3)

# Plot reproduction models
ggplot(dff_cl3, aes(x = size, y = repro)) + 
  geom_point() +
  geom_line(aes(y=fitted(repr_mod_1)),col="red",linewidth=1) +
  geom_line(aes(y=fitted(repr_mod_2)),col="purple",linewidth=1) +
  geom_line(aes(y=fitted(repr_mod_3)),col="blue",linewidth=1) +
  labs(y = "Palm reproduction",x = "Palm height (m)",
       title="3 reproduction models: constant (red), logistic (purple), ... with ^2 (blue)")

# Compare goodness of fit of three models  
AIC(repr_mod_1,repr_mod_2,repr_mod_3)

##################################
# Step 5. Recruitment parameters # 
##################################


# New recruits are those individuals with NA for size(t), and non-NA for size(t + 1)
recr_data <- subset(dff, is.na(size))
hist(recr_data$size_next)
recr_mu  <- mean(recr_data$size_next)
recr_sd  <- sd(recr_data$size_next)


# Divide a quantidade de recrutas / divido
recr_n   <-dim(recr_data)[1]/dim(subset(dff, repro==1))[1]


######################################
# Step 6. Prepare info for IPM model #
######################################

# Bundle all parameters and statistical models into a list. 
params <- list(recr_mu = recr_mu,
               recr_sd = recr_sd,
               grow_sd = grow_sd_mod_2,
               surv_mod = surv_mod_2,
               grow_mod = grow_mod_2,
               repr_mod = repr_mod_2,
               recr_n   = recr_n)

# Set lower and upper bounds for integration. Adding 20% on either end. 
L <- min(c(dff$size, dff$size_next), na.rm = TRUE) * 0.8
U <- max(c(dff$size, dff$size_next), na.rm = TRUE) * 1.2

# Defining the number of classes
mesh <- 200
(U-L)/mesh # this is the category width in m palm height

# Defining starting population structure
# First distribution from continuous classes, abundance is individuals per 6 ha
brks_hist <- seq(from=L,to=U,length.out=mesh+1)
srt_distr <- hist(dff$size,breaks=brks_hist,plot=F)
srt_distr$counts
barplot(srt_distr$counts, names = brks_hist[-1], xlab = "Palm height (m)",ylab = "Abundance per class (/6_ha)")

#################################
# Step 7. Create the IPM model  #
#################################

n_iter = 500 # number of iterations

# The code below contains several steps that are piped together to make the IPM

eut_ipm <- 
  # The first step is to decide what class of model we want to implement. 
  # We have one continuous state variable and no spatial or temporal variation to deal with. 
  # Thus, we have a simple, density independent, deterministic IPM. 
  # We initialize it with init_ipm().
  init_ipm(sim_gen = "simple", di_dd = "di", det_stoch = "det") %>%
  # Create survival & growth kernel (P) 
  define_kernel(
    name          = "P",
    family        = "CC", #this means: from continuous to continuous classes
    formula       = s * g,
    # Predict values for survival and mean growth (ie size change) based on statistical models.
    s             = predict(surv_mod, 
                            newdata = data.frame(size = ht_1), 
                            type    = 'response'),
    g_mu          = predict(grow_mod, 
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    # Here the distribution of size values is generated
    g             = dnorm(ht_2, g_mu, grow_sd),
    states        = list(c("ht")),
    data_list     = params,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm", 
                                            target =  "g")
  ) %>%
  # Fecundity kernel (F) 
  define_kernel(
    name          = "F",
    family        = "CC",
    formula       = r_p * r_d * r_r, #r_p = repro probability,r_d=number recruits, r_r=recruit size distribution   
    r_p           = predict(repr_mod,
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    r_r           = recr_n,
    r_d           = dnorm(ht_2, recr_mu, recr_sd),
    states        = list(c("ht")),
    data_list     = params,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm",
                                            target =  "r_d")
  ) %>%
  # Here more info on the two kernels is given
  define_impl(
    make_impl_args_list(
      kernel_names = c("P", "F"),
      int_rule     = rep('midpoint', 2),
      state_start    = rep("ht", 2),
      state_end      = rep("ht", 2)
    )
  ) %>%
  # Here the lower and upper limits of the IPM are specified, as well as the number of classes
  define_domains(
    ht = c(L,
           U,
           mesh)
  ) %>%
  # Here the initial population distribution is defined  
  define_pop_state(n_ht = srt_distr$counts) %>%
  # This function creates the IPM by applying the functions
  make_ipm(iterate = TRUE,
           iterations = n_iter)

# Check the model 
eut_ipm
eut_ipm$sub_kernels

# Save for tomorrow
#save.image(file="IPM_construction_acai.Rdata")

###################################
# Step 8. Visualize the IPM model #
###################################


par(mfrow=c(1,2))# We can use the simple plotting function of ipmr, but this is not very flexible...
plot(eut_ipm$sub_kernels$P)
plot(eut_ipm$sub_kernels$F)

# To plot in ggplot, we first convert to a dataframe 
ipm_df <- ipm_to_df(eut_ipm, name_ps="P",f_forms="F")


ggplot(ipm_df$mega_matrix) + 
  geom_tile(aes(x=t,y=t_1,fill = value)) + 
  scale_fill_gradient2(mid="grey90",high="red")+
  scale_y_reverse(expand=c(0,0))+
  scale_x_continuous(expand=c(0,0))+
  labs(y = "Class number at time t+1",x = "Class number at time t")

# We can zoom in on smallest size classes
ggplot(ipm_df$mega_matrix) + 
  geom_tile(aes(x=t,y=t_1,fill = value)) + 
  scale_fill_gradient2(low="grey70", high="blue")+
  scale_x_continuous(limits = c(0,30))+
  scale_y_reverse(limits = c(30,0)) +
  labs(y = "Class number at time t+1",x = "Class number at time t")

# We can zoom in on reproduction
ggplot(ipm_df$mega_matrix) + 
  geom_tile(aes(x=t,y=t_1,fill = value)) + 
  scale_fill_gradient2(low="grey70", high="blue")+
  scale_x_continuous(limits = c(90,120))+
  scale_y_reverse(limits = c(20,0)) +
  labs(y = "Class number at time t+1",x = "Class number at time t")

# A 3D figure of P kernel
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=eut_ipm$sub_kernels$P[1:mesh,1:mesh],zlim=range (0,1), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")

# A 3D figure of F kernel
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=(eut_ipm$sub_kernels$F[1:200,1:200]),zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")

# A 3D figure of the total IPM, whcih is the sum of P + F 
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=(eut_ipm$sub_kernels$P[1:mesh,1:mesh]+eut_ipm$sub_kernels$F[1:mesh,1:mesh]),
      zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")

###################################
# Step 9. Do some checks of IPM   #
###################################

# And then some plots of some sums and slices of the IPMs
# Check and plot survival rates in the IPM  
colSums(eut_ipm$sub_kernels$P)
plot(x = brks_hist[-1], y=colSums(eut_ipm$sub_kernels$P), ylim=c(0.9,1.0),main = "Survival rates" ,xlab = "Palm height (m)",ylab = "Survival probaility in class (/y)")

# Check and plot reproduction rates in the IPM  
colSums(eut_ipm$sub_kernels$F)
plot(y=colSums(eut_ipm$sub_kernels$F), x = brks_hist[-1], main = "Reproduction rates", xlab = "Palm height (m)",ylab = "Number of recruits produced per individual in class (/y)")

# Check and plot statis values   
diag(eut_ipm$sub_kernels$P)
plot(y=diag(eut_ipm$sub_kernels$P), x = brks_hist[-1], main = "Statis probabilities" ,xlab = "Palm height (m)",ylab = "Probability of remaining in same class (/y)")

# Check and plot distribution of transitions to other classes
# For palms of 2 m height
which(round(brks_hist,1)==2.0) # check in what class palms are 2 m tall
eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==2.0)]
plot(y=eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==2.0)], x = brks_hist[-1], main = "Transiions of 2-m tall palms",xlab = "Palm height (m)",ylab = "Prob to move to class with height... (/y)")

# For palms of 10 m height
which(round(brks_hist,1)==10.0) # check in what class palms are 10 m tall
eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==10.0)]
plot(y=eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==10.0)], x = brks_hist[-1], main = "Transiions of 10-m tall palms", xlab = "Palm height (m)",ylab = "Prob to move to class with height... (/y)")



################################
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SEPARANDO LAJEDO E TORRE
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
################################

unique(dff$site)
table(dff$site)

torre<-dff%>%filter(site=="torre")
lajedo<-dff%>%filter(site=="lajedo")


##################################
# Step 2. Create growth models   #
##################################
all_cl<-dff_cl <- dff   #Mantive assim por facilidade mas no original outliers eram removidos
torre_cl <- torre
lajedo_cl <- lajedo


grow_torre <- nls(size_next ~ size + a + b*size + c*size^2, data = torre_cl, start=list(a=1, b=1, c=1),control=nls.control(warnOnly = T))
summary(grow_torre)

grow_lajedo <- nls(size_next ~ size + a + b*size + c*size^2, data = lajedo_cl, start=list(a=1, b=1, c=1),control=nls.control(warnOnly = T))
summary(grow_lajedo)

grow_all <- nls(size_next ~ size + a + b*size + c*size^2, data = all_cl, start=list(a=1, b=1, c=1),control=nls.control(warnOnly = T))
summary(grow_all)


# NÃO FUNCIONA AINDA! TAMANHO DOS VETORES ALL x TORRES x LAJEDO É DIFERENTE!!!
# To compare the 3 models we calculate their fitted data
#compare_grow_mod <- all_cl %>% 
#  select(id, size,size_next) %>% 
#  drop_na(size, size_next) %>% 
#  mutate(resid_model_1=resid(grow_mod_1),resid_model_2=resid(grow_mod_2),resid_model_3=resid(grow_mod_3))

grow_sd_lajedo  <- sd(resid(grow_lajedo))
grow_sd_torre  <- sd(resid(grow_torre))
grow_sd_all  <- sd(resid(grow_all))



##################################
# Step 3. SURVIVAL #
##################################
all_cl2<-dff_cl2 <- dff   #Mantive assim por facilidade mas no original outliers eram removidos
lajedo_cl2 <- lajedo
torre_cl2 <- torre  

surv_lajedo <- glm(survival ~ size, data = lajedo_cl2, family = binomial())
surv_torre <- glm(survival ~ size, data = torre_cl2, family = binomial())
surv_all <- glm(survival ~ size, data = all_cl2, family = binomial())


summary(surv_lajedo)
summary(surv_torre)
summary(surv_all)

######################################
# Step 4. Create reproduction models #
######################################

# Clean data: leave out individuals without size measurements
all_cl3<-dff_cl3 <- dff %>% 
  drop_na(size)

lajedo_cl3 <- lajedo %>% 
  drop_na(size)

torre_cl3 <- torre %>% 
  drop_na(size)


# Model 2: logistic model of reproduction probability against size
repr_all <- glm(repro ~ size, data = all_cl3, family = binomial())
summary(repr_all)

repr_lajedo <- glm(repro ~ size, data = lajedo_cl3, family = binomial())
summary(repr_lajedo)

repr_torre <- glm(repro ~ size, data = torre_cl3, family = binomial())
summary(repr_torre)

##################################
# Step 5. Recruitment parameters # 
##################################

# New recruits are those individuals with NA for size(t), and non-NA for size(t + 1)
recr_data_all <- subset(dff, is.na(size))
recr_data_lajedo <- subset(lajedo, is.na(size))
recr_data_torre <- subset(torre, is.na(size))

# All
recr_mu_all  <- mean(recr_data_all$size_next)
recr_sd_all  <- sd(recr_data_all$size_next)

# Lajedo
recr_mu_lajedo  <- mean(recr_data_lajedo$size_next)
recr_sd_lajedo  <- sd(recr_data_lajedo$size_next)

# Torre
recr_mu_torre  <- mean(recr_data_torre$size_next)
recr_sd_torre  <- sd(recr_data_torre$size_next)


# Divide a quantidade de recrutas / divido
recr_n_all   <-dim(recr_data_all)[1]/dim(subset(dff, repro==1))[1]
recr_n_torre   <-dim(recr_data_torre)[1]/dim(subset(torre, repro==1))[1]
recr_n_lajedo   <-dim(recr_data_lajedo)[1]/dim(subset(lajedo, repro==1))[1]



# Bundle all parameters and statistical models into a list. 
params_torre <- list(recr_mu = recr_mu_torre,
                     recr_sd = recr_sd_torre,
                     grow_sd = grow_sd_torre,
                     surv_mod = surv_torre,
                     grow_mod = grow_torre,
                     repr_mod = repr_torre,
                     recr_n   = recr_n_torre)


params_lajedo <- list(recr_mu = recr_mu_lajedo,
                      recr_sd = recr_sd_lajedo,
                      grow_sd = grow_sd_lajedo,
                      surv_mod = surv_lajedo,
                      grow_mod = grow_lajedo,
                      repr_mod = repr_lajedo,
                      recr_n   = recr_n_lajedo)

#======================================================================
#
#=======================================================================


eut_ipm_torre <- 
  # The first step is to decide what class of model we want to implement. 
  # We have one continuous state variable and no spatial or temporal variation to deal with. 
  # Thus, we have a simple, density independent, deterministic IPM. 
  # We initialize it with init_ipm().
  init_ipm(sim_gen = "simple", di_dd = "di", det_stoch = "det") %>%
  # Create survival & growth kernel (P) 
  define_kernel(
    name          = "P",
    family        = "CC", #this means: from continuous to continuous classes
    formula       = s * g,
    # Predict values for survival and mean growth (ie size change) based on statistical models.
    s             = predict(surv_mod, 
                            newdata = data.frame(size = ht_1), 
                            type    = 'response'),
    g_mu          = predict(grow_mod, 
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    # Here the distribution of size values is generated
    g             = dnorm(ht_2, g_mu, grow_sd),
    states        = list(c("ht")),
    data_list     = params_torre,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm", 
                                            target =  "g")
  ) %>%
  # Fecundity kernel (F) 
  define_kernel(
    name          = "F",
    family        = "CC",
    formula       = r_p * r_d * r_r, #r_p = repro probability,r_d=number recruits, r_r=recruit size distribution   
    r_p           = predict(repr_mod,
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    r_r           = recr_n,
    r_d           = dnorm(ht_2, recr_mu, recr_sd),
    states        = list(c("ht")),
    data_list     = params,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm",
                                            target =  "r_d")
  ) %>%
  # Here more info on the two kernels is given
  define_impl(
    make_impl_args_list(
      kernel_names = c("P", "F"),
      int_rule     = rep('midpoint', 2),
      state_start    = rep("ht", 2),
      state_end      = rep("ht", 2)
    )
  ) %>%
  # Here the lower and upper limits of the IPM are specified, as well as the number of classes
  define_domains(
    ht = c(L,
           U,
           mesh)
  ) %>%
  # Here the initial population distribution is defined  
  define_pop_state(n_ht = srt_distr$counts) %>%
  # This function creates the IPM by applying the functions
  make_ipm(iterate = TRUE,
           iterations = n_iter)







eut_ipm_lajedo <- 
  # The first step is to decide what class of model we want to implement. 
  # We have one continuous state variable and no spatial or temporal variation to deal with. 
  # Thus, we have a simple, density independent, deterministic IPM. 
  # We initialize it with init_ipm().
  init_ipm(sim_gen = "simple", di_dd = "di", det_stoch = "det") %>%
  # Create survival & growth kernel (P) 
  define_kernel(
    name          = "P",
    family        = "CC", #this means: from continuous to continuous classes
    formula       = s * g,
    # Predict values for survival and mean growth (ie size change) based on statistical models.
    s             = predict(surv_mod, 
                            newdata = data.frame(size = ht_1), 
                            type    = 'response'),
    g_mu          = predict(grow_mod, 
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    # Here the distribution of size values is generated
    g             = dnorm(ht_2, g_mu, grow_sd),
    states        = list(c("ht")),
    data_list     = params_lajedo,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm", 
                                            target =  "g")
  ) %>%
  # Fecundity kernel (F) 
  define_kernel(
    name          = "F",
    family        = "CC",
    formula       = r_p * r_d * r_r, #r_p = repro probability,r_d=number recruits, r_r=recruit size distribution   
    r_p           = predict(repr_mod,
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    r_r           = recr_n,
    r_d           = dnorm(ht_2, recr_mu, recr_sd),
    states        = list(c("ht")),
    data_list     = params,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm",
                                            target =  "r_d")
  ) %>%
  # Here more info on the two kernels is given
  define_impl(
    make_impl_args_list(
      kernel_names = c("P", "F"),
      int_rule     = rep('midpoint', 2),
      state_start    = rep("ht", 2),
      state_end      = rep("ht", 2)
    )
  ) %>%
  # Here the lower and upper limits of the IPM are specified, as well as the number of classes
  define_domains(
    ht = c(L,
           U,
           mesh)
  ) %>%
  # Here the initial population distribution is defined  
  define_pop_state(n_ht = srt_distr$counts) %>%
  # This function creates the IPM by applying the functions
  make_ipm(iterate = TRUE,
           iterations = n_iter)





par(mfrow=c(3,2))
plot(eut_ipm$sub_kernels$P, main="All - P")
abline(a=0,b=1,col="grey",lty=2)
plot(eut_ipm$sub_kernels$F,main="All - F")

plot(eut_ipm_torre$sub_kernels$P,main="Shruby canga - P")
abline(a=0,b=1,col="grey",lty=2)
plot(eut_ipm_torre$sub_kernels$F,main="Shruby canga - F")

plot(eut_ipm_lajedo$sub_kernels$P,main="Open canga - P")
abline(a=0,b=1,col="grey",lty=2)
plot(eut_ipm_lajedo$sub_kernels$F,main="Open shrubt - F")


ipo_SSD <- right_ev(eut_ipm,iterations=2000)
ipo_SSD_torre <- right_ev(eut_ipm_torre,iterations=2000)
ipo_SSD_lajedo <- right_ev(eut_ipm_lajedo,iterations=2000)

ipo_SSD_torre[1]

plot(ipo_SSD)

ipo_SSD%>%names()

SSD_full<-data.frame(obs_all = as.numeric(dff$size),
           obs_torre=as.numeric(torre$size),
           obs_lajedo = as.numeric(lajedo$size),
           teo_all=ipo_SSD$ht_w,
           teo_torre=ipo_SSD_torre$ht_w,
           teo_lajedo=ipo_SSD_lajedo$ht_w)%>%
  as_tibble()



str(as.numeric(dff$size))
str(as.numeric(torre$size))
str(as.numeric(lajedo$size))

SSD_obs<-data.frame(all = as.numeric(dff$size),
                    torre=as.numeric(torre$size),
                    lajedo = as.numeric(lajedo$size))
mutate(ID=row_number())%>%
  pivot_longer(!ID,names_to="VAR",values_to="OBS_ssd")

SSD_obs


SSD_tep<-data.frame(all = ipo_SSD$ht_w,
                    torre=ipo_SSD_torre$ht_w,
                    lajedo = ipo_SSD_lajedo$ht_w)%>%
  mutate(size_class=brks_hist[-1])%>%
  pivot_longer(!size_class,names_to="VAR",values_to="OBS_ssd")



ggplot(SSD_tep,aes(x=size_class,y=OBS_ssd))+
  geom_line(aes(color=VAR))

library(cowplot)




ggplot()+
  geom_point(data=SSD_tep,aes(x=size_class,y=OBS_ssd,color=VAR))+
  geom_density(data = dff, aes(x = size), col = "blue", linewidth = 1)+
geom_density(data = dff, aes(x = size), col = "red", linewidth = 1)+
geom_density(data = lajedo, aes(x = size), col = "green", linewidth = 1)+
geom_density(data = torre, aes(x = size), col = "blue", linewidth = 1)+
  theme_bw()
xlab("Size_class")+ylab("density function")

cowplot::plot_grid(
  #ALL
  ggplot()+
    geom_point(data=filter(SSD_tep,VAR=="all"),aes(x=size_class,y=OBS_ssd),color="black")+
    theme_bw()+labs(title="ALL (open canga x shrubby canga)",x="Size_class", y="density function")+
  geom_density(data = dff, aes(x = size), col = "black", linewidth = 1)
,
  #TORRE
  ggplot()+
    geom_point(data=filter(SSD_tep,VAR=="torre"),aes(x=size_class,y=OBS_ssd),color="green")+
  theme_bw()+labs(title="shrubby canga",x="Size_class", y="density function")+
  geom_density(data = torre, aes(x = size), col = "green", linewidth = 1)
,

  #LAJEDO
  ggplot()+
    geom_point(data=filter(SSD_tep,VAR=="lajedo"),aes(x=size_class,y=OBS_ssd),color="orange")+
    theme_bw()+labs(title="open canga",x="Size_class", y="density function")+
   geom_density(data = lajedo, aes(x = size), col = "orange", linewidth = 1)
)






  geom_line(aes(y=fitted(surv_mod_1)),col="red",linewidth=1) +
  geom_line(aes(y=fitted(surv_mod_2)),col="purple",linewidth=1) +
  geom_line(aes(y=fitted(surv_mod_3)),col="blue",linewidth=1) +
  labs(y = "Palm survival (/y)",x = "Palm height (m)",
       title="3 survival models: constant (red), logistic (purple), cuadratic logistic (blue)")
