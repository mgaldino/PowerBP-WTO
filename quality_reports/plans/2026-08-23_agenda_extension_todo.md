# Plano: extensão de agenda informal e reorganização narrativa do paper

**Status**: DRAFT — aguardando decisão do autor sobre a pergunta aberta (§6)
**Data**: 2026-08-23
**Origem**: conversa autor–Claude de 2026-08-23; triagem de Steinberg em
`notes/2026-08-23_steinberg_mecanismos_triagem_racional.md`
**Escopo de autorização**: este documento é um to-do. Ele NÃO autoriza edição
de artefatos congelados (N1–N4, N6, N7), nem de `formal_model_v6.Rmd` — o
snapshot revisado do Goal 5 (`b5fdefb`) permanece a última versão coberta por
pareceres. Toda derivação nova segue o protocolo do contrato essential-input:
quem implementa não revisa; simulação antes de formalização; pareceres
completos salvos em `quality_reports/`.

---

## 0. Leitura sem jargão

O puzzle do paper é por que o hegemon prefere unanimidade. O resultado atual
responde: sem poder de agenda, a informação privada sob unanimidade gera
renda — mas ela vai para o tipo que blefa (tipo baixo), e o tipo alto fica
indiferente ou perde. A extensão decidida nesta conversa acrescenta o que
Steinberg documenta como prática: o hegemon escreve o primeiro texto (agenda
informal). O resultado candidato, ainda por verificar e provar: com agenda, o
hegemon prefere unanimidade sempre que sua opção externa descontada, no tipo
alto, vale mais que metade da pie — para os dois tipos, sem depender do
prior. O motivo: sob unanimidade, quem recusa a proposta do hegemon continua
precisando dele amanhã e terá que pagar o preço dele; sob maioria, quem
recusa pode excluí-lo amanhã e ficar com tudo. A unanimidade enfraquece a
ameaça de recusa exatamente na medida em que o hegemon é caro como votante.

## 1. Objetivo

1. Derivar e verificar a extensão de agenda informal (novo nó, `N8`).
2. Reorganizar a narrativa do paper em torno de duas fontes de poder que se
   compõem: informação privada (resultado atual) e agenda informal (extensão).
3. Usar a triagem de Steinberg como seção/parágrafo que ordena as práticas
   documentadas e torna visível o ganho do modelo formal.
4. Engajar Stone (2011) em parágrafo próprio.

## 2. Decisão de desenho: protocolo da extensão

- **Escolha**: três rodadas. R1 nova — só `H` propõe (`pi_H = 1` nessa
  rodada), todos os fracos votam sob a regra vigente. Se falha, segue o jogo
  atual inteiro (R1 fraco-proponente, depois R2 terminal), entrado com a
  crença pós-proposta — que em equilíbrio é o prior, pelo lema de
  não-separação. Os nós congelados N1–N4 são consumidos como estão, como
  funções da crença de entrada. A única prova nova é o nó `N8`.
- **Alternativas descartadas**:
  - *Duas rodadas (`H` propõe; se falha, rodada terminal)*: descartada porque
    o fallback dos fracos sob unanimidade fica dependente do prior
    (`M(ν)/m`), existe região em que o tipo alto prefere deixar R1 falhar, e
    o paper teria dois jogos lado a lado em vez de um jogo que contém o atual
    como continuação.
  - *Bolo dependente da participação de `H` (contribuição)*: descartada
    porque, em barganha com proposta e voto, contribuição sem poder de recusa
    não rende nada a `H` — o proponente captura o crescimento inteiro.
    Registrado na conversa de 2026-08-23; não repropor.
  - *Jogo de bem público com carona*: descartada como caminho deste paper;
    inverte a assimetria de outside options e é outro projeto.
  - *Ofertas competitivas dos fracos com `H` escolhendo (gatekeeping)*:
    não desenvolvida; manter fora até decisão explícita do autor.

## 3. Resultados candidatos — conta de guardanapo, A VERIFICAR

Fonte detalhada: `notes/2026-08-23_steinberg_mecanismos_triagem_racional.md`,
seção "Decisão: protocolo da extensão de agenda". Nada abaixo é resultado;
tudo é candidato a resultado.

Payoff de `H` como proponente na R1 nova (região de pooling `ν > ν*` sob
unanimidade; célula de exclusão `1/m < o_0` sob maioria):

```text
unanimidade: 1 − β(1 − β·o_1) = (1 − β) + β·(β·o_1)
maioria q:   1 − (q−1)β/m     = (1 − β) + β·[1 − (q−1)/m]

H prefere unanimidade  sse  β·o_1 > (m − q + 1)/m
N ímpar, maioria simples (q = m/2 + 1):  β·o_1 > 1/2, para todo N
```

Decomposição comum: prêmio de proponente `(1 − β)` mais `β` vezes a pie menos
a reivindicação total dos fracos. Maioria: fração `(q−1)/m` de reivindicação
cheia. Unanimidade: o todo de reivindicação reduzida pelo preço futuro de `H`.

Estática comparativa no quórum — **vale, não monotônica**: para `q < N` o
payoff de `H`-proponente cai com `q` (BF padrão); em `q = N` salta, porque
`H` vira essencial na continuação. O salto de `q = N−1` para `q = N` existe
sse `β·o_1 > 1/m`; vencer maioria simples exige `β·o_1 > 1/2`; vencer dois
terços exige cerca de `1/3`. Frase candidata: entre as regras que o mantêm
substituível, o hegemon quer o menor quórum; a única regra que o torna
essencial pode vencer todas.

Renda informacional do tipo baixo sob unanimidade com agenda:
`β²(o_1 − o_0)` — a renda atual descontada mais uma vez (nasce no screening
terminal). Sob maioria, zero.

Lema de sustentação (a provar em `N8`): separação em puras é impossível —
qualquer ação exclusiva do tipo alto leva a crença a 1, e nessa crença a
continuação dá o mesmo aos dois tipos; o tipo baixo imita de graça. Logo
pooling, posterior = prior, e o jogo atual é consumido exatamente como
derivado.

Obrigações de prova do nó `N8`, além do lema: (i) crenças off-path após
desvio de `H` declaradas e postas no domínio de existência (D1 leva a
`ν' = 1`); (ii) condições de fechamento contra espera nas duas regras — sob
maioria existe região `β·o_1 > 1 − (q−1)β/m` com separação por falha (tipo
baixo fecha, alto espera), sem custo ao tipo baixo; (iii) recomputar a
reivindicação dos fracos nas células de maioria fora da exclusão
(`o_1 < 1/m` e `o_0 < 1/m < o_1` com `ν ≤ ν_SE`); (iv) benchmark de
informação completa exportado (D5); (v) domínio herdado: sem afirmação em
`0 < ν ≤ ν*` sob unanimidade (região sem PBE em puras do jogo atual).

## 4. Ordem de trabalho

1. **Script primeiro** (regra do autor): `scripts/verify_agenda_extension_napkin.R`
   varrendo `(ν, β, o_0, o_1, N, q)`, avaliando as fórmulas candidatas,
   marcando: região de preferência por unanimidade; condições de fechamento;
   o vale no quórum; consistência com as interfaces de N1–N4 nos pontos de
   fronteira. Salvar antes de rodar; revisão independente do script
   (`review-r`) por agente que não o escreveu.
2. **Derivação do nó `N8`** em `model_redesign/essential_input_*`, sob as
   convenções do contrato (PBE + stage-undominated voting + `T^Y`; crenças
   conforme decisão de 2026-08-21 + refinamento D1 a declarar para o nó).
3. **Duas revisões independentes** read-only, PASS 0/0/0, pareceres completos
   salvos.
4. Só então migração ao paper, como seção de extensão, mantendo o resultado
   atual como principal.

## 5. Mudanças de texto no paper (após 1–4)

- [ ] **Narrativa**: puzzle (por que consenso?) → duas fontes de poder que se
  compõem. Resultado atual continua principal, tipo a tipo; extensão de
  agenda como segunda parte. Frase candidata: "sem agenda, a unanimidade
  recompensa quem blefa; com agenda, recompensa o hegemon".
- [ ] **NÃO enquadrar** como "quanto mais realismo, mais unanimidade" —
  vulnerável a realismo que corta na direção oposta (compliance, saída dos
  fracos, reputação). Enquadrar como duas fontes específicas.
- [ ] **Estática do quórum**: apresentar o vale (cai até `N−1`, salta em
  `N`), com figura candidata.
- [ ] **Seção/parágrafo Steinberg** — ordenar as práticas em três categorias:
  (i) fontes de poder: tamanho de mercado/outside option (1), saída e
  reconstituição (6b, 7), agenda informal (8, 9, 11, 13, Green Room);
  (ii) consequências da estrutura, que o modelo já contém: pagamentos
  laterais (3), bloqueio seletivo (10), pacote fechado (14);
  (iii) práticas que exigem fracos que não antecipam, e que não podem
  carregar peso: reciprocidade absoluta (2), autoria oculta (12), mandatos
  vagos (15, na parte da vagueza), sondas sem estoppel (16 isolado),
  legitimação por aparência (22). Os itens 16–21 entram como
  microfundamentação da informação privada unilateral: a tecnologia das
  potências extrai a dos fracos; contra `H` a sonda existe (oferta `o_0` em
  R2) e falha porque `H` pode esperar — que é o resultado do paper.
- [ ] **Ilustração de `o_H > o_W = 0`**: saída do GATT 1947 / single
  undertaking (7), com o argumento de credibilidade por indução retroativa.
- [ ] **Parágrafo Stone (2011)**: hoje citado só em lista (l.145). Distinguir:
  em Stone, poder informal é contornar a regra quando os stakes são altos;
  aqui, a regra formal de consenso é o que dá valor à agenda informal, via
  essencialidade e informação privada. Sem esse parágrafo, parecerista da
  escola de governança informal pergunta o que há de novo.

## 6. Pergunta aberta — decisão do autor pendente

Na parte sem agenda, a narrativa afirma que **o tipo baixo** prefere
unanimidade (tipo a tipo, como o v6 apresenta) ou que **o hegemon ex ante**
prefere (média sobre tipos, que o v6 deliberadamente não faz)? A escolha
muda o que a extensão acrescenta: se a narrativa já for ex ante, "a extensão
tira a dependência do tipo" perde força. Retomar antes de escrever a
narrativa. **Nada do §5 deve ser redigido antes desta decisão.**

## 7. Fora de escopo deste plano

- Reabrir a decisão D4 (mixed strategies no ballot) para fechar a região
  `0 < ν ≤ ν*` sem equilíbrio: a falha está no voto de `H` após desvio do
  proponente (v6, Remark "Pure-strategy scope"); mixing do proponente não a
  toca. É decisão sobre o paper atual, ortogonal à extensão, e do autor.
- Qualquer edição nos nós congelados ou no snapshot revisado do Goal 5.
- O projeto "bem público / contribuição" como paper separado.

## 8. Arquivos a modificar (quando autorizado)

- [ ] `scripts/verify_agenda_extension_napkin.R` — novo (passo 1)
- [ ] `model_redesign/essential_input_r1_h_proposer_v1.md` (ou nome análogo
  no padrão da cadeia) — novo nó `N8` (passo 2)
- [ ] `formal_model_v6.Rmd` — seção de extensão + §5 (somente após passos 1–3
  e decisão do §6)
- [ ] `figures/` — figura do vale no quórum (candidata)
- [ ] `AGENTS.md` / `CLAUDE.md` — registrar a extensão quando aprovada

## 9. Verificação

- [ ] Script roda e reproduz as fórmulas candidatas; revisão independente
- [ ] Fronteiras do script batem com as interfaces congeladas de N1–N4
- [ ] `N8` com dois pareceres PASS 0/0/0 salvos em `quality_reports/`
- [ ] Nenhuma afirmação no paper sobre `0 < ν ≤ ν*` sob unanimidade
- [ ] Texto final sem referência a versões anteriores (documento atemporal)

## 10. Fontes

- `notes/2026-08-23_steinberg_mecanismos_triagem_racional.md` — triagem
  completa + conta de guardanapo + lema
- `formal_model_v6.Rmd` — Props. "Private majority correspondence",
  "Private unanimity correspondence", "Private institutional payoff
  contrast" (l.448–603 do snapshot atual)
- `quality_reports/2026-08-12_essential_input_gate0_decisions.md` — D4, D5,
  D6 (convenções que o nó `N8` herda)
- `quality_reports/2026-08-21_decisao_conceito_solucao_essential_input.md` —
  crenças off-path e votação
