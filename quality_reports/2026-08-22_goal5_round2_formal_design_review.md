# Parecer independente — Goal 5, desenho formal e fidelidade matemática, Round 2

## Snapshot verificado

- Commit: `5539815ff840fc36d06f592de5fbbe2f09a16b71`
- SHA-256 de `formal_model_v6.Rmd`: `2a7ef9415cad5efe5c47573f67860e011b18e2f561bd46a755f8332d563790a5`
- SHA-256 de `formal_model_v6.pdf`: `0c020de04c893c976869242307f6720d7585e0776ea3069d7f0caa08b2d12ad3`
- Worktree limpa antes e depois da auditoria.
- Interfaces congeladas confirmadas:
  - N1: `1a171791...981b5`
  - N2: `c6a65dc8...a85a2`
  - N3: `ff053798...47330d`
  - N4: `f1c82312...6408b`
  - N6: `a9cfd593...a5a92`
  - N7: `4e0169de...9c45`
- Nenhum artefato congelado N1–N7 difere da fronteira anterior ao Goal 5.
- A revisão foi estritamente read-only: não editei, compilei, gerei artefatos ou fiz commit.

## Escopo e checagens

Reli a matriz aprovada, a decisão autoral do conceito de solução e Emenda 1a,
as fontes congeladas N1–N7, o parecer formal do Round 1, o relatório de reparos
e o manuscrito integral.

Foram confrontados:

- jogadores, factibilidade, reconhecimento, timing e payoffs;
- execução integral de `y` e incidência de `o_theta`;
- no-signaling, consistência estrutural, as-if-pivotal, `T^Y`, suporte dos endpoints e desempate anti-`H`;
- solução de R2 antes de R1 e aplicação única de `beta`;
- correspondências públicas e privadas, fronteiras, multiplicidade e célula vazia;
- certificado de inexistência de N4;
- equivalência entre endpoints privados e jogos públicos;
- `RI_M`, `RI_U`, `DeltaRI`, segmentos atômicos e envelopes;
- domínio `m>=3` e PBE com ballots puros;
- marcadores P1/P2, exclusão de P3 e busca negativa;
- ausência de feedback para os nós congelados e de resultados formais novos.

## Findings anteriores

Os quatro findings do parecer formal do Round 1 foram sanados:

1. o conjunto factível agora contém todos os limites, não negatividade e proibição de pagamentos laterais;
2. o reconhecimento é explicitamente independente, uniforme, com reposição e com elegibilidade continuada;
3. o ganho do tipo baixo sob screening foi corretamente restringido à célula de crença alta;
4. multiplicidade, segmento residual, vínculo pelo mesmo `lambda`, envelopes e payoffs fracos rotulados foram transportados.

## Checagens aprovadas

- As correspondências de N1–N4 coincidem com as fontes congeladas.
- A célula `0<nu<=nu_star` permanece vazia, com o certificado correto pelos quatro perfis puros de `H`.
- Os quatro jogos públicos e seus payoffs estão corretos.
- A equivalência público–endpoint respeita a restrição de suporte.
- As tabelas de rendas e de `DeltaRI` reproduzem os vetores, vazios e segmentos de N7.
- O segmento residual mantém o mesmo `lambda` em todas as coordenadas; nenhum retângulo artificial foi criado.
- A imagem ex ante de P3 não entrou no manuscrito.
- P1 e P2 aparecem somente nos marcadores interpretativos autorizados.
- A fórmula geral `y+o_theta` está restrita à definição completa e às provas fora do caminho; exclusões de equilíbrio pagam apenas `o_theta`.
- O remark sobre estratégias mistas limita corretamente o resultado ao espaço de ballots puros.
- A busca negativa não encontrou opt-out, entry, A/C/R, C-B-R, random proposer, linguagem de versões ou identificadores internos F1–F4.
- As figuras inspecionadas reproduzem corretamente os resultados e os valores da ilustração numérica.

## Findings

### SUBSTANTIVE

Nenhum.

### TECHNICAL

#### T1 — A tabela de protocolo iguala continuações que podem ser diferentes

Em `formal_model_v6.Rmd:220–222`, a linha de falha em R1 registra, para `H`:

- após voto `sim`: `beta` vezes a continuação de R2;
- após voto `não`: “Same continuation”.

Isso contradiz a regra dinâmica do contrato. O vetor completo de votos é
público, e o voto de `H` pode alterar o posterior que entra em R2. Sob
unanimidade, sobretudo fora do caminho, as histórias com `H` votando sim e não
podem induzir continuações diferentes; para o tipo baixo, elas podem inclusive
cair em lados distintos de `nu_star`.

As provas posteriores usam corretamente continuações dependentes da história,
de modo que o erro está confinado à nova tabela. O reparo é único: substituir
“Same continuation” por continuações indexadas pelas respectivas histórias
públicas, como `beta C_H(h^Y)` e `beta C_H(h^N)`, sem afirmar igualdade salvo
onde ela tenha sido demonstrada.

#### T2 — O preço de um voto fraco em R1 foi apresentado como universal

Em `formal_model_v6.Rmd:304–310`, o texto afirma sem qualificação que “A
weak-state vote costs `beta/m` in first-round units”.

Esse é o preço sob maioria, cuja continuação terminal dá `1/m` a cada Estado
fraco. Sob unanimidade pública, o preço correto depende do tipo conhecido:

\[
\frac{\beta(1-o)}{m}.
\]

A proposition e a tabela imediatamente posteriores usam corretamente as duas
fórmulas, portanto os resultados não estão afetados. O reparo forçado é
restringir a frase a maioria ou declarar separadamente os dois preços.

### ADVISORY

Nenhum.

## Veredicto

**FAIL**

**Contagem S/T/A: 0/2/0**

O núcleo matemático e os quatro reparos do Round 1 estão corretos, mas PASS
exige `0/0/0`. Os dois findings restantes são correções técnicas de redação
formal com reparo único; qualquer novo hash deve retornar aos dois revisores
independentes.
