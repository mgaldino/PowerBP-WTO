# Relatório de implementação de `A_R` sob M/S/B

**Data:** 2026-08-30  
**Worktree:** `/private/tmp/PBP-am-msb`  
**Branch:** `agenda-extension-am-msb`  
**Commit de autorização:** `c72335ace29fbee9262cbfbd2b843b155a351653`  
**Status:** `IMPLEMENTER CANDIDATE / 4342 PASS / 0 FAIL / UNREVIEWED / UNFROZEN`

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

Sob unanimidade, em toda fibra existente, a renda do tipo baixo é não negativa e a do tipo alto é não positiva, com ao menos uma desigualdade estrita. Nos priors altos em que a interação com `N7` existe, introduzir agenda reduz estritamente a renda informacional do tipo baixo e reduz fracamente a do tipo alto. Isso é uma afirmação sobre a vantagem de informação privada, não sobre o nível do payoff de `H`.

As rendas e interações de maioria permanecem set-valued quando as fontes são set-valued; nenhum envelope foi promovido a correspondência exata.

## 4. Arquitetura e arquivos

| Arquivo | Função | SHA-256 |
|---|---|---|
| `model_redesign/agenda_extension_AR_msb_contract.md` | autoridade, domínio, datas e operadores | `b4c785a23ad6481090f8008955a65640de7b15b0bb5aa82d8e0b0dcb9540828b` |
| `model_redesign/agenda_extension_AR_msb_results.md` | derivação e provas | `ddfeaabb56b91f039adc2eafd8b0168450d245eeb848ba8f805c50c1c5471bc3` |
| `model_redesign/agenda_extension_AR_msb_interface.json` | interface downstream tipada | `bc81df2958584046ffcbe6d88eb8e5012bd23c56bddc77858c80abaaf455b181` |
| `model_redesign/agenda_extension_AR_msb_claim_ledger.tsv` | ledger de 30 claims | `c190a67776ab834afa77b77da5d70c19e5834eda8fe8c650fdd60af331238e3a` |
| `model_redesign/agenda_extension_AR_msb_game_dag.json` | DAG de dependências | `792350ced6ab0877043d5bc552d1a4f4ecd5641f4777ae6271da6fb9168ff8d5` |
| `scripts/verify_agenda_extension_AR_msb.R` | falsificação mecânica reproduzível | `6b3b6aed891a39bd9c8ebaef8099bc97621f4f10ab05b4f0867a7e3f6369a5a6` |
| `quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt` | saída completa | `549663a249d1745fffaacb2001f693c646650bc5098a7ccc709bd547dba1f52b` |

## 5. Verificação mecânica

Comando:

```bash
Rscript --vanilla scripts/verify_agenda_extension_AR_msb.R \
  quality_reports/verification_outputs/2026-08-30_AR_msb_verifier_output.txt
```

Resultado:

```text
SUMMARY | 4342 PASS / 0 FAIL
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
