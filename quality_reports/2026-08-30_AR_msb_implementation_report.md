# Relatório de implementação de `A_R` sob M/S/B

**Data:** 2026-08-30  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Commit de autorização:** `c72335ace29fbee9262cbfbd2b843b155a351653`  
**Status:** `IMPLEMENTER CANDIDATE / 4359 PASS / 0 FAIL / UNREVIEWED / UNFROZEN`

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
| `model_redesign/agenda_extension_AR_msb_contract.md` | autoridade, domínio, datas e operadores | `385bc9ec8cec9fd60c83659cf634d7d68bfb7115a37852d873c67c5460ef78df` |
| `model_redesign/agenda_extension_AR_msb_results.md` | derivação e provas | `4dcd7d1919203ebf52431ce9ee0a44a2571c1075773fb5c8d2e1aef8be8e598f` |
| `model_redesign/agenda_extension_AR_msb_interface.json` | interface downstream tipada | `6fcf1ba0f7433e55ac984d8ab20984fca7034e98f816ca61e7f236dfdf4d372f` |
| `model_redesign/agenda_extension_AR_msb_claim_ledger.tsv` | ledger de 30 claims | `19d077a697d1ece385dacc095c0d4e95101fd24aff536161f56e92e2c6afe109` |
| `model_redesign/agenda_extension_AR_msb_game_dag.json` | DAG de dependências | `c4a317598e9f22fcf6273d39cfdec23aa8e7cf075f88d90d42a9850d94fe4a7d` |
| `scripts/verify_agenda_extension_AR_msb.R` | falsificação mecânica reproduzível | `c2c421414ecbc365d5628f566f64baa64d8c5fb8ba289acd50db40df690e04d3` |
| `quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt` | saída completa | `adbf7b561417849694205f79f98fd789c5a25b5cb95d849906c640f07659e897` |

## 5. Verificação mecânica

Comando:

```bash
Rscript --vanilla scripts/verify_agenda_extension_AR_msb.R \
  quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt
```

Resultado:

```text
SUMMARY | 4359 PASS / 0 FAIL
LIMIT | Mechanical evidence only; independent formal review remains required.
```

O script conferiu hashes das fontes, manifesto final de `A_C`, JSON, schema TSV, DAG acíclico, hashes internos, registros de `N7`, datas, ausência de sentinelas, fórmulas e sinais em grades finitas, identidade das rendas, células de unanimidade e invariância anônima entre coalizões nomeadas.

Ele não prova completude das correspondências, fatorização Borel abstrata ou validade matemática universal. Esses itens seguem para leitores independentes.

## 6. Próximo gate

1. fixar manifesto do candidato e commit;
2. duas revisões independentes, sem edição, sobre os mesmos hashes;
3. adjudicar todo finding contra as fontes e o contrato;
4. se o pacote sobreviver, pedir aprovação autoral terminal.

Até lá, `A_R` permanece `unreviewed/unfrozen`.
