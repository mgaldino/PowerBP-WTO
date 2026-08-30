# Contrato de `A_T` — efeito total da etapa obrigatória de agenda

**Data:** 2026-08-30  
**Nó:** `A_T`  
**Status:** `AUTHORIZED / IMPLEMENTER CANDIDATE / UNREVIEWED / UNFROZEN`  
**Orientações:** efeitos de agenda `com agenda - sem agenda`; contrastes institucionais `U-M`

## 1. Pergunta e autorização

`A_T` responde qual é o efeito estrutural de inserir uma etapa anterior e
**obrigatória** na qual `H` propõe na data `A`, separadamente sob maioria e
unanimidade, quando a informação é completa e quando o tipo permanece privado.

A autorização literal e os limites estão em
`quality_reports/plans/2026-08-30_autorizacao_efeito_total_agenda.md`, SHA-256
`701861558cc5634f28e8ba02e364a8f8c909bbee9cec1aa09d3febf3a370044e`.

## 2. Fontes congeladas

O nó consome, sem editar:

| Fonte | Artefato | SHA-256 | Status |
|---|---|---|---|
| resultados de agenda, benchmark público, rendas e interação | `model_redesign/agenda_extension_AR_msb_results.md` | `7a7913b6999a5cd69446d5f3e191f507f417582cd1c8617f7af0d5d8e8d331db` | `A_R pass/frozen` |
| interface de `A_R` | `model_redesign/agenda_extension_AR_msb_interface.json` | `62caca71f0fd221a7e17026d7518d53b97713ff9c9d7f61a62a52f312120800b` | `A_R pass/frozen` |
| registros completos de `A_R` | `model_redesign/agenda_extension_AR_msb_complete_records.json` | `96d6045787200153f9d77cab9279053ad97a3076d2c23782b16b8f3e2ff6cca8` | `A_R pass/frozen` |
| manifesto final de `A_R` | `quality_reports/2026-08-30_A_R_msb_final_gate_manifest.sha256` | `a57696cac12d3b3910cd7406842ea9d270df6193e4c696e455e06722447c8e38` | final `pass/frozen` |
| benchmark sem agenda | `model_redesign/essential_input_n7_complete_information_benchmark_candidate.json` | `4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45` | `N7 pass/frozen` |

`A_T` não reabre `A_M`, `A_U`, `A_C`, `A_R` ou `N7`. Toda multiplicidade
entra por seus registros completos congelados.

## 3. Data e tratamento

O estágio `A` é a data 0. Nele, `H` precisa fazer uma proposta: o game form não
contém ação nula, renúncia ou passagem. O jogo sem agenda começa diretamente em
`R1`, uma data depois. Assim, o efeito da **etapa obrigatória de agenda** compara:

```text
valor com agenda na data A - beta * valor sem agenda na data R1.
```

O fator `beta` aparece uma única vez no braço sem agenda. Um contraste sem esse
fator responderia a outra pergunta — substituir o proponente mantendo a data
fixa — e não é o tratamento definido no contrato aprovado da extensão.

O tratamento é, portanto, `inserir a etapa anterior e obrigatória de proposta -
iniciar diretamente em R1`. Ele não é o valor de uma opção facultativa de
propor, nem o efeito de trocar o proponente mantendo a data fixa. Sob informação
privada, a proposta obrigatória também pode revelar informação e alterar crenças
e continuações. O termo "causal" é estrutural e interno ao modelo; não é uma
afirmação causal empírica.

## 4. Desenho fatorial `2 x 2`

Para cada regra `g in {M,U}` e tipo `theta`, as quatro células, todas expressas
na data `A`, são:

| | informação completa (`CI`) | informação privada (`PI`) |
|---|---|---|
| sem agenda (`N`) | `beta*h_g^{N,R1}(o_theta)` | `beta*V_g^{N,R1,theta}` |
| com agenda (`A`) | `h_g^A(o_theta)` | `V_g^{A,theta}` |

As rendas satisfazem:

```text
V_g^{A,theta}=h_g^A(o_theta)+RI_g^{A,theta},
V_g^{N,R1,theta}=h_g^{N,R1}(o_theta)+RI_g^{N,R1,theta}.
```

## 5. Operadores causais e interação

O efeito direto da agenda sob informação completa é

```text
D_g^theta=h_g^A(o_theta)-beta*h_g^{N,R1}(o_theta).
```

O efeito total da agenda sob informação privada — agenda versus **informação
apenas** — é

```text
T_g^theta=V_g^{A,theta}-beta*V_g^{N,R1,theta}.
```

A interação agenda × informação já congelada em `A_R` é

```text
I_g^theta=RI_g^{A,theta}-beta*RI_g^{N,R1,theta}.
```

Logo a identidade governante é

```text
T_g^theta=D_g^theta+I_g^theta.
```

As imagens ex ante são aplicadas somente depois da formação do vetor ligado
por tipos.

## 6. Comparação institucional dos efeitos

Defina

```text
DeltaD^theta=D_U^theta-D_M^theta,
DeltaT^theta=T_U^theta-T_M^theta,
DeltaI^theta=I_U^theta-I_M^theta.
```

Então

```text
DeltaT^theta=DeltaD^theta+DeltaI^theta.
```

Esse objeto responde se dar agenda a `H` aumenta mais seu payoff sob
unanimidade ou maioria.

## 7. Comparação diagonal

Para evitar ambiguidade na expressão "agenda apenas versus informação apenas",
defina também

```text
Q_g^theta=h_g^A(o_theta)-beta*V_g^{N,R1,theta}
         =D_g^theta-beta*RI_g^{N,R1,theta}.
```

`Q_g` compara dois pacotes: `(agenda, CI)` contra `(sem agenda, PI)`. Como
agenda e regime informacional mudam juntos, `Q_g` **não** é o efeito causal de
um único fator.

## 8. Correspondências, pareamento e `none`

Para efeitos privados, forme primeiro o produto dos registros completos com e
sem agenda nas mesmas primitivas. Depois aplique a diferença vetorial. Não há
realização aleatória comum, seleção cross-world nem recombinação de coordenadas
de tipos ou classes diferentes.

Consequências:

1. `T_M`, `Q_M` e `DeltaT` permanecem set-valued quando suas fontes o são;
2. um sinal só é robusto se todos os membros do conjunto exato têm esse sinal;
3. se qualquer braço exigido é `none`, o efeito composto é `none`;
4. o contrato não impõe um "mesmo equilíbrio" contrafactual que o game form
   não fornece;
5. uma futura seleção cross-world seria uma extensão normativa separada.

## 9. Limites

O nó não altera o jogo, não acrescenta ações ou crenças e não resolve novamente
equilíbrios. Ele deriva traduções, somas e diferenças de objetos congelados.
Código pode conferir hashes e identidades algébricas, mas não prova completude
de PBE, legitimidade de uma seleção cross-world inexistente ou afirmações
empíricas.

Qualquer mudança em datas, `beta`, fontes de `A_R` ou `N7`, orientação dos
contrastes ou regra de `none` invalida integralmente `A_T`.
