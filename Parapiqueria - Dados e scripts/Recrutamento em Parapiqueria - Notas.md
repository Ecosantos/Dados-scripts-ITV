---
enableTimeBar: true
---

> [!info] **Compilação pessoal de informações**
> - **Temática**: Delineamento amostral de Parapiqueria; Estimativa de densidade por metro quadrado
> - **Tags:** #Projetos/ITV/Parapiqueria   
> - **Ver também:**
> 	- [[Demografia de Parapiqueria - geral overview]]
> 	- [[Parcelas, Área e densidade de Parapiqueria]]

# Overview
- Recrutamento é Máximo Imaturos / Máximo Reprodutivo 
	- Ver em: [[#Justificativa escolha dos parâmetros do modelo]]
- Recrutamento em S11C é maior que S11B
	- Independente da forma de estimar o recrutamento
		- [[#GLM ou razão simples?]]
- Resultados coincidem com o que Talita havia encontrado no estudo de germinação.
	- ver em [[#Relação entre recrutamento e viabilidade da semente]]
- Não detectei nenhuma diferença significativa que pudesse indicar viés de amostragem ao longo das mudanças de metodologia e equipe
	- [[#Viés de amostragem leva a diferenças no recrutamento?]]
- glm com distribuição binomial é a melhor forma de estimar recrutamento (se considerarmos os glms)
	- [[#GLM com melhores modelos de recrutamento]]
# Relação entre recrutamento e viabilidade da semente
- As análises de recrutamento coincidem com as taxas de germinação mas são inversas ao número de sementes produzidas de acordo com o [[9 - ITV/Arquivos/Relatórios/Exemplo/Parapiqueria - Apresentação Talita Fev-2024.pdf|relatório da Talita referente ao ano de 2022]]
	- Recrutamento em S11C é maior que S11B
		- Bem como na germinação das sementes S11C>S11B
		- Ainda que a produção de sementes em S11B>S11C.
		- Talita não encontrou diferença na viabilidade das sementes de S11C e S11B
	- Independente se foram utilizando razão simples ($MaxImaturo_{t_1} /MaxRep_{t_0}$) ou modelos glm (ver em [[#GLM ou razão simples?]]) 
# Viés de amostragem leva a diferenças no recrutamento?
- As amostragens, que começaram em 2022 foram gradualmente mudando para Parapiqueria. Seja na composição das equipes responsáveis pela amostragem dos indivíduos, quanto na forma de amostrar, que passou a ser delimitada por quadrantes, facilitando a contagem dos indivíduos e provavelmente reduzido erros de contagem.  ^e656da
- Por conta dessas mudanças havia, em início de 2024, uma preocupação quanto a qualidade dos dados obtidos, principalmente no ano de 2022 (que não tinha os quadrantes). Havia discussão inclusive sobre não utilizar esses dados de 2022. [
- Quando comparamos o número de indivíduos de um ano para outro, no entanto, encontramos que:
	- Há naturalmente uma grande variação (que fica visível tanto nos períodos (2022–2023 e 2023–2024)
	- As setas (figura B) não ficam sistematicamente na mesma direção
	- A diferença é predominante para indivíduos jovens, que de fato tem uma grande variação.

>[! column] Comparação no recrutamento entre os diferentes anos
>>[! info] Legenda figuras
>>Essa daqui é a relação entre indivíduos amostrados em t0 e t1. Cada painel é a relação entre o número de indivíduos em um estágio em t0 e número de indivíduos em outro (ou mesmo estágio) em t1. (ou seja, entre 2022-2023 e 2023-2024).
>>- MaxIm=Máximo indivíduos imaturos
>>- MaxRep = Máximo indivíduos reprodutivos 
>>- MaxTot  = Máximo indivíduos totais.
>>Então os rótulos acima são referentes a, por exemplo:
>>- MaxRep>MaxRep = Máximo Reprodutivos em t0 e MaxRep em t1
>>- MaxTot>MaxIm = Máximo Total em t0 e Máximo de imaturos em t1
>>- De certa forma isso dá uma noção grosseira da taxa de recrutamento.
>>- Figura B é o mesmo gráfico. As linhas conectam os mesmos plots nos diferentes anos. Triangulo é 2023-2024 e bolinha 2022-2023
>>  Na figura B ainda foi adicionado o MaxIm t0 > MaxIm t1 para mostrar que a maior dispersão (diferença entre anos) está justamente nos indivíduos jovens.
>>  Na figura C o número máximo de indivíduos é comparado entre intervalos entre anos e não parecem apresentar qualquer indício de difereça entre anos e sítios quanto ao recrutamento.
>>  Aqui novamente é possível ver valores bastante altos de indivíduos tanto no ano de 2022 quanto de 2023
>
>>[! info]
>>![[Pasted image 20240809144838.png|Figura A - Taxa de recrutamento por riacho]]
>>![[Pasted image 20240809144713.png|Figura B - Taxa de recrutamento por riacho e por córrego]]
>>![[Pasted image 20240809153335.png|Figura C - Recrutamento - Ano t0 comparado com t1]]


# GLM ou razão simples?
- Através da razão simples de recrutamento $MaxIm_{t1}/MaxRep_{t0}$ eu consigo facilmente um valor de recrutamento por plot e por ano. Isso me permute realizar análises de LTRE facilmente.
- Já utilizando o GLM eu estou com dificuldades para simular valores e incorporar nos plots. Apenas fazendo de maneira coletiva.
	- Uma possivel solução passa pelo seguinte 
```{R Possivel_solução_simulação_a_partir_do_glmNB}


# Sendo que que o valor de theta foi obtido da seguinte forma.
# Theta_bestS11C<-bestS11C$fit$par[names(bestS11C$fit$par)=="theta"]


mpm_list_recruit_S11C%>%lapply(.,as.vector)%>%do.call(rbind,.)%>%
data.frame()%>%as_tibble()%>%
mutate(lower_est=quantile(rnbinom(1000, mu = X3, size = Theta_bestS11C),0.025))%>%
mutate(higher_est=quantile(rnbinom(1000, mu = X3, size = Theta_bestS11C),0.975))


rnbinom(1000, 
mu = data.frame(do.call(rbind,lapply(mpm_list_recruit_S11B,as.vector)))$X3,
size = Theta_bestS11B)%>%mean()

```
- A diferença entre os dois é bem grande
	- No GLM os valores giram em algo como
		- $Recrutamento = 1.10 [1.09-1.11] standard~error$
	- Já na estimativa direta
		- $Recrutamento~S11C~2022=2.34;S11B~2022=0.87$
	- Quando eu simulo os valores a partir da solução oferecida acima esses valores muito sentido, já que a maioria dos valores simulados retornaram 0 e quando eu determino o limite do quantil inferior quase todos os valores são 0 

```{R temporário}
RepTot%>%
 mutate(recruit=t1/t0)%>%
ungroup()%>%
 group_by(Site,year)%>%
summarise(mean=mean(recruit),
 sd=sd(recruit))
```

# GLM com melhores modelos de recrutamento
Modelo escolhido foi:

$$
\begin{matrix}
Reprodutive>Immatures:\\
\\
Immatures_{t_1} \sim 0+Reproductives_{t_0} + Site + (1|period) \tag{1A}
\\
NBin(\mu, \theta)
\end{matrix}
$$

onde,
- $Immatures_{t_1}$ número de indivíduos imaturos em $t_1$
- $Reproductives_{t_0}$ número de indivíduos reprodutivos em $t_0$
- Site = riachos (S11B e S11C)
- $(1|Period)$ é o random effect do modelo.
	- onde Period = pares de censos (2022-2023 e 2023-2024) 
- NBin significa uma distribuição binomial negativa com $\mu$ e $\theta$ sendo os parâmetros que descrevem a distribuição dos dados utilizados.


## Justificativa escolha dos parâmetros do modelo 
### Escolha dos modelos $Reproductive > Total$
- Os modelos considerando $Reproductive > Total$ (AIC=421) tiveram um AIC levemente pior do que $Reproductive > Imatures$ (AIC=417)
	- Por outro lado o modelo $Reproductive > Total$ parece ser mais adequado, pois:
		- Considera a possibilidade do imaturo não ser contabilizado, passando direto para a fase de reprodutivo nos nossos censos
			- A quantidade total de indivíduos (Max. Tot) precisa ter saído de algum lugar, logo se o total de individuos é maior que o maior número máximo de imaturos, o modelo não sabe o que fazer com essa diferença de individuos.
		- Ainda, o número de indivíduos totais parece estar muito mais correlacionado com o total de imaturos (correlação $\rho = 0.94$) do que com o total de reprodutivos (correlação $\rho = 0.73$).
			- Dessa maneira é provável que a escolha dos modelos não altere os resultados; 

>[! info|bg-c-blue]- Seleção de modelos Imaturos e Total x Máximo reprodutivo
> #### Seleção de modelos Imaturos em função do máximo de individíduos reprodutivos
> 
> | formula                                   | Var    | Dist    | K   | AICc   | Delta_AICc | AICcWt | Cum.Wt |
> | -----------------------------------------: | ------ | :-------: | :---: | :------: | :----------: | :------: | :------: |
> | $t_{0} \sim -1+t_{0}+Site+(1\mid period)$ | Rep>Im | Neg.Bin | 5   | 417.58 | 0.000      | 0.647  | 0.647  |
> | $t_{0} \sim -1+t_{0}*Site+(1\mid period)$ | Rep>Im | Neg.Bin | 6   | 420.06 | 2.487      | 0.186  | 0.834  |
> | $t_{0} \sim -1+Site+(1\mid period)$       | Rep>Im | Neg.Bin | 4   | 420.32 | 2.7405     | 0.164  | 0.998  |
> | $t_{0} \sim -1+t_{0}+(1\mid period)$      | Rep>Im | Neg.Bin | 3   | 429.83 | 12.249     | 0.001  | 1.000  |
>
> #### Seleção de modelos Total em função do máximo de individíduos reprodutivos
>
> | formula                                   | Var     | Dist    | K   | AICc    | Delta_AICc | AICcWt | Cum.Wt |
> | -----------------------------------------: | :-------: | :-------: | :---: | :-------: | :----------: | :------: | :------: |
> | $t_{0} \sim -1+t_{0}+Site+(1\mid period)$ | Rep>Tot | Neg.Bin | 5   | 421.08  | 0.000      | 0.6194 | 0.619  |
> | $t_{0} \sim -1+t_{0}*Site+(1\mid period)$ | Rep>Tot | Neg.Bin | 6   | 423.392 | 2.313      | 0.1947 | 0.814  |
> | $t_{0} \sim -1+Site+(1\mid period)$       | Rep>Tot | Neg.Bin | 4   | 423.519 | 2.427      | 0.1840 | 0.998  |
> | t$t_{0} \sim -1+t_{0}+(1\mid period)$     | Rep>Tot | Neg.Bin | 3   | 432.78  | 11.696     | 0.0017 | 1.000  |
>

### Comparação com o modelo nulo
No modelo nulo a reprodução não seria afetada nem pelo sítio nem pelo número de individuos no ano $t_0$. Nesse caso, no entanto, há a necessidade de se incluir o intercepto. Dessa forma, o modelo é representado por $t_{0} \sim 1 +(1\mid period)$

|          **Variável**           |           **Modelo**           | **AIC** | **Diferença AIC** | **Posição em relação aos demais modelos** |
| :-----------------------------: | :----------------------------: | :-----: | :---------------: | :---------------------------------------: |
|   *Reproductives > Immatures*   | $t_{0} \sim 1 +(1\mid period)$ | 423.34  |       5.76        |                    4º                     |
| *Reproductives >Maximum  Total* | $t_{0} \sim 1 +(1\mid period)$ | 423.34  |       2.26        |                    2º                     |
### Melhor distribuição para os modelos de recrutamento
- Os modelos com distribuição binomial negativa tiveram uma performance muito superior ao Poisson em todos os modelos.
	- AIC dos modelos com negative binomial variou entre 420-430, já os modelos com Poisson foram superiores a 1200.
- Os modelos utilizando Poisson diversas vezes apresentaram conflito durante as análises de seleção de modelos
	- A maioria dos problemas parece ter acontecido entre os modelos ajustados com Poisson para Reprodutivos>Imaturos parece ter sido.
		- Justamente os modelos que fazem mais sentido.

### Incluir ou não incluir o intercepto no modelo?
- Escolhi não incluir o intercepto no modelo.
	- Não incluir o intercepto força o modelo a estimar uma relação em que $t_0$ quando 0 terá também $t_1$ como 0.
		- Essa abordagem foi utilizada no livro de IPM do Ellner. Descrever com mais detalhes como foi utilizado e quais as interpretações dos autores
		- Acredito que represente uma abordagem mais realística  com que esperamos.
### GLM ou GLMM — qual melhor abordagem nesse caso?
- Optei por utilizar um GLMM deixando o período entre os censos (2022–2023, 2023–2024) como fator aleatório.
- Nosso interesse é produzir uma estimativa de recrutamento.
	- Porém, quando considero o período como fator fixo preciso criar interações entre os riachos e isso me gera diferentes valores de Beta que não sei como trabalhar
		- Ver figura abaixo glm com interação
	- A escolha de incluir o período entre censos como fator aleatório surge justamente de reduzir esse problema.
		- Ao incluir o período como fator aleatório, sua variabilidade continua sendo contabilizada, porém dentro de cada riacho. Dessa maneira, consigo estimar valores de recrutamento e seus respectivos erros padrão em um único modelo glmm. Nenhuma outro cálculo ou transformação é necessária.
	- Quando incluo a interação ou não no GLMM não há grandes mudanças como é possível ver na figura abaixo.
		- Visualmente o glmM **COM** interação (gráfico do centro) deixa de tocar o eixo o eixo y em t1=125

>[! grid]
>![[Pasted image 20240815150537.png| glm aditivo t1~0+t0+Site+(1|period)]]
>![[Pasted image 20240815151553.png|glmM com interação t1~0+t0*Site+(1|period)]]
>![[Pasted image 20240815150610.png|glm com interação  - (nb_RepTot,t1~0+t0+Site*period)]]

### Diferenças de recrutamento ao longo dos períodos (2022–2023 e 2023–2024)
- Detectei uma diferença no recrutamento entre anos. 
- É importante entender isso melhor no futuro.

### Escolha do pacote: glmmTMB
- Rodei as análises com dois pacotes. lme4 e glmmTMB.
	- No caso do pacote lme4 os modelos, tanto poisson quanto negative binomial retornam possível erro de convergência do estimador. 
	- Aparentemente resultando em valores muito baixos de random effect.
	- O pacote glmmTMB por outro lado não retorna nenhum aviso de erro

```{R Mensagem_de_erro}
In checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv,  :
  Model is nearly unidentifiable: very large eigenvalue
 - Rescale variables?
```

 
# Ilustrações
>[! grid]
>![[Modelos possiveis recrutamento Parapiqueria.excalidraw| Modelos possíveis Parapiqueria]]
>![[Pasted image 20240815101343.png|Relação entre indivíduos imaturos, reprodutivos e máximo total]]{width: 100px}


# Minimum reproducible code

## Gráficos de recrutamento
```{R Recrutamento_plots}

Census_all_max 


pairCensus<-Census_all_max %>%
  mutate(year = as.numeric(year)) %>%
  group_by(Plot) %>%
  arrange(year, stage) %>%
  mutate(VAR = paste0(stage, "-", lead(stage, order_by = interaction(stage,year)))) %>%
  mutate(t0y = year,
         t1y = lead(year, order_by = VAR))%>%
  mutate(t0 = value, 
         t1 = lead(value, order_by = VAR)) %>%
filter(t1y>t0y)%>%
arrange(Plot,VAR)

pairCensus%>%
filter(VAR!="MaxIm-MaxRep")%>%
mutate(period=paste0(t0y,"-",t1y))%>%
ggplot(.,aes(x=t0+1,y=t1+1))+
geom_point(aes(color=period))+
geom_abline(intercept=0,slope=1)+
#scale_x_continuous(trans='log10',limits=c(1,450)) +
#scale_y_continuous(trans='log10',limits=c(1,450)) +
facet_grid(Site~VAR)+
xlim(0,450)+ylim(0,450)+
theme_grey(base_size=14)


#---------------------------------------------------------------------------
#	FINAL! ESSE TÁ CERTO, FINALMENTE!
#---------------------------------------------------------------------------

Timelags_base<-Census_all_max %>%
  mutate(year = as.numeric(year)) %>%
  group_by(Plot) %>%
  arrange(year, stage) %>%
  mutate(VAR = paste0(stage, ">", lead(stage, order_by = interaction(year,stage)))) %>%
  mutate(t0y = year,
         t1y = lead(year, order_by = VAR))%>%
  mutate(t0 = value, 
         t1 = lead(value, order_by = VAR)) %>%
filter(t1y>t0y)%>%	#It only returns with timelag. Change interaction to return same year variables
arrange(Plot,VAR)



#Pairing Maximum reprodutctive to Max Total
RepTot<-left_join(
filter(Timelags_base,stage=="MaxRep")%>%select(Site:Plot,t0y,t0),
filter(Timelags_base,stage=="MaxTot")%>%select(Site:Plot,t1y,t1))%>%
mutate(VAR="MaxRep>MaxTot")%>%
select(VAR,Site:t0y,t1y,t0,t1)	#Reorder columns

#Pairing Maximum reprodutctive to Max Total
TotIm<-left_join(
filter(Timelags_base,stage=="MaxTot")%>%select(Site:Plot,t0y,t0),
filter(Timelags_base,stage=="MaxIm")%>%select(Site:Plot,t1y,t1))%>%
mutate(VAR="MaxTot>MaxIm")%>%
select(VAR,Site:t0y,t1y,t0,t1)	#Reorder columns



dplyr::bind_rows(Timelags_base,
RepTot,TotIm)%>%
filter(VAR!="MaxIm>MaxIm")%>%
mutate(period=paste0(t0y,"-",t1y))%>%
ggplot(.,aes(x=t0+1,y=t1+1))+
geom_abline(intercept=0,slope=1,linetype="longdash",color="grey70")+
geom_point(aes(color=period))+
#scale_x_continuous(trans='log10',limits=c(1,450)) +
#scale_y_continuous(trans='log10',limits=c(1,450)) +
guides(color=guide_legend(nrow=2))+
xlim(0,380)+ylim(0,380)+
theme_bw(base_size=14)+
facet_grid(Site~VAR)+
labs(
color="Periods",,
x=expression(paste("Individuals in ",italic("t_0"))),
	y=expression(paste("Individuals in ",italic("t_1"))))+
facet_grid(Site~VAR,scales="free")



#--------------------------------------------------------
#	Gráfico com setas
#--------------------------------------------------------
dplyr::bind_rows(Timelags_base,
RepTot,TotIm)%>%
#filter(VAR!="MaxIm>MaxIm")%>%
mutate(period=paste0(t0y,"-",t1y))%>%
ggplot(.,aes(x=t0+1,y=t1+1))+
geom_abline(intercept=0,slope=1,linetype="longdash",color="grey70")+
geom_point(aes(shape=period,color=as.factor(Plot)))+
geom_line(
	arrow = arrow(length=unit(0.1,"cm"), ends="last", type = "closed"),
aes(group = Plot,color=as.factor(Plot)),linetype="solid",alpha=.7)+
#scale_x_continuous(trans='log10',limits=c(1,450)) +
#scale_y_continuous(trans='log10',limits=c(1,450)) +
guides(color=guide_legend(ncol=2),
	shape=guide_legend(nrow=2))+
xlim(0,380)+ylim(0,380)+
theme_bw(base_size=14)+
labs(
color="Plots",shape="Periods",
x=expression(paste("Individuals in ",italic("t_0"))),
	y=expression(paste("Individuals in ",italic("t_1"))))+
facet_grid(Site~VAR,scales="free")+
theme(legend.position="bottom")


#-------------------------------------------
# COMPARAÇÃO PAR-A-PAR ABUNDANCIA ANOxSITIO
#-------------------------------------------
Timelags_base%>%
mutate(period=paste0(t0y,"-",t1y))%>%
pivot_longer(c(t0,t1),names_to="time",values_to="values")%>%
ggplot(.,aes(x=time,y=values,group=interaction(Plot,year,Site)))+
geom_line(aes(color=period))+
geom_point(aes(fill=period),shape=21)+
facet_grid(Site~VAR)+
labs(y="Individuals")


```


## Seleção de modelos para estimar recrutamento
```{R GLM_recrutamento_seleção_modelos}

#########################################################
#			RECRUITMENT
#-------------------------------------------------------
#
# Estimate recruitment in Parapiqueria between 2022-2024
#	Versão extendida para tomada de notas
#########################################################

#========================================================
#		Data preparation
#========================================================
Census_all<-rbind(
cbind(census2024,year="2024"),
cbind(census2023,year="2023"),
cbind(census2022,year="2022"))%>%
pivot_longer(Imaturos:Reprodutivos,names_to="stage")


#Maximum number of individuals 
Census_all_max<-rbind(
cbind(census2024,year="2024"),
cbind(census2023,year="2023"),
cbind(census2022,year="2022"))%>%
group_by(Site,year,Plot)%>%
summarise(MaxIm=max(Imaturos),
	MaxRep=max(Reprodutivos))%>%
mutate(MaxTot=ifelse(MaxIm>MaxRep,MaxIm,MaxRep))%>%
pivot_longer(MaxIm:MaxTot,names_to="stage")

	
#setting t0 and t1
#Pairing timelags

Timelags_base<-Census_all_max %>%
  mutate(year = as.numeric(year)) %>%
  group_by(Plot) %>%
  arrange(year, stage) %>%
  mutate(VAR = paste0(stage, ">", lead(stage, order_by = interaction(year,stage)))) %>%
  mutate(t0y = year,
         t1y = lead(year, order_by = VAR))%>%
  mutate(t0 = value, 
         t1 = lead(value, order_by = VAR)) %>%
filter(t1y>t0y)%>%	#It only returns with timelag. Change interaction to return same year variables
arrange(Plot,VAR)

#----------------------------------------------------------------------------
# Max Rep in t0 vs. MaxTot in t1
#----------------------------------------------------------------------------
#Pairing Maximum reprodutctive to Max Total
RepTot<-left_join(
filter(Timelags_base,stage=="MaxRep")%>%select(Site:Plot,t0y,t0),
filter(Timelags_base,stage=="MaxTot")%>%select(Site:Plot,t1y,t1))%>%
mutate(VAR="MaxRep>MaxTot")%>%
select(VAR,Site:t0y,t1y,t0,t1)%>%	#Reorder columns
mutate(Site=as.factor(Site))%>%
mutate(period=as.factor(paste0(t0y,"-",t1y)))

#----------------------------------------------------------------------------
# Max Rep in t0 vs. MaxIm in t1
#----------------------------------------------------------------------------
RepIm<-left_join(
filter(Timelags_base,stage=="MaxRep")%>%select(Site:Plot,t0y,t0),
filter(Timelags_base,stage=="MaxIm")%>%select(Site:Plot,t1y,t1))%>%
mutate(VAR="MaxRep>MaxIm")%>%
select(VAR,Site:t0y,t1y,t0,t1)%>%	#Reorder columns
mutate(Site=as.factor(Site))%>%
mutate(period=as.factor(paste0(t0y,"-",t1y)))

#========================================================
#		RECRUITMENT ANALYSES
#========================================================
library(lme4)
library(DHARMa)
library(performance)
library(glmmTMB)
library(MuMIn)

options(na.action=na.fail)	#Necessário para rodar a função dredge do pacote MuMIn

#----------------------------------------------------------------------------
#			MODELO COM DISTRIBUIÇÃO BINOMIAL	
#----------------------------------------------------------------------------
## 		Maximum Reprodutives > Maximum Total
nb_RepTot<-glmmTMB::glmmTMB(t1~0+t0*Site+(1|period),
				family=nbinom2(link = "log"),data=RepTot)
#----------------------------------------------------------------------------
## Maximum Reprodutives > Maximum Immatures
nb_RepIm<-glmmTMB::glmmTMB(t1~0+t0*Site+(1|period),
				family=nbinom2(link = "log"),data=RepIm)
#----------------------------------------------------------------------------
## Seleção do melhor modelo
# Rep> Tot vs. Rep>Im
#----------------------------------------------------------------------------

nb_RepTot_ls<-dredge(nb_RepTot)%>%get.models(subset=NA)

nb_RepTot_df<-data.frame(
	formula=cbind(lapply(nb_RepTot_ls,formula)),
		Var="Rep>Tot",Dist="Neg.Bin",
			AICcmodavg::aictab(nb_RepTot_ls))


nb_RepIm_ls<-dredge(nb_RepIm)%>%get.models(subset=NA)

nb_RepIm_df<-data.frame(
	formula=cbind(lapply(nb_RepIm_ls,formula)),
		Var="Rep>Im",Dist="Neg.Bin",
			AICcmodavg::aictab(nb_RepIm_ls))


nb_RepTot_df
nb_RepIm_df


#----------------------------------------------------------------------------
## Comparado os modelos com o modelo nulo
# Rep> Tot vs. Rep>Im
#----------------------------------------------------------------------------
#Nulo Rep>Total
nb_RepTot_NULL<-update(nb_RepTot,~1)
nb_RepTot_NULL<-list(nb_RepTot_NULL)
names(nb_RepTot_NULL)<-"nulo"
AICcmodavg::aictab(c(nb_RepTot_ls,nb_RepTot_NULL))

#Null Rep>Imaturos
nb_RepIm_NULL<-update(nb_RepIm,~1)
nb_RepIm_NULL<-list(nb_RepIm_NULL)
names(nb_RepIm_NULL)<-"nulo"
AICcmodavg::aictab(c(nb_RepIm_ls,nb_RepTot_NULL))


#----------------------------------------------------------------------------
# Escolha do pacote 
#----------------------------------------------------------------------------
#GLMM com o pacote lme4 há erro de convergência.
glmer(t1~0+t0+Site+(1|period),
				family=poisson,data=RepTot)

glmer.nb(t1~0+t0+Site+(1|period),data=RepTot)



# Modelos com Poisson
pois_RepTot<-update(nb_RepTot,family=poisson(link = "log"))

pois_RepTot_ls<-dredge(pois_RepTot)%>%get.models(subset=NA)

pois_RepTot_df<-data.frame(
	formula=cbind(lapply(pois_RepTot_ls,formula)),
		Var="Rep>Tot",Dist="Poisson",
			AICcmodavg::aictab(pois_RepTot_ls))


nb_RepIm_ls<-dredge(nb_RepIm)%>%get.models(subset=NA)

pois_RepIm_ls<-dredge(pois_RepIm)%>%get.models(subset=NA)

pois_RepIm_df<-data.frame(
	formula=cbind(lapply(pois_RepIm_ls,formula)),
		Var="Rep>Im",Dist="Poisson",
			AICcmodavg::aictab(pois_RepIm_ls))


nb_RepTot_df
pois_RepTot_df


nb_RepIm_df
pois_RepIm_df


#Null Poisson
pois_RepTot_NULL<-update(pois_RepTot,~1)
pois_RepTot_NULL<-update(pois_RepIm,~1)
#==========================================================================
#	GLMM ou GLM com ou sem interação entre t_0 e Site
#==========================================================================

m2<-update(nb_RepTot,t1~0+t0+Site+(1|period))
m3<-update(nb_RepTot,t1~0+t0+Site*period)

ggeffects::predict_response(m2, terms=c("Site","period"))%>%plot()
ggeffects::predict_response(m3, terms=c("Site","period"))%>%plot()

ggeffects::predict_response(nb_RepTot, terms=c("Site","period"))%>%plot()
ggeffects::predict_response(nb_RepTot, terms=c("Site","period"))%>%plot()
ggeffects::predict_response(nb_RepTot, terms=c("Site","period"))%>%plot()
ggeffects::predict_response(BestModel, terms=c("Site","period"))%>%plot()

```


## Relação entre quantidade de indivíduos imaturos, reprodutivos e máximo total
```{R pairwise_plot_individuals}

# DADOS	 
	 Site Plot Month Imaturos Reprodutivos year
1   S11B   11     3       72            0 2024
2   S11B   11     4       23           56 2024
3   S11B   11     5        0           57 2024
4   S11B   12     3       78            0 2024
5   S11B   12     4       44           78 2024
6   S11B   12     5        2           92 2024
7   S11B   13     3       29            0 2024
8   S11B   13     4       31            4 2024
9   S11B   13     5        0           10 2024
10  S11B   14     3        8            0 2024
#-------------------------------------------------------------------------

rbind(
cbind(census2024,year="2024"),
cbind(census2023,year="2023"),
cbind(census2022,year="2022"))%>%
group_by(Site,year,Plot)%>%
summarise(MaxIm=max(Imaturos),
	MaxRep=max(Reprodutivos))%>%
mutate(MaxTot=ifelse(MaxIm>MaxRep,MaxIm,MaxRep))%>%
ungroup()%>%
select(MaxIm:MaxTot)%>%
psych::pairs.panels()
```