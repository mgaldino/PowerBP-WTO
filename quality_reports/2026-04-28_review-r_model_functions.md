# Revisão de código: scripts/model_functions.R

## Resumo executivo

Arquivo compacto (127 linhas) com 5 funções que implementam os payoffs do modelo BF sob unanimidade e maioria, mais concavificação. A lógica econômica está correta e alinhada com as derivações do appendix. Há um problema metodológico na função de VW majority (assume budget identity exata quando sob unanimidade pode falhar) e issues de robustez numérica.

## Nota geral: B

## Problemas críticos :red_circle:

### 1. Header desatualizado (linha 1)
```r
# Model functions for formal_model_v3.Rmd
```
Referencia v3 mas o paper ativo é v5. Confusão para quem abre o arquivo.

### 2. VW_R1_majority usa budget identity via VH, não derivação direta (linhas 56-62)
```r
VW_R1_majority <- function(r, alpha, mu, N, beta) {
  Ve <- 1 + mu * (r - 1)
  EVH <- VH_R1_majority(r, alpha, mu, N, beta)
  VW_R1_M <- (Ve - EVH) / (N - 1)
  return(VW_R1_M)
}
```
A budget identity `EVH + (N-1)*VW = Ve` vale exatamente sob majority (sem surplus destruction), então o cálculo está correto. Mas a dependência circular (VW chama VH) é frágil — se alguém alterar VH sem atualizar, VW quebra silenciosamente. Seria mais robusto derivar VW diretamente das primitivas, como já é feito para unanimidade.

**Impacto**: Baixo para resultados atuais (a identity vale), mas risco de manutenção.

### 3. Nonproposer payoff sob aggressive R1 (linhas 46-47) — lógica complexa sem comentário
```r
nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)
```
Esta fórmula calcula o payoff esperado de um W não-proposer quando outro W faz oferta agressiva em R1. A decomposição é: prob 1/N de H propor (W recebe beta*VW_R2) + prob (N-2)/N de outro W propor (sob agressivo: theta=0 aceita → VW_R2; theta=1 rejeita → R2 com mu=1 → VW_R2_1). A fórmula parece correta mas é difícil de auditar sem comentário. Comparar com derivação no appendix A.3.

**Impacto**: Incerto. Requer verificação cruzada com as fórmulas do appendix.

## Melhorias importantes :yellow_circle:

### 4. Sem validação de inputs
Nenhuma função verifica se os parâmetros estão no domínio válido:
- `alpha < 1/r` (requerido pelo modelo)
- `mu` em [0,1]
- `N >= 3`
- `r > 1`
- `beta` em (0,1)

Valores fora do domínio produzem resultados silenciosamente errados.

### 5. Funções não vetorizadas
Todas as funções usam `if/else` escalar, impedindo uso vetorizado (`sapply` necessário nos chunks do Rmd). Com `ifelse()` ou `dplyr::case_when()`, as funções aceitariam vetores diretamente. Isso afeta performance nos heatmaps (150x150 grid = 22,500 chamadas com loop).

### 6. concavify() tem edge case perigoso (linhas 111-112)
```r
for (j in (i+2):n) {
  if (j > n) break
```
Quando `i = n-1`, `(i+2):n` produz `(n+1):n` que é um vetor decrescente `c(n+1, n)` em R — executa o loop com j=n+1 (fora de bounds) antes do break. O guard `if (j > n) break` salva, mas o padrão é frágil. Usar `seq_len()` ou checagem explícita.

## Sugestões :green_circle:

### 7. Documentação
Adicionar roxygen-style comments (@param, @return) para facilitar manutenção. O header é bom mas as funções individuais não têm documentação inline.

### 8. Testes unitários
Não há testes. Pelo menos verificar budget identity, continuidade nos cutoffs, e comparação com valores analíticos do appendix (e.g., lambda_M, mu_s_R2).

## Pontos positivos :white_check_mark:

- **Estrutura limpa**: separação clara entre VH e VW, unanimidade e maioria
- **Header documentado**: parâmetros e ranges explícitos
- **Concavify**: implementação correta do upper concave envelope
- **Lógica econômica correta**: screening cutoffs, branches agressivo/conservador, R2 continuation values — tudo consistente com o appendix
- **Sem dependências externas**: usa apenas R base, sem pacotes adicionais
