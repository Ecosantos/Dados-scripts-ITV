> [!info] **Compilação pessoal de informações**
> - **Temática**: Cursos cursados; Peter Zuidema; Modelagem populacional; 
> - **Tags:** #Demografia/IPM #Demografia/MPM #Demografia #Leactures 
> - **Professor:** Pieter Zuidema pieter.zuidema@wur.nl
> - **Material disponível em:**  [https://drive.google.com/drive/folders/1GLKJYrX0XzUHiCGBOeCRob3s8m8iiF-2?usp=drive_link](https://drive.google.com/drive/folders/1GLKJYrX0XzUHiCGBOeCRob3s8m8iiF-2?usp=drive_link)
> - **Ver também procedimentos pré-curso**: [[README - Curso Zuidema 2025 - Pré curso]]


# Lembretes
- Novo script "....\_CORRECTED"  adicionou estocasticidade ambiental

# TODO
- [ ] Ler artigos


# Presentation
- 10-15min
- Ideias, IPM results or first results of vital rate regression
- Please include:
	- Question
	- pictures of the study species & environment
	- Graphs with results of info about the data.
- 

# Goals
- 3 relevante R-packages[^2]
- Basic to know, construct, run and interpret MPMs & IPMs
- Tuesday: 1st paper discussion
- Wednesday: 2nd paper discussion

>[! hint] PRESENTATION!!!! 
>## FRIDAY! 

# Aula 1
## Introdução
- Aplication of matrix models:
	- Identify Critical life stages
	- Evolutionary advances of LH strategies
	- Importance of seed input for survival
	- Conservation of threatened species
		- What are critical Life stages?
		- Extinction risk?
	- Muitos outros exemplos
	- for Invasive species:
		- What the invasion speed
		- What phases contribute most


## Making size categories
- Trees size
- para outras espécies (espécies rápidas) também é possível utilizar idade[^1]

## Transiente population growth
Projeções ao longo do tempo podem ser realizadas apenas elevando a matriz
- t+1 = $n_{t+1} = A ** n_t$
- t+2 =$n_{t+1} = A^2 * n_t$
- t+3 = $n_{t+1} = A^3 * n_t$
- t+4 = $n_{t+1} = A^{...} * n_t$


#### Se tivermos várias matrizes
Podemos fazer assim
$n_{t+3} = A * B * C * n_{t}$, onde A, B e C são matrizes diferentes para anos diferentes. No caso três anos diferentes mas poderiam ser mais se D, E , F fossem inclusos....

We can also calculate $A * B * C$ para calcular lambda de três anos consecutivos de uma vez só.   

## Assumptions
- ver [[Lecture Monday Matrix models.pdf#page=26]]

## Asymptotic population growth rate
- When simulated population  reach size structure we can rewrite the formula 
	 - from: 
		 - $n_{t+1} = A * n_t$
	- to
		 - $n_{t+1} = \lambda * n_t$

## Stable stage/age distribution 
- Podem ser utilizado como proxy para validação do modelo.
	- Se por exemplo a estrutura populacional simulada é muito diferente do que faz sentido, provavelmente o modelo matricial é ruim
		- Ex. Quando sobrevivência de adultos é proximo de 1, o stable size distribution tende a se concentrar praticamente só entre adultos. Isso vai indicar que o modelo matricial não é acurado suficiente
- A interpretação da distribuição etária estável não é tão obvia então precisa de muito cuidado.
- De qualquer forma o Pieter concorda que essa métrica é pouco utilizada, mas no caso ele acredita que o uso deveria ser incrementado como uma forma de validação dos modelos.

## Elasticities
- Slides 42 a 44 apresentam excelentes exemplo  de como calcular a elasticidade
	- ver: [[Lecture Monday Matrix models.pdf#page=44]]

## Exemplos ao longo da aula 1  - Euterpe precatória
- ver [[Exercises matrix models.docx]]
	- [[MatrixPopulationModels.r]]

### Comentários interessantes.
>[! caution] 
>Interessante que apenas a soma das elasticidades de cada categoria (stasis, growth, reproduction...) já represente a contribuição de cada categoria. Talvez eu quebrasse a cabeça tentando entender isso de maneira mais aprofundada. Não lembro como fiz no meu artigo do doutorado. Acho que fiz isso mesmo! 
>-  >[! quote]
>"We can sum elasticities per category to evaluate the contribution of size categories to population growth. Using the following code you can see which is the most important category"
>\- Step4 de [[Exercises matrix models.docx]]


## Exemplos ao longo da aula 1  

### Exemplos script
#### Roe Deer

Muito interessante a forma como density dependence foi adicionada ao modelo.

- "1-nt_dd_sum/K" representa uma relação logit da população observada  em relação à capacidade suporte, no caso: $\frac{1-N}{K}$
- Anteriormente o que estava fazendo é limitar o tamanho populacional a K indivíduos, então eu implementava a capacidade suporte matando os indivíduos, porém dessa forma apresentada abaixo é muito mais alegante.
	- Entretanto, precisa ter atenção aqui.
	- Quando os valores de ar_max e sr_max são apresentados há uma multiplicação misteriosa por 2. Que parece que é pra ajustar os dados. Pode ser justamente pq apesar de mais elegante essa abordagem apenas adiciona outro tipo de viés.
		- `{R} ar_max=0.2044*2 # maximum reproduction rate for A individuals` <- Ninguem entendeu direito o que esse 2 está fazendo ai. 
			- A resposta mais próxima para entender isso é que os autores do artigo consideraram que aoenas meta da reprodução real foi observada. Por isso o \*2.
		- Outra explicação é que esse 2 foi incorporado pq boa parte do tempo a população estava na metade da capacidade suporte


```{R "Rum deer"}
#####################################
# Step 9. Density dependent for deer#
#####################################

#.... Várias coisas aqui até chegar na parte abaixo
for (t in 1:20) {
  A_dd <- A
  A_dd[1,2] <- ar_max * (1-nt_dd_sum/K)     # ar_max sao os individuos maduros jovens
  A_dd[1,3] <- sr_max * (1-nt_dd_sum/K)     # sr_max sao os indivíduos maduros seniores. 
  proj_dd <- pop.projection(A_dd,nt_dd,2)
  nt_dd <-as.matrix(proj_dd$stage.vectors[,2], nrow=3, ncol=1)
  nt_dd_sum <- sum(nt_dd)
  deer_dd$pop_dd[t+1] <- nt_dd_sum
}

# Acho que o código acaba aqui. No script original tem:
# n0  <- as.matrix(read.table(file = "deer_vec.csv", sep=",", header = FALSE))
# nt_dd_sum <- sum(n0)
# e continua.... porém isso parece uma repetição de linhas anteriores. 


```

#### Mahogany (mogno) Swietenia macrophylla.
O que foi realizado com essa espécie no exemplo dado foi basicamente fazer um ciclo onde:
$n_{t+20} = C^{11} * LS^9 * N_t$

- We canso consider $Cycle = C^{11} * LS^9$ , where:
	- Cycle is the complete 20 years analysed.
	- Logo, pode ser reescrito como

$n_{t+20} = Cycle * N_t$


#### 
# Aula 2 - IPM
- ver [[Lecture Tuesday IPM construction.pdf]]
Quando transforma o kernel em matriz nos referimos a essa matriz resultante como "Kmatrix"

$n(t+1) = Kmatrix * n_t$

### Why IPM
- Eliminate the effects of categories
- Flexible model with few parameters



## IPM x MPM - problemas com a categorização
- Considere o modelo a seguir: [[Lecture Tuesday IPM construction.pdf#page=17]]
	- Um individuo de sorte pode chegar a um adulto sênior em apenas 4 anos 
		- Mesmo para uma árvore de longíssima duração❗❗ UAU ❗❗
	- Como resultado, $\lambda$ tende a ser superestimado! [^3]
	- Uma forma de resolver esse problema é adicionar idade. Viraria uma espécie de "memória" garantindo que essa 

- No slide 19 há uma comparação entre entre idade estimada pelos modelos matricias x estimado por anéis de crescimento. [[Lecture Tuesday IPM construction.pdf#page=19]]
	- Os simbolos descrevem as dfiferentes categorias utilizadas e ficou claro que categorias 2.5cm são ideias.
	- As demais categorias utilizadas (10, 5 e 1.25 cm) tendem a super ou sub estimar a idade desses indivíduos e deveriam ser evitadas
		- Essa informação no entanto é ausente para a maioria dos MPMs e é justamente ai que o IPM é especialmente interessante.
		- No MPM uma solução mitigadora seria adicionar mais classes. 


- midpoint: 

- Representa como o tamanho das categorias afeta o crescimento populacional[[Lecture Tuesday IPM construction.pdf#page=26]]
	- É possível ver que categorias DBH = 1 alcança uma forma de assíntota.
		- Reduzir ainda mais o tamanho das categorias além de não melhorar muito o modelo ainda demandaria maior capacidade computacional 


- [[Lecture Tuesday IPM construction.pdf#page=33]]
	- Slide 33 mostra três habitats (SF,F,FC) diferentes in dois anos diferentes (plot 3x2 respectivamente)


- Quality of the model for IPM.
	- Quality do modelo afeta diretamente a qualidade do IPM.
	- Embora geralmente a galera não preste muita atenção no R²
	- Um modelo ruim pode indicar que a dinâmica populacional não é muito bem determinada pelo tamanho dos indvíduos.


### Flexible models & few parameters
- Todos os dados são utilizados para estimar todos os parâmetros.
	- Diferente dos MPM onde cada categoria acaba tendo uma "análise" diferente


Uma forma interessante de validar os IPMs é comparar o IPM construido com os melhores modelos com um IPM construido com outros GLMs subótimos!



## Definindo os modelos
Frequentemente
	$size_{next} ~ a * size ~+~ ....$
Porém, faz mais sentido
	$growth ~ a*size+b*size^2  ~+~ ....$

Para resolver esse dilema, utilizamos a função nls (=non-linear least squares)


## Exemplo 1 - Euterpe precatória - IPM

#### Crescimento 
- No modelo do crescimento desse exemplo três modelos foram criados
- Linear, quadrático e o Hossfeld equation
	- O Hossfeld equation se mostra uma solução para evitar que o modelo quadrático force uma relação negativa nos tamanhos finais, isso porque o modelo quadrático sempre terá uma forma concava ou convexa. Com a Hossfeld equation isso é minimizado.
		- A escolha do Hossfeld equation vem de um background teórico. Pieter usou ela como uma tentativa e já que deu certo ficou com esse modelo. 
			- Isso significa que a escolha do modelo é baseada em empiricismo + teoria + tentativa-erro


>[! column]
> No exemplo fornecido "palm height" não poderia haver retrogressão já que se trata de uma palmeira. No entanto, devido a erros de amostragem ha diversas medidas que de fato são negativas. Especialmente por isso o modelo quadrático é pouco interessante em termos práticos pq mesmo se fossem escolhido como o melhor modelo ele provavelmente não seria representativo. Por isso a equação Hossfeld foi incorporada
> >
>![[Pasted image 20250211141858.png]]

#### Corrected for eviction

`eviction_cor=TRUE` em `init_ipm` function serve para evitar que os indivíduos nas últimas classes sejam removidos de um ano para outro. 

>[! quote]
>`evict_cor` refers to whether or not to correct for eviction in the kernel. If this is set to `TRUE`, then you must supply a function specifying which expressions need to be corrected and the correction to apply. `ipmr` provides `truncated_distributions` for now, though others will eventually be implemented as well. Subsequent additions are mainly to accommodate models in PADRINO, and I very strongly suggest sticking to `truncated_distributions` for your own models.
>
>\- [ipmR manual](https://padrinodb.github.io/ipmr/articles/ipmr-introduction.html). 

#### Checking mesh points
- Há diversas formas de avaliar se a escolha do Mesh size foi adequada
	- Modificando o mesh size e comparando os lambdas
	- Verificar o tempo de geração
		- O
	- Outra forma é apresentada na "Step 9" do script [[IPM_construction_acai.r]]
		- Tem um gráfico que mostra qual a probabilidade de plantas de X cm de altura transicionar. Para um bom ajuste de Mash size há a necessidade de apresentar uma boa curva que isso irá garantir uma boa descrição dos processos que estão ocorrendo.


### Discussão de artigos - Zucaratto et al. 2021
- During the group discussion, use the following questions to guide the conversation:
	- How were the data on vital rates collected in the field? 
	- What statistical models were used for each of the vital rates?
	- What type of analyses were done with the IPM? Possible analyses include population projection, elasticity analysis, calculation of asymptotic growth rate, etc. 
		- ***REPLY***
			- Elasticidade; 
			- Calculation of asymptotic growth rate
	- Was there a clear reason to use IPMs for this study?
		- ***REPLY:*** Para eliminar a necessidade de subdividir em classes etárias/tamanhos
	- Do you have any critical comments on the study?


# Aula 3 - Life history

>[! info|wsmall right] 
>Aqui é apresentada a fórmula do LTRE.
>![[Formula LTREexcalidraw]]
>
>$\Lambda \lambda$ é determinada pelo somatório dos efeitos das diferenças entre as taxas vitais *x* contribuição dessas taxas vitais pelo crescimento populacional (= sensitivity, $s_{ij}$)  

## LTRE - Life Table Response Experiment

- LTRE não é uma análise estatística. É só um calculo de como entender o que está determinando o lambda da população.
- Sendo assim, Zuidema prefere que análises estatísticas sejam realizadas inicialmente durante o GLM para verificar se há diferença significativa nas taxas vitais.
- Uma vez que essas diferenças existem, então prosseguimos com os LTRE para entender como elas determinaram a diferença entre $\lambda$


## ipmr package
- limited output available:
	- Lambda, eigenvectors
	- 


# Aula 3 - What do you need for an IPM
Ver slides [[Lecture Thursday IPM tips.pdf]]
- An interesting question
- The question determines
	- What you measure and study in the field
		- Where
		- how long
		- what classes
		- how many plots
	- What stages your IPMs includes: seeds, seedlings
	- What structure your IPM has:
		- Time varying
		- habitat differences
		- treatments
		- landscape level
- Sound data:
	- sufficient individuals
		- minimum ~200, ideally 500
			- Entre ambientes, tratamentos e 
	- Ensure sufficient coverage of all classes
	- Statistical logic to determine sampling and experimental design
	- Pool data across habitats, treatments, etc..
	- All vital rates
		- Survival
		- Growth
		- Reproduction/recruitment




## Vital rate regressions: 

### growth
- How to fit growth model in IPMs - ver [[Lecture Thursday IPM tips.pdf#page=10]]
	- long-lived x short-lived provavelmente respondem melhor a diferentes modelos. 

### Reproduction
ver [[Lecture Thursday IPM tips.pdf#page=11]]
- Most complex.[^4]
- Algumas vezes podem ser obtidos de indivíduos fora da parcela
	- Por exemplo. Probabilidade de reprodução
	- Número de inflorescência ou sementes produzidas por indivíduos


### Clonal reproduction
- You need:
	- Which individuals are producing new shoots
	- New shoots per clonality per repro. individuals

## IPM construction
- start simple
- Mesh size check
	- Mesh size incluence in lambda, ages & growth variability
	- Make cross-cuts in IPM to ensure growth variability is described by at least 5 points[^5]


# Curiosidades
## Lidando com clonalidade
- Pieter comentou sobre a possibilidade de criar três modelos distintos quando há a clonalidade:
	- Sem considerar clonalidade
	- Considerando apenas clonalidade e não reprodução sexuada
	- Considerando clonalidade + reprodução
## Lidando com multiplos estágios reprodutivos
- Só é possível distinguir a produção de seedlings para duas ou mais classes de adultos reprodutivos quando alguma outra informação como produção de sementes, frutos ou flores em cada estágio reprodutivo e então multiplicar pelo total de seedlings. Isso dará a diferença entre os estágios

## Lidando com espécies com dimorfismo
- É possível considerar apenas uma matriz para ambos os sexos
- É possível construir uma matriz onde há transição entre machos e fêmeas.
	- ![[MPM com Dimorfismo.excalidraw|100]]

### Pooling datasets
- Como lidar com modelos determinísticos quando possuimos diferentes anos amostrados?
	- Usar a média é uma possibilidade, mas o Peiter prefere utilizar os dados Pooled
	- Ou seja, se temos 10 anos amostrados, o que vamos fazer é ver o crescimento ao longo desses 10 anos, reprodução ao longo desses 10 anos e etc...
	- Para seedlings, onde 

# Glossary
- LH = Life stages
- SSD = Stable Stage Distribution




### Using  GAM
- GAM is too flexible and it is possible it will not handle very well missing classes. GLM can be more robust in such cases.
	- Pieter suggested try, He believe ipmr can handle that,
- 
# Notes

[^1]: Interessante. Não lembro de ter visto age no COMPADRE, mas provavelmente tem sim
[^2]: Não ficou claro quais são esses pacotes na apresentação
[^3]:Essa relação também ocorre quando estamos trabalhando com Mesh sizes pequenos nos IPMs! 
[^4]: Curioso. Eu achava que era o mais fácil
[^5]: Pelo que entendi aqui é aquele gráfico de distribuição representando qual a probabilidade de um individuo transicionar de um tamanho pra outro. O ideal é que no gráfico seja possível visualizar uma curva bem definida. Essa curva bem definida deve conteur pelo menos 5 pontos.