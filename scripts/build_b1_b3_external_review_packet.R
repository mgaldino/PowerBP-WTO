options(encoding = "UTF-8")

if (!isTRUE(l10n_info()[["UTF-8"]])) {
  stop("Execute with LC_ALL=pt_BR.UTF-8 and LANG=pt_BR.UTF-8")
}

packet_path <- "reports/chatgpt_pro_packets/2026-09-01_b1_b3_exclusion_external_review_packet.md"
manifest_path <- sub("\\.md$", ".sha256", packet_path)

manuscript_path <- "formal_model_v6.Rmd"
candidate_path <- "quality_reports/2026-09-01_b1_b3_exclusion_derivation.md"
review_design_path <- "quality_reports/2026-09-01_b1_b3_formal_design_review.md"
review_game_path <- "quality_reports/2026-09-01_b1_b3_game_theory_audit.md"
adjudication_path <- "quality_reports/adjudication/b1_b3_exclusion/f510f82eb0f9/adjudication_round1.md"
adjudication_json_path <- "quality_reports/adjudication/b1_b3_exclusion/f510f82eb0f9/adjudication_round1.json"

required_paths <- c(
  manuscript_path,
  candidate_path,
  review_design_path,
  review_game_path,
  adjudication_path,
  adjudication_json_path
)
stopifnot(all(file.exists(required_paths)))

read_utf8 <- function(path) {
  size <- file.info(path)$size
  connection <- file(path, open = "rb")
  on.exit(close(connection))
  text <- rawToChar(readBin(connection, what = "raw", n = size))
  Encoding(text) <- "UTF-8"
  strsplit(text, "\n", fixed = TRUE)[[1]]
}

extract_block <- function(lines, start_pattern, end_pattern) {
  start <- grep(start_pattern, lines)[1]
  end_candidates <- grep(end_pattern, lines)
  end <- end_candidates[end_candidates > start][1] - 1L
  if (is.na(start) || is.na(end) || end < start) {
    stop("Bloco não encontrado: ", start_pattern, " -> ", end_pattern)
  }
  lines[start:end]
}

sha256 <- function(path) {
  output <- system2("shasum", c("-a", "256", path), stdout = TRUE)
  sub("[[:space:]].*$", "", output[[1]])
}

manuscript <- read_utf8(manuscript_path)
candidate <- read_utf8(candidate_path)

model_block <- extract_block(
  manuscript,
  "^## Players, information, and proposals$",
  "^## Separate agenda-stage extension$"
)

results_block <- extract_block(
  manuscript,
  "^## Complete-information benchmark$",
  "^## Private unanimity in Round 1$"
)

appendix_block <- extract_block(
  manuscript,
  "^## A\\.1 Complete transition and payoff rules",
  "^# Appendix C:"
)

header <- c(
  "---",
  "title: \"Correção de B.1/B.3 sob a regra de exclusão\"",
  "subtitle: \"Pacote autocontido para consulta técnica externa no ChatGPT Web\"",
  "date: \"1 de setembro de 2026\"",
  "lang: pt-BR",
  "geometry: margin=2.3cm",
  "fontsize: 10pt",
  "toc: true",
  "numbersections: true",
  "colorlinks: true",
  "linkcolor: blue",
  "urlcolor: blue",
  "header-includes:",
  "  - \\usepackage{amsmath,amssymb}",
  "  - \\usepackage{booktabs,longtable,array}",
  "  - \\sloppy",
  "---",
  "",
  "# Mandato ao ChatGPT Web",
  "",
  "Você atuará como leitor técnico externo de uma correção delimitada em um",
  "modelo formal de barganha política. Empregue o rigor matemático esperado de",
  "um referee de teoria formal, mas identifique seu produto como **consulta",
  "técnica externa não formal**. Esta consulta não é um gate, não congela bytes,",
  "não substitui as revisões internas e não autoriza alteração do manuscrito.",
  "",
  "Não produza um parecer genérico de journal, não avalie a contribuição do",
  "paper e não redesenhe o modelo. O objeto exclusivo é verificar se a nova",
  "regra de exclusão — acordo e outside option são mutuamente exclusivos — foi",
  "corretamente propagada às provas B.1 e B.3 e se os resultados downstream",
  "realmente permanecem invariantes no sentido restrito declarado.",
  "",
  "Duas leituras internas independentes deram `PASS 0/0/0`, e uma adjudicação",
  "separada registrou `NO_CONFIRMED_DEFECTS`. **Não dê PASS por deferência a",
  "essas leituras.** Tente construir um contraexemplo antes de aceitar cada",
  "passo. Da mesma forma, não dê FAIL apenas porque as estratégias fora do",
  "caminho mudam: verifique se o candidato limita corretamente sua alegação aos",
  "resultados e payoffs reportados.",
  "",
  "O manuscrito ainda contém as duas frases antigas em B.1 e B.3. Isso é",
  "intencional: nenhuma migração foi autorizada. Compare o texto vigente com o",
  "memorando candidato; não trate os bytes atuais do manuscrito como já",
  "corrigidos.",
  "",
  "## Escopo obrigatório",
  "",
  "Audite:",
  "",
  "1. a factibilidade do desvio que fixa `x_H=0` e transfere a parcela ao",
  "   proponente;",
  "2. sua lucratividade estrita para toda proposta em que os votos fracos já",
  "   bastam;",
  "3. a preservação da quota, dos votos fracos e da simultaneidade do ballot;",
  "4. as respostas de `H` nos três casos `n_Y>=k`, `n_Y=k-1` e `n_Y<=k-2`;",
  "5. a datação do limiar pivotal `beta o`;",
  "6. o uso do desempate em favor de sim na indiferença;",
  "7. as fórmulas `Pi_E`, `Pi_S`, `Pi_P`, seus cutoffs e knife edges;",
  "8. a alegação de que B.2, B.4, B.5 e B.6 não exigem mudança substantiva;",
  "9. a distinção entre a correspondência completa de assessments/estratégias",
  "   e a correspondência reportada de resultados, payoffs, classes, cutoffs e",
  "   multiplicidades;",
  "10. a redação inglesa proposta para futura migração em B.1 e B.3.",
  "",
  "Não reabra:",
  "",
  "- a escolha entre unanimidade e maioria como comparação institucional;",
  "- a pie unitária fixa, o espaço de propostas ou a interpretação de forum",
  "  shopping;",
  "- o conceito de solução, a regra as-if-pivotal, `T^Y` ou a consistência",
  "  estrutural;",
  "- a ausência de agenda de `H` no baseline;",
  "- extensões de membership-dependent pie, benefícios intrínsecos,",
  "  externalidades ou signaling de escolha institucional.",
  "",
  "## Regras metodológicas",
  "",
  "- Trate verificação numérica somente como diagnóstico, nunca como prova.",
  "- Respeite que os votos são simultâneos: `H` não observa o vetor de votos",
  "  fracos antes de votar.",
  "- Não some `x_H` e `o` na mesma história.",
  "- Não introduza cap sobre `x_H` além da restrição agregada da pie.",
  "- Não infira invariância do assessment completo a partir da invariância de",
  "  resultados ótimos.",
  "- Se encontrar um problema, forneça localizador, contraexemplo ou derivação",
  "  e a correção mínima. Separe diagnóstico de eventual redesign.",
  "",
  "# Primitives, protocolo e conceito de solução — excerto exato do manuscrito",
  "",
  "O trecho a seguir é reproduzido sem alteração dos bytes correntes do",
  "manuscrito. Ele contém a regra nova que governa a auditoria.",
  ""
)

between_model_and_results <- c(
  "",
  "# Proposições e objetos downstream — excerto exato do manuscrito",
  "",
  "Este bloco contém o benchmark público, o jogo terminal privado e a",
  "correspondência privada sob maioria. As proposições ainda reportam os",
  "resultados cuja invariância o memorando procura demonstrar.",
  ""
)

between_results_and_appendix <- c(
  "",
  "# Appendix A.1--A.2 e Appendix B completas — bytes correntes",
  "",
  "Este bloco preserva inclusive as duas fórmulas antigas `x_H+o` em B.1 e",
  "B.3. Elas são o defeito a ser corrigido; não são axiomas para a auditoria.",
  ""
)

before_candidate <- c(
  "",
  "# Memorando de derivação candidato — texto integral",
  "",
  "O documento a seguir é o objeto primário da consulta. Seu SHA-256 é",
  paste0("`", sha256(candidate_path), "`."),
  "",
  "A condição de sucesso não é que a redação pareça plausível, mas que as",
  "derivações sustentem todas as alegações restritas de invariância.",
  ""
)

format_section <- c(
  "",
  "# Formato obrigatório da consulta",
  "",
  "Produza Markdown UTF-8 com o título",
  "`Consulta técnica externa não formal — B.1/B.3 e regra de exclusão`.",
  "Se a interface puder criar um arquivo, nomeie-o",
  "`2026-09-01_consulta_tecnica_chatgpt_web_b1_b3_exclusion.md`; caso",
  "contrário, devolva o Markdown completo, sem texto introdutório fora do",
  "documento.",
  "",
  "Use a seguinte estrutura:",
  "",
  "1. **Boundary e método** — declare o objeto exato e como tentou refutá-lo.",
  "2. **Veredicto executivo** — `PASS`, `REPAIR` ou `FAIL`, sempre com contagem",
  "   `CRITICAL / IMPORTANT / MINOR`.",
  "3. **Reconstrução independente** — apresente a lógica do desvio, os três",
  "   casos de `n_Y`, o limiar pivotal e a redução aos candidatos.",
  "4. **Findings** — para cada finding, dê severidade, localizador, evidência,",
  "   efeito sobre resultados downstream e correção mínima. Não invente",
  "   findings para preencher a seção.",
  "5. **Respostas às dez perguntas de escopo** — uma resposta numerada para",
  "   cada item do mandato.",
  "6. **Auditoria da redação candidata** — diga se os dois parágrafos ingleses",
  "   são matematicamente completos, claros e fiéis ao protocolo; proponha",
  "   substituição apenas se houver defeito.",
  "7. **Blast radius B.2--B.6** — indique `UNCHANGED`, `REPAIR` ou `UNRESOLVED`",
  "   para cada subseção, com uma frase de justificativa.",
  "8. **Conclusão operacional** — diga explicitamente se o candidato pode",
  "   avançar à adjudicação externa sem reparo, com reparo delimitado ou se",
  "   permanece bloqueado.",
  "",
  "Um `PASS` cobre apenas o memorando no hash deste pacote. Ele não cobre o",
  "manuscrito ainda não migrado, não cria tag, não autoriza merge/push e não",
  "substitui decisão do autor.",
  "",
  "# Proveniência, validação e bytes exatos",
  "",
  paste0("- Manuscrito corrente: `", sha256(manuscript_path), "`."),
  paste0("- Memorando candidato: `", sha256(candidate_path), "`."),
  paste0("- Parecer interno de design formal: `", sha256(review_design_path), "` — `PASS 0/0/0`."),
  paste0("- Auditoria game-teórica interna: `", sha256(review_game_path), "` — `PASS 0/0/0`."),
  paste0("- Adjudicação Markdown: `", sha256(adjudication_path), "` — `NO_CONFIRMED_DEFECTS`."),
  paste0("- Adjudicação JSON: `", sha256(adjudication_json_path), "` — validada pelo schema 1.0."),
  "- Commit do candidato: `3f0b035`.",
  "- Commit das revisões internas: `4905170`.",
  "- Branch: `codex/exclusion-proof-b1-b3`.",
  "",
  "As revisões internas são informadas apenas para proveniência. Sua tarefa é",
  "uma leitura nova. O arquivo `.sha256` ao lado deste pacote fixa o próprio",
  "pacote e todos os inputs acima."
)

packet <- c(
  header,
  model_block,
  between_model_and_results,
  results_block,
  between_results_and_appendix,
  appendix_block,
  before_candidate,
  candidate,
  format_section
)

dir.create(dirname(packet_path), recursive = TRUE, showWarnings = FALSE)
writeLines(packet, packet_path, useBytes = TRUE)

manifest_lines <- paste(
  vapply(c(packet_path, required_paths), sha256, character(1)),
  c(packet_path, required_paths),
  sep = "  "
)
writeLines(manifest_lines, manifest_path, useBytes = TRUE)

cat("PACKET_OK\n")
cat("packet:", packet_path, "\n")
cat("packet_sha256:", sha256(packet_path), "\n")
cat("manifest:", manifest_path, "\n")
cat("manifest_sha256:", sha256(manifest_path), "\n")
