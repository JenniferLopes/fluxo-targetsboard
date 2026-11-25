ler_ensaio <- function(arquivo) {
  read.csv(arquivo, stringsAsFactors = TRUE)
}

limpar_ensaio <- function(dados) {
  dados[!is.na(dados$produtividade), ]
}

resumir_cultivares <- function(dados) {
  dados |>
    dplyr::group_by(cultivar) |>
    dplyr::summarise(
      n = dplyr::n(),
      media = mean(produtividade),
      dp = sd(produtividade),
      .groups = "drop"
    ) |>
    dplyr::arrange(dplyr::desc(media))
}

ajustar_modelo <- function(dados) {
  lm(produtividade ~ bloco + cultivar, data = dados)
}

grafico_cultivares <- function(resumo) {
  ggplot2::ggplot(resumo, ggplot2::aes(reorder(cultivar, media), media)) +
    ggplot2::geom_col(fill = "#2E7D32") +
    ggplot2::geom_errorbar(ggplot2::aes(ymin = media - dp, ymax = media + dp),
                           width = 0.2) +
    ggplot2::coord_flip() +
    ggplot2::labs(x = "Cultivar", y = "Produtividade (kg/ha)") +
    ggplot2::theme_minimal()
}

# ---- Novas funções (diagnóstico e comparação de médias) ----

comparar_medias <- function(dados) {
  ajuste <- aov(produtividade ~ bloco + cultivar, data = dados)
  tk <- TukeyHSD(ajuste, "cultivar")$cultivar
  data.frame(comparacao = rownames(tk), tk, row.names = NULL)
}

extrair_residuos <- function(modelo) {
  data.frame(ajustado = fitted(modelo), residuo = resid(modelo))
}

grafico_residuos <- function(residuos) {
  ggplot2::ggplot(residuos, ggplot2::aes(ajustado, residuo)) +
    ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
    ggplot2::geom_point(colour = "#2E7D32", size = 2) +
    ggplot2::labs(x = "Valor ajustado", y = "Resíduo") +
    ggplot2::theme_minimal()
}

teste_normalidade <- function(residuos) {
  shapiro.test(residuos$residuo)
}