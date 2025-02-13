##################################################
## Day 4. Implementing bootstrapping for acai   ##
## Data; Bolivian acai (Euterpe precatoria)     ##
## Analyses: vital rates, IPM construct & run   ##
##################################################

# Clean workspace
rm(list = ls()) # Empty workspace 
#setwd("C:/Users/Zuide015/OneDrive - Wageningen University & Research/Pieter/Teaching/IPM course/2025 Fortaleza IPM/Day4_Thursday")

# Packages
library(stats)
library(dplyr)
library(nlme)
library(ipmr)
library(ggplot2)
library(tidyr) 

# Load data on Euterpe precatoria palms
dff <- read.csv("eutprec.csv") 

##################################
# Step 1. Set the parameters     #
##################################

prop_data_left_out = 0.2
n_bootstrap        = 100
tmax_simulation    = 100 #years

L <- min(c(dff$size, dff$size_next), na.rm = TRUE) * 0.8
U <- max(c(dff$size, dff$size_next), na.rm = TRUE) * 1.2
mesh <- 200
n_iter = 500 # number of iterations

brks_hist <- seq(from=L,to=U,length.out=mesh+1)
srt_distr <- hist(dff$size,breaks=brks_hist,plot=F)
n_0 <- as.matrix(srt_distr$counts)

# Dataframe for results
bootstrap_results <- c()

##################################
# Step 2. A very long loop       #
##################################

for (i in 1:n_bootstrap) {
  subs <- sample(1:nrow(dff), size = ceiling(nrow(dff)*(1-prop_data_left_out))) #random subset of 75% size (do sensitivity check later)
  dff_subs <- dff[subs,]
  dim(dff_subs)
  # Growth model
  dff_subs_cl1 <- dff_subs %>% filter(size_next-size > -0.5)
  grow_mod_3 <- nls(size_next ~ size + (b * c * size^(c-1))/((b+((size^c)/a))^2), data = dff_subs_cl1, start=list(a=7, b=73, c=3),control=nls.control(warnOnly = T))
  grow_sd_mod_3  <- sd(resid(grow_mod_3))
  # Survival
  dff_subs_cl2 <- dff_subs %>% drop_na(survival)
  surv_mod_1 <- glm(survival ~ 1, data = dff_subs_cl2, family = binomial())
  # Sexual reproduction
  dff_subs_cl3 <- dff_subs %>% drop_na(size)
  repr_mod_2 <- glm(repro ~ size, data = dff_subs_cl3, family = binomial())
  # Number and size of seedlings
  recr_n   <- 5.9 * 0.05 # From field data we know that 5.9 small seedlings appear per reproductive adult 
  recr_data <- subset(dff_subs, is.na(size))
  recr_mu  <- mean(recr_data$size_next)
  recr_sd  <- sd(recr_data$size_next)
  params <- list(recr_mu = recr_mu,
               recr_sd = recr_sd,
               grow_sd = grow_sd_mod_3,
               surv_mod = surv_mod_1,
               grow_mod = grow_mod_3,
               repr_mod = repr_mod_2, 
               recr_n   = recr_n) 
  tryCatch(eut_ipm <- 
    init_ipm(sim_gen = "simple", di_dd = "di", det_stoch = "det") %>%
      define_kernel(
      name          = "P",
      family        = "CC", #this means: from continuous to continuous classes
      formula       = s * g,
      s             = predict(surv_mod, 
                            newdata = data.frame(size = ht_1), 
                            type    = 'response'),
      g_mu          = predict(grow_mod, 
                            newdata = data.frame(size = ht_1),
                            type    = 'response'),
      g             = dnorm(ht_2, g_mu, grow_sd),
      states        = list(c("ht")),
      data_list     = params,
      uses_par_sets = FALSE,
      evict_cor     = TRUE,
      evict_fun     = truncated_distributions(fun   = "norm", 
                                            target =  "g")
    ) %>%
    define_kernel(
      name          = "F",
      family        = "CC",
      formula       = r_p * r_d * r_r, #r_p = repro probability,r_d=number recruits, r_r=recruit size distribution   
      r_p           = predict(repr_mod,newdata = data.frame(size = ht_1),
                            type    = 'response'),
      r_r           = recr_n,
      r_d           = dnorm(ht_2, recr_mu, recr_sd),
      states        = list(c("ht")),
      data_list     = params,
      uses_par_sets = FALSE,
      evict_cor     = TRUE,
      evict_fun     = truncated_distributions(fun   = "norm",target =  "r_d")
    ) %>%
    define_impl(
      make_impl_args_list(
        kernel_names = c("P", "F"),
        int_rule     = rep('midpoint', 2),
        state_start    = rep("ht", 2),
        state_end      = rep("ht", 2)
      )
    ) %>%
    define_domains(ht = c(L,U,mesh)
    ) %>%
    define_pop_state(n_ht = srt_distr$counts) %>%
    make_ipm(iterate = TRUE, iterations = n_iter),
  error=function(e){cat("ERROR :",conditionMessage(e),"\n")})
  eut_ipm_mat <- as.matrix(eut_ipm$sub_kernels$P[1:mesh,1:mesh]+eut_ipm$sub_kernels$F[1:mesh,1:mesh])
  bootstrap_results$lambda[i] <- popbio::lambda(eut_ipm_mat)
  transdistr <- srt_distr$counts
  for (t in 1:tmax_simulation) {
    transdistr <- eut_ipm_mat %*% transdistr
  }
  bootstrap_results$lambda_transient[i] <- (sum(transdistr)/sum(srt_distr$counts))^(1/tmax_simulation)
print(i)
  }

hist(bootstrap_results$lambda)
hist(bootstrap_results$lambda_transient)
