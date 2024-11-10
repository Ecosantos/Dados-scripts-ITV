---
lang: en-UK
---

# Versão mais atual no google docs

## [https://docs.google.com/document/d/1Wk5n6P7wRexZ83jidtEnAVwfAkUc0C4XO2Oxjr8Bw4o/edit?usp=sharing](https://docs.google.com/document/d/1Wk5n6P7wRexZ83jidtEnAVwfAkUc0C4XO2Oxjr8Bw4o/edit?usp=sharing)

----



> [!info] **Proposta de artigo - DRAFT**
> - **Temática**: ARTIGOS EM PREPARAÇÃO
> **Tags:** #Demografia #Demografia/MPM #Demografia/Abundance #Demografia/ModelosInversos #Projetos/ITV #Projetos/ITV/Parapiqueria #Artigos/EmAndamento
> - **Contexto:** Um artigo de demografia de *Parapiqueria cavalcantei* utilizando problemas inversos para estimar parâmetros demográficos e testar hipóteses ecologicas
> - **Pasta de trabalho:**  "C:\Artigos e resumos publicados submetidos ideias\Notes\9 - ITV\Parapiqueria - Dados e scripts"
> 	- `{R icon title:Diretório}  setwd("C:/Artigos e resumos publicados submetidos ideias/Notes/9 - ITV/Parapiqueria - Dados e scripts")`
> - **Ver tambem:**
> 	- [[Demografia de Parapiqueria - geral overview]]
> 	- [[Artigo Parapiqueria - Outlines]]
> 	- [Inverse problems for IPMs](https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.12519)
> 	- [[Wood's Quadratic Program - algumas limitações]]
> 	- [[Barbara Leal et al - Genetica de plantas criticas.docx|Artigo Barbara et al. in progress]].
> 		- Baixa diversidade genética para Parapiqueria
> 			- É mais baixa entre as 3 espécies estudadas? (Ipomoea, Carajasia e Parapiqueria? ver pag. 
> 		- 3 córregos distintos em composição genética
> 		- **Effective population size** = Alarming! ($N_e < 50$) 
> - **Storytelling**: [[Artigo Parapiqueria - Outlines#Discussion outline]]  <- ==**USAR AQUI!!!**==


>[! note] Revistas potenciais
>- [Plant biology; IF=4.2, Acceptance rate: 21%](https://onlinelibrary.wiley.com/journal/14388677)
>- [Journal of Ecology; IF=5.3 Acceptance rate:16%](https://besjournals.onlinelibrary.wiley.com/journal/13652745)
>- [Botanical studies](https://as-botanicalstudies.springeropen.com/about)
>- New phythology; IF= 8, Acceptanve rate:22%
>- [Plant methods; IF=4.7](https://plantmethods.biomedcentral.com/articles)
>- [Perspectives in plant ecology, systematics and evolution](https://www.sciencedirect.com/journal/perspectives-in-plant-ecology-evolution-and-systematics/vol/65/suppl/C)
>- [~~Plant science~~](https://www.sciencedirect.com/journal/plant-science/vol/349/suppl/C)
>	- Parece só publicar coisa de genéica
>- Forest management and ecology IF=3.7 A1
>Ver mais: https://www.scimagojr.com/journalrank.php?category=1110&page=3&total_size=528


# [[#Draft|IR PARA O TEXTO EM DESENVOLVIMENTO]]

Referências ResearchRabbit: https://www.researchrabbitapp.com/collection/public/KL44NGRVLW

# TO DO
- [ ] Padronizar uso de CI95%, SD e SE
	- Como alguns valores de sobrevivência são negativos pq o modelo não ajusta bem, fica esquisito utilizar CI. Mas por outro lado SD não é legal pq os dados não são normais então talvez SE fosse melhor.

# Paralavras e questionamentos interessantes
- Metodologia
	- Chronosequence
- Espécie caracterização
	- edaphic endemic / edaphic endemism[^27]
- #### Questionamentos
	- Não, a abordagem não é circular!
		- Pergunta feita pelo Marquinhos no RABECO
		- De fato, já que já temos o padrão e estamos tentando entender os processos que levaram a formar aquele padrão que estamos observando, pode dar a sensação de que o processo é circular.
			- Entretanto, ao aplicarmos uma técnica de modelos inversos temos diversas vantagens em relação à mera observação do padrão.
				- Permite testar hipóteses
				- Permite um conjunto de ferramentas que não poderia ser aplicado aos dados de abundância:
					- Sensitivity
					- Elasticity 
					- Análises de viabilidade populacional
						- É possível fazer análise de viabilidade populacional apenas com o número de indivíduos, mas nesse caso como informar processos estocásticos ou mudanças de cenário? Com base nos parâmetros demográficos temos análises mais robustas!






>[! grid]
>![[Demografia de Parapiqueria.excalidraw]]
>![[Artigo Parapiqueria - Storytelling.excalidraw]]
>![[Modelos possiveis recrutamento Parapiqueria.excalidraw]]
>![[Drawing 2024-08-13 18.17.23.excalidraw]]



# Literatura interessante
- https://www.sciencedirect.com/science/article/abs/pii/S1574954111000537
- https://www.degruyter.com/document/doi/10.1515/math-2017-0040/html
- https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4573988/
- https://academic.oup.com/gji/article/191/2/849/646030
- https://www.degruyter.com/document/doi/10.1515/JIIP.2009.034/html
- https://www.sciencedirect.com/science/article/abs/pii/S0006320718310577
- https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0137272


# GOALS
![[#^81avec]]



# Outline
- ##### Introdution
	- **Parágrafo 1: Openning** 
		- Demographic studies are key for management, control and risk assessment
		- Demographic studies imply mark-recapture
			- ==BUT== Not feasible for most situations for animals
		- Developing alternatives for indirect estimation have been a ALTAMENTE DINÂMICA research field. 
			- MAJOR CHALLENGE IS.....?
	- **Parágrafo 2: Alternativas à marcação-recaptura em plantas é quase inexistente**
		- Despite the ALTAMENTE DINÂMICA research field developing alternatives to mark-recapture in animals, the usage of such techniques is still **Subutilizada** para estudos demográficos em plantas. Regardless general believe, marking and following plants are not always possible or accurate regardless their limited mobility[^8]. Lack of access to the individuals due the physical constraints such hills (Bodgan et al. 2021[^6]) or even when there is no aboveground biomass. An alternative to such direct estimation of demographic parameters is indirect estimation based on population-level data such as age structure estimates (e.g., Caughley, 1977; Michod and Anderson, 1980; Udevitz and Ballachey, 1998; Wiegand et al., 2004)[[#^0qz510|APUD]]. 
	- **Parágrafo 3: Importante desenvolver E DOCUMENTAR! métodos alternativos à marcação e recaptura**
		- Developing and showcasing new methods are important steps to equip practicioners with tools to apply for local conservation monitoring programs as well as prevent information gaps for global analyses. For instance, comparative demographic studies have been extremely important to unveil how species cope the environmental stochasticity in cenarious of climatic change and increasing environmental stochasticity. However, these studies have been hampered by the scarce data particularly where the richest biodiversity areas where limiting resources are most damaging. While mark-recapture is still the gold standard in demographic studies, the popularization of alternative methods, such inverse problems techniques, will dramatically help filling demographic information gaps and levearege the monitoring of isolated populations or unmarkable individuals.[^9]. A disponibilidade de outros métodos, bem documentados e com demostrações claras de sua eficiência tem o poder de estimular outros estudos, tornar viável estudos que foram desconsiderados ou descontinuados por falta de recursos humanos e logísticos e até mesmo revisitar dados já existentes. 

- ##### Goal
	- Showcase the use of inverse problem technique
	- [[#GOALS]]
- #### Discussion
- ver [[Artigo Parapiqueria - Outlines#Discussion outline]]
	- Seção 1/Parágrafo 1 - Overview
		- Fomos os primeiros a aplicar modelos inversos em uma espécie de planta anual.
			- Estimativa dos parâmetros foi desafiadora já que:
				- O modelo inverso não permitia a estimativa do recrutamento (já que a espécie é anual).
				- Além disso o ciclo de vida curto limitava o número de censos possíveis - mais isso não foi um grande problema.
	- *Seção 2/Parágrafo 2: Adequação dos modelos inversos*.
		- Modelos inversos são bastante eficientes.
			- No nosso caso o modelo não foi afetado pelo:
				- tamanho da série temporal; 
				- A falta de estimativa de reprodução pode ser facilmente compensada com outras técnicas.
			- A classificação em estágios ajudou bastante.
				- Outros estudos mostram que essa é a parte mais crítica na construção de modelos inversos (artigo do Connor).
				- Isso é particularmente interessante pq plantas anuais com ciclo de vida curto podem ser representadas por uma categorizaçao simples dos estágios do ciclo de vida, tornando elas o "padrão-ouro" onde aplicar esses métodos retorna estimativas bastante precisas.
					- Falar da importância das espécies anuais.
					- Espécies anuais são pouco representativas em estudos demográficos na base de dados COMPADRE. 
	- *Seção 3/Parágrafo XX: Demographic studies as an ancillary metric to ongoing studies for management*
		- Inverse methods allow us to gather the minimum necessary demographic information for population viability analyses. 
			- Population viability está assegurada.
				- Ver [[OostermeijerEtAl2003BiologicalConservation]].
					- Nesse artigo há várias citações do Lande falando que Demografia é mais importante que estudos genéticos 
					- Além disso que é necessário entender como a genética afeta a demografia para conseguir traçar conclusões claras.
						- Por exemplo, endogamia implica em menor performance.
							- No caso de [[OostermeijerEtAl2003BiologicalConservation]] menor numero de flores e menor tamanho das sementes.
								- Aqui nós encontramos menor peso e produção de sementes mas não necessariamente menor viabilidade, nem diferença genética, nem diferenças grandes na estimativa de sobrevivência e recrutament. --> Talvez fazer um LTER para testar essa hipótese.
	- *Seção 4/Parágrafo XX: New insights about the autoecology of Parapiqueria allowed by the Inverse problem techniques.* 
		- Talvez falar da plasticidade de desenvolvimento, que não precisa ter pressa para germinar e se desenvolver.
		- Mudança na velocidade do desenvolvimento ao longo dos três anos amostrados.
			- Plasticidade na janela reprodutiva?
				- Talvez seja interessante falar sobre o teste de armazenamento para discutir a viabilidade das sementes armazenada e discutir que essa plasticidade talvez não seja tão grande assim.


# Draft

## Abstract


## Introduction
Estimating demographic parameters such as survival and reproduction rates is key to accurately predicting the fate of wildlife populations and planning management actions (Boyce, 1992; Williams et al., 2002; Beissinger and McCullough, 2002)[[#^k01uht|APUD]].  Capture-mark-recapture (mark-recapture therefore) is the gold standard for estimating such demographic parameters in wildlife studies [@ManlyMcDonald1996CHANCE; @LebretonEtAl1992EcologicalMonographs; @Pollock1991JournaloftheAmericanStatisticalAssociation] but several alternatives exists when mark-recapture is not feasible (==REFs==).  Plant studies rely on in a “similar vein” to mark-recapture [@CubaynesEtAl2021DemographicMethodsacrosstheTreeofLife], but unlike wildlife studies, very few alternatives exist or have been applied when marking and “recapture” is not feasible (==REF==). However, contrary to popular belief, it is not always possible or accurate to mark and track plants, regardless of their limited mobility [e.g., @KéryGregg2004AnimBiodivConserv]. The limitations of direct estimation of demographic parameters in plants can have many causes, such as logistical constraints due to remoteness [e.g., @RaghuEtAl2013Aust.J.Bot.], physical constraints such as hills [@BogdanEtAl2021PLoSONE], or cryptic life stages (e.g., belowground biomass [@KéryGregg2004AnimBiodivConserv] to cite a few. Some alternative methods to mark-recapture rely on indirect estimates based on population-level data, such as age-structure estimates [e.g., @ZipkinEtAl2014Ecology], which are by definition *inverse problems*. Inverse problems are a large family of indirect estimators where demographic parameters are inferred from observed age or stage structure over time by optimizing the fit between observed patterns and corresponding plausible processes. [[#^0qz510|APUD]]. In principle, such methods could be directly applied to plant studies [eg., @KéryGregg2004AnimBiodivConserv], but (1) this claim remains largely untested or (2) available methods may sound overcomplicated to become a regular toolkit among plant population ecologists (==REFs==). 

Preventing using alternative approaches to mark-recapture might dramatically reduce possible life forms to be monitored and the feasibility of long-term studies in plants [@Rodríguez-CaroEtAl2019BiologicalConservation; @RaghuEtAl2013Aust.J.Bot.]. Inverse problems gained traction in demographic studies firstly applied to fish[^19] and zooplankton monitoring [@CaswellTwombly1989EstimationandAnalysisofInsectPopulations]. These initial attempts use a very basic mathematical principle based on least square estimation, the same approach used on simple linear regression models, to a set of differential quadratic equations on a time series of stage structured population (*Quadratic programming* therefore; ==REFs==). Further, fundamental work lead by Simon Wood sequentially tested the theoretical and empirical bases of quadratic programming models with a great support of its reliability (==REFs==)[^33]. These validations paved the way for further application and extension of *quadratic programming* on ecological studies (==REFs==). Yet, the use on ecological studies remained timidly limited to animals until [@RaghuEtAl2013Aust.J.Bot.] use this approach to construct matrices population models (MPMs) for population viability of a critically endangered plant species in the desert of Australia. Comparing a MPM built on quadratic programming to a MPM built based on multiple sources in literature (a common practice in population viability analyses), Raghu et al. (2013) found a great matching between these two approaches and reached similar conclusions. Despite its successful application in a plant study, *quadratic programming* has not been used in plant monitoring a decade later.  

The combination of inverse models with the recently developed Integral Projection Model (IPM) framework has introduced an appealing new avenue that is increasingly drawing interest from plant ecologists [@GonzalezEtAl2016MethodsEcolEvol; @GonzálezMartorell2013EcologyandEvolution; @NeedhamEtAl2016JournalofEcology; @BernardEtAl2024]. IPMs and MPMs are mathematical representation of species life-cycle and account for the underlying demographic parameters that driven population fluctuation [@caswell2001matrix; @EllnerEtAl2016]. Major difference between these two methods relies on IPM fitting a set of linear models for a continuous variable (e.g. size), while MPMs are frequently built based on stage/age discretization [@MerowEtAl2014MethodsEcolEvol; @EllnerEtAl2016; but see; @DoakEtAl2021EcolMonogr]. IPMs are indeed more flexible than MPMs [but see @DoakEtAl2021EcolMonogr], however, they also require a much more information and such existing prior information might represent a critical step for accurate implementation of inverse methods [@BernardEtAl2024; @GonzalezEtAl2016MethodsEcolEvol]. While such information might be missing to implement inverse models within an IPM framework, simplicity allowed by MPMs might improve the capacity to abstractions for stakeholders[see @Murtaugh2007Ecology; @GarcíaDíazEtAl2019ConservatSciandPrac], that is precisely where inverse problems applied to MPMs might be most valuable [e.g., @MarescotEtAl2012EcologicalModelling]. Moreover, on many cases, simple life-cycles representations better capture species management propose with more engaging results for delivery information to stakeholders [@MarescotEtAl2012EcologicalModelling]. This might be precisely the case of annual herbs which tend to be underrepresented in demographic studies [@RömerEtAl2024Oikos]. 

Here we showcase how inverse problem techniques could fill urgent gaps in autoecology and conservation guidelines for a microendemic annual plant species. We also provide a roadmap for the implementation of this technique for annual plant species because it require some particular treatment to estimate recruitment. Specifically, (1) we first estimated demographic parameters using a *quadratic programming* approach; (2) second, we assessed the accuracy of the estimated demographic parameters using simulated data; then, (3) we compared the demographic information with previous and ongoing studies aimed at assessing population performance and its long and short-term viability. Our study model is the *Parapiqueria calvantei*, a microendemic plant species with known populations occurring only along three streams in the Amazonian Cangas, a particular type of OCBIL (Old Climatic Buffered Infertile Landscape), areas with the highest plant diversity in the world. Previous studies have indicated a remarkably low genetic diversity (Leal et al. in review) and unpublished experimental studies on the reproduction of this species revealed different reproductive performances among streams but in general a low reproductive performance (see Methods). Together, these results may suggest a worrying extinction probability which requires further investigation, particularly to assess the long-term viability of this species under increasing climate change and the urgent need to better manage the protected area where this species occurs. *Here, we synthesise such previous and ongoing projects integrated with new demographic information to test whether: (i) existing genetic differences between streams and (ii) existing reproductive traits (e.g., differences in germination rate and seeds size) can explain differences in performance between these distinct populations. By integrating demographic information we revealed that despite a very low genetic diversity and great reproductive performance, there is very little effective differentiation in population performance along the streams. Finally, because we were the first to apply an inverse problem technique to an annual plant species, we also provide a detailed framework that might guide further studies to implementing such a promising approach*. ^81avec

## Results
### Population structure, densities and temporal dynamics
We recorded a great variation of maximum total individuals of *Parapiqueria cavalcanti* along the parcels, from 2 to 365 individuals (80.6 $\pm$  63.0, mean and standard deviation). We also recorded a great temporal variation in the maximum total of individuals along of our three census. From 94.5 $\pm$ 77.6 individuals in 2022 to 55.2 $\pm$ 37.0 individuals in 2024. Such spatial and temporal variation are likely to mask differences between populations of the two sampled streams. Indeed, by fitting a GLM with negative binomial distribution and interactions between *site* X *year*, we failed to find statistical differences in the abundance across the two streams ($\beta_{Site}=-137.00 \pm 463.00$,  F=0.297, p-value=0.767), while we detected a small but significant decline between reproductive individuals along the years ($\beta_{year}=-0.461 \pm 0.156$,  F=-2.95 p-value=0.003). This decline is reduced until become only marginally significant when immature individuals are included in the analysis ($\beta_{year}=-0.308 \pm 0.162$,  F=-1.90 p-value=0.058)[^16]. Altogether, these results support that variation in abundance along the year is most important than geographical differences and this difference is mainly driven by the maximum of reproductive individuals detected along the year.  

#### Demographic parameters: survival, development and model validation
By using the inverse method techniques in this study, we successfully estimated the demographic parameters of *P. cavalcantei* which were further complemented with well-estabilished approaches to estimate recruitment rate. Survival of reproductive individuals was estimated to $0.167 \pm 0.213$ (mean, standard deviation), development rate (growth from immature to reproductive) was estimate to $0.741 \pm 0.290$ and stasis (the probability of an immature individual stays immature in one census and the next one) was estimated to $0.647 \pm 0.373$. Streams did not differed in any of these parameters [[#table 1]] but we noticed a progressive delay in the development of the immature individuals to reach reproductive status (significative lower growth rate and significative higher stasis rate; [[#Tabela taxas vitais e sinal entre anos|table xx]], [[#Figure 1]]).  Our model validation demonstrated strong robustness regardless of the number of censuses or replications. In general, the estimated error was almost negligible, with differences appearing only at the 11th, 14th, and 18th decimal places ([[#Figure 2]]).

### Recruitment rate
Recruitment is a key process to estimate the population growth rate and could not be estimated trough the inverse method technique because the number of new individuals produced in one year can only be quantified on next year. Differently from vital rates estimated from inverse models (stasis, growth, and survival), recruitment shows a strong and significative difference between the streams with S11C recruiting more new individuals per year (51.42 $\pm$ 14.07) than S11B (28.92 $\pm$ 8.59). Although recruitment is dependent of the maximum reproductive of individuals counted in the previous year ($\beta_{t0 \rightarrow t1}$ = 1.007 $\pm$ 0.003, z= 2.24, p-value= 0.025), the small effect size estimated ($\beta_{t0 \rightarrow t1}$ = 1.007 $\pm$ 0.003) highlights a highly variable recruitment between parcels and years. This difference, however, is particularly evident between parcels[^29], as we found only a marginally significant difference between recruitment from 2022-2023 to 2023-2024 (Year; $X²$= 2.933, df=1, p-value = 0.087; [[#Tabela XXX]])[^30]. 

### Experimental reproductive biology, genetic studies and their connections with demographic performance and  long-term population viability

Experimental reproductive biology studied show that reproductive performance vary great between the streams. In general, individuals from S11C produce 0.63 seeds less than S11B ($\beta_{S11C}$  = 0.63 $\pm$ 0.02; z=-13.84, p-value= < 0.001). This difference however is compensated by S11C having heavier seeds (t = -2.969, df = 11.558, p-value = 0.012), and higher germination rate (t = 3.02, df = 9.226, p-value = 0.014) when compared to S11B. Seeds in S11B, however, also show faster germination compared to S11C ($\beta$ = 0.165 $\pm$ 0.073, z=2.252, p-value=0.024). Despite differences in size, seed production, time to germinate, and germination rate, we failed to find different between the viability rate of seeds produced in S11B compared to S11C in green house experiments (t = 1.397, df = 8.227, p-value = 0.199).==Thus, differential performance on seed traits and germination rate seem to be the major role on recruitment performance, more than seed viability.==[^28]

Finally, we estimated a mean population growth ($\lambda$) of 1.31 $\pm$ 0.04 for S11B and 1.30 $\pm$ 0.04 for S11C.  We did not find significant difference of $\lambda$ between the streams (t = 0.138, df = 55.99, p-value = 0.891). Population growth rates ($\lambda$) greater than 1 represent health on-growing populations, which is supported by a very low extinction probability of 3% and 4% when projected for 10 and 30 generations (i.e., years). When extinction probability is compared between streams, we did not find any significant differences ($X^2$ = 0.50, df = 1, p-value = 0.479). This very low extinction probability is particularly interesting given its contrast with a very small effective population size estimated by genetics. That is only 18.7[13.5-27.4] individuals among the streams with a very swallow allelic richness estimated to 1.440 [1.343-1.534] on S11C and 1.390 [1.257-1.467] on S11B. This is a very low allelic richness when compared to some species (e.g, *Ipomoea cavalcantei* XXXXX) but does not represent an isolated case on Cangas (e.g., *Carajasia cangae* which shows an even lower genetic diversity - ==DAR ESTATÍSTICAS==). 

## Discussion
- ver [[Artigo Parapiqueria - Outlines#Discussion outline]]


>[! danger]-  COMO MELHORAR A DISCUSSÂO DA ESPÉCIE. Insights da conversa com o Rafa ^1fi51g
>A discussão pode se beneficiar de uma ampliação da discussão sobre a espécie. Especificamente, parece ser muito interessante explorar as evidencias ainda que inconclusivas sugeridas pelos resultados encontrados.
>
>Uma possibilidade é começar cada parágrafo explicando cada um dos principais insights obtidos com os modelos inversos.
>Algo como:
>Based on demographic data, we unveiled an interesting trade-off that might be changing trough time.....Demographic data has been important to XYZ in this aspect and this particular question could be only assessed trought the inverse model.... Further studies must consider X,Y and Z as literature say blablabla. 


We first applied an inverse problem technique to a microendemic annual plant species where individual marking is not feasible. The successful application of this promising technique allow us to showcase potentiality of this approach to assess important conservation and autoecology aspects urgently required for a better management of the protected area where the species occurs. While the application of inverse problem techniques have been modestly used to study wildlife populations, these techniques are still overlooked on plant studies. Moreover, these techniques have never been applied for an annual species, where reproduction cannot be directly assessed using inverse problem techniques but complementary approaches need to be conducted instead. Yet, the successful application of the inverse problem technique for our study system which has a very short non-dormant season plus simulations with a hypothetical species with known demographic parameters shown that even with small time-series we can reach a good parametrization. [^17]Finally, based on robust estimation of demographic parameters for *Parapiqueria cavalcantei*, we could largely increase the existing biological information necessary for its protection as we discussed below. We aim for our showcase to enhance the current literature and provide researchers and practitioners with an alternative tool for plant studies, which will ultimately lead to a significant reduction in costs and an improvement in the long-term viability of plant population monitoring programs. [^10]

##### Important insights in conservation biology of *Parapiqueria cavalcantei*
Based solely on experimental reproductive studies and genetic information, we could expect an enormous difference in the performance of the studied population of *P. cavalcantei* in the two streams. However, by integrating demographic information with such studies give us a much more broaden understanding on the mechanisms and process governing the dynamics of these populations. We highlight three major insights allowed by demographic information and its consequence of the management of these populations. First, the very small effective number estimated by genetics and its respective dramatically reduced genetic diversity might suggest a higher probability extinction probability but it does not necessary hold on demographic studies. This result is very interesting because reduced genetic diversity might increase endogamy reducing reproductive performance. Indeed experimental studies support different performance between streams although genetic diversity did not differ significantly between streams. This is precisely where demographic information given us the second most valuable insight. While we could not determine if reproductive differences are a outcome of endogamy, demographic information helped us to clarify that these reproductive differences is secondary to determine population performance when compared to adult survival, which is mainly determined by differences within streams and across years than between streams. Finally, demographic information unveiled an interesting change in the trade-off development, where individuals gradually slowdown their maturation rate. This pattern require an in deep study which we already started by spreading different temperature and humidity sensors across the different parcels in the two streams. [^25]

Above mentioned results from demographic information integrated with experimental reproductive biology and genetic studies should be interpretated with caution. First, low probability to get extinct must be understand as an initial exercise to understand what the major treat populations of *P. calvancatei*. Thus, it is important to recogonise a few limitation. First, probability to extinct was calculated based on pooled parcels, thus it reflects the probability to *P. calvancatei* disappear in all parcels in a given stream at the same time, which is indeed very low. However, each parcel must have their own probability to extinct and during our monitoring one of our parcels was potentially extincted due to a canopy clearing in ==ANO==. We believe that such extinction might be followed by further colonization. A highly dynamic extinction-colonization process might partially be a clue to explain the reduced allelic richness among streams detected in Leal et al. (in review). Mostly important the low contribution of recruitment to population growth rate ($\lambda$) should not be interpreted as less important to modelling its extinction rate, but instead as a system highly dependent of environmental and demographic stochasticity.  

#### Inverse model validity, leasons learned and application showcase
Inverse methods might be challenging to apply to complex life cycles but seems particularly promising with simple life cycles, even if reproduction cannot be directly incorporated in methods and there is no information about size distribution in the population. This is precisely the case of our study system, *P. cavalcantei*, which has as simple aboveground life cycle. This simple life cycle while limited potential information to guide the implementation of inverse problem approach, is also likely to have counterbalanced two potential challenges in the implementation of the inverse model: (1) necessity of population size structure, and (2) its annual behaviour. Reducing population structure to only immature and reproductive individuals prevented the implementation of inverse model in an IPM framework but as counterpart greatly reduced the complexity of demographic estimation. Indeed, inverse methods require a time series of ages or ontogenetic stages to estimate interested demographic parameters, as consequence, increase the number and complexity of the life cycle might potentially explain previous failure to converge to a single set of demographic parameters [see @GonzalezEtAl2016MethodsEcolEvol]. Finally, while the annual behaviour might sound as an additional challenge in our study system, it could be easily incorporated in our demographic estimation by splitting the Matrix Population Models (MPMs) in survival (U) MPM and recruitment (F) MPM, a common approach used in demographic studies [@Salguero-GomezEtAl2016J.Anim.Ecol.; @Salguero-GómezEtAl2015J.Ecol.]. This allow us to implement complementary approaches on demographic studies. Thus, the challenges-solutions present here showcases the flexibility of inverse problems on demographic estimation but particularly highlights: (1) the flexibility and robustness of inverse models over a high variable life-histories; (2) the importance to reduce its complexity during demographic parameter estimation.

Key methodological advances has been done in order to support the robustness of inverse models on demographic studies greatly enlarging its potential on ecological plant studies. The integration of inverse models on IPM represents a potential game change on use of inverse methods for plant monitoring allowing the implementation of this approach on more complex population structures [e.g., @NeedhamEtAl2016JournalofEcology]. However, improving complexity also come at a cost, which may include necessity of more *a priori* information and/or higher risk of reducing accuracy on estimation of demographic parameters [@BernardEtAl2024; @GonzalezEtAl2016MethodsEcolEvol]. On the other hand, inverse method based on *quadratic programming*, as we used here, dramatically reduce the minimum necessary information to an accurate estimation of demographic parameter and might be suitable approach for simple life cycles or when only minimum information can be collected during the monitoring. Thus, as we have shown, both, inverse models applied to MPMs and IPMs, should be promoted as a regular toolkit for plant ecologists with a greater potential to improve our capacity to monitoring and predict fates of plant populations in nature.

Finally, it is important to recognize that demographic information is a time consuming activity [@RömerEtAl2024Oikos; @SalgueroGómezEtAl2018FunctionalEcology]. Such information usually gains power in long-term ecological studies that in its turn suffer most from lack of resources, staff and logistics constraints [@AppletonEtAl2022NatSustain ;@LeveringtonEtAl2010EnvironmentalManagement], imposing a great challenge on the management of these protected areas [e.g., @SantosEtAl2024]. We foresee at least three ways inverse methods will help to reverse this situation. First, applying inverse models might allow to estimate demographic parameters even in populations where mark-recapture is not feasible, as we have showcase in this study, which extend the potential species where demographic parameters can be estimated [e.g., @RaghuEtAl2013Aust.J.Bot.]. Second, when mark-recapture is possible but prevented by lack of resources, simple individual counting with posterior application of inverse method might bring feasibility and reduce costs to associated with long-term ecological monitoring on plants and vertebrates. These two approaches remains the main use of Quadratic Programming in wildlife studies [e.g.,@WielgusEtAl2008EcologicalApplications, @Rodríguez-CaroEtAl2019BiologicalConservation] and we believe it will equally apply for plant studies as well. Lastly, there are lots of information from structured populations collected worldwide where demographic transitions (e.g., survival, recruitment) is still waiting to be estimated but due to the lack of individual mark-recapture can only be assessed with inverse models [e.g., @RaghuEtAl2013Aust.J.Bot.]. For sure, these three ways we foresee as path inverse modelling techniques may reverse the lack of demographic information do not exhaust all potentiality of these techniques.

>[! hint]- PARTE INTERESSANTE QUE POSSO DEIXAR NA INTRODUÇÃO OU DISCUSSÃO
The inverse estimation method that we used is based on quadratic programming. Although the method was first proposed a decade ago (Wood 1997), it was applied only recently to empirical data (Wielgus et al. 2007). Similar to inverse estimation using a Bayesian approach (Gross et al. 2002), quadratic programming makes it possible to constrain the estimated demographic rates to a range of values that are considered realistic for the species (see Methods). The use of parameter constraints is particularly useful when dealing with species of conservation concern, in which case the values can be restricted to precautionary values. Another advantage of quadratic programming is the relative ease with which it can be implemented using software for numerical analysis. Model algorithms and computer code for quadratic programming are widely available (e.g., Byrne 1984, Caswell et al. 2001, Lau 2007), and the input required for the estimations are simply (1) a matrix containing abundance data and (2) a vector containing the constraints for the parameter values (see Methods). In addition, no assumptions are required about the types of distributions of the demographic rates, in contrast to Bayesian and maximum likelihood approaches. 
>
>Parte interessante retirada de Wielgus, J., González‐Suárez, M., Aurioles‐Gamboa, D., & Gerber, L. R. (2008). A noninvasive demographic assessment of sea lions based on stage‐specific abundances. Ecological Applications, 18(5), 1287-1296. https://doi.org/10.1890/07-0892.1

## Conclusion[^34]
Demographic information is critical to predict the fates of natural populations of plants and animals, demographic estimation, mainly performed using mark-recapture is huge time consuming and might not be feasible due to lack of assess to the individuals or limited staff, resources or remoteness. Inverse problems techniques represent the alternative for mark-recapture but remaining unpopular on plant studies. In order to help inverse model gain popularity on plant studies, we showcase how quadratic programming, an inverse model technique, can be implemented with barely no prior information with great success. This approach allow us to fill critical information in a puzzle of previous studies aiming a better management of a micro-endemic plant species, the *Parapiqueria cavalcatei*. This represent the first attempt to implement such technique in an annual species and one of the few uses of inverse problems in plant monitoring. While the application of this approach resolve a pressing local demand to the monitoring of a critical species for the management of a protected area in the high diverse Amazon region, we could also unveil important patterns that deserve attention. Therefore, we believe the successful implementation of such inverse model here has the potential to popularise this promising tool on plant studies and codes and data accompanying this manuscript will help others on this endeavour. 

## Metodologia
#### Study area
This study was conducted in the _Cangas of Carajás_, an ironstones outcrop with Canga vegetation surrounded by the Amazon Forest. Canga is a specific type of Campo rupestre (rupestrian grassland) formation [@SilveiraEtAl2016PlantSoil; @ZappiEtAl2019PLoSONE], which are characterized by a mosaic of vegetation largely influenced by soil conditions, but distinct from other types of campos rupestres due to its ferruginous dominance [@ZappiEtAl2019PLoSONE]. Campos rupestres, including cangas, have been recently inserted in the old climatically-buffered infertile landscapes (OCBIL) theory due their old geological origins [@SilveiraEtAl2016PlantSoil], which in the case of the cangas of Carajás is assumed to date from Cretacean [@absaber1986geomorfologia; @VasconcelosEtAl1994GeochimicaetCosmochimicaActa][^14]. Given its geological history and geographic position, OCBILs are assumed to be climatic buffered with low geological disturbances history and consequently long weathering, thus nutrient-depauperised, particularly in phosphorus [@SilveiraEtAl2016PlantSoil]. This particular conditions is assumed to lead to a great diversification of their plant species with specific adaptations [@SilveiraEtAl2016PlantSoil].[^15]  Together with other OCBILs, cangas and other kinds of campos rupestres hold the highest number of endemism worldwide [@Hopper2023Plants][^15]. However, different from others campos rupestres, the Cangas of Carajás also need to cope with high temperature along the typical infertile soils [@SchaeferEtAl2016EcologyandConservationofMountaintopgrasslandsinBrazil]. As consequence, the Cangas of Carajás physiognomy is strongly seasonal, with several herbaceous annual, ephemeral species that are present during the rainy season, and a trend to leaf-loss of the shrubby and tree component during the dry period [@VianaEtAl2016Rodriguésia].[^12] 

The cangas of Carajás are mostly enclosed in the Floresta Nacional de Carajás, a sustainable use protected area. Similar to other ironstones outcrops around the world, the distribution of endemic species from Carajás partially overlaps with operating iron mines and future targets of mining [@SkiryczEtAl2014Front.PlantSci.; @GibsonEtAl2010BiodiversConserv]. Indeed, the Carajás Mountain range is home to the largest iron ore mines in Brazil, which in turn is the world's second-largest usable iron ore producer [@HolmesEtAl2022IronOre]. To better conciliate the mining activities and the protection of the enormous biodiversity existing in FLONA Carajás, a great effort has been done to map and monitoring the microendemic species to the Cangas of Carajás. *Parapiqueria cavalcantei* is one of these species [@silva_jorge_2018].

#### Studied species
*Parapiqueria calvancatei* (Asteraceae) is a microendemic annual herb to the ferruginous formation and is only associated to occur on rocks' fissures along to the shadow border of only three streams [@silva_jorge_2018; @amorim_bicalho_2022, Leal et al in review]. The maximum height of the reproductive individuals range from 5‒15 centimeters [@CruzEtAl2016Rodriguésia]. Despite the small distribution of this species, it has been only assessed on 2016, when received the status of threatened due to its limited range size which largely overlaps with areas of mining interests [@amorim_bicalho_2022]. Meanwhile, the species have been identified as one of the 38 endemic species of special interesting for the management of areas of cangas in the FLONA Carajás [@silva_jorge_2018; @GiuliettiEtAl2019Bot.Rev.] and a population monitoring have been identified as a critical component for the conservation of the Cangas [@amorim_bicalho_2022].  
#### Population monitoring
We started the population monitoring in 2022 establishing twenty permanent plots 25×25cm along two streams (S11B and S11C), ten plots each. This study contemplates the period between March 2022 to May 2024 but the monitoring program continues. A small populations have been identified on another stream (S11D) few months later the starting of this monitoring but no parcels have been added there so far. Each of our plot are subsampled in small grids of 5×5 cm where individuals are counted and categorized as reproductive if any reproductive structure is observed or immature otherwise. Because individuals are tiny, particularly on earlier stages, and occur in a very dense aggregation (ranging from ==XXXX to XXXX== per parcel) mark-"recapture” is not feasible. The small grids in the parcels are an important guide during the counting but all analyses are made based on plot, thus individuals in all grids are summed. 

Each plot was monitored three times along the year with intervals of about four weeks from March to May between the monitoring. March represents the month when seeds start to germinate and aboveground biomass start to appear. Very few individuals are reproductive in March (==%==). On Abril we have a mix of immature and reproductive individuals but with reproductive individuals start to become predominant in the plots ==%==. Finally, on May, immature individuals become only a very tiny proportion of individuals in the plots ==%== and most of the reproductive individuals are already starting to senesce. This effort given us a small time series, from March to May, every year from 2022 to 2024, which we can estimate survival, growth and stasis of the aboveground biomass. Thus, it is critical to recognize that the demographic parameters estimated therefore represent the ecological processes occurring during the season with aboveground biomass, from germinate to reproduce.  

#### Inverse problem model implementation
To estimate demographic parameters from the timeseries, we implement a Quadratic Programming approach. A Quadratic programming represent the seminal attempt to implement inverse model technique on demographic parameter estimation (see Introduction). In a Quadratic Programming, a set of quadratic equations are adjusted though observed timeseries of counted individuals and the demographic parameters are reached though the minimized square of the residuals, this is a similar optimization criteria used on simple linear regression. However, differently from simple optimization, Quadratic Programming is also flexible to fit the quadratic functions accordingly to some specified constraints, which include limited range of the demographic parameters and unlikely transitions in the species' life-cycle. A most obvious constraints is that survival can only range from 0-1. Moreover, specifically for *P. cavalcantei*, because we are working with only two stages (i.e., immature and reproductive individuals), which might be represented by a 2 x 2 MPM, all transitions likely to occur, excepting recruitment that cannot be directly estimated without include data from next year. However, including data from next year will mix up information in different temporal scales to assess demographic parameters. It means, survival comes from March to May representing survival during a season, while recruitment comes from one season to another, representing a longer period, which is a bad practice in demographic studies [see @KendallEtAl2019EcologicalModelling]. Thus, reproduction require a different treatment which is explained in the section below ([[#Estimating recruitment rate]]). It is critical to note that the resulting MPM represents the mean survival, stasis, and individual growth rate during the sampled season (March to May). Finally, the Quadratic Programming was implemented with packages *popbio* [v.2.8, @StubbenMilligan2007J.Stat.Softw.](v. ; REF) and its dependency *quadprog* [v.1.5.8, @TurlachEtAl2019]. A concise explanation on how to set the constraints and the implementation process of the Quadratic Programming is provided on [@caswell2001matrix, p.], and in the ==Supplementary material SX==.  Data and code are available in Supplementary material SX (==Temporariamente em GITHUB==.

#### Model validation
To validate the implementation of the Inverse problem in our study species, we created a hypothetical timeseries frequency of stages from a species with known survival, stasis, and ==individual growth== rates. It allows us to quantify the accuracy of the quadratic programming in our study system. Using this hypothetical species as a model, we project the species during different seasons (March to May) until it reaches the asymptotic population growth rate. First, we randomly select ==XXXX== timeseries, comprising three to eight censuses along the population trajectory. Then, for each timeseries, we derived the estimated demographic parameters. Finally, derived demographic parameters were compared to known parameters of our hypothetical species and the difference (known parameter —simulation derived demographic parameter) represent the error.  [^31]

### Long-term population viability



### Experimental reproductive biology
In 2022, reproductive biology experiments were conducted to gather information on (i) the average seed production per individual, (ii) the average seed weight, (iii) the germination rate, (iv) the average germination time, and (v) the proportion of viable seeds in each stream. Each of these parameters was then compared between streams to assess whether there were differences in the reproductive performance of the populations across streams. 

To determine the average number of seeds per individual (i), seeds were collected from 31 individuals (15 individuals from S11B and 16 individuals from S11C). Subsequently, to calculate mean seed weight (ii), seeds of each stream were divided into eight groups of 100 seeds each, which were collectively  weighed using a precision scale balance. To evaluate germination aspects (iii-v), including germination time, germination rate, and seed viability, the seeds from each population were placed to germinate in Petri dishes lined with moistened filter paper in germination chambers at 27ºC with 12 hours of light and 12 hours of darkness. For each population, we had six replicates with 20 seeds each (n=120/stream). The germination experiment lasted 90 days. After the 90 days, the viability of ungerminated seeds was assessed using the tetrazolium test (1% solution), where seeds that stained red were considered viable, while seeds that did not stain or showed flaccid tissues were considered dead [@Lakon1949PlantPhysiol.]. In each replicate, seed viability was calculated as the sum of the number of stained seeds and the number of germinated seeds.

### Genetic studies 
Genetic information of *P. calvancantei* comes from a broader study from [[Barbara Leal et al - Genetica de plantas criticas.docx|Leal et al. in review]] assessing the genetic diversity and structure of multiple species. In brief, [[Barbara Leal et al - Genetica de plantas criticas.docx|Leal et al. in review]] applied a reduced-representation sequencing (nextRAD) methods to check allelic diversity based on Single nucleotide polymorphism (SNP) in 49 individuals of *P. cavalcantei*. The SNPs are abundant and widespread single-base DNA mutation in species' genome serving as a practical and reliable tool to estimate allelic uniqueness within and between populations [@MorinEtAl2004TrendsinEcology&Evolution]. Genetic diversity is then represented by the number of observed alleles across loci and the observed heterozygosity in each population, with higher numbers of alleles and higher rates of heterozygosity a metric for higher genetic diversity in the population. Finally, effective population size was estimated based on the possible combination of existing alleles using the NeEstimator 2 (Do et al. 2014). Here, we only use information number of alleles and heterozigosity. 


#### Estimating recruitment rate 
>[! hint]- Ver
>>[! info|right wtiny]
>> ![[Modelos possiveis recrutamento Parapiqueria.excalidraw| Modelos possíveis Parapiqueria]]
>
> [[Recrutamento em Parapiqueria - Notas]]

To estimate recruitment rate, we start by building a serie of competing generalized linear mixed models (GLM) that encompassing different numeric response between the number of individuals in a year $y_0$ to next year $y_1$. Competing models considered four possibilities as following: (1) the number of <font color="#f79646">maximum total individuals </font>in census $y_1$ as a function of the <font color="#f79646">maximum total individuals</font> in $y_0$; (2) the <font color="#f79646">maximum total individuals</font> in $y_1$ as a function of the <font color="#0070c0">maximum reproductive individuals</font> in $y_0$; (3) <font color="#00b050">maximum number of immature individuals </font>in $y_1$ as a function of the <font color="#0070c0">maximum reproductive individuals</font> in $y_0$; and (4) the <font color="#00b050">maximum number of immature individuals</font> as a function of $y_1$ as a function of <font color="#de7802">maximum total individuals</font> in $y_0$.[^4]. Each model included an interaction between individuals and plots (see eq.1) and two family distributions were tested, Poisson and Negative binomial, because these two distributions are recommended for response variables related to individual counting. Posteriorly, we ranked theses models to their Akaike Information Criteria (AIC) value using the _AICtab_ function from the package _AICcmodavg_ (Mazerolle 2020). The model with the lowest AIC was assumed to be the most plausible, and models with 𝛥AIC < 2 were assumed to be equally plausible (Burnham and Anderson, 2004). Finally, we validated our results through two steps described in the supplementary material [S3](https://link.springer.com/article/10.1007/s10531-024-02796-y#MOESM3). In brief, we checked if the most plausible model fits the assumptions of heteroscedasticity, outliers, and the residuals’ absence of spatial autocorrelation using the _DHARMa_ package (Hartig 2022).[^3]. Finally, once a best model structure was reached, which clearly told us that recruitment is dependent of the plots, recruitment in each plot for each year was estimated using the best model structure. 

$$Ind_{y_1} =  Ind_{y_0}*Year*Plot \tag{eq.1}$$

# Trechos de outros artigos


 The estimation of demographic parameters such as survival and reproduction rates is key for accurate forecasting of the fate of wildlife populations and for evaluating alternative management actions (Boyce, 1992; Williams et al., 2002; Beissinger and McCullough, 2002). In ecology, several approaches have been developed to estimate demographic parameters of wild animal and plant populations (Williams et al., 2002; Gross et al., 2002; Thomson et al., 2009). The estimation of age dependent survival is especially difficult for long-lived species because current methods such as capture-recapture (CRC) methods typically require long-term monitoring of individuals (Lebreton et al., 1992), which involves intensive field effort (e.g. for tortoises the range is 3–22 years monitoring, Appendix 1) and consideration of imperfect detection (Lebreton and Pradel, 2002; Thomas et al., 2010; Sanz-Aguilar et al., 2016). The capture-recapture framework allows for dealing with imperfect detection and is now commonly used to estimate animal survival rates (e.g., Lebreton et al., 1992; Lebreton and Pradel, 2002; Giménez et al., 2007; Thomson et al., 2009; S[^11]anz-Aguilar et al., 2016). During the last decades, technological development has allowed to track animals and obtain direct survival estimates using telemetry data that provide an accurate monitoring of individuals over time (Millspaugh and Marzluff, 2001), but batteries do not usually last long (Bridge et al., 2011). Although CRC and telemetry monitoring methods proved to be accurate and useful, they can often not be applied for species of conservation concern where long-term studies would be very costly or infeasible (Williams et al., 2002). [^2] ^k01uht
 
 An alternative to direct estimation of demographic parameters is indirect estimation based on population-level data such as age structure estimates (e.g., Caughley, 1977; Michod and Anderson, 1980; Udevitz and Ballachey, 1998; Wiegand et al., 2004). For example, survival rates can be indirectly estimated from age distribution data by analysis of the underlying age-structured Leslie matrix model if additional pieces of information are available, for example population growth rate, recruitment rates, the age structure of natural deaths, or stability of the age structure (Caughley, 1977; Michod and Anderson, 1980; Tait and Bunnell, 1980; Sickle et al., 1987; Udevitz and Ballachey, 1998). Similar methods were also developed in fisheries where catch-age patterns provide population age structures that then allowed together with auxiliary information for stock assessment (for a review see Quinn, 2003). These approaches fit into the pattern-oriented modeling strategy (Wiegand et al., 2003; Grimm et al., 2005), a general modeling framework that relies on “inverse modeling” where the outputs of a model called “patterns” (e.g., in our context the emerging stable age distribution of a population or time-series data) are used to estimate the model inputs (e.g., the unknown parameters). In other words, inverse modeling estimates parameter values by optimizing the match between observed patterns and the corresponding model outputs. Inverse modeling has been traditionally used in several scientific areas like hydrology, oceanography, soil science or climatology (Tarantola, 1987; Gottlieb and DuChateau, 1996; Wunsch, 1996; Bennett, 2002), but less in ecological studies. Exceptions are applications to time-series data (e.g., Wiegand et al., 1998, Wiegand et al., 2004; Gross et al., 2002; Martínez et al., 2011, Martínez et al., 2016; González and Martorell, 2013; White et al., 2014; González et al., 2016; Zipkin et al., 2014a, Zipkin et al., 2014b) or other types of patterns (e.g., Revilla et al., 2004; Kramer-Schadt et al., 2007; Hartig et al., 2011; Anadón et al., 2012; May et al., 2015). [^2] ^0qz510


# Figuras e tabelas


## Figuras

### Figure 1

![[Pasted image 20240820161619.png|500]]

[[#Figure 1]]. Vital rates of *Parapiqueria cavalcantei* vary greatly between years but only recruitment differ between streams. The figure shows estimated vital rates related to survival (imature stasis and growth and adult survival) using inverse methods and recruitment estimated based on model selection for two different streams and three different years. Note that we could not estimate recruitment for 2024 because it can only be quantified a year later. 


### Figure 2

![[Pasted image 20240926083746.png |500]]

Figure 2. Quadratic programming accurately estimates the demographic parameters in our hypothetical species resembling *Parapiqueria cavalcantei* independently of the length of the time series (#census). Figure depicts associated error on the estimation of demographic parameters with inverse problem based on Quadratic programming, an inverse problem technique. 



## Tabelas

### table 1 
Table 1. Vital rate pairwise comparison between streams show no difference in estimated vital rates. Table shows mean individual stasis and growth of immature individuals and adult survival of adults and a t-test statistics is presented (t) as well as with the degree of freedom (df) and p-value.

| Vital rate              | mean (S11B) | mean (S11C) |  *t*   |  df  | p_value |
| ----------------------- | :---------: | :---------: | :----: | :--: | :-----: |
| $Stasis_{Immat}$        |    0.149    |    0.184    | -0.626 | 53.5 |  0.534  |
| $Growth_{Immat.>Adult}$ |    0.796    |    0.690    |  1.41  | 54.6 |  0.164  |
| $Survival_{Adult}$      |    0.611    |    0.681    | -0.700 | 53.0 |  0.487  |

### table 2

| Vital_rate           | Correlation | CI_low | CI_high | t     | df  | p_value |
| -------------------- | ----------- | ------ | ------- | ----- | --- | ------- |
| Stasis[Immat]        | 0.687       | 0.521  | 0.802   | 7.07  | 56  | <0.001  |
| Growth[Immat.>Adult] | -0.491      | -0.665 | -0.267  | -4.22 | 56  | <0.001  |
| Surv[Adult]          | -0.150      | -0.393 | 0.112   | -1.14 | 56  | 0.260   |
Table xx. Pearson correlation between each vital rate and years highlights that annual stasis significantly increases and annual individual growth rate significantly decreases during 2022-2024.  For each vital rate t-test statistics, degree of freedom, p-value and confidence interval at 95% are shown. 



### Tabela XXX

|      | Survival |      | Growth |      | Stasis |      | Lambda |      |
| ---- | -------- | ---- | ------ | ---- | ------ | ---- | ------ | ---- |
|      | S11C     | S11B | S11C   | S11B | S11C   | S11B | S11C   | S11B |
| 2022 | XXX      | XXX  | XXX    | XXX  | XXX    | XXX  | XXX    | XXX  |
| 2023 | XXX      | XXX  | XXX    | XXX  | XXX    | XXX  | XXX    | XXX  |
| 2024 | XXX      | XXX  | XXX    | XXX  | XXX    | XXX  | XXX    | XXX  |
| Mean | XXX      | XXX  | XXX    | XXX  | XXX    | XXX  | XXX    | XXX  |



# Referências

Appleton MR, Courtiol A, Emerton L, Slade JL, Tilker A, Warr LC, Malvido MÁ, Barborak JR, de Bruin L, Chapple R, Daltry JC, Hadley NP, Jordan CA, Rousset F, Singh R, Sterling EJ, Wessling EG, Long B. 2022. Protected area personnel and ranger numbers are insufficient to deliver global expectations. _Nature Sustainability_. DOI: [10.1038/s41893-022-00970-0](https://doi.org/10.1038/s41893-022-00970-0).

Bernard CD, Bonsall MB, Salguero-Gómez R. 2024. Life Histories and Study Duration matter less than Prior Knowledge of Vital Rates to Inverse Integral Projection Models. DOI: [10.1101/2024.04.06.588423](https://doi.org/10.1101/2024.04.06.588423).

Caswell H. 2001. _Matrix population models: Construction, analysis, and interpretation_. John Wiley & Sons, Ltd.

Doak DF, Waddle E, Langendorf RE, Louthan AM, Isabelle Chardon N, Dibner RR, Keinath DA, Lombardi E, Steenbock C, Shriver RK, Linares C, Begoña Garcia M, Funk WC, Fitzpatrick SW, Morris WF, DeMarche ML. 2021. A critical comparison of integral projection and matrix projection models for demographic analysis. _Ecological Monographs_ 91. DOI: [10.1002/ecm.1447](https://doi.org/10.1002/ecm.1447).

Ellner SP, Childs DZ, Rees M. 2016. Data-driven Modelling of Structured Populations. :9–56. DOI: [10.1007/978-3-319-28893-2](https://doi.org/10.1007/978-3-319-28893-2).

González EJ, Martorell C. 2013. Reconstructing shifts in vital rates driven by long‐term environmental change: a new demographic method based on readily available data. _Ecology and Evolution_ 3:2273–2284. DOI: [10.1002/ece3.549](https://doi.org/10.1002/ece3.549).

González EJ, Martorell C, Bolker BM. 2016. Inverse estimation of integral projection model parameters using time series of population‐level data. _Methods in Ecology and Evolution_ 7:147–156. DOI: [10.1111/2041-210X.12519](https://doi.org/10.1111/2041-210X.12519).

Leverington F, Costa KL, Pavese H, Lisle A, Hockings M. 2010. A Global Analysis of Protected Area Management Effectiveness. _Environmental Management_ 46:685–698. DOI: [10.1007/s00267-010-9564-5](https://doi.org/10.1007/s00267-010-9564-5).

Merow C, Dahlgren JP, Metcalf CJE, Childs DZ, Evans MEK, Jongejans E, Record S, Rees M, Salguero-Gómez R, McMahon SM. 2014. Advancing population ecology with integral projection models: a practical guide. _Methods in Ecology and Evolution_ 5:99–110. DOI: [10.1111/2041-210X.12146](https://doi.org/10.1111/2041-210X.12146).

Needham J, Merow C, Butt N, Malhi Y, Marthews TR, Morecroft M, McMahon SM. 2016. Forest community response to invasive pathogens: the case of ash dieback in a British woodland. _Journal of Ecology_ 104:315–330. DOI: [10.1111/1365-2745.12545](https://doi.org/10.1111/1365-2745.12545).

Raghu S, Nano CEM, Pavey CR. 2013. A demographic framework for the adaptive management of the endangered arid-zone tree species Acacia peuce. _Australian Journal of Botany_ 61:89. DOI: [10.1071/BT12221](https://doi.org/10.1071/BT12221).

Rodríguez-Caro RC, Wiegand T, White ER, Sanz-Aguilar A, Giménez A, Graciá E, Van Benthem KJ, Anadón JD. 2019. A low cost approach to estimate demographic rates using inverse modeling. _Biological Conservation_ 237:358–365. DOI: [10.1016/j.biocon.2019.07.011](https://doi.org/10.1016/j.biocon.2019.07.011).

Römer G, Dahlgren JP, Salguero‐Gómez R, Stott IM, Jones OR. 2024. Plant demographic knowledge is biased towards short‐term studies of temperate‐region herbaceous perennials. _Oikos_ 2024:e10250. DOI: [10.1111/oik.10250](https://doi.org/10.1111/oik.10250).

Salguero-Gómez R, Jones OR, Archer CR, Bein C, Buhr D, Farack C, Gottschalk FFF, Hartmann A, Henning A, Hoppe G, Römer G, Ruoff T, Sommer V, Wille J, Voigt J, Zeh S, Vieregg D, Buckley YM, Che-castaldo J, Hodgson D, Scheuerlein A, Caswell H, Vaupel JW, Salguero Gomez R, Jones OR, Archer R, Bein C, de Burh H, Farack C, Gottschalk FFF, Hartmann A, Henning A, Hoppe G, Roemer G, Ruoff T, Sommer V, Wille J, Voigt J, Zeh S, Vieregg D, Buckley YM, Che-castaldo J, Hodgson D, Scheuerlein A, Caswell H, Vaupel JW, Salguero-gómez R, Jones OR, Archer CR, Bein C, de Buhr H, Farack C, Gottschalk FFF, Hartmann A, Henning A, Hoppe G, Römer G, Ruoff T, Sommer V, Wille J, Voigt J, Zeh S, Vieregg D, Buckley YM, Che-castaldo J, Hodgson D, Scheuerlein A, Caswell H, Vaupel JW, Salguero Gomez R, Jones OR, Archer R, Bein C, de Burh H, Farack C, Gottschalk FFF, Hartmann A, Henning A, Hoppe G, Roemer G, Ruoff T, Sommer V, Wille J, Voigt J, Zeh S, Vieregg D, Buckley YM, Che-castaldo J, Hodgson D, Scheuerlein A, Caswell H, Vaupel JW, Salguero-gómez R, Jones OR, Archer CR, Bein C, de Buhr H, Farack C, Gottschalk FFF, Hartmann A, Henning A, Hoppe G, Römer G, Ruoff T, Sommer V, Wille J, Voigt J, Zeh S, Vieregg D, Buckley YM, Che-castaldo J, Hodgson D, Scheuerlein A, Caswell H, Vaupel JW. 2016. COMADRE: A global data base of animal demography. _Journal of Animal Ecology_ 85:371–384. DOI: [10.1111/1365-2656.12482](https://doi.org/10.1111/1365-2656.12482).

Salguero-Gómez R, Jones OR, Archer CR, Buckley YM, Che-Castaldo J, Caswell H, Hodgson D, Scheuerlein A, Conde DA, Brinks E, de Buhr H, Farack C, Gottschalk F, Hartmann A, Henning A, Hoppe G, Römer G, Runge J, Ruoff T, Wille J, Zeh S, Davison R, Vieregg D, Baudisch A, Altwegg R, Colchero F, Dong M, de Kroon H, Lebreton JD, Metcalf CJEE, Neel MM, Parker IM, Takada T, Valverde T, Vélez-Espino LA, Wardle GM, Franco M, Vaupel JW. 2015. The COMPADRE Plant Matrix Database: An open online repository for plant demography. _Journal of Ecology_ 103:202–218. DOI: [10.1111/1365-2745.12334](https://doi.org/10.1111/1365-2745.12334).

Santos GS, Moreira DO, Ana Carolina Loss, Mário Luís Garbin. 2024. Management plans bias the number of threatened species in protected areas: a study case with flora species in the Atlantic Forest. xx:xx. DOI: [10.1007/s10531-024-02796-y](https://doi.org/10.1007/s10531-024-02796-y).

Silveira FAO, Negreiros D, Barbosa NPU, Buisson E, Carmo FF, Carstensen DW, Conceição AA, Cornelissen TG, Echternacht L, Fernandes GW, Garcia QS, Guerra TJ, Jacobi CM, Lemos-Filho JP, Le Stradic S, Morellato LPC, Neves FS, Oliveira RS, Schaefer CE, Viana PL, Lambers H. 2016. Ecology and evolution of plant diversity in the endangered campo rupestre: a neglected conservation priority. _Plant and Soil_ 403:129–152. DOI: [10.1007/s11104-015-2637-8](https://doi.org/10.1007/s11104-015-2637-8).

Viana PL, Mota NFDO, Gil ADSB, Salino A, Zappi DC, Harley RM, Ilkiu-Borges AL, Secco RDS, Almeida TE, Watanabe MTC, Santos JUMD, Trovó M, Maurity C, Giulietti AM. 2016. Flora das cangas da Serra dos Carajás, Pará, Brasil: história, área de estudos e metodologia. _Rodriguésia_ 67:1107–1124. DOI: [10.1590/2175-7860201667501](https://doi.org/10.1590/2175-7860201667501).

Zipkin EF, Thorson JT, See K, Lynch HJ, Grant EHC, Kanno Y, Chandler RB, Letcher BH, Royle JA. 2014. Modeling structured population dynamics using data from unmarked individuals. _Ecology_ 95:22–29. DOI: [10.1890/13-1131.1](https://doi.org/10.1890/13-1131.1).

# Notas
[^1]: Quais life traits?
[^2]: Retirado na íntegra de https://www.sciencedirect.com/science/article/abs/pii/S0006320718310577
[^3]: Parte desse texto foi copiado e colado do meu artigo da Biodiv. Conservation. Fazer os ajustes necessários para se adequar ao artigo atual.
[^4]: Apenas os modelos com máximo reprodutivos serão considerados já que no MPM não faz sentido incluir os indivíduos totais na capacidade reprodutiva. Ver detalhes em [[Modelos possiveis recrutamento Parapiqueria.excalidraw]].  
[^6]: Bogdan A, Levin SC, Salguero-Gómez R, Knight TM (2021) Demographic analysis of an Israeli _Carpobrotus_ population. PLoS ONE 16(4): e0250879. https://doi.org/10.1371/journal.pone.0250879
[^7]: See [[Mark-recapture in plants]]
[^8]: Citar Demographic studies in plants appear simple because unlike animals, plants do not run away. [Kéry & Gregg 2003 Animal Biodiversity Conservation](https://museucienciesjournals.cat/en/abc/issue/27-1-2004-abc/demographic-estimation-methods-for-plants-with-dormancy)
[^9]: ==Eu preciso escrever isso com outro sentido, dando a entender que inverse methods são uma solução mas são pouco explorados!!!==
[^10]: **ANTERIORMENTE**: The estimation of demographic parameters were particularly challenging since mark-recapture was not possible and the annual behaviour limit the direct estimation of reproduction along the survival in inverse problems techniques. In addition, the short life-cicle also limit the possibility of several census along their non-dormant season, reducing the window monitoring might be performed. Regardless all difficulties, we successfully estimated survival and recruitment and the simulations with a hypothetical species with known parameters supported a robust estimation of these demographic parameters. 
[^12]: A questão da diversidade de espécies anuais pode ser um problema/solução. Se der a sensação de que a alta frequencia de ervas anuais é comum apenas nas cangas eu posso acabar jogando o trabalho para um contexto muito local.
[^13]: 
[^14]: [[0 - Resources/Reading notes/3-Ecologia geral/SilveiraEtAl2016PlantSoil#^j2iq2e|SilveiraEtAl2016PlantSoil#^j2iq2e]] falando sobre o Mioceno e o surgimento das plantas C4 inflamáveis. Uma diferença considerável em relação a proposta do Cretáceo
[^15]: Citar  [Hopper et al. 2023 Plants](https://www.mdpi.com/2223-7747/12/3/645)
[^16]: Baseado em: [[Pasted image 20240806221944.png|glm.nb(abundância ~ year*Site)]]
[^17]: **Alternativo a essa sentença:** Based on such information, we noticed a low but significant different extinction probability between the two sampled streams. Mostly important several ecological inferences about the population dynamics and its implications were allowed
[^18]: Outras citações possíveis  (e.g., Caughley, 1977; Michod and Anderson, 1980; Udevitz and Ballachey, 1998; Wiegand et al., 2004)[[#^0qz510|APUD]]
[^19]: David Fournier and Chris P. Archibald . 1982. A General Theory for Analyzing Catch at Age Data. _Canadian Journal of Fisheries and Aquatic Sciences_ . **39** (8): 1195-1207. [https://doi.org/10.1139/f82-157](https://doi.org/10.1139/f82-157)
[^20]: Caswell, H. and Twombly, S. (1989). Estimation of stage—specific demographic parameters for zooplankton populations: methods based on stage—classified matrix projection models. Estimation and Analysis of Insect Populations, 93-107. https://doi.org/10.1007/978-1-4612-3664-1_4
[^21]: Citar artigo do Marc Kery aqui falando sobre detectabilidade
[^22]: **PARÁGRAFO ANTIGO:** The estimation of demographic parameters such as survival and reproduction rates is key for accurate forecasting of the fate of wildlife and plant populations and for evaluating alternative management actions (Boyce, 1992; Williams et al., 2002; Beissinger and McCullough, 2002)[[#^k01uht|APUD]].  ==SENTENÇA PARA ORGANISMOS EM GERAL FALANDO DE MARCAÇÃO E RACAPTURA==. For plants, demographic parameters have been traditionally estimated by marking and following ("recapture") the individuals, in a same vein as Mark-recapture practices in animals[^5]. However, contrary to popular belief, marking and following plants are not always possible or accurate regardless their limited mobility[^8]. Such appropriate direct estimation then might be unfeasible by logistic constraints due remoteness [e.g., @RaghuEtAl2013Aust.J.Bot.], physical constraints such hills (Bodgan et al. 2021[^6]), or cryptic life stage (e.g., aboveground biomass[^5]). An alternative to such direct estimation of demographic parameters is indirect estimation based on population-level data such as age structure estimates [^18]  [@ZipkinEtAl2014Ecology] . 
[^24]: A partir de agora acho que vou usar só o modelo `t1~0+t0+Site+period` que parece ser adequado tbm segundo a função dredge e tbm passa em todos os testes do pacote DHARMa
[^25]: **PARÁGRAFO ANTIGO:**  "extend deeply how populations are performing between different streams and how climatic change and habitat management could determine its persistence. Integrating such studies with demographic information was possible only given the successful implementation of the inverse model techniques. Based on this result we unveil an interesting change in the trade-off development, where individuals gradually slowdown their maturation rate. This pattern require an in deep study which we already started by spreading different temperature and umidity sensors across the different parcels in the two streams. ==Mostly important, we could discover that reproductive performance is the major driven of population fluctuation which in their turn reflects on their probability to extinct==. Despite general high values of $\lambda$ for populations on both streams, the huge variation on recruitment confer a small but not negligible extinction probability. By holding all these information, we also could make an initial exercise to estimate the population viability in both streams, and we surprisingly found a very small probability to extinct that contrasts with the very small effective population size estimated by genetics. Altogether, these results represent important pieces to stregthen the protection about these populations." 
[^26]: AQUI ELA ESTÁ COMO EM PERIGO! https://proflora.jbrj.gov.br/html/Parapiqueria%20cavalcantei_2022.html. Também há menção ao PAT. VER: "A espécie ocorre em território que poderá ser contemplado por Plano de Ação Nacional (PAN) Territorial, no âmbito do projeto GEF Pró-Espécies - Todos Contra a Extinção: Território PAT Meio Norte - 1 (PA)".
[^27]: Ver Méndez‐Castro, F. E., Chytrý, M., Jíménez-Alfaro, B., Hájek, M., Horsák, M., Zelený, D., … & Ottaviani, G. (2021). What defines insularity for plants in edaphic islands?. Ecography, 44(8), 1249-1258. https://doi.org/10.1111/ecog.05650
[^28]: Trocar essa interpretação! Focar no fato que os estudos reprodutivos casam com a estimativa de recrutamento mas as mudanças populacionais parecem ser muito mais dependentes da quantidade de indivíduos que sobrevive até a fase reprodutiva do que da taxa de recrutamento
[^29]: Parcels ou streams?
[^30]: Pq é um Qui-quadrado aqui? Estranho!
[^31]: Anteriormente: ==To make the hypothetical species as most realistic as possible, we first estimated the development and survival rates from maximum total of immature individuals to maximum total of reproductive individuals based on a linear model selection using AIC. We followed the same framework used to the estimate the recruitment but a few necessary adjustment were necessary. First our model compared maximum immature individuals in $t_0$ against maximum reproductive individuals in the same year, so, also in $t_0$. Second, only Immature against reproductive individuals were considered. Similar to the recruitment rate, we applied different distributions and selected the model based on their AIC. It is important to notice that altough simple GLMs cannot produce accurate estimates of individual growth and survival without individual mark-recapture, it provides a rough guess to what extent survival and development parameters ranges. Second, we fixed the recruitment rate based on what we have already estimated for our studied species. By fixing the parameter already estimated to our studied species, we allow to vary only the parameters of development and survival which is implemented by inverse problems and requires further validation.==    
[^32]: Discussão semelhante em Murtaugh PA. 2007. SIMPLICITY AND COMPLEXITY IN ECOLOGICAL DATA ANALYSIS. _Ecology_ 88:56–62. DOI: [10.1890/0012-9658(2007)88[56:SACIED]2.0.CO;2](https://doi.org/10.1890/0012-9658(2007)88[56:SACIED]2.0.CO;2).
[^33]: Ver Wood, S. N. 1997. Inverse problems and structured-population dynamics. Pages 555–586 in S. Tuljapurkar and H. Caswell, editors. Structured-population models in marine, terrestrial, and freshwater systems. Chapman and Hall, New York, New York, USA.
[^34]: A conclusão não inclui os achados da biologia da espécie. Aqui é interessante informar os aspectos importantes que foram possíveis concluir ou pelo menos as questões levantar graças ao modelo inverso aplicado.