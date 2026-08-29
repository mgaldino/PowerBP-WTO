# Decisão autoral — assinatura de A_M em duas camadas (órbita diagonal exata + resumo anônimo por Z/G)

**Data:** 2026-08-29
**Status:** APPROVED — aval autoral concedido em 2026-08-29 ("aprovo"), sobre
o texto integral deste registro.
**Objeto:** resolver o defeito `important` adjudicado dos dois pareceres
formais de `A_M` sob M/S/B — a anonimização por Reynolds componentwise não é
um quociente diagonal exato — e destravar a reimplementação de `AMX-016` e da
parte afetada de `AMX-MSB-010`. Esta é a "decisão autoral explícita sobre a
equivalência" exigida pelo passo 1 da sequência institucional do pacote de
consulta.

**Insumos, com hashes:**

| Documento | Caminho | SHA-256 |
|---|---|---|
| Pacote de consulta | `reports/chatgpt_pro_packets/2026-08-29_A_M_anonimato_reynolds_consulta_decisao.md` (worktree `agenda-extension-am-msb`) | conforme manifesto do worktree |
| Consulta externa não formal — Fable | `quality_reports/external_reviews/2026-08-29_consulta_fable_anonimato_reynolds_A_M.md` | `608b9459d26063c6e45f895ba70bd00c2f73bf12cdff3dac854a9b62746e10d7` |
| Consulta externa não formal — ChatGPT Web | `quality_reports/external_reviews/2026-08-29_consulta_tecnica_externa_nao_formal_chatgpt_simetria_AM.md` | `142a39ed2124aca50743e92ef67f505192eb6d159f546b3d8b0c42a274804d0b` |
| Pareceres formais 1 e 2 + adjudicação | caminhos e hashes na Seção "Referências internas" do pacote | idem |

As duas consultas, produzidas de forma independente, convergem integralmente
na arquitetura e nas provas centrais: o lema do colapso por baricentro
(qualquer equivalência que identifique um perfil com seus baricentros de pesos
comuns identifica `x^P` com `x^Q` por transitividade), a completude de
`Lambda_x` como invariante da órbita diagonal, a não realizabilidade do par
simetrizado por um único mapa público de posterior, a ortogonalidade a
`rho`/crenças e o reparo local do finding menor. A convergência não altera o
estado `BLOCKED`; esta decisão é o que o altera, após implementação e novas
revisões formais.

## Decisão 1 — arquitetura em duas camadas (Alternativa D, precisada)

### Camada formal exata

- **Escolha**: a equivalência formal exata de `A_M` é a órbita da ação
  diagonal de `S_m` sobre `x = (Gamma_0, Gamma_1)`: dois assessments são
  formalmente equivalentes se e somente se têm o mesmo `rho`, o mesmo
  `nu_off` e seus pares diferem por uma única permutação comum aplicada ao
  perfil inteiro. Codificação canônica, sem escolha de representante:

  ```text
  Sig_ex_M(R) = ( rho(R), nu_off(R), Lambda_{x(R)} ),
  Lambda_x = |G|^{-1} * soma_g delta_{g.x}  em  P(X).
  ```

  A completude de `Lambda_x` (igualdade sse mesma órbita) entra como
  proposição provada no pacote, sob o quadro Borel-padrão de `Z`; as duas
  consultas fornecem a prova, e o implementador a incorpora com a verificação
  explícita de que `X_M` e `Omega_T` são Borel-padrão na formalização vigente.
- **Representante expositivo**: um membro real da órbita, por seleção
  mensurável fixada (mínimo lexicográfico sob isomorfismo de Borel declarado),
  com a órbita registrada. A média de Reynolds nunca é usada como
  representante, porque em geral não é imagem de assessment algum.

### Camada de resumo econômico

- **Escolha**: o resumo anônimo canônico é o pushforward do registro realizado
  inteiro para o quociente `Z/G` (forma da consulta ChatGPT, que subsome a
  tupla curada da consulta Fable):

  ```text
  Sum_econ_M(R) = ( rho(R), nu_off(R), (q_Z)#Gamma_0^R, (q_Z)#Gamma_1^R ),
  q_Z : Z -> Z/G  (apaga os nomes dos fracos em cada registro realizado).
  ```

  Estatísticas exibidas no texto — payoffs por tipo, probabilidades de
  acordo/atraso, lei do posterior por tipo, outcome terminal anônimo, payoffs
  fracos como lei exchangeable — são derivadas de `Sum_econ` pelo lema de
  fatorização de funções `G`-invariantes, que o implementador enuncia e prova.
- **Reynolds**: rebaixado a estatística computacional do resumo marginal. O
  texto declara explicitamente que ele não é invariante completo da órbita
  diagonal, não retém a relação entre os planos dos tipos, pode não pertencer
  à imagem de assessment algum, e que sua igualdade significa apenas igualdade
  de um resumo marginal.
- **Escopo do colapso de misturas (reescrita da frase aprovada
  anteriormente)**: identidade formal só por permutação comum; mesmo resumo se
  e somente se as leis anônimas de registros realizados por tipo coincidem.
  Consequências explícitas no texto: (i) misturas sobre identidades com
  suportes que não alteram Bayes têm o mesmo resumo e órbitas distintas — o
  caso que motivava a intuição original; (ii) misturas realizadas que alteram
  a revelação — por exemplo, os dois tipos misturando sobre o mesmo suporte —
  são outro experimento, com outra lei de posterior, e diferem nas duas
  camadas; (iii) `x^P` e `x^Q` diferem na camada exata e coincidem,
  deliberadamente, no resumo.

### Alternativas descartadas

- **Camada única que cumpra os quatro desiderata**: impossível — lema do
  colapso por baricentro, provado identicamente nas duas consultas; o
  desideratum de misturas só tem casa como afirmação de resumo.
- **Identificação por `Mix_G^cw`**: além do colapso pelo baricentro uniforme,
  pesos degenerados tornam a equivalência ao menos tão grossa quanto o
  quociente por `G x G`, abandonando a ação diagonal já nos pontos extremos
  (consulta ChatGPT, §6.3).
- **Reynolds como quociente exato ou representante**: contraexemplo `P/Q`
  adjudicado e não realizabilidade por incoerência de posteriores.
- **Acoplamento contrafactual `Xi`**: o PBE determina marginais por tipo;
  qualquer acoplamento é conteúdo sem interpretação estratégica, e a versão
  "semente comum" exigiria dispositivo de correlação ausente do game form —
  mudança de protocolo desproporcional.
- **`L_q` no metaespaço como solução autônoma**: registra a randomização sem
  identificar; o quociente pelo suporte reduz-se à própria Alternativa A
  (consulta ChatGPT, §4.2); o sorteio comum entre mundos contrafactuais não é
  objeto do jogo.

## Decisão 2 — regra de consumo downstream

- `AC` e `AR` consomem `Sum_econ` somente mediante claim provado, por
  operação: constância nas fibras do resumo dentro da mesma fibra
  `(rho, nu_off)` e fatorização mensurável `C = C_bar ∘ Sum_econ`; para
  correspondências, a prova é setwise, sem emparelhar coordenadas de
  elementos distintos, e verificações escalares pontuais não bastam. Sem o
  claim, o consumidor recebe `Sig_ex`.
- Operações que usem identidade formal, suportes estratégicos, coincidência de
  mensagens entre tipos, mapa público `pi`, Bayes/crenças, correlação entre
  planos contingentes, contagem de classes, seleção de representante ou
  composições que possam recombinar coordenadas usam obrigatoriamente a
  camada exata.
- O produto fibrado no mesmo `(rho, nu_off)` precede qualquer resumo; proibido
  recombinar coordenadas de assessments distintos em qualquer camada.

## Decisão 3 — reenunciados dos claims

- **`AMX-016a`**: definição da assinatura exata + proposição de completude de
  `Lambda_x` (base textual: consulta ChatGPT, §8.2–8.3, fundida com a cláusula
  do representante real da consulta Fable, §8a).
- **`AMX-016b`**: definição de `Sum_econ` por `Z/G`, lema de fatorização de
  estatísticas `G`-invariantes e os claims de suficiência por operação
  downstream declarada.
- **`AMX-MSB-010` (parte afetada)**: base textual na consulta ChatGPT, §8.4 —
  relabeling comum preserva PBE e assinatura exata; misturas de identidade não
  são formalmente equivalentes por esse fato; baricentros não são presumidos
  PBEs nem imagens de mapa público comum; mesmo resumo quando diferem apenas
  pela distribuição de massa dentro das órbitas de registros realizados.
- **Teorema cardinal**: inalterado; muda o objeto que codifica a órbita, não o
  contínuo de classes sob o quociente correto.
- **Finding menor da Seção 8.3**: adotar a redação corrigida das consultas,
  com a precisão da ChatGPT — a dicotomia correta é átomo versus ponto de
  massa zero, com "fora dos átomos" substituído por "nos pontos de massa zero
  não há conclusão pointwise; a igualdade permanece quase-certamente" — e as
  provas atômica e setwise incorporadas.

## Processo

1. Implementação em novos bytes por implementador separado, no worktree
   `agenda-extension-am-msb`, com este registro, as duas consultas e a
   adjudicação importados na árvore; novo preflight e manifesto SHA-256.
2. Duas novas revisões formais independentes sobre exatamente os mesmos bytes
   (nunca quem implementou, nunca Fable).
3. Aprovação autoral terminal à luz dos pareceres; somente então eventual
   liberação de `A_M` para consumo por `AC`, condicionada também aos claims de
   suficiência e à auditoria própria de `A_U`.

**Aprovação autoral:** concedida em 2026-08-29 ("aprovo").
