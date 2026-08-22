# Parecer independente — fidelidade e desenho formal do Goal 5

## Snapshot verificado

- Commit: `829b25f774a90398e53fb8d339e133b1b26be9ad`
- SHA-256 do Rmd: `848f86094fa6074fe034a3fdec97c47a0e710df8b99562b817a8224cf6b015e8`
- SHA-256 do PDF: `133bf3238ad99493a4e74a573a2035a3756f4aa743906d8b2b0a298432835876`
- Worktree sem alterações locais.
- As seis interfaces congeladas reproduzem exatamente os hashes aprovados de N1, N2, N3, N4, N6 e N7.
- Nenhum artefato congelado em `model_redesign/` difere da fronteira anterior ao Goal 5.

A revisão foi estritamente read-only. Não compilei, não gerei artefatos e não editei arquivos.

## Escopo examinado

Li integralmente o contrato Gate 0, a decisão de conceito de solução e sua Emenda 1a, a matriz aprovada do Goal 5, o registro de aprovação, o manuscrito, as seis interfaces congeladas e as derivações de N1, N2, N3, N4, N6 e N7.

Foram confrontados:

- primitivas, factibilidade, reconhecimento e timing;
- execução integral de `y` e pagamento de `o_theta`;
- crenças, suporte dos endpoints, comparação as-if-pivotal e `T^Y`;
- ordem R2–R1 e aplicação única de `beta`;
- correspondências, multiplicidade e célula vazia;
- benchmark público, equivalência dos endpoints e rendas;
- segmentos atômicos, vazios e envelopes;
- domínio `m>=3` e ballots puros;
- marcadores P1/P2 e exclusão de P3;
- ausência de linguagem e resultados das arquiteturas descartadas.

## Checagens aprovadas

O transporte central está matematicamente fiel nos seguintes pontos:

1. A fórmula geral `y+o_theta` aparece apenas na definição completa do jogo e nas provas de incentivos; toda exclusão de equilíbrio fixa `y=0` e paga exatamente `o_theta`.
2. Um voto `não` de `H` não encerra o jogo. Falha em R1 conduz a R2 sem pagamento corrente.
3. R2 está em unidades correntes; `beta` entra exatamente uma vez nas comparações de R1.
4. O conceito de solução incorpora no-signaling, consistência estrutural, as-if-pivotal, `T^Y`, desempate anti-`H` e preservação do suporte nos endpoints.
5. As correspondências terminais N1/N2 e as cinco regiões de N3 estão corretas, inclusive as igualdades.
6. A correspondência de N4 e o certificado pelos quatro perfis puros de `H` estão corretamente transportados.
7. Os quatro jogos públicos e a equivalência com os endpoints privados estão corretos.
8. As tabelas de `RI_M`, `RI_U` e `DeltaRI`, inclusive a célula vazia, os sinais por tipo e os segmentos residuais de N7, reproduzem as interfaces congeladas.
9. O remark sobre estratégias mistas está no lugar autorizado e não afirma existência ou inexistência sob mistura.
10. P3 e imagens ex ante não entraram no manuscrito nem nas figuras finais.
11. A busca negativa não encontrou opt-out, entry, A/C/R, C-B-R, random proposer ou referências a versões.

## Findings

### SUBSTANTIVE

Nenhum.

### TECHNICAL

#### T1 — O conjunto factível apresentado no manuscrito está incompleto

Em `formal_model_v6.Rmd:161–171`, a proposta é restringida apenas por

\[
y+\sum_jx_j+r_i\leq1.
\]

Não aparecem as restrições congeladas:

- `0 <= y <= y_bar`;
- `x_j >= 0`;
- `r_i >= 0`;
- `o_1 <= y_bar <= 1`;
- inexistência de pagamentos laterais.

Sem a não negatividade, o jogo literalmente apresentado permitiria pagamentos negativos e resíduos superiores à pie, invalidando argumentos de argmax, uso integral da pie e cutoffs de voto.

O reparo é único e puramente de transporte: reproduzir o conjunto factível e a exclusão de side payments já fixados na Seção 2 do contrato. Não há escolha autoral nova.

#### T2 — A lei de reconhecimento de R2 não está completamente especificada

Em `formal_model_v6.Rmd:161–162`, consta apenas que um weak state é reconhecido uniformemente em cada rodada. O texto omite que os sorteios são independentes, com reposição, e que todos os weak states continuam elegíveis em R2, inclusive o proponente de R1.

Essa omissão importa: os valores `1/m`, `A`, `B` e `w` transportados para R1 pressupõem exatamente essa lei condicional depois que a identidade do primeiro proponente é conhecida.

O reparo também é único: acrescentar a lei de reconhecimento congelada, sem modificar fórmulas.

#### T3 — O preview sobre screening omite a exceção do endpoint

O abstract (`formal_model_v6.Rmd:40–44`), a introdução (`:97–100`) e a interpretação dos sinais (`:573–575`) afirmam que o componente do tipo baixo é positivo quando maioria faz screening.

Isso vale na célula comparável alta, `nu>nu_star`, onde o contraste é `(d,0)`. Não vale em `nu=0`: quando maioria faz screening, N6 e N7 dão contraste `(0,0)`. Na região intermediária, o contraste é vazio.

O reparo forçado é qualificar essas três passagens: positivo sob screening na célula alta; zero no endpoint; vazio na célula intermediária.

#### T4 — A multiplicidade não foi transportada integralmente em N6 e nos envelopes

Há três manifestações do mesmo problema:

1. A proposition de comparação privada (`formal_model_v6.Rmd:471–482`) lista screening, pooling e exclusão, mas omite o conjunto exato do empate residual:
   \[
   \{\lambda(k,-a_1):\lambda\in[0,1]\},
   \]
   com o mesmo `lambda` vinculando payoff e outcome.
2. A Seção C.2 (`:935–942`) diz que os envelopes “podem” resumir o segmento, mas não reporta os envelopes exigidos pela matriz:
   - `RI_M`: tipo baixo em `[min(a_0,d),max(a_0,d)]`, tipo alto em `[0,a_1]`;
   - `DeltaRI` e contraste privado: tipo baixo em `[min(0,k),max(0,k)]`, tipo alto em `[-a_1,0]`.
3. Em `formal_model_v6.Rmd:391–393`, a frase de que permutar identidades fracas “não muda o payoff vector” precisa ser qualificada como vetor de payoff de `H`. Os payoffs dos weak states rotulados podem ser permutados ou variar com a família `F`; somente o vetor de `H` e a classe de outcome permanecem invariantes.

Todos os objetos necessários já estão congelados em N3, N6 e N7. O reparo é de transporte exato, sem derivação ou seleção nova.

### ADVISORY

Nenhum.

## Veredicto

**FAIL**

**Contagem S/T/A: 0/4/0**

O núcleo matemático migrado está próximo do snapshot congelado, mas PASS exige `0/0/0`. Os quatro findings são reparos técnicos forçados pelas fontes aprovadas; qualquer novo hash deve voltar aos dois revisores.
