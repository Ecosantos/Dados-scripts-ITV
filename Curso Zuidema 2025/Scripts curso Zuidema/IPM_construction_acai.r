##################################################
## Day 2. IPM construction                      ##
## Data; Bolivian acai (Euterpe precatoria)     ##
## Analyses: vital rate models and IPM contruct ##
##################################################

# Clean workspace
rm(list = ls()) # Empty workspace 
#setwd("C:/Users/Zuide015/OneDrive - Wageningen University & Research/Pieter/Teaching/IPM course/2025 Fortaleza IPM/Day2_Tuesday")

# Packages
install.packages(c("dplyr","nlme","ipmr","ggplot2","tidyr"))
library(stats)
library(dplyr)
library(nlme)
library(ipmr)
library(ggplot2)
library(tidyr) 

# Load data on Euterpe precatoria palms
dff <- read.csv("eutprec.csv")

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

# We remove some negative outliers (>0,5 m negative), possibly errors
dff_cl <- dff %>% 
  filter(size_next-size > -0.5)

# We will try three growth models, with increasing complexity

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

# Growth model 3 = non-linear model with  Hossfeld equation (used for trees)
grow_mod_3 <- nls(size_next ~ size + (b * c * size^(c-1))/((b+((size^c)/a))^2), data = dff_cl, start=list(a=7, b=73, c=3),control=nls.control(warnOnly = T))
summary(grow_mod_3)

# To compare the 3 models we calculate their fitted data
compare_grow_mod <- dff_cl %>% 
  select(id, size,size_next) %>% 
  drop_na(size, size_next) %>% 
  mutate(resid_model_1=resid(grow_mod_1),resid_model_2=resid(grow_mod_2),resid_model_3=resid(grow_mod_3))

# Plot the models with growth on y-axis 
ggplot(compare_grow_mod, aes(x=size, y=size_next-size)) + 
  geom_point(pch=1) + 
  geom_line(aes(y=fitted(grow_mod_1)-size),col="red",linewidth=1) + 
  geom_line(aes(y=fitted(grow_mod_2)-size),col="purple",linewidth=1) + 
  geom_line(aes(y=fitted(grow_mod_3)-size),col="blue",linewidth=1) +
  labs(y = "Palm growth (m/y)",x = "Palm height (m)",
       title="3 Growth models: linear (red), cuadratic (purple), Hossfeld (blue)")

# Plot models with size_next on y axis
ggplot(compare_grow_mod, aes(x=size, y=size_next)) + 
  geom_point(pch=1) + 
  geom_line(aes(y=fitted(grow_mod_1)),col="red",linewidth=1) + 
  geom_line(aes(y=fitted(grow_mod_2)),col="purple",linewidth=1) + 
  geom_line(aes(y=fitted(grow_mod_3)),col="blue",linewidth=1) +
  labs(y = "Palm height at t+1 (m/y)",x = "Palm height at t (m)",
       title="3 Growth models: linear (red), cuadratic (purple), Hossfeld (blue)")

# Plot residuals of models
ggplot(compare_grow_mod) + 
  geom_density(aes(x=resid(grow_mod_1)),col="red",linewidth=1) + 
  geom_density(aes(x=resid(grow_mod_2)),col="purple",linewidth=1) + 
  geom_density(aes(x=resid(grow_mod_3)),col="blue",linewidth=1) +
  labs(y = "Density",x = "Palm height next (m) or palm growth (m/y)",
       title="3 Growth models: linear (red), cuadratic (purple), Hossfeld (blue)")

# Compare goodness of fit of three models  
AIC(grow_mod_1,grow_mod_2,grow_mod_3)

grow_sd_mod_1  <- sd(resid(grow_mod_1))
grow_sd_mod_2  <- sd(resid(grow_mod_2))
grow_sd_mod_3  <- sd(resid(grow_mod_3))

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

# We also need the number of recruits produced per reproductive palm 
recr_n   <- 5.9 * 0.05 # From field data we know that 5.9 small seedlings appear per reproductive adult 
# The 5% is an estimate of the proportion that survives to become a palm of 0.4 m in height. 

# New recruits are those individuals with NA for size(t), and non-NA for size(t + 1)
recr_data <- subset(dff, is.na(size))
hist(recr_data$size_next)
recr_mu  <- mean(recr_data$size_next)
recr_sd  <- sd(recr_data$size_next)

######################################
# Step 6. Prepare info for IPM model #
######################################

# Bundle all parameters and statistical models into a list. 
params <- list(recr_mu = recr_mu,
               recr_sd = recr_sd,
               grow_sd = grow_sd_mod_3,
               surv_mod = surv_mod_1,
               grow_mod = grow_mod_3,
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
save.image(file="IPM_construction_acai.Rdata")

###################################
# Step 8. Visualize the IPM model #
###################################

# We can use the simple plotting function of ipmr, but this is not very flexible...
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
      z=eut_ipm$sub_kernels$P[1:mesh,1:mesh],zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
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

# For palms of 32 m height
which(round(brks_hist,1)==32.2)
eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==32.2)]
plot(y=eut_ipm$sub_kernels$P[1:200,which(round(brks_hist,1)==32.2)], x = brks_hist[-1], main = "Transiions of 32-m tall palms" ,xlab = "Palm height (m)",ylab = "Prob to move to class with height... (/y)")


