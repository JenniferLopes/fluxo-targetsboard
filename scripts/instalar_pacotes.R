# Rode uma vez antes de tudo. Instala o que faltar e carrega os pacotes.
if (!require("pacman")) install.packages("pacman")

# Pacotes do CRAN
pacman::p_load(targets, dplyr, ggplot2, broom)

# targetsboard 
# pacman::p_load_gh("Athospd/targetsboard") #ou
# remotes::install_github("Athospd/targetsboard")
library(targetsboard)

# targetsboard precisa de um shiny recente (1.12 ou mais)
if (packageVersion("shiny") < "1.12.0") pacman::p_install(shiny, force = TRUE)


