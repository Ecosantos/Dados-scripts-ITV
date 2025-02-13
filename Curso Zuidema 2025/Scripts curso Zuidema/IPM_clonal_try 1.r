##################################################
## Day 4. Clonal growth added to acai           ##
## Data; Bolivian acai (Euterpe precatoria)     ##
## ADDED MADE-UP DATA FOR CLONAL REPRODUCTION   ##
## Analyses: vital rates, IPM construct & run   ##
##################################################

# Clean workspace
rm(list = ls()) # Empty workspace 
setwd("C:/Users/Zuide015/OneDrive - Wageningen University & Research/Pieter/Teaching/IPM course/2025 Fortaleza IPM/Day4_Thursday")

# Packages
library(stats)
library(dplyr)
library(nlme)
library(ipmr)
library(ggplot2)
library(tidyr) 

# Load data on Euterpe precatoria palms
dff <- read.csv("eutprec_CLON_Trial.csv")

##################################
# Step 1. All vital rate models  #
##################################

# Growth model
dff_cl <- dff %>% 
  filter(size_next-size > -0.5)
grow_mod_3 <- nls(size_next ~ size + (b * c * size^(c-1))/((b+((size^c)/a))^2), data = dff_cl, start=list(a=7, b=73, c=3),control=nls.control(warnOnly = T))
grow_sd_mod_3  <- sd(resid(grow_mod_3))

# Survival
dff_cl2 <- dff %>% 
  drop_na(survival)
surv_mod_1 <- glm(survival ~ 1, data = dff_cl2, family = binomial())

# Sexual reproduction
dff_cl3 <- dff %>% 
  drop_na(size)
repr_mod_2 <- glm(repro ~ size, data = dff_cl3, family = binomial())

# Clonal reproduction -- THIS IS MADE UP DATA!
clon_mod <- glm(clon ~ size, data = dff_cl3, family = binomial())
summary(clon_mod)
# Plot clonal models
ggplot(dff_cl3, aes(x = size, y = clon)) + 
  geom_point() +
  geom_line(aes(y=fitted(clon_mod)),col="blue",linewidth=1) +
  labs(y = "Clonal reproduction (DATA MADE UP!)",x = "Palm height (m)",
       title="Clonal reproduction model")

# Number and size of seedlings
recr_n   <- 5.9 * 0.05 # From field data we know that 5.9 small seedlings appear per reproductive adult 
recr_data <- subset(dff, is.na(size))
recr_mu  <- mean(recr_data$size_next)
recr_sd  <- sd(recr_data$size_next)

# Number and size of clonal recruits -- THIS IS MADE UP DATA!
clon_n   <- 0.5 # number per clonaly reproducing individual 
clon_mu  <- 1.5 # meter heights, made up because we do not have data
clon_sd  <- 0.5 # meter heights, made up because we do not have data

######################################
# Step 2. Make IPM model             #
######################################

# Bundle all parameters and statistical models into a list. 
params <- list(recr_mu = recr_mu,
               recr_sd = recr_sd,
               clon_mu = clon_mu, # for clonal reproduction
               clon_sd = clon_sd, # for clonal reproduction
               grow_sd = grow_sd_mod_3,
               surv_mod = surv_mod_1,
               grow_mod = grow_mod_3,
               repr_mod = repr_mod_2, 
               clon_mod = clon_mod, # for clonal reproduction
               recr_n   = recr_n,
               clon_n   = clon_n) # for clonal reproduction

# Set lower and upper bounds for integration. Adding 20% on either end. 
L <- min(c(dff$size, dff$size_next), na.rm = TRUE) * 0.8
U <- max(c(dff$size, dff$size_next), na.rm = TRUE) * 1.2
mesh <- 200

# Defining starting population structure
brks_hist <- seq(from=L,to=U,length.out=mesh+1)
srt_distr <- hist(dff$size,breaks=brks_hist,plot=F)

n_iter = 500 # number of iterations

# In the ipm producing code here, we now have P, F and C kernels
eut_ipm_clon <- 
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
  # Sexual reproducion kernel (F) 
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
  # Clonal reproduction kernel (C) 
  define_kernel(
    name          = "C",
    family        = "CC",
    formula       = c_p * c_d * c_r, #c_p = clonal probability,c_d=number clonal recruits, r_r=recruit size distribution   
    c_p           = predict(clon_mod,
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
    c_r           = clon_n,
    c_d           = dnorm(ht_2, clon_mu, clon_sd),
    states        = list(c("ht")),
    data_list     = params,
    uses_par_sets = FALSE,
    evict_cor     = TRUE,
    evict_fun     = truncated_distributions(fun   = "norm",
                                            target =  "c_d")
  ) %>%
  # Here more info on the three kernels is given
    define_impl(
      make_impl_args_list(
        kernel_names = c("P", "F","C"),
        int_rule     = rep('midpoint', 3),
        state_start    = rep("ht", 3),
        state_end      = rep("ht", 3)
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
eut_ipm_clon
eut_ipm_clon$sub_kernels

###################################
# Step 3. Visualize the IPM model #
###################################

# To plot in ggplot, we first convert to a dataframe 
eut_ipm_clon_df <- ipm_to_df(eut_ipm_clon, name_ps="P",f_forms="F + C")

ggplot(eut_ipm_clon_df$mega_matrix) + 
  geom_tile(aes(x=t,y=t_1,fill = value)) + 
  scale_fill_gradient2(low="grey70", high="blue")+
  scale_y_reverse()+
  labs(y = "Class number at time t+1",x = "Class number at time t")
  
# We can zoom in on reproduction
ggplot(eut_ipm_clon_df$mega_matrix) + 
  geom_tile(aes(x=t,y=t_1,fill = value)) + 
  scale_fill_gradient2(low="grey70", high="blue")+
  scale_x_continuous(limits = c(mesh/3,mesh))+
  scale_y_reverse(limits = c(40,0)) +
  labs(y = "Class number at time t+1",x = "Class number at time t")

# A 3D figure of P kernel
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=eut_ipm_clon$sub_kernels$P[1:mesh,1:mesh],zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")
# A 3D figure of F kernel
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=(eut_ipm_clon$sub_kernels$F[1:mesh,1:mesh]),zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")
# A 3D figure of C kernel
persp(x=brks_hist[-1],y=brks_hist[-1],
      z=(eut_ipm_clon$sub_kernels$C[1:mesh,1:mesh]),zlim=range (0,.5), xlab = "Palmheight at t+1 (m)", ylab = "Palmheight at t (m)", zlab = "Transition",
      theta = 30, phi = 40, r = 3, d = 2, expand = 0.3, col = "white", border = NULL, shade = NA, 
      box = TRUE, axes = TRUE, nticks = 5, ticktype = "detailed")

###################################
# Step 4. IPM output with C       #
###################################

# Here we get the total transition matrix, by adding all three kernels (P, F and C)
eut_ipm_clon_mat <- as.matrix(eut_ipm_clon$sub_kernels$P[1:mesh,1:mesh]+eut_ipm_clon$sub_kernels$F[1:mesh,1:mesh]+eut_ipm_clon$sub_kernels$C[1:mesh,1:mesh])
popbio::lambda(eut_ipm_clon_mat)

# Elasticity
eut_clon_elas <- elas(eut_ipm_clon_mat)

# To plot in ggplot, convert to dataframe
eut_clon_elas_df <- reshape2::melt(eut_clon_elas, c("x", "y"), value.name = "z")

ggplot(eut_clon_elas_df) + 
  geom_tile(aes(x=x,y=y,fill = z)) + 
  scale_y_reverse()+
  scale_fill_gradient2(low="grey70", high="blue")+
  labs(y = "Class number at time t+1",x = "Class number at time t")

