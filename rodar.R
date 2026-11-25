library(targets)
library(targetsboard)

source("gerar_dados.R")    

app <- tar_board()         
tar_make()                 

tar_read(resumo)
tar_read(anova_tab)
tar_read(grafico)

app$kill()               
