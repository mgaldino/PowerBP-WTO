# Contrato de `A_C` sob M/S/B — comparação privada em duas camadas

**Data:** 2026-08-30  
**Nó:** `A_C`  
**Status:** `AUTHORIZED / IN PROGRESS / UNFROZEN`  
**Natureza:** operador de comparação entre correspondências de PBE já congeladas; não é um novo estágio de ação  
**Orientação dos contrastes:** unanimidade menos maioria, `U-M`

## 1. Autoridade e dependências congeladas

A autorização de início está em
`quality_reports/plans/2026-08-30_autorizacao_inicio_A_C_msb.md`, SHA-256
`ea4e2e9b9e1296aecd64760f058f0097ff4281f6a9b301373feeea2591092f95`.

`A_C` consome somente:

| Fonte | Artefato matemático principal | SHA-256 | Autoridade terminal | Manifesto final |
|---|---|---|---|---|
| `A_M` | `model_redesign/agenda_extension_A_M_msb_results.md` | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` | `ca109199...f412158` | `8eb870d5...a32775e` |
| `A_U` | `model_redesign/agenda_extension_A_U_msb_interface.json` | `2ee931d21e3858db6702f78a4636d1f3c4b445910c8160120921c3bfc3b4b317` | `e330a195...e195111b` | `b85741b2...7030180` |

Os hashes completos das autoridades e manifestos entram na interface e no manifesto do candidato. `A_M` e `A_U` são dependências `pass/frozen`; este contrato não altera seus bytes nem rederiva seus jogos.

Os artefatos históricos `agenda_extension_AC_*_simplified` são proveniência diagnóstica, não fontes matemáticas.

## 2. Classificação do nó

`A_C` não acrescenta jogadores, ações, informações ou transições. Ele toma como dados dois jogos contrafactuais já resolvidos sobre a mesma economia primitiva:

- `A_M`: agenda privada sob maioria;
- `A_U`: agenda privada sob unanimidade.

O nó forma pares compatíveis de assessments completos e calcula imagens comparativas. Portanto:

| Campo | Especificação |
|---|---|
| Classe | integração de correspondências de PBE em jogo Bayesiano finito |
| Dependências | `A_M`, `A_U` |
| Novos movimentos | nenhum |
| Novas crenças | nenhuma |
| Novo conceito de solução | nenhum; herda PBE + as-if-pivotal + `T^Y` + M/S/B de cada fonte |
| Seleção cross-rule | nenhuma |
| Acoplamento probabilístico cross-world | inexistente e não presumido |
| Data dos valores | `A` em ambas as fontes |
| Novo desconto | nenhum |

## 3. Domínio comum e fibra institucional

Fixe

```text
d=(N,m,q,k,beta,o_0,o_1,y_bar,Y,nu),
m=N-1,
q=floor(N/2)+1,
k=q-1,
N>=3,
0<beta<1,
0<o_0<o_1<1,
o_1<=y_bar<=1,
nu in [0,1].
```

`y_bar` é a primitiva de domínio carregada por `A_M`; `A_U` é uniforme nela e não a usa para alterar sua correspondência. Ela permanece no tipo de `A_C` para não repetir a omissão histórica. O símbolo de proposta `y_H` em `A_U` não é essa primitiva `y_bar`.

O simplex `Y` é o mesmo conjunto de pacotes nas duas regras. As quotas diferentes são precisamente a variação institucional comparada, não divergência do domínio.

Para `0<nu<1`, a fibra comum é

```text
eta=(rho,nu_off),
rho in [0,infinity],
nu_off=b_rho(nu)=nu*rho/(1-nu+nu*rho).
```

Nos endpoints:

```text
eta=(*,nu),
nu_off=nu.
```

Maioria e unanimidade devem usar a mesma `eta`. Pares fora da diagonal `nu_off^M=nu_off^U` não pertencem à comparação principal.

## 4. Bindings completos das fontes

Defina `B_M(d,eta)` como o conjunto de binders completos `R_M` da correspondência congelada de `A_M` na fibra. Cada binder conserva, sem splicing:

```text
sigma_0^M, sigma_1^M, lambda^M, pi^M, chi^M,
ballot^M, kappa_M, Gamma_0^M, Gamma_1^M,
payoffs por tipo e identidade, outcomes e funções off-path.
```

Defina `B_U(d,eta)` analogamente para `A_U`, com seus family records literais e o binder completo subjacente.

As assinaturas e resumos são:

```text
Sig_ex_g(R_g)=(eta,Lambda_g),
Sum_econ_g(R_g)=(eta,Gamma_bar_0^g,Gamma_bar_1^g),
g in {M,U},
```

com a convenção `*` nos endpoints. `Sig_ex_g` é exata para a lei realizada enriquecida aprovada; uma operação sensível ao off-path continua a receber `R_g`.

## 5. Compatibilidade necessária e suficiente

O conjunto primário de pares é

```text
J_AC^bind(d,eta)
 ={(R_M,R_U):
    R_M in B_M(d,eta),
    R_U in B_U(d,eta),
    fontes e hashes coincidem com os congelados,
    cada binder permanece atômico}.
```

Um par pertence ao conjunto se, e somente se:

1. as primitivas em `d` coincidem;
2. a fibra `eta` coincide;
3. cada componente é membro completo da própria correspondência congelada;
4. nenhuma coordenada é transplantada entre assessments ou instituições.

Não há condição adicional de que propostas, suportes, realizações aleatórias, seleções de continuação ou identidades favorecidas coincidam entre regras. Os jogos são contrafactuais e o game form não fornece sorteio cross-world comum.

A imagem na camada exata é

```text
J_AC^ex(d,eta)
 ={(Sig_ex_M(R_M),Sig_ex_U(R_U)):(R_M,R_U) in J_AC^bind(d,eta)}.
```

O produto das camadas exatas é formado antes de qualquer resumo econômico.

## 6. Operações comparativas declaradas

Para `g in {M,U}` e `theta in {0,1}`, extraia do mesmo binder:

```text
V_g^theta       = payoff de H na data A,
a_g^theta       = probabilidade de acordo imediato,
dly_g^theta     = 1-a_g^theta,
Gamma_bar_g^theta = lei anônima do registro realizado.
```

Defina:

```text
delta_theta = V_U^theta-V_M^theta,
delta_E     = (1-nu)delta_0+nu*delta_1,
Delta_a^theta   = a_U^theta-a_M^theta,
Delta_dly^theta = -Delta_a^theta.
```

O operador econômico declarado é

```text
C_econ(R_M,R_U)
 =((V_M^0,V_M^1),(V_U^0,V_U^1),
   delta_0,delta_1,delta_E,
   (a_M^0,a_M^1),(a_U^0,a_U^1),
   Delta_a^0,Delta_a^1,
   (Gamma_bar_M^0,Gamma_bar_M^1),
   (Gamma_bar_U^0,Gamma_bar_U^1)).
```

As leis das duas instituições aparecem como par ordenado. Não existe lei conjunta cross-world.

`A_C` não introduz função de bem-estar, ordem estocástica ou ranking escalar dos payoffs fracos. Ele preserva suas leis anônimas dentro de `Gamma_bar_g^theta`.

## 7. Gate de fatorização econômica

O candidato deve provar que, dentro da mesma fibra,

```text
Sum_econ_M(R_M)=Sum_econ_M(R'_M)
e
Sum_econ_U(R_U)=Sum_econ_U(R'_U)
implicam
C_econ(R_M,R_U)=C_econ(R'_M,R'_U).
```

Também deve construir uma aplicação Borel

```text
C_bar_econ
```

tal que

```text
C_econ
 =C_bar_econ compose (Sum_econ_M,Sum_econ_U)
```

na fibra. Para a correspondência set-valued, deve provar que sua imagem é obtida por lifting de pares completos e que nenhum vetor `(V^0,V^1)`, outcome ou lei de posterior é recombinado entre pré-imagens distintas.

Comparações de suportes, coincidência de mensagens, mapas públicos `pi`, crenças, relação entre planos dos tipos, funções off-path ou identidades nomeadas estão fora de `C_econ` e usam `J_AC^bind/J_AC^ex`.

## 8. Existência e células `none`

```text
J_AC^bind(d,eta) não vazio
sse
B_M(d,eta) não vazio e B_U(d,eta) não vazio.
```

Se uma fonte é vazia, `A_C` recebe `status=none` naquela fibra. A regra sobrevivente permanece registrada em sua própria correspondência. Não se imputa `0`, `NA`, infinito ou payoff fictício.

A partição explícita de `A_U` será importada no resultado. A possível vacuidade de `B_M(d,eta)` em uma fibra fixa permanece a condição simbólica exata do Teorema T4 de `A_M`; não se presume existência para todo `rho`.

## 9. Datas e desconto

| Valor importado | Data nativa | Data em `A_C` | Fator | Novas aplicações de `beta` |
|---|---:|---:|---:|---:|
| `V_M^theta`, `Gamma_M^theta` | `A` | `A` | 1 | 0 |
| `V_U^theta`, `Gamma_U^theta` | `A` | `A` | 1 | 0 |

As aplicações únicas de `beta` entre `C_g` e `A_g` permanecem internas às fontes congeladas.

## 10. Conceito de prova e revisão

O verificador futuro pode conferir hashes, tipos, domínio, diagonal da fibra, identidades algébricas, partição de `A_U`, ausência de sentinelas, contagem de `beta` e exemplos finitos. Ele não prova completude das fontes, fatorização Borel abstrata, extrema de correspondências contínuas nem dominância universal.

O candidato de `A_C` permanece `pending/unfrozen` até duas revisões independentes sobre os mesmos hashes, adjudicação e aprovação autoral terminal.

## 11. Invalidação

Qualquer mudança nos bytes congelados de `A_M`, `A_U`, nas decisões de duas camadas, em M/S/B, na fibra comum, no domínio `y_bar`, na orientação `U-M` ou nas operações declaradas invalida este contrato e todos os artefatos de `A_C`.

`A_R`, manuscrito, tag, merge e push permanecem não autorizados.
