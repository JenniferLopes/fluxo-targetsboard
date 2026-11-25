# Gera um ensaio simulado de cultivares (DBC, 4 cultivares x 4 blocos)
set.seed(35)
ensaio <- expand.grid(cultivar = paste0("C", 1:4), bloco = paste0("B", 1:4))
efeito <- c(C1 = 0, C2 = 400, C3 = 350, C4 = 500)
ensaio$produtividade <- round(6000 + efeito[ensaio$cultivar] +
  rnorm(nrow(ensaio), 0, 250))
ensaio$produtividade[3] <- NA  # uma parcela perdida
write.csv(ensaio, "dados/ensaio.csv", row.names = FALSE)
