library(targets)

tar_option_set(packages = c("dplyr", "ggplot2"))
tar_source()

list(
  # Entrada e preparo
  tar_target(arquivo, "dados/ensaio.csv", format = "file"),
  tar_target(brutos, ler_ensaio(arquivo)),
  tar_target(dados, limpar_ensaio(brutos)),

  # Descritivo
  tar_target(resumo, resumir_cultivares(dados)),
  tar_target(grafico, grafico_cultivares(resumo)),

  # Modelo
  tar_target(modelo, ajustar_modelo(dados)),
  tar_target(anova_tab, anova(modelo)),
  tar_target(tukey, comparar_medias(dados)),

  # Diagnóstico do modelo
  tar_target(residuos, extrair_residuos(modelo)),
  tar_target(grafico_res, grafico_residuos(residuos)),
  tar_target(normalidade, teste_normalidade(residuos))
)
