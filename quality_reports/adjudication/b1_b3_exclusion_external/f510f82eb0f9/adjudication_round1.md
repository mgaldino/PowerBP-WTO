# Adjudicação independente da consulta técnica externa — B.1/B.3

## 1. Identidade da fonte e do contrato

- **Artefato adjudicado:** `quality_reports/2026-09-01_b1_b3_exclusion_derivation.md`
- **SHA-256 recalculado:** `f510f82eb0f9f6e3e7cc8a59a6d26724cea3cff7ee53da2d1eabdbb3c3264665`
- **Integridade:** confirmada; coincide com o hash do mandato e do pacote externo.
- **Parecer externo:** `quality_reports/external_reviews/2026-09-01_consulta_tecnica_chatgpt_web_b1_b3_exclusion.md`
- **SHA-256 do parecer:** `cae750f8d5cc6e8fdab68d07d1d9fe7eb08050a8e43642396dc78c2e8cbeac3c`
- **Commit que preserva o parecer:** `b2d48a25643b0631bc5ed4beac935028100ebd30`
- **Pacote enviado:** `reports/chatgpt_pro_packets/2026-09-01_b1_b3_exclusion_external_review_packet.md`
- **SHA-256 do pacote:** `604be9525c6d15953202048e9181b58dc61db2c71f789fd318c582b1a9472e2c`
- **Argument contract:** não requerido (`contract.required=false`).

O manifesto do pacote passou integralmente em `shasum -a 256 -c`. O pacote
identifica o hash exato do memorando, contém seu texto integral e advertia
expressamente que `formal_model_v6.Rmd` ainda conservava, de modo intencional,
os dois passos antigos. Não há evidência de truncamento ou conversão defeituosa.

## 2. Disposição executiva

**Veredicto: `READY_FOR_IMPLEMENTATION`.**

A conclusão `REPAIR — 0/0/4` do parecer externo não é adotada de forma
automática. A adjudicação encontrou:

| Status | Contagem |
|---|---:|
| `CONFIRMED` | 1 |
| `PARTIAL` | 2 |
| `REFUTED` | 1 |
| `UNRESOLVED` | 0 |

A separação operacional é:

1. **defeito local do memorando:** M1;
2. **reparos necessários somente na futura migração do manuscrito:** partes
   confirmadas de M2 e M3;
3. **melhoria expositiva já coberta por outra seção:** M4;
4. **erro matemático substantivo, mudança de payoff ou de cutoff:** nenhum.

Esta adjudicação não implementa correções e não autoriza por si só edição do
manuscrito, tag, merge ou push.

## 3. Tabela de findings

| ID | Severidade proposta | Status | Natureza adjudicada | Correção sugerida |
|---|---|---|---|---|
| M1 | MINOR | **CONFIRMED** | Defeito expositivo-lógico local do memorando | `safe` |
| M2 | MINOR | **PARTIAL** | Correção válida da B.1 vigente; não é defeito matemático do memorando | `safe` |
| M3 | MINOR | **PARTIAL** | Correção válida da futura transição em B.3; derivação candidata já distingue os ramos | `safe` |
| M4 | MINOR | **REFUTED** | Melhoria expositiva opcional; a justificativa já consta da Seção 6.3 e da tabela | `safe`, mas não obrigatória |

## 4. Evidência e raciocínio por finding

### M1 — CONFIRMED

> **Finding M1 — o lema omite uma premissa necessária para preservar os votos
> fracos.** Manter (x_j) fixo não preserva, em geral, a ação de um jogador cuja
> estratégia pode depender do pacote inteiro. Aqui a conclusão é verdadeira
> porque os limiares fracos são independentes de (x_H): zero no terminal e
> (w=\beta/m) em Round 1.

**Evidência do defeito.** Nas linhas 80--83 do memorando, a prova passa de
“cada (x_j) fica fixo” para “cada voto fraco fica fixo”. O passo requer a
propriedade adicional de que a resposta fraca dependa apenas da própria
alocação comparada com um limiar belief-free. Além disso, as linhas 101--103
afirmam que o lema usa “apenas” não negatividade, restrição agregada e
especificidade de (x_H), omitindo essa propriedade.

A propriedade necessária é verdadeira e aparece no restante do memorando:

- Round 1: linhas 64--65 e 184--185, com limiar (w=\beta/m);
- maioria terminal: linhas 109--112, com limiar zero.

Portanto, o problema é local e não invalida o desvio, sua lucratividade estrita
ou qualquer fórmula downstream. A correção proposta é **segura**: tornar a
premissa explícita no lema e incluí-la na enumeração final das hipóteses.

**Disposição:** reparar apenas o memorando candidato; não mudar fórmulas nem o
manuscrito neste gate.

### M2 — PARTIAL

> **Finding M2 — a desigualdade (k\leq m) não demonstra que a maioria pode
> excluir (H).** Há apenas (m-1) respondedores fracos; a condição pertinente
> é (k\leq m-1), verdadeira para (m\geq3).

**Parte confirmada.** `formal_model_v6.Rmd:1390-1391` usa (k\leq m) para
concluir que a proposta pode passar sem (H). Isoladamente, essa desigualdade
não prova que os (k) votos adicionais vêm dos (m-1) respondedores fracos.
Na futura migração de B.1, a contagem deve ser substituída por

\[
k=\left\lfloor\frac{m+1}{2}\right\rfloor\leq m-1,
\qquad m\geq3.
\]

A desigualdade vale em todo o domínio: se (m=2r), então (k=r\leq2r-1);
se (m=2r+1), então (k=r+1\leq2r=m-1).

**Parte refutada.** O objeto adjudicado não é a B.1 ainda não migrada. O pacote
externo, linhas 40--43, advertia que o manuscrito continuava deliberadamente
com os passos antigos. O memorando define (m\geq3) e (k), afirma
corretamente a existência de respondedores suficientes e seu texto inglês
candidato elimina a desigualdade inadequada. Logo M2 não é razão para rejeitar
a derivação candidata.

**Disposição:** correção obrigatória e segura somente quando a migração de B.1
for autorizada.

### M3 — PARTIAL

> **Finding M3 — o parágrafo de redução subsequente em B.3 não deve permanecer
> literalmente inalterado.** A dominância (x_H=0) vale no ramo não pivotal;
> os limiares (\beta\ell) e (\beta h) valem apenas no ramo pivotal.

**Parte confirmada.** Depois de substituir a abertura de B.3, conservar
literalmente `formal_model_v6.Rmd:1437-1439` permitiria interpretar “relevant
type threshold” como se também governasse o ramo (n_Y\geq k). A futura
migração deve separar:

- (x_H=0) por dominância estrita quando (n_Y\geq k);
- (x_H=\beta\ell) ou (x_H=\beta h) quando (n_Y=k-1).

**Parte refutada.** O memorando já faz essa distinção nas linhas 243--248,
usando expressamente “limiar pivotal aplicável” e registrando a dominância
estrita da concessão não pivotal. Sua linha 305 não autoriza conservar
incondicionalmente o restante da B.3; ela condiciona essa decisão ao parecer
independente. Portanto, o finding identifica uma instrução de migração, não um
erro na derivação.

**Disposição:** correção obrigatória e segura somente na futura migração de
B.3; não alterar as fórmulas ou as classes.

### M4 — REFUTED

> **Finding M4 — a justificativa sobre crenças cobre apenas o ramo que passa.**
> Em (n_Y\leq k-2), a proposta fracassa, posteriors podem diferir e a
> invariância depende de a maioria terminal ser belief-independent.

**Evidência refutadora.** A alegada lacuna não existe no memorando:

- as linhas 235--241 dizem expressamente que, se (n_Y\leq k-2), a proposta
  fracassa, os dois votos entregam a mesma continuação (\beta o), a
  continuação independe da crença e o desempate seleciona sim;
- a linha 315 da tabela contém uma linha própria para esse ramo;
- a linha 321 afirma apenas que não há continuação “após uma proposta que já
  passou”, sem generalizar essa afirmação a propostas fracassadas.

Completar a célula deixaria a tabela mais autossuficiente, mas seria uma
melhoria expositiva opcional, não uma correção de prova. A redação sugerida é
segura, porém **não deve ser encaminhada como reparo obrigatório**.

## 5. Correções inseguras e decisões do autor

Nenhuma correção proposta foi classificada como `unsafe`, `needs_design` ou
`owner_decision`. Nenhuma decisão mantida do autor foi reaberta. Em particular,
esta adjudicação preserva:

- a exclusividade entre alocação de acordo e outside option;
- a intransferibilidade de (x_H) após exclusão;
- a ausência de cap individual além da restrição agregada;
- a regra as-if-pivotal, (T^Y) e a consistência estrutural;
- a separação entre o gate de derivação e a futura migração do manuscrito.

## 6. Itens não resolvidos

Nenhum. Os quatro findings possuem localização verificável e a evidência
disponível permite classificação segura.

## 7. Checks mecânicos registrados

1. `shasum -a 256` confirmou os hashes do memorando, do parecer externo, do
   pacote, do manuscrito e dos registros normativos.
2. `git show --stat --oneline b2d48a2` confirmou que o commit preserva apenas o
   parecer externo e que o arquivo possui 353 linhas.
3. `shasum -a 256 -c reports/chatgpt_pro_packets/2026-09-01_b1_b3_exclusion_external_review_packet.sha256`
   retornou `OK` para todos os sete artefatos listados.
4. Leituras numeradas com `nl -ba` verificaram os localizadores do memorando,
   do manuscrito, dos registros normativos e do pacote enviado.
5. A desigualdade (k\leq m-1) foi verificada analiticamente por paridade, não
   apenas por enumeração numérica.

## 8. Veredicto da adjudicação

**`READY_FOR_IMPLEMENTATION`.**

Há um reparo local confirmado no memorando (M1) e dois reparos delimitados para
a futura migração (partes confirmadas de M2 e M3). Não há erro matemático
substantivo, cutoff alterado, finding material não resolvido ou decisão autoral
pendente. M4 não é encaminhado como correção obrigatória.

O implementador deve receber somente esses limites. Após qualquer mudança de
bytes, será necessário recalcular o hash e submeter o novo candidato ao gate
independente apropriado.
