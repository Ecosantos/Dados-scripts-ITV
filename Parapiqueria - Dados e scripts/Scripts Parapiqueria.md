---
tags:
  - "#Projetos/ITV"
  - "#Projeto/Parapiqueria"
  - "#Demografia"
---

Disponíveis em
`setwd("C:/Artigos e resumos publicados submetidos ideias/Notes/9 - ITV/Dados-scripts-ITV/Parapiqueria - Dados e scripts")` 

```dataviewjs
const files = app.vault.getFiles()
  .filter(file => file.path.includes("Parapiqueria - Dados e scripts") && file.extension =='r')

.sort(p => p.dateStarted, 'desc')

dv.table(["Arquivo", "PATH","Teste1","Tentei colocar a data, não consegui"],
  files.map(file =>
    [ dv.fileLink(file.path),
      file.path,
       p.dateStarted,
       Date()]))
```
