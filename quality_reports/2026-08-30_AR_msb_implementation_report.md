# Relatório de implementação de `A_R` sob M/S/B

**Data:** 2026-08-30  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Commit de autorização:** `c72335ace29fbee9262cbfbd2b843b155a351653`  
**Status:** `REPAIRED IMPLEMENTER CANDIDATE / 4367 PASS / 0 FAIL / UNREVIEWED / UNFROZEN`

## 1. Escopo executado

Foram implementados os cinco itens autorizados:

1. correspondências de PBE públicas de agenda sob maioria e unanimidade;
2. benchmark público por tipo e ex ante;
3. rendas informacionais com agenda por regra;
4. diferença institucional `U-M` dessas rendas;
5. interação agenda × informação relativamente às rendas sem agenda de `N7`.

Nenhum arquivo congelado de `A_C` ou `N7` foi alterado. Manuscrito, tag, merge e push não foram iniciados.

## 2. Achado formal que mudou a derivação

No ramo público de maioria em que `N7` exclui `H`, o payoff externo `o_theta` de `H` não reduz a unidade repartida pelos Estados fracos. Portanto, a continuação de cada fraco é `1/m`, não `(1-o_theta)/m`, e o voto na data `A` custa `beta/m`.

Disso segue que a melhor proposta majoritária que passa dá a `H`

```text
Z_E=1-k*beta/m,
```

enquanto rejeitar dá `beta*o_theta`. Assim, para um tipo público com opção externa alta, `H` prefere deliberadamente o atraso. No empate `beta*o_theta=Z_E`, a correspondência preserva todas as misturas entre propostas mínimas que passam e propostas que falham. Não foi criado um desempate de proposta.

Esse ramo é substantivamente importante: o benchmark público não favorece automaticamente a maioria. Para `o>1/m`, o sinal de

```text
G(o)=h_M(o)-h_U(o)
```

é o sinal de `c/m-beta*o`.

## 3. Resultados fechados

Sob unanimidade pública, o acordo é sempre imediato:

```text
h_U(o)=1-beta+beta^2*o.
```

Sob maioria pública:

```text
h_M(o)=1-k*beta*(1-beta*o)/m, se o<=1/m;
h_M(o)=max{1-k*beta/m,beta*o}, se o>1/m.
```

As rendas com agenda são translações exatas dos vetores privados congelados:

```text
RI_g^{A,01}=V_g^{01}-(h_g(o_0),h_g(o_1)).
```

A decomposição institucional é

```text
delta_theta=-G(o_theta)+DeltaRI_A^theta,
```

de modo que unanimidade supera maioria no jogo privado para o tipo `theta` se e somente se a diferença de rendas `DeltaRI_A^theta` excede o gap público `G(o_theta)`.

Sob unanimidade, em toda fibra existente, a renda do tipo baixo é não negativa e a do tipo alto é não positiva, com ao menos uma desigualdade estrita. Para a interação, a renda sem agenda de `N7` é primeiro transportada da data `R1` para `A` por um fator `beta`. Nos priors altos em que a interação existe, introduzir agenda reduz fracamente a renda informacional dos dois tipos; a redução é estrita para ambos nos membros `rho=0` com `u<z_H` e é zero no membro eficiente e na família de crença off-path alta. Isso é uma afirmação sobre a vantagem de informação privada, não sobre o nível do payoff de `H`.

As rendas e interações de maioria permanecem set-valued quando as fontes são set-valued; nenhum envelope foi promovido a correspondência exata.

## 4. Arquitetura e arquivos

| Arquivo | Função | SHA-256 |
|---|---|---|
| `model_redesign/agenda_extension_AR_msb_contract.md` | autoridade, domínio, datas e operadores | `c4867a9a8ef5f8171de04ae6b628a2fc29c5d5e033678f4448d0cbc55433f7a6` |
| `model_redesign/agenda_extension_AR_msb_results.md` | derivação e provas | `7a7913b6999a5cd69446d5f3e191f507f417582cd1c8617f7af0d5d8e8d331db` |
| `model_redesign/agenda_extension_AR_msb_interface.json` | interface econômica downstream e ponte por hash | `ff2270043e6e7e64aa6fdd6843e0fadc1f902d6282ca3e367f922f43762ddf03` |
| `model_redesign/agenda_extension_AR_msb_complete_records.json` | family records públicos e tuplas derivadas completas | `64e6f9b9c0c4b5775793a9361c4af06a8c82a892882b5c608101ffa420f7f0ff` |
| `model_redesign/agenda_extension_AR_msb_claim_ledger.tsv` | ledger de 30 claims no enum aprovado | `98d3ac5acc4ea347c5c3cca4ae41ffdda589683ea1399836b9f8f37ae5814a76` |
| `model_redesign/agenda_extension_game_dag_simplified.json` | DAG canônico imutável de topologia/proveniência | `a2572dc8954d63535d4edcbf04158e9524d11ed4537a822713e534df580ee9e0` |
| `scripts/verify_agenda_extension_AR_msb.R` | falsificação mecânica reproduzível | `20ada1470e823af00967ce1a2af23c7563c6c4e6f55c098b25ac19d47a1b3250` |
| `quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt` | saída completa | `5d0d89d4dc37ed97ca739f0b1c1f4cca6e500fee460ab5c9449b5d6b07282bba` |

### 4.1 Reparo após a primeira rodada independente

O snapshot `aba98f6abcf1b13d2dc386962fb592133a80001f` recebeu um parecer
matemático `PASS 0/0/0` e um parecer adversarial `FAIL 0/2/1`. A adjudicação
confirmou que os três findings eram de empacotamento, sem contraprova à
matemática:

1. o DAG concorrente de `A_R` foi removido e substituído por referência ao DAG
   canônico imutável de Gate 0;
2. os cinco resumos públicos foram mantidos apenas como resumos econômicos, e
   um novo export materializa os 19 campos obrigatórios, `public_type`, binders
   atômicos e as tuplas completas de datas e transportes;
3. os cinco `claim_kind` fora do enum aprovado foram reclassificados sem mudar
   o conteúdo dos claims;
4. o verificador passou a chamar os validadores genéricos aprovados para DAG,
   family records e ledger, além de rejeitar tuplas derivadas incompletas e
   hashes autorreferentes.

Essas mudanças invalidam o primeiro snapshot para fins de aprovação e exigem
uma nova rodada de duas revisões sobre os novos bytes.

## 5. Verificação mecânica

Comando:

```bash
Rscript --vanilla scripts/verify_agenda_extension_AR_msb.R \
  quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt
```

Resultado:

```text
SUMMARY | 4367 PASS / 0 FAIL
LIMIT | Mechanical evidence only; independent formal review remains required.
```

O script conferiu hashes das fontes, manifesto final de `A_C`, JSON, schema
TSV, DAG canônico pelo validador aprovado, family records, enum dos claims,
tuplas derivadas, hashes externos e ausência de autorreferência, registros de
`N7`, datas, ausência de sentinelas, fórmulas e sinais em grades finitas,
identidade das rendas, células de unanimidade e invariância anônima entre
coalizões nomeadas.

Ele não prova completude das correspondências, fatorização Borel abstrata ou validade matemática universal. Esses itens seguem para leitores independentes.

## 6. Próximo gate

1. fixar manifesto do candidato e commit;
2. duas revisões independentes, sem edição, sobre os mesmos hashes;
3. adjudicar todo finding contra as fontes e o contrato;
4. se o pacote sobreviver, pedir aprovação autoral terminal.

Até lá, `A_R` permanece `unreviewed/unfrozen`.
