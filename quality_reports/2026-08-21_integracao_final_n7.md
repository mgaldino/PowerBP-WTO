# Integração final de N7 — benchmark público e rendas informacionais

Data: 2026-08-21  
Estado de N7: PASS / frozen  
Escopo: Goal 4 exclusivamente N7, `m>=3`, `beta in (0,1)` e PBE com ballots
puros  
Parada: aguardar aval explícito do autor; Goal 5 não autorizado

## 1. Autoridade, método e fontes

A integração foi feita exclusivamente na worktree
`/private/tmp/PowerBayesianPersuasion-essential-input-n7-fresh`, branch
`codex/essential-input-goal4-n7-fresh`, a partir do HEAD obrigatório
`8813303ac37be6d5ac9f3da822c0855d34e9e349`.

N7 consumiu N6 somente pela interface congelada:

```text
a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92
```

N1–N4 foram usados apenas para o teste de equivalência dos endpoints, nos
hashes congelados registrados no manifesto candidato. Não houve edição ou
rederivação de N1–N6. Não foram consultados a worktree de suporte, calculadora
de renda, branches ou worktrees antigas de N7, nem outputs paralelos.

A derivação resolveu primeiro R2 e depois R1 em cada regra. O benchmark público
foi derivado sem usar o equilíbrio privado como premissa; somente depois foram
transportados os conjuntos privados de N6 para formar as rendas.

## 2. Quatro jogos públicos

Escreva `m=N-1`, `q=floor(N/2)+1` e fixe o tipo público, com outside option
`o=o_theta`.

### Maioria, R2

Todos os weak responders votam sim; `H`, não pivotal, vota não. A proposta
única é `y=0`, pagamentos fracos zero e residual 1. Ela passa sem `H`.

```text
payoff do proponente reconhecido = 1
payoff weak antes do reconhecimento = 1/m
payoff de H = o
```

### Unanimidade, R2

`H` é pivotal e aceita se e somente se `y>=o`, com `T^Y` na igualdade. A
proposta única paga `y=o`, zero aos weak responders e deixa `1-o` ao
proponente. Ela passa com `H`.

### Maioria, R1

A continuação pública produz `w=beta/m` para cada weak responder e
`t(o)=beta*o` para `H`. O proponente compara:

```text
inclusão: J(o)=1-(q-2)beta/m-beta*o
exclusão: E=1-(q-1)beta/m.
```

Como `J(o)-E=beta(1/m-o)`, `H` é incluído se `o<=1/m` e excluído se
`o>1/m`. Na igualdade, o desempate anti-`H` seleciona inclusão. A rejeição
deliberada é estritamente inferior, pois `E-beta/m=1-beta*q/m>0`.

A estratégia de `H` cobre todas as propostas: vota não se pelo menos `q-1`
weak nonproposers votam sim; com exatamente `q-2`, vota sim se e somente se
`y>=beta*o`; com no máximo `q-3`, vota sim por `T^Y`, pois a falha independe de
seu voto.

Há multiplicidade apenas nas identidades das coalizões fracas compradas e nas
distribuições sobre coalizões empatadas. A família `F=(F_i)_i` permanece
atômica: pode alterar o payoff de um weak state rotulado, mas não altera payoff
de `H`, payoff do proponente, média fraca ou outcome.

### Unanimidade, R1

Defina:

```text
C(o)=beta(1-o)/m
Q(o)=C(o)+1-beta.
```

A proposta única paga `beta*o` a `H`, `C(o)` a cada weak responder e deixa
`Q(o)` ao proponente. Como `Q(o)-C(o)=1-beta>0`, acordo imediato domina
estritamente atraso. Não há multiplicidade.

## 3. Endpoints

Os oito pares regra–rodada–tipo coincidem em outcome e payoffs por papel com os
endpoints privados de N1–N4 sob restrição de suporte. A Emenda 1a foi aplicada:
um tipo com probabilidade a priori zero nunca recebe posterior positivo. Não
foi encontrada discrepância de fonte compartilhada; N7 não reabre N1–N6.

## 4. Payoffs públicos e rendas

Os conjuntos públicos de payoff de `H` são singletons:

```text
p_M(o)=beta*o se o<=1/m; p_M(o)=o se o>1/m
V_M^pub={(p_M(o_0),p_M(o_1))}
V_U^pub={(beta*o_0,beta*o_1)}.
```

Defina:

```text
a_0=(1-beta)o_0
a_1=(1-beta)o_1
d=beta(o_1-o_0)>0
k=beta*o_1-o_0.
```

Nas três regiões públicas de maioria, `II: o_1<=1/m`,
`IX: o_0<=1/m<o_1` e `XX: 1/m<o_0`, as rendas exatas são:

| Região | Classe privada | `RI_M(theta_0,theta_1)` |
|---|---|---|
| II | S | `(0,0)` |
| II | P | `(d,0)` |
| II | E | `(a_0,a_1)` |
| II | EP | `lambda(a_0,a_1)+(1-lambda)(d,0)` |
| IX | S | `(0,-a_1)` |
| IX | E | `(a_0,0)` |
| XX | E | `(0,0)` |

Sob unanimidade:

```text
nu=0:              RI_U={(0,0)}
0<nu<=nu_star:     RI_U=vazio
nu_star<nu<=1:     RI_U={(d,0)}.
```

Na região intermediária, `RI_M` continua definida, mas `RI_U` e `DeltaRI` são
vazios porque N4 não tem PBE puro. Não existe payoff sentinela ou ordenação
robusta nessa região.

## 5. Diferença das diferenças

Em `nu=0`:

```text
II: (0,0)
IX: (0,a_1)
XX: (0,0).
```

Em `0<nu<=nu_star`, `DeltaRI` é vazio nas três regiões públicas.

Em `nu_star<nu<=1`:

| Região | Classe privada de maioria | `DeltaRI` |
|---|---|---|
| II | S | `(d,0)` |
| II | P | `(0,0)` |
| II | E | `(k,-a_1)` |
| II | EP | `{lambda(k,-a_1): lambda in [0,1]}` |
| IX | S | `(d,a_1)` |
| IX | E | `(k,0)` |
| XX | E | `(d,0)` |

Assim, `d` e `a_1` são estritamente positivos; `k` é positivo, zero ou
negativo conforme `beta*o_1` seja maior, igual ou menor que `o_0`. No segmento
`EP`, a mesma `lambda` vincula as duas coordenadas e `lambda=0` preserva o ponto
zero. Envelopes são projeções do conjunto exato, não produtos cartesianos.

Todas as imagens ex ante usam o mesmo prior `mu=nu`. Em particular, uma
diferença apenas na coordenada de um tipo de massa zero tem imagem ex ante zero.

## 6. Ciclos de revisão

No primeiro hash candidato
`7e5e8e0be9d896fd995c30e7b8a33d4b88760757e2710c1b9a7ffee872bea7f8`,
o parecer de teoria dos jogos registrou `REVISE 0/0/1`: dois registros de
exclusão em R1-maioria descreviam apenas a ação on-path de `H`, e não sua
estratégia depois de toda proposta factível. O reparo era único e não alterava
outcomes, payoffs ou rendas. A interface e o verificador foram corrigidos; o
novo hash reiniciou ambos os pareceres, invalidando o PASS anterior.

Texto original do finding `GT-N7-01`, classificado como técnico pelo teste de
reparo único:

> Nos registros `N7-PUB-M-R1-T0-EXCLUDE` e
> `N7-PUB-M-R1-T1-EXCLUDE`, o campo `strategy_profile.hegemon` contém apenas
> `no because the proposal passes without H`. Isso especifica a ação de `H`
> diante da proposta no caminho, mas não sua estratégia depois de toda proposta
> factível. Uma estratégia de PBE deve também cobrir propostas fora do caminho
> que produzam exatamente `q-2` ou no máximo `q-3` votos fracos. Sem essas
> ações, o registro atômico não contém o perfil estratégico completo que seu
> próprio `existence_uniqueness_status` declara. A correção é unívoca e já está
> provada na Seção 6 da derivação e registrada nas células de inclusão do mesmo
> tipo: `no` se pelo menos `q-1` weak nonproposers votam sim; `sim` iff
> `y>=beta*o_theta` quando exatamente `q-2` votam sim; `sim` por `T^Y` quando
> no máximo `q-3` votam sim. O finding não altera proposta no caminho, payoffs,
> outcomes, multiplicidade, endpoints, `RI_M`, `RI_U` ou `DeltaRI`. Contudo,
> altera os bytes da interface; portanto gera novo hash e reinicia os dois
> pareceres.

No ciclo final, exatamente dois revisores independentes e read-only examinaram
integralmente a mesma interface e o mesmo manifesto:

- `formal_design`, reviewer
  `codex-formal-design-n7-final-20260821`: PASS 0/0/0; relatório
  `eca9697269589688a0bb568be96deeaa446326e2a40b8b9c3c0c919159857aad`;
- `game_theory`, reviewer
  `codex-game-theory-n7-final-20260821`: PASS 0/0/0; relatório
  `42604ed0770923c1fa94e3a4314376a1fd3bb05f3fb024750b77fa7e9da4ae0d`.

Ambos incidem sobre:

```text
interface = 4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45
manifesto = a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09
```

O manifesto final dos pareceres tem hash
`56669e62160fb7718992170555dcca8ad46e40dd41123ad2f07d9484283bae0e`.

## 7. Artefatos

```text
derivação:
2431e0f8c6846149a328a373e290083f09f22d02ff6a10e25c3705b86b413251

interface complete_information_benchmark_v1:
4e0169ded349bce0377561001b18424c3daf4f22baee7c034deacc7677b49c45

ledger:
f00aeb8fd81d629902535f31ed4f0d913cf5891778bccf929c33ed8e7bd29526

relatório legível:
3e2755937d6ca17f362b9f9ca48bd2a15cd286053782626fc1f8568c2d69e257

verificador N7:
d5124b7c9f4643e31e535bf25dc92d30110e4b823f2a70ab615a1bc5f8258a6c

manifesto candidato:
a54c86df332780756c52a170f6e8f0aef113683c04402ee668a4a92c6d987b09

manifesto final dos pareceres:
56669e62160fb7718992170555dcca8ad46e40dd41123ad2f07d9484283bae0e

DAG integrado:
36155405a635bf6842c09dcde127907ec1f6fe61bb86ec06d932d7e472abf9ab
```

O manifesto candidato registra deliberadamente o snapshot anterior à promoção
administrativa. Por isso, os pins do DAG e do Gate 0 nele contidos não são
reaplicados como hashes finais; todos os artefatos matemáticos revisados
permanecem imutáveis.

## 8. Validação final

Após a promoção administrativa, retornaram PASS:

- N1 e N2 nos hashes congelados;
- verificador conjunto corrente de N3/N4;
- N6, incluindo 60 identidades dirigidas e 5/5 negativos;
- N7, com 27 casos públicos, 16 equivalências de endpoint, 18 casos de renda e
  5/5 negativos representativos;
- Gate 0, com N1–N7 `pass/frozen`, cinco negativos administrativos de N7 e
  nenhuma tarefa derivacional pronta;
- checker do DAG com ordem de execução: `VALID`, batches
  `[N1,N2] -> [N3,N4] -> [N6] -> [N7]`, `Ready: none`;
- identidade do objeto N7 embutido no DAG com o arquivo standalone;
- `git -c core.whitespace=-trailing-space diff --cached --check`. O check
  padrão aponta somente quebras Markdown deliberadas de dois espaços nos
  artefatos já hashados; elas foram preservadas para não alterar os bytes
  revisados.

O script `scripts/verify_essential_input_n3.R` permaneceu intocado e não foi
usado: os manifestos correntes e o verificador conjunto confirmam que ele é
histórico/obsoleto.

## 9. Estado e parada

N1, N2, N3, N4, N6 e N7 estão `pass/frozen`. N7 é terminal, portanto não há
novo nó derivacional pronto. Isso ainda não fecha Goal 4: falta o aval explícito
posterior do autor, conforme o contrato.

Não foram editados nem compilados `formal_model_v5.Rmd` ou
`formal_model_v6.Rmd`. Goal 5 não foi aberto. Não houve commit, push, merge ou
tag durante a derivação e a revisão. A única escrita Git de encerramento é o
commit local que fixa esta integração; não há push, merge ou tag.
