# Parecer formal independente 2 — `A_U` sob M/S/B (passo 3)

**Data:** 2026-08-29  
**Papel:** parecerista formal independente 2, adversarial e read-only  
**Objeto:** correspondência completa de PBE do estágio de agenda sob unanimidade, `A_U`, consumindo literalmente `C_U`  
**Tipo de jogo:** jogo Bayesiano finito, acíclico, de horizonte finito e informação imperfeita; proposta contínua de um emissor informado, votação simultânea selada e continuação dinâmica literal após rejeição  
**Snapshot examinado:** branch `agenda-extension-am-msb`, commit `b59ce1bf5b5ee7b57707684de92c38d4fa325b30`

## 1. Independência, precedência e método

Eu não implementei `A_U`, não acompanhei a construção de seu candidato e fiz esta revisão a frio em relação a `A_U`. Antes deste mandato, eu havia revisado `A_M` no mesmo worktree. Declaro essa exposição para transparência: ela não foi usada como autoridade para `A_U`; em particular, a decisão autoral de assinatura em duas camadas foi relida como documento normativo e tratada segundo seu escopo textual, que é exclusivamente `A_M`.

Não abri `quality_reports/2026-08-29_A_U_msb_formal_review_1.md`, não li parecer anterior específico sobre `A_U`, não consultei memórias, rollout summaries ou web, não deleguei nenhuma parte e não me comuniquei com outro parecerista. Li os artefatos históricos de implementação de `A_U` somente porque o mandato exige auditar os claims históricos; eles não são pareceres independentes.

Antes de inspecionar o candidato, reli integralmente e apliquei:

- `/Users/manoelgaldino/.codex/skills/game-theory-audit/SKILL.md`;
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/SKILL.md`;
- `/Users/manoelgaldino/.codex/skills/solve-dynamic-games/references/templates.md`.

O método foi: (i) preflight de identidade e proveniência; (ii) reconstrução independente da forma extensiva, dos estados suficientes e do ledger de datas; (iii) indução reversa a partir de `C_U`; (iv) prova adversarial de Bayes local, racionalidade sequencial, imitação bilateral, existência e exaustão; (v) testes de sinais atômicos, compartilhados, separating, semipooling e atomless, inclusive pontos disciplinados de massa pontual zero; (vi) auditoria dos binders completos, mensurabilidade e ação comum de permutações; (vii) comparação independente com os claims históricos; e (viii) reexecução do verificador apenas como evidência finita.

Precedência aplicada: Gate 0 simplificado; emenda M/S/B; clarificação autoral de anonimato/assinatura; decisão posterior limitada a `A_M`; `C_U` congelado; contrato, DAG, interface, resultados, ledger, script, outputs, preflights, relatório e manifestos atuais de `A_U`; por último, os artefatos históricos não revisoriais.

## 2. Identidade dos bytes e preflight

### 2.1 Git e manifesto

| Verificação | Resultado |
|---|---|
| Worktree | `/private/tmp/PBP-am-msb` |
| Branch | `agenda-extension-am-msb`, exatamente como mandatado |
| `HEAD` | `b59ce1bf5b5ee7b57707684de92c38d4fa325b30`, exatamente como mandatado |
| Blind-lock | `c193f3bdd99c6b127e76e595d851051fa005e247` existe |
| Ancestralidade | `c193f3b...` é ancestral de `b59ce1b...` (`git merge-base --is-ancestor`, código 0) |
| Cleanliness antes deste parecer | `git status --short` vazio, inclusive no recorte tracked-only |
| Manifesto | `quality_reports/2026-08-29_A_U_msb_final_implementer_manifest.sha256` |
| SHA-256 externo do manifesto | `f95322c800e113ac74dbf8d378d7a329b9e6a06cb27e7e016c0a1c6322d2be81`, igual ao esperado |
| Conteúdo do manifesto | 26 entradas; `env LC_ALL=C LANG=C shasum -a 256 -c ...` retornou `OK` para as 26 |
| DAG | checker da skill retornou `VALID`, com ordem `C_U_frozen -> A_U_blind_contract -> A_U_blind_candidate -> AC` |

O fato de o checker indicar `AC` como próximo nó topologicamente pronto não constitui autorização substantiva. Não abri, executei nem aprovei `AC` ou `AR`.

### 2.2 Hashes normativos e dos bytes centrais recalculados

| Objeto | SHA-256 conferido |
|---|---|
| Gate 0 simplificado | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| Emenda M/S/B | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| Clarificação de assinatura/anonimato | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| Decisão de duas camadas limitada a `A_M` | `cd9650715442dc0beae2fa6af450c509c0ad871d51dc5d54b0a6a826d1fc86e8` |
| `C_U` congelado | `f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b` |
| Contrato atual de `A_U` | `4136d897d3606a5cec926247d1dc57e60a90e83344a5c19efbef8dd789d97a57` |
| DAG atual | `2c5808e3ed6e1ae08795c17980c25988191689d16bd4c49b2cae3e10d201e94f` |
| Interface atual | `ee9582805b17562d5b1e2bb9e511eca7984ae2fd3379d94667b8464c50932410` |
| Resultados atuais | `fefe77fe0dcd86941ed41ed5cd13ff22323ffb2e12221db5e2d91604de7774fc` |
| Ledger atual | `e2d7b0f19429bf7149b7e2ba0afd998469004b5dad23e1b8a7330aec6a8bd03b` |
| Verificador atual | `b738695e38de6fe8ceaca982250cac5f3251ef2dbb903ac47e03246b27328399` |
| Output pós-comparação | `e06587ec81df764726e7fbb7f1a7b163528f3bc235c57a5f05b880585f228586` |

### 2.3 Reexecução mecânica

Executei, escrevendo somente em `/private/tmp`:

```text
env LC_ALL=C LANG=C Rscript --vanilla \
  scripts/verify_agenda_extension_A_U_msb.R \
  /private/tmp/A_U_msb_formal_review_2_verifier.txt
```

Resultado: `MECHANICAL RESULT: PASS | 1095 PASS | 0 FAIL`. A saída em `/private/tmp` é byte a byte idêntica ao output pós-comparação versionado (`cmp`, código 0). Isso confirma identidades, grades e testemunhas finitas do script; não prova completude de PBE, todos os desvios no simplex contínuo, existência pointwise de Bayes local, totalidade Borel dos binders nem literalidade de todo seletor de continuação. O próprio output declara esses gates como não testados.

## 3. Reconstrução independente do jogo e da solução

### 3.1 Forma extensiva, informação e datas

Há um hegemon `H` com tipo privado `theta in {0,1}` e `m=N-1>=2` Estados fracos. Natureza sorteia `theta`, com `Pr(theta=1)=nu`. Na nova data `A`, `H` é obrigado a propor

```text
y=(z,x_1,...,x_m) in Y,
Y={z>=0, x_j>=0: z+sum_j x_j<=1}.
```

Não há opt-out, proposta nula ou sentinela. A proposta de `H` conta como seu voto favorável. Os fracos observam `y`, mas não `theta` nem os votos alheios, e votam simultânea e secretamente. Sob unanimidade, passa se e somente se todos votam `sim`. Se passa, o payoff na data `A` é o vetor proposto, independentemente do voto individual. Se qualquer fraco vota `não`, a proposta rejeita e o jogo entra em exatamente um membro literal de `C_U`, com uma única aplicação externa de `beta` para trazer o payoff nativo de `C_U` à data `A`.

O estado público suficiente da continuação é `(U,C,mu)`. Por M, a escolha `hat{kappa}_U(U,C,mu)` não pode depender de proposta, identidade ou vetor de votos; por S, escolhe um membro literal anônimo da continuação; por B, há um único `nu_off` em todos os pontos não disciplinados. Um desvio de voto fraco não muda o posterior sobre `theta`, de modo que toda proposta — inclusive uma prescrita para aprovação — precisa ter continuação literal depois do desvio unilateral que a rejeita.

### 3.2 Interface reduzida de `C_U` e desconto

Com

```text
nu_star=(o_1-o_0)/(1-o_0),
ell=beta o_0,
h=beta o_1,
```

o domínio consumível de `C_U` é exatamente

```text
D_C={0} union (nu_star,1].
```

Não existe membro de continuação em `(0,nu_star]`; nenhum payoff convencional pode ocupar essa célula. Aplicando `beta` exatamente uma vez ao importar `C_U`, obtêm-se

```text
d_0=beta ell=beta^2 o_0,
d=beta h=beta^2 o_1,
a=beta(1-ell)/m,
b=beta(1-h)/m,
z_L=1-ma=1-beta+d_0,
z_H=1-mb=1-beta+d,
Delta=z_L-d=1-beta-beta^2(o_1-o_0).
```

Valem `0<b<a`, `d_0<d<z_H` e `z_L<z_H`. Na continuação de posterior zero, o payoff fraco realizado é `a` se `theta=0` e **zero** se `theta=1`; `a` é o preço esperado de voto sob posterior zero, não o payoff contrafactual do tipo impossível. Em posterior alto, cada fraco recebe `b` em ambos os tipos.

### 3.3 Bayes local, votos e objeto reduzido

Para medidas Borel de proposta `sigma_0,sigma_1`, a medida pública é

```text
mbar=(1-nu)sigma_0+nu sigma_1.
```

Em todo ponto disciplinado — toda vizinhança relativa tem massa pública positiva — o posterior é o limite local de Bayes e deve existir pointwise, inclusive em pontos de massa pontual zero. Ele precisa pertencer a `D_C`. Num ponto não disciplinado, o posterior é o único `nu_off in D_C`, com `nu_off=0` em `nu=0` e `nu_off=1` em `nu=1`.

Como um fraco é pivotal exatamente quando todos os demais votam `sim`, sua regra pura é

```text
sim iff x_j>=a,  se mu=0;
sim iff x_j>=b,  se mu>nu_star.
```

`T^Y` inclui a igualdade. Assim, os conjuntos de aprovação são fechados e os máximos aceitos de `H` são atingidos, não meros supremos:

```text
y_L=(z_L,a,...,a),
y_H=(z_H,b,...,b).
```

Ambos pertencem ao simplex primitivo e esgotam a pie. O alias `y_bar=y_H` não cria sentinela nem amplia `Y`.

Ao rejeitar, `H1` recebe sempre `d`; `H0` recebe `d_0` em posterior zero e `d` em posterior alto. Portanto, sob crença zero, o maior desvio de `H1` vale `max{z_L,d}`; sob crença alta, o maior acordo vale `z_H>d`.

### 3.4 Imitação bilateral e dicotomia de Bayes

No interior, todo sinal usado por `H1` tem posterior alto. Ao imitá-lo, `H0` recebe a mesma parcela se houver acordo e o mesmo `d` se houver rejeição, logo `V_0>=V_1`. Reciprocamente, num sinal alto de `H0`, `H1` obtém o mesmo payoff ao imitar. Um sinal de posterior zero usado por `H0` não pode rejeitar: `H1` garante `d`, `d_0<d`, e a primeira desigualdade já exige que `H0` não use uma ação estritamente inferior. Logo esse sinal passa e `H1` pode imitá-lo, dando `V_1>=V_0`. Conclui-se

```text
V_0=V_1=V
```

em todo PBE com `0<nu<1`, sem impor pooling ou simetria comportamental.

Seja `lambda_0` a massa pública total em posterior zero. Se `lambda_0>0`, apenas `H0` pode gerar essa massa; seu sinal zero precisa passar. Feasibility limita `V<=z_L`, enquanto o desvio para o máximo de crença zero dá `V>=z_L`. Se `nu_off` fosse alto, `y_H` daria desvio estrito. Logo

```text
nu_off=0,
Delta>=0,
V=z_L,
sigma_0({y_L})>0,
sigma_1({y_L})=0,
```

e `y_L` é o único sinal de posterior zero usado com massa positiva. Se `lambda_0=0`, os posteriores são estritamente maiores que `nu_star` quase certamente; Bayes plausibility, `E_mbar[mu]=nu`, implica `nu>nu_star`.

### 3.5 Correspondência estratégica reconstruída

- **`AU-MSB-L`:** `0<nu<1`, `Delta>=0`, `nu_off=0`, átomo exclusivo de `H0` em `y_L`, posterior alto quase certamente fora dele, payoff comum `z_L`. Sinais altos aceitos têm `z=z_L`; rejeição no suporte só pode ocorrer em `Delta=0`, quando `d=z_L`. As condições pointwise do gerador limitam ambos os tipos em todo o simplex, inclusive pontos disciplinados de massa zero e todos os pontos não disciplinados.
- **`AU-MSB-H0`:** `nu_star<nu<1`, `nu_off=0`, `V in [max{z_L,d},z_H]`. Todo sinal aceito usado tem `z=V` e paga pelo menos `b` a cada fraco; sinais rejeitados só podem entrar quando `V=d`. Pooling em `y(V)=(V,(1-V)/m,...,(1-V)/m)` testemunha cada valor do intervalo.
- **`AU-MSB-HB`:** `nu_star<nu<1`, `nu_off>nu_star`. `y_H` é um desvio aceito com payoff `z_H` em todo ponto de crença alta; feasibility dá a desigualdade oposta. O único resultado corrente é pooling em `y_H`, com payoff `z_H`, embora a multiplicidade literal interna de `C_U` permaneça no binder.
- **Não existência:** se `0<nu<=nu_star` e `Delta<0`, Bayes exige `lambda_0>0`, mas essa massa exigiria `z_L>=d`, contradição.
- **Endpoint `nu=0`:** crenças são zero em toda proposta; `H0` escolhe unicamente `y_L`. O tipo contrafactual `H1` escolhe `y_L` se `Delta>0`, qualquer medida em `{y_L} union R_L` se `Delta=0`, e qualquer medida em `R_L={y:min_j x_j<a}` se `Delta<0`.
- **Endpoint `nu=1`:** crenças são um em toda proposta e ambos os tipos escolhem unicamente `y_H`.

Não encontrei quebra nos máximos fechados, no transporte temporal, na classificação de acordo/atraso, nos endpoints ou na exaustão por `lambda_0`.

### 3.6 Bindings e mensurabilidade

O objeto atômico preserva conjuntamente `sigma_0,sigma_1`, o mapa `mu`, `nu_off`, o seletor Borel literal `hat{kappa}_U`, todos os votos, a lei terminal `Q` e `Gamma_0,Gamma_1`. Isso impede recombinar marginais de assessments diferentes. `Y` é compacto Borel; as estratégias são medidas Borel; os limiares de voto definem conjuntos Borel fechados; e a ação do grupo finito de permutações fracas é Borel.

A existência de um binder de continuação Borel não exige escolha não mensurável: em `mu=0` há o membro literal único; em `mu>nu_star` pode-se fixar o membro pooling anônimo de `C_U` e, nas crenças internas livres desse registro, escolher uniformemente o valor admissível `1`. As regiões internas são dadas por desigualdades Borel, e a junção por `{0}` e `(nu_star,1]` é Borel. Portanto não encontrei lacuna de existência ou measurability em `AUX-MSB-019`.

Essa conclusão não salva a regra de **equivalência** adotada pelo candidato: a ação comum é mensurável e define órbitas, mas escolher essas órbitas como a camada formal exata de `A_U` é uma decisão substantiva distinta. Esse é o finding abaixo.

## 4. Checklist formal

| Item | Resultado | Base da conclusão |
|---|---|---|
| Forma extensiva e conjuntos de informação | Conforme | Proposta pública; tipo privado; votos selados simultâneos; nenhuma reação de `H` ao vetor ex post |
| Grafo e indução reversa | Conforme | DAG acíclico; `C_U` fechado antes de resolver proposta/voto em `A` |
| Dependência única e literal de `C_U` | Conforme | Hash correto; nenhuma célula `none` completada; binder literal retido |
| Um único `beta` externo | Conforme | `d_0,d,a,b` têm exatamente uma passagem de `C_U` para `A` |
| Posterior proibido `(0,nu_star]` | Conforme | Qualquer desvio unilateral de voto que rejeita exigiria continuação inexistente |
| Bayes local pointwise | Conforme | Exigido em todo ponto disciplinado, inclusive massa pontual zero |
| `nu_off` constante e endpoints | Conforme | Um por assessment; zero/um nos priors degenerados |
| Voto as-if-pivotal e `T^Y` | Conforme | Threshold próprio; igualdade aceita; fronteiras fechadas |
| `y_bar`, máximos e supremos | Conforme | `y_bar=y_H in Y`; máximos atingidos; nenhum apelo indevido a semicontinuidade global |
| Imitação bilateral dos tipos | Conforme | Equalização interior provada nas duas direções, inclusive rejeição |
| Todos os pontos do simplex | Conforme | Caps de desvio pointwise no gerador; máximos explícitos para cada regime de crença |
| Sinais shared, pooling e semipooling | Conforme | Bayes nos átomos compartilhados; correlação tipo-sinal mantida no binder |
| Sinais atomless e pontos de massa zero | Conforme | Medidas comuns contínuas sobre faces de `K_H(V)` dão testemunhas; regra local permanece pointwise |
| Separação e payoffs assimétricos | Conforme | Separação por vetor `x` sobrevive; níveis distintos de `z` não; coordenadas por tipo/identidade retidas |
| Atraso e `Delta=0` | Conforme | Rejeição no suporte somente em `V=d`; em `L`, isso equivale a `Delta=0` |
| Endpoints e payoff fraco `theta=1,mu=0` | Conforme | Tipo impossível retido; payoff fraco realizado igual a zero, não `a` |
| Binder M/S e ausência de recombinação | Conforme | Um mapa Borel público e comum aos tipos; `Gamma_0,Gamma_1` permanecem conjuntos |
| Uma permutação comum no perfil inteiro | Matematicamente bem definida | A ação diagonal é coerente e mensurável |
| Escolha da assinatura exata para `A_U` | **Não conforme** | Contradiz o colapso de misturas aprovado e usa, sem decisão para `A_U`, a arquitetura exata introduzida somente para `A_M` |
| Execução de `AC`/`AR` | Conforme ao limite | Não houve derivação ou cálculo; porém o default downstream já escolhido é atingido pelo finding |
| Verificador R | Conforme como evidência finita | `1095/0`; não tratado como prova |

## 5. Auditoria claim by claim do ledger atual

“Sustentado” abaixo significa que o claim formal sobre `A_U` sobreviveu aos contraexemplos tentados; não é aprovação terminal do pacote.

| Claim | Avaliação independente | Observação |
|---|---|---|
| `AUX-MSB-001` | Sustentado | Dependência única de `C_U`; nenhuma rederivação detectada |
| `AUX-MSB-002` | Sustentado | Domínio consumível exatamente `{0} union (nu_star,1]` |
| `AUX-MSB-003` | Sustentado | Desvio de voto rejeitante exige continuação literal mesmo fora do caminho |
| `AUX-MSB-004` | Sustentado | Transporte de datas e aplicação única de `beta` corretos |
| `AUX-MSB-005` | Sustentado | Thresholds `a,b`, voto puro e `T^Y` corretos |
| `AUX-MSB-006` | Sustentado | `y_L,y_H` são factíveis, únicos nos respectivos máximos e atingem a fronteira |
| `AUX-MSB-007` | Sustentado | Imitação bilateral equaliza payoffs de `H` no interior |
| `AUX-MSB-008` | Sustentado | Massa positiva em posterior zero força `nu_off=0`, `Delta>=0`, `V=z_L` e o átomo `y_L` |
| `AUX-MSB-009` | Sustentado | Sem massa em zero, plausibilidade de Bayes força `nu>nu_star` |
| `AUX-MSB-010` | Sustentado | Não existência em prior baixo e `Delta<0` |
| `AUX-MSB-011` | Sustentado | Gerador `L` é necessário/suficiente no nível de assessments, com condições pointwise mantidas |
| `AUX-MSB-012` | Sustentado | `H0` cobre exatamente o intervalo declarado para `nu_off=0` |
| `AUX-MSB-013` | Sustentado | `nu_off` alto força pooling eficiente único em `y_H` |
| `AUX-MSB-014` | Sustentado | Família com massa zero também existe em priors altos quando `Delta>=0` |
| `AUX-MSB-015` | Sustentado no nível de assessments | A dicotomia `lambda_0>0`/`=0` exaure os perfis; a classificação de **assinaturas** é afetada por `I-1` |
| `AUX-MSB-016` | Sustentado | Rejeição no suporte somente quando `V=d` |
| `AUX-MSB-017` | Sustentado | Separação aceita exige o mesmo `z`; distinção por vetor fraco continua possível |
| `AUX-MSB-018` | Sustentado | Bayes local e admissibilidade não foram enfraquecidos para “quase certamente” |
| `AUX-MSB-019` | Sustentado | Há seleção Borel literal anônima; o binder permanece público e comum aos tipos |
| `AUX-MSB-020` | Sustentado | Payoffs por tipo/identidade precedem a média ex ante |
| `AUX-MSB-021` | Sustentado | Endpoint zero e correspondência contrafactual por sinal de `Delta` corretos |
| `AUX-MSB-022` | Sustentado | Endpoint um: crença um em toda parte e `y_H` único para ambos |
| `AUX-MSB-023` | **Refutado (`I-1`)** | A órbita exata do binder não implementa a regra aprovada que colapsa misturas sobre relabelings; a exceção autorizadora existe apenas para `A_M` |
| `AUX-MSB-024` | Pendente e afetado por `I-1` | É correto não declarar suficiência para `AC`, mas não está autorizado fixar o binder/órbita exato de `A_U` como default downstream |
| `AUX-MSB-025` | Sustentado | `Gamma_0,Gamma_1` preservam objeto conjunto; nenhum produto de marginais foi usado |
| `AUX-MSB-026` | Sustentado | O texto limita corretamente a força do verificador |
| `AUX-MSB-027` | Sustentado como estado de ciclo de vida | O candidato continua pendente e não recebe aprovação neste parecer |
| `AUX-MSB-028` | Sustentado | Corrige explicitamente o payoff fraco contrafactual `theta=1,mu=0` para zero |

### Claims históricos

Minha leitura independente dos bytes históricos produz o seguinte bloco de correspondência:

| Claims históricos | Resultado sob M/S/B |
|---|---|
| `A-U-CLM-001`–`006`, `009`–`010`, `012`, `014` | Núcleo correto e preservado após renomear `w_0,w_1,p_0,p_1,d_1` como `a,b,z_L,z_H,d` |
| `A-U-CLM-007`, `008`, `015` | Payoffs e regiões sobrevivem, mas os geradores antigos são incompletos para M/S/B |
| `A-U-CLM-011` | Superado como gerador corrente: permitia liberdade por história/ponto incompatível com M e B |
| `A-U-CLM-013` | A atomicidade sobrevive, mas a antiga coordenada fraca em `theta=1,mu=0` estava errada/não tipada; `AUX-MSB-028` a corrige |
| `A-U-CLM-016` | Evidência mecânica histórica somente; não valida o contrato atual |

Não encontrei transplante de fórmulas de `A_M` para os thresholds, payoffs ou famílias estratégicas de `A_U`. O transplante não autorizado está na arquitetura da assinatura, não na solução backward-induction do jogo.

## 6. Stress-tests adversariais e contraexemplos tentados

### 6.1 Imitação bilateral por família e simplex inteiro

- Em `L`, tentei `H0` imitando cada sinal alto aceito e rejeitado e `H1` imitando `y_L`. O primeiro não ganha porque todos os sinais usados entregam `z_L` ou, no knife-edge, `d=z_L`; o segundo recebe `z_L`. Um ponto arbitrário do simplex não supera `z_L` pelas condições pointwise 5–6, e os extremos explícitos cobrem os dois regimes de crença.
- Em `H0`, tentei propostas aceitas de crença zero, propostas rejeitadas em ambas as células e propostas altas com parcela maior. O maior payoff off-path de crença zero é `max{z_L,d}` e o maior acordo de crença alta é `z_H`; exatamente esses limites geram o intervalo de `V`. Para `V>d`, qualquer rejeição seria estritamente pior; para `V=d`, acordo e atraso podem misturar.
- Em `HB`, tentei impedir `y_H` transformando-o em ponto disciplinado de massa zero. Isso não ajuda: se todo posterior on-path é maior que `nu_star`, a média local em qualquer vizinhança com massa não pode convergir a zero; quando disciplinado, `y_H` continua com crença alta e passa, e quando não disciplinado recebe o `nu_off` alto. Assim `z_H` força o payoff e a proposta.
- Nos endpoints, tentei desvios do tipo de probabilidade zero. O suporte do prior fixa as crenças em zero ou um; a correspondência por `sign(Delta)` em `nu=0` e a unicidade de `y_H` em `nu=1` continuam sequencialmente racionais.

### 6.2 Shared, atomless e massa pontual zero

Um átomo compartilhado por ambos os tipos tem posterior dado por Bayes e, se consumível, precisa ser alto. Em `H0`, ambos os tipos podem usar a mesma medida atomless sobre uma face não degenerada de

```text
K_H(V)={y:z=V, min_j x_j>=b};
```

o posterior local é `nu` em todo ponto do suporte, inclusive endpoints de massa pontual zero. Em `L`, pode-se manter o átomo exclusivo de `H0` em `y_L` e escolher massas relativas contínuas no restante de `K_L` de modo que o posterior comum fora do átomo seja maior que `nu_star`. Esses testes confirmam que o texto não confunde “átomo zero” com “ponto não disciplinado”.

### 6.3 Posterior proibido, `nu_off` e continuação literal

Tentei sustentar aprovação em uma proposta com posterior em `(0,nu_star]` alegando que a continuação não é alcançada. Um único fraco pode votar `não` sem sinalizar informação, e a continuação inexistente seria então necessária. O assessment é inadmissível. Também tentei crenças off-path distintas por proposta; B as proíbe e os family generators usam um único `nu_off`. Nenhum payoff sentinela apareceu.

### 6.4 Separação, assimetria, atraso e correlação dos planos

Imitação elimina separating por níveis diferentes da parcela `z`, mas não por vetores fracos diferentes com o mesmo `z`. O binder guarda `sigma_0` e `sigma_1` juntos e preserva posterior, votos, continuação e lei terminal por tipo, de modo que não encontrei recombinação espúria de marginais. Atraso é possível somente na igualdade `V=d`; em `L`, isso requer exatamente `Delta=0`. O payoff fraco contrafactual no ramo rejeitado de `mu=0,theta=1` permanece zero.

### 6.5 Teste numérico `P/Q` que refuta a assinatura escolhida

Considere

```text
m=2, beta=0.9, o_0=0.2, o_1=0.5, nu=0.6.
```

Então

```text
nu_star=0.375,
a=0.369,
b=0.2475,
d=0.405,
z_L=0.262,
z_H=0.505,
Delta=-0.143.
```

Estamos na família `H0`. Fixe `nu_off=0`, `V=0.45` e as propostas permutadas

```text
P=(0.45,0.3025,0.2475),
Q=(0.45,0.2475,0.3025).
```

Cada proposta esgota a pie e paga pelo menos `b` a ambos os fracos. Se os dois tipos fazem pooling puro em `P`, o posterior em `P` é `nu=0.6>nu_star`, todos votam `sim` e cada tipo recebe `0.45`. Fora do caminho, a crença é zero e o melhor desvio vale

```text
max{z_L,d}=0.405<0.45.
```

Logo esse é um PBE. O pooling puro em `Q` também é PBE. Mais ainda, para qualquer `p in [0,1]`, se ambos os tipos usam a mesma mistura

```text
p delta_P+(1-p)delta_Q,
```

o posterior é `0.6` em cada átomo usado, as duas propostas passam, o payoff é `0.45` e os mesmos caps eliminam todo desvio. Portanto toda a família de pesos é PBE, sem alteração de revelação ou de `nu_off`.

A órbita exata adotada pelo candidato identifica `p` apenas com `1-p`. Assim, por exemplo, a mistura `(0.9,0.1)` não está na órbita da mistura `(0.5,0.5)`, e um pooling puro não está na órbita de sua mistura uniforme: a cardinalidade e os pesos do suporte são diferentes. Entretanto, a clarificação aprovada diz expressamente que misturas sobre a órbita pertencem à mesma classe e que perfis que diferem apenas por identidades ou misturas sobre identidades formam uma classe. A exceção para separating por identidade não se aplica: `P`, `Q` e todas as misturas acima têm o mesmo posterior alto em cada sinal alcançado e não revelam o tipo.

Esse exemplo também distingue corretamente suporte de mensagens, revelação e o vínculo entre os planos dos tipos. Ele não depende de Reynolds, não combina marginais de assessments distintos e não usa `AC`.

## 7. Findings

### `I-1` — **important** — A assinatura de `A_U` adota sem autorização a camada exata criada apenas para `A_M` e contradiz o colapso aprovado de misturas sobre relabelings

**Localização exata:**

- `model_redesign/agenda_extension_A_U_msb_results.md`, linhas 95–101: declara que as “classes exatas” são órbitas do binder inteiro e fixa essa camada como consumo de `AC`;
- mesmo arquivo, linhas 335–337: declara que misturas sobre relabelings não são automaticamente o mesmo assessment;
- mesmo arquivo, linhas 354–365: exporta binder/órbita exata e impõe esse default downstream;
- `model_redesign/agenda_extension_A_U_msb_interface.json`, linhas 87–91: codifica a equivalência como órbita exata do binder inteiro;
- `model_redesign/agenda_extension_A_U_msb_claim_ledger.tsv`, linha 24, `AUX-MSB-023`: marca essa regra como provada e afirma que nenhuma regra exclusiva de `A_M` foi importada;
- mesmo ledger, linha 25, `AUX-MSB-024`: embora corretamente `pending`, já pressupõe o binder/órbita exato como exportação de `A_U`;
- `quality_reports/2026-08-29_A_U_msb_historical_comparison.md`, linhas 76–79: repete que a decisão de `A_M` não foi imposta, ao mesmo tempo que preserva sua arquitetura exata.

**Norma afetada:**

- `quality_reports/plans/2026-08-29_clarificacao_assinatura_anonimato.md`, linhas 59–73 e 86–95, determina que a assinatura seja anônima, que misturas sobre a órbita pertençam à mesma classe e que perfis que diferem apenas por misturas de identidades formem uma classe;
- `quality_reports/plans/2026-08-29_decisao_assinatura_duas_camadas_A_M.md`, linhas 1–11 e 32–54, cria a órbita diagonal exata como reparo explicitamente circunscrito a `A_M`. Ela não altera `A_U`.

**Claim afetado:** `AUX-MSB-023` é falso sob a precedência vigente. A parte de `AUX-MSB-024` que evita alegar fatorização para `AC` é prudente, mas o default exato nela pressuposto não está autorizado. Qualquer contagem/classificação de classes de assinatura de `A_U`, bem como o formato final de sua interface downstream, permanece sem fundamento autoral. Os teoremas de existência, payoff e exaustão de assessments não são refutados por este finding.

**Argumento/contraexemplo:** o exemplo `P/Q` da Seção 6.5 fornece PBEs puros e todas as misturas comuns entre seus relabelings. A regra do candidato separa `p=0.9` de `p=0.5`; a clarificação vigente manda colocá-los na mesma classe. Não há diferença de revelação que acione a exceção da própria clarificação. Além disso, a órbita do binder inteiro distingue multiplicidade off-path que nem sequer aparece na lista original de coordenadas da assinatura. Portanto não se trata apenas de uma notação mais conservadora: muda a relação de equivalência e o objeto entregue ao consumidor.

**Reparo mínimo forçado:** não existe patch técnico único legitimado pelos textos atuais. O precedente de `A_M` mostra precisamente que a regra antiga de colapso e a órbita diagonal exata são escolhas substantivas distintas. É necessária uma decisão autoral específica para `A_U`: ou (a) estender explicitamente a arquitetura de duas camadas e então definir/provar `Sig_ex_U` e `Sum_econ_U`, inclusive mensurabilidade, completude e fatorizações permitidas; ou (b) manter o quociente anônimo aprovado e reconstruir uma equivalência coerente que implemente o colapso de misturas sem apagar diferenças de revelação. Depois dessa decisão, contrato, resultados, interface, ledger, comparação histórica e manifesto precisam ser recortados conjuntamente e submetidos a nova revisão independente. Não é lícito escolher uma dessas alternativas dentro deste parecer.

## 8. Limites e escopo

- Este parecer cobre somente os bytes do snapshot e manifesto identificados acima e o relatório não rastreado permitido por este mandato.
- Não revisei `AC`, `AR`, manuscrito, efeitos comparativos entre instituições ou qualquer autorização de consumo downstream.
- Não qualifico `A_U` como aprovado, congelado ou pronto para integração.
- O verificador R é evidência de falsificação finita, não prova formal ou exaustão computacional do simplex.
- Fora do conflito de assinatura, não identifiquei finding critical, important ou minor nos thresholds, payoffs, Bayes local, famílias, endpoints, atraso, mensurabilidade do binder literal ou claims históricos já corrigidos. Não transformei observações editoriais sem consequência formal em findings.

## 9. Veredito

A reconstrução estratégica de `A_U` sob unanimidade e M/S/B sobreviveu aos stress-tests: a forma extensiva, o consumo literal de `C_U`, o desconto, Bayes local, thresholds, imitação bilateral, famílias, endpoints, atraso e correspondência de payoffs são formalmente sustentados. Contudo, o pacote não pode passar porque sua regra de assinatura contradiz uma decisão geral ainda vigente e só seria justificável pela decisão posterior expressamente limitada a `A_M`. Isso é um defeito importante de escopo normativo e interface, com contraexemplo P/Q dentro da própria família `H0`.

FINAL_STATUS: FAIL

COUNTS: C/I/M = 0/1/0
