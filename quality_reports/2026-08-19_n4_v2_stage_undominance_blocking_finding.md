# Finding bloqueante — N4 v2 e stage-undominated voting

**Data:** 2026-08-19

**Status:** decisão autoral necessária; nenhum reparo autorizado

**Candidato preservado:** `sha256:67dc008a42db6d6c7f7c12eb3abf9fd7eb4a273a73ca0ec6f4a1ece180320c0b`
**Commit do candidato:** `889c5ffcc8cc6bc5c903ec5197e418fed407c758`

## 1. Gate independente

Exatamente dois revisores read-only examinaram os mesmos bytes:

- `formal_design`: **FAIL — 0 critical / 2 major / 0 minor / 0 epistemic**;
- `game_theory`: **FAIL — 0 critical / 1 major / 0 minor / 0 epistemic**.

Nenhum revisor editou arquivos. O hash inicial e final coincidiu nos dois
pareceres. N4 permanece `pending/unfrozen`; N6 e N7 não podem consumir o
candidato.

## 2. Finding central

A correção anteriormente autorizada — payoff realizado `(a,0)` no registro N2
low-only — foi transportada corretamente. O novo erro ocorre na etapa seguinte:
o candidato verifica a indiferença do weak voter no perfil de votos efetivo,
mas não compara sua ação em **todos** os vetores simultâneos dos demais voters,
como P6 exige.

`T^Y` só seleciona `yes` quando as duas ações são payoff-idênticas em todo o
problema de votação relevante. Uma igualdade no perfil efetivo não reintroduz
`yes` se `no` for estritamente melhor em outra linha; nesse caso `no` pode
dominar fracamente `yes`.

### Contraprova `m=3`

Para `beta=.9`, `o0=.2`, `o1=.6`, `nu=.1`, obtêm-se:

```text
ell=.18, h=.54, a=.24, b=.12, D=.216, P=.22.
```

Na oferta candidata `(h,b,b,P)`, uma proposta zero-probabilidade pode receber
continuação pooling nas falhas com `H=yes` e continuação low-only quando
`H=no` e há weak veto. Com ambos os weak voters dizendo `no` e ambos os tipos
de H dizendo `yes`, cada weak voter enfrenta:

| H | outro weak | payoff de `yes` | payoff de `no` |
|---|---:|---:|---:|
| yes | yes | .12 | .12 |
| yes | no | .12 | .12 |
| no | yes | .12 | .24 |
| no | no | .24 | .24 |

Assim, `no` domina fracamente `yes`, com uma linha estrita. O ballot é
sequencialmente racional; H0 prefere `yes` e H1 usa `T^Y=yes`. A proposta falha
para pooling e o proponente recebe `b=.12`, abaixo do suposto security
`S_m=.216`. Isso refuta a lower bound de `S_m=min{P,D}` e a proibição de
multi-veto na fronteira e na região alta.

### Contraprova `m=2`

Para `beta=.5`, `o0=.2`, `o1=.6`, `nu=.5`, obtêm-se:

```text
ell=.1, h=.3, a=.2, b=.1, D=.1, F=.5.
```

Na oferta `(h,a,F)`, faça o único weak responder dizer `no` e ambos os tipos de
H dizerem `yes`. Associe low-only aos vetores com `W=no` e pooling ao vetor
`(W=yes,H=no)`. Então:

| H | payoff de `yes` | payoff de `no` |
|---|---:|---:|
| yes | .2 | .2 |
| no | .1 | .2 |

Novamente `no` domina fracamente `yes`. A oferta falha e o proponente recebe
`D=.1`, não `F=.5`. Portanto, `(h,a,F)` não força aprovação e o componente `F`
de `S_2=max{F,K,M}` não está provado.

## 3. Finding adicional localizado

O parecer `game_theory` identificou também que o construtor `H_veto` para
`m=2`, `nu>=nu_star`, admite `x<b`. Nessa região, o piso subjetivo de toda
continuação N2 é `b`; logo `no` domina fracamente `yes`. O construtor precisaria
ao menos de `x>=b` nessa região.

Esse bound é uma consequência válida e útil, mas **não constitui reparo
suficiente**: o parecer formal mostrou que security, pooling caps, endpoints e
famílias multi-veto foram derivados de uma aplicação mais ampla e incorreta de
P6.

## 4. Alcance

Não é seguro apagar `F`, substituir uma única fórmula ou acrescentar somente o
bound do `H_veto`. Precisam ser rederivados desde P6 e N2:

- garantias exatas do proponente para `m=2` e `m>=3`;
- mínimo versus ínfimo e máximo versus supremo;
- pooling caps, residual rules e endpoints;
- existência e parametrização de delay e multi-veto;
- low-only, misturas e multiplicidade por identidade;
- payoffs de H e todos os objetos exportados para N6/N7.

Os claims N4 v2 003–009 e 018 ficam sem suporte. O candidato hashado e seus
dois pareceres devem permanecer como proveniência reprovada.

## 5. Falso PASS do verifier

O verifier sela os bytes do objeto e reusa como oracle as fórmulas do próprio
candidato. As mutações de folhas demonstram identidade, não validade do jogo;
os testes negativos afirmam booleanos previamente construídos e não chamam um
validador que enumere ballots.

Em mutação read-only em memória, o parecer formal conseguiu alterar
simultaneamente o status de multi-veto e o payoff do proponente sem que o
subset chamado de semântico detectasse a corrupção quando o pin foi
neutralizado.

Depois da rederivação, o gate precisa de um oracle independente que:

1. enumere os vetores completos de votos simultâneos;
2. associe as continuações N2 admissíveis por vetor público;
3. aplique melhor resposta, stage-undominance e `T^Y` na ordem contratual;
4. confira payoffs realizados por tipo e payoff ex ante do proponente;
5. teste interior, fronteiras, endpoints e contraprovas desta rodada.

## 6. Leituras e decisão necessária

### Opção A — recomendada

Autorizar uma nova rederivação fria de N4, mantendo integralmente N2,
primitivas, informação, payoffs, PBE, stage-undominated voting, `T^Y`, schema e
topologia. A rederivação deve começar pelo problema vetorial de P6, sem
preservar nenhuma fórmula de security por objetivo, e construir o oracle
independente acima antes de republicar a interface.

Consequência: as fórmulas e famílias sobrevivem somente se forem novamente
provadas; o novo hash retorna aos mesmos dois papéis read-only. N4 continua
pending até dois `PASS 0/0/0`.

### Opção B — não recomendada e atualmente não autorizada

Alterar P6, a interação com `T^Y` ou restringir as crenças off-path para
preservar as fórmulas atuais.

Consequência: isso muda conceito/protocolo ou espaço de assessments, reabre o
design do jogo e o Gate0 e invalida dependências. A autorização corrente
proíbe essa leitura.

Pela Seção 11.1, a Opção A também exige autorização expressa: o finding altera
a correspondência e não possui reparo local único. Até essa decisão, nenhum
artefato N4, DAG, lifecycle, N6 ou N7 deve ser alterado.

## 7. Escopo preservado

- N1 e N2 continuam byte a byte frozen nos hashes correntes.
- N3 permanece separadamente pending pelos findings de sua própria rodada.
- O candidato Phase A permanece no hash aprovado.
- A tag protegida permaneceu intacta.
- Nenhum PDF foi produzido.
- Goal 5, manuscritos, figuras e `beta=1` continuam fora do escopo.
