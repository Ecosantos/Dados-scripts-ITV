#'################################################
# Script viabilidade populacional Ipomoea
#
#
#'################################################
library(popbio)
library(tidyverse)

rm(list=ls())

# MPM Torre
A1<- matrix(data=c(0,0.4,0, 0,0.7,0.18, 1.433,0.164,0.794), nrow=3, ncol=3) 

lambda(A1)
# MPM lajedo
A2<- matrix(data=c(0,0.25,0, 0,0.85,0.05, 2.72,0.27,0.73), nrow=3, ncol=3) #Lajedo

lambda(A1)
lambda(A2)

AA<-mean(list(A1,A2))
mean(AA)
lambda(AA)

dano<-seq(0,.90,by=0.03)


res<-NULL
for(i in 1:length(dano)){
  res[[i]] <- list()
  res[[i]]$projpop<-pop.projection((AA-(AA*dano[i])),stable.stage(AA),iterations=11)$pop.sizes
  res[[i]]$extinctpop<- res[[i]]$projpop<.1
  res[[i]]$firstextinct<-which(res[[i]]$extinctpop == TRUE)[1]
  res[[i]]$extinct_many<-length(which(res[[i]]$extinctpop == TRUE))  
  res[[i]]$lambda<-lambda(AA-(AA*dano[i]))
  res[[i]]$dano<-dano[i]
    }

tabela_projpop <- do.call(rbind, lapply(seq_along(res), function(i) {
  data.frame(
    t = seq_along(res[[i]]$projpop),
    dano = res[[i]]$dano,
    projpop = res[[i]]$projpop
  )
}))

tabela_projpop%>%
#  mutate(dano=as.factor(dano))%>%
  ggplot(.,aes(x=t-1,y=projpop*100,group=dano))+
  geom_line(aes(color=dano*100))+
#  viridis::scale_color_viridis(option="magma")+
  scale_color_stepsn(
    #    colours = c("red", "yellow", "green", "yellow", "red"),
    # colours = viridis::viridis(n = 7, option = "inferno",direction=-1) ,
    colours = rev(viridis::viridis(n = 5, option = "magma", direction = -1)))+ 
  theme_classic(base_size=16)+
  scale_x_continuous(breaks=seq(0,10,by=1),expand = c(0, 0))+
  scale_y_continuous(labels = scales::percent_format(scale = 1),
                     expand = c(0, 0),
                     breaks=c(0,10,seq(50,200,by=50)))+
  geom_hline(yintercept=10,color="tomato",linetype="dashed")+
  labs(color="Impacto/Redução (%)",
       y="Projeção populacional",
       x="Anos projetados")+
  theme(legend.position="bottom")


tabela_extincao <- do.call(rbind, lapply(seq_along(res), function(i) {
  data.frame(
    dano = res[[i]]$dano,
    firstextinct = res[[i]]$firstextinct,
    extinct_many = res[[i]]$extinct_many,
    lambdas=res[[i]]$lambda
  )
}))

#tabela_extincao$firstextinct[is.na(tabela_extincao$firstextinct)]<-Inf


plot(tabela_extincao$lambdas~tabela_extincao$dano)
form<-lm(tabela_extincao$lambdas~tabela_extincao$dano)

# Encontra o valor de dano para os lambdas de interesse
lambda_target <- 1
coef <- coef(form)
dano_for_target_lambda <- (lambda_target - coef[1]) / coef[2]
dano_for_target_lambda*100  #Multipla por 100 para porcentagem

plot(tabela_extincao$firstextinct~tabela_extincao$dano)
form_extinct<-lm(tabela_extincao$firstextinct~tabela_extincao$dano)
abline(form_extinct)


extinct_target <- 9
coef2 <- coef(form_extinct)
dano_for_target_extinct <- (extinct_target - coef2[1]) / coef2[2]
dano_for_target_extinct*100  #Multipla por 100 para porcentagem





tabela_extincao%>%
  ggplot(.,aes(x=dano,y=lambdas,color=firstextinct))+
  geom_line(size=2)+
  geom_hline(yintercept=1,colour="tomato",linetype=2)+
  theme_minimal(base_size=18)+
  labs(colour="Tempo até extinção \n (em anos)")+
  scale_color_stepsn(
#    colours = c("red", "yellow", "green", "yellow", "red"),
# colours = viridis::viridis(n = 7, option = "inferno",direction=-1) ,
 colours = RColorBrewer::brewer.pal(n = 7, name = "Spectral") ,
    breaks = c(5, 10, 15,20, 25, 30)
  )



lambda(AA)
pop.projection(AA,stable.stage(AA),iterations=30)

res[1:2]


