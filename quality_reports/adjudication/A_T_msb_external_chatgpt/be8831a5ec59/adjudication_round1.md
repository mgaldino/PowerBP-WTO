# Adjudicação da consulta técnica externa não formal — `A_T` M/S/B

**Adjudication ID:** `a-t-msb-external-chatgpt:ca3248fb8ef6:round1`  
**Data/hora:** `2026-08-30T20:05:33-03:00`  
**Modo:** read-only quanto aos artefatos matemáticos de `A_T`  
**Branch:** `codex/agenda-total-effect`  
**Candidato matemático:** `7033063a4b737cc0acc087ac71261e25805c689d`  
**Manifesto:** `quality_reports/2026-08-30_AT_msb_candidate_manifest.sha256`  
**SHA-256 do manifesto:** `ca3248fb8ef63a2dcc008b5e30ffda1a8e170806ea172969e069daef1e9629cd`

## 1. Disposição executiva

A consulta externa confirma, condicionalmente aos inputs congelados, todos os
resultados matemáticos de `A_T`: desenho `2 x 2`, datas, `T=D+I`, fórmulas de
`D_U`, `D_M` e `DeltaD`, classificação completa de `T_U`, representação
set-valued de `T_M`, comparação institucional e contraste diagonal `Q`.

Não há defeito matemático que exija reabrir `A_R`, `N7` ou as correspondências
de agenda. Há quatro precisões locais de exposição:

1. repetir em `A_T` o lema já provado na fonte `A_R`, `tau_M>1/m`;
2. explicitar que `tau_M` pode ficar fora do domínio `o in (0,1)`;
3. anunciar a descontinuidade em `o=1/m`;
4. tornar literais as qualificações membro a membro e a definição de `none`
   como correspondência vazia no conceito mantido.

O parecer também deriva seis resultados adicionais corretos. Eles não são
reparos: fortalecem o conteúdo formal e permanecem reservados à decisão do
autor.

## 2. Identidade e integridade

O parecer foi preservado byte a byte em
`quality_reports/external_reviews/2026-08-30_consulta_tecnica_externa_nao_formal_chatgpt_AT_msb.md`,
SHA-256
`be8831a5ec593481032b93079d19eea6ed0fcb59bcf96139a3d69e30106a303a`.

O pacote efetivamente enviado tem SHA-256
`a8639e863fa57e6510c8cfa5cc8ee9ff9731638909452040c0c92b96f6d21d81`.
O parecer identifica seu nome, sua arquitetura e seus resultados sem sinal de
truncamento. O manifesto matemático corrente passou `11/11 OK` durante a
adjudicação. Não existe argument-contract JSON compatível com o validador; o
registro estruturado usa `contract.required=false`.

## 3. Findings normalizados

| ID | Finding | Estado | Disposição |
|---|---|---|---|
| `WEB-AT-F001` | Falta provar `tau_M>1/m` dentro de T3 | `PARTIAL` | O lema já está na fonte congelada `A_R`; repeti-lo torna `A_T` autocontido |
| `WEB-AT-F002` | `tau_M` pode ficar fora de `(0,1)` | `CONFIRMED` | Acrescentar qualificação de domínio |
| `WEB-AT-F003` | Os ramos de `DeltaD` devem ser disjuntos | `REFUTED` | O overlap em `tau_M` é deliberado e o texto prova coincidência; mudança apenas editorial |
| `WEB-AT-F004` | Há descontinuidade em `o=1/m` | `CONFIRMED` | Tornar explícita; fórmulas atuais continuam corretas |
| `WEB-AT-F005` | O `iff` institucional precisa dizer membro a membro | `PARTIAL` | O contexto já usa tuplas completas, mas a frase local pode ser mais literal |
| `WEB-AT-F006` | Usar notação caligráfica para correspondências | `REFUTED` | A natureza set-valued já está explícita; preferência tipográfica opcional |
| `WEB-AT-F007` | Definir `none` como correspondência vazia em PBE puro M/S/B | `CONFIRMED` | Precisão de escopo segura |
| `WEB-AT-F008` | Na família baixa, o tratamento também pode ser `none` | `PARTIAL` | O controle é sempre vazio; esclarecer que o tratamento pode existir ou não |
| `WEB-AT-F009` | Contrastar com controle redatado para `A` | `REFUTED` | O contrato já distingue esse estimando e o exclui deliberadamente |
| `WEB-AT-F010` | Ordenação completa dos limiares | `CONFIRMED` | Corolário novo; decisão autoral |
| `WEB-AT-F011` | Classificação global do sinal de `DeltaD` | `CONFIRMED` | Corolário novo; decisão autoral |
| `WEB-AT-F012` | Positividade uniforme de `T_U` iff `Delta_U>0` | `CONFIRMED` | Corolário novo; decisão autoral |
| `WEB-AT-F013` | Imagem ex ante completa de `T_U` | `CONFIRMED` | Corolário novo; decisão autoral |
| `WEB-AT-F014` | Critérios robustos sem seleção | `CONFIRMED` | Corolário novo; decisão autoral |
| `WEB-AT-F015` | Identidade `Q=T-RI^A` | `CONFIRMED` | Corolário novo; decisão autoral |

## 4. Evidência e raciocínio

### `WEB-AT-F001` — `PARTIAL`

`A_T` declara `D_M(o)>0` iff `o<tau_M`, mas não repete a ordenação dos ramos.
A fonte congelada `A_R` já prova literalmente `tau_M>1/m`, usando
`q=k+1<=m` e `beta<1`. Portanto não há lacuna na cadeia de dependências, mas há
uma omissão local de autocontenção. O reparo seguro é repetir o lema e sua prova
em uma linha.

### `WEB-AT-F002` — `CONFIRMED`

Vale

```text
tau_M<1 iff beta>m/(m+k).
```

Se a condição falha, o ramo `o>=tau_M` é vazio no domínio `o in (0,1)` e
`D_M>0` para todo `o` admissível. O teorema atual permanece verdadeiro por
vacuidadade do ramo, mas a interpretação substantiva fica mais clara com essa
qualificação.

### `WEB-AT-F003` — `REFUTED`

Os ramos de `DeltaD` se sobrepõem somente em `o=tau_M`, e o próprio resultado
mostra que as duas fórmulas coincidem exatamente nesse ponto. Não há ambiguidade
de valor. Torná-los disjuntos é preferência de exposição, não correção.

### `WEB-AT-F004` — `CONFIRMED`

Em `o=1/m`, a seleção congelada usa o ramo de inclusão. O limite pela direita
usa exclusão, e

```text
D_M(1/m)-lim_{o downarrow 1/m, o>1/m} D_M(o)
 = (beta/m)*(1-c*beta/m)>0.
```

Logo `D_M` cai e `DeltaD` salta para cima ao atravessar a fronteira. O texto
registra a seleção especial, mas não enuncia a descontinuidade. A fórmula não
precisa mudar.

### `WEB-AT-F005` — `PARTIAL`

T6 começa “em todo produto completo” e termina proibindo subtrações fora de
tuplas completas. Assim, o `iff` já é matematicamente membro a membro. Ainda
assim, a frase “agenda beneficia mais” pode soar como ranking único da
correspondência. Acrescentar “em cada tupla admissível” é reparo seguro. As
versões robustas para todo/algum membro são resultados adicionais, não parte do
reparo mínimo.

### `WEB-AT-F006` — `REFUTED`

O texto chama `T_M` de conjunto, diz que ele é set-valued e condiciona sinais à
imagem exata inteira. A notação não produz seleção implícita. Usar caligrafia é
opção editorial.

### `WEB-AT-F007` — `CONFIRMED`

O candidato já diz que `none` decorre da ausência de PBE sob votos puros e no
conceito mantido. A formulação mais exata é: “correspondência vazia do contraste
sob PBE puro e arquitetura M/S/B”. Isso previne leitura de zero, inexistência de
equilíbrio misto ou conclusão válida sob todo conceito de solução.

### `WEB-AT-F008` — `PARTIAL`

Em `0<nu<=nu_star`, o controle é sempre `none`; o tratamento existe apenas na
subfibra autorizada e também é `none` nas demais. A regra total `T_U=none` está
correta em toda a região. O ponto a reparar é apenas a possível leitura de que o
tratamento sempre existe.

### `WEB-AT-F009` — `REFUTED`, decisão já mantida

O contrato já afirma que remover o `beta` responderia a outra pergunta e define
explicitamente o tratamento como etapa anterior obrigatória versus início em
`R1`. O contrafactual alternativo é válido como outro modelo, mas não falta no
objeto atual.

## 5. Resultados adicionais confirmados

### `WEB-AT-F010` — ordenação dos limiares

```text
1/m < tau_M,
c/m < tau_M,
tau_M<1 iff beta>m/(m+k).
```

As duas primeiras desigualdades seguem das primitivas; a terceira classifica
quando o ramo de atraso é admissível.

### `WEB-AT-F011` — sinal completo de `DeltaD`

Se `c>1`, `DeltaD` é negativo em `o<c/m`, zero em `o=c/m` e positivo em
`o>c/m`. Se `c=1`, ele é negativo em `o<=1/m` e positivo em `o>1/m`, sem ponto
de igualdade porque a função salta na fronteira.

### `WEB-AT-F012` — positividade uniforme sob unanimidade

Sobre todas as células existentes, membros e tipos,

```text
T_U^theta>0 uniformemente
 iff Delta_U>0
 iff 1-beta>beta^2*(o_1-o_0).
```

### `WEB-AT-F013` — imagem ex ante completa de `T_U`

Na família alta `rho=0`, o vetor é diagonal e a imagem ex ante coincide com o
mesmo intervalo `[max{Delta_U,0},1-beta]`. Nas células fixas, é `1-beta`; nas
duas famílias vazias, é `none`.

### `WEB-AT-F014` — critérios robustos

Para correspondências não vazias:

```text
T_M^theta>=0 em todo membro
 iff I_M^theta subset [-D_M(o_theta),infinity),

T_U^theta>T_M^theta em todo membro institucional
 iff DeltaI^theta subset (-DeltaD^theta,infinity).
```

### `WEB-AT-F015` — relação entre `Q` e `T`

Quando os braços privados existem,

```text
Q_g^theta=T_g^theta-RI_g^{A,theta}.
```

Os resultados `F010`–`F015` foram reconstruídos algebricamente. Uma checagem R
com 200.000 sorteios admissíveis não encontrou violação das ordenações, da
classificação de sinais ou da condição de positividade uniforme. Isso é
evidência mecânica complementar, não substituto das provas.

## 6. Decisões reservadas ao autor

As quatro precisões locais estão tecnicamente determinadas e podem ser
implementadas sem mudar o estimando ou reabrir fontes. Já os seis resultados
adicionais mudam a força e a extensão da apresentação. O autor deve decidir:

1. incorporar apenas os reparos mínimos; ou
2. incorporar também `F010`–`F015` como lemas/corolários formais.

A segunda opção parece substantivamente valiosa: ela transforma a descrição por
ramos em uma classificação global de quando maioria ou unanimidade converte
melhor agenda em payoff e fornece condições selection-free. Mas não deve ser
implementada automaticamente pela adjudicação.

## 7. Veredito

`READY_FOR_IMPLEMENTATION` significa apenas que os reparos locais estão
determinados. Não é autorização para editar, não congela `A_T` e não autoriza
migração ao manuscrito, tag, merge ou push. Os corolários adicionais aguardam
decisão autoral explícita.

```text
ADJUDICATION_VERDICT: READY_FOR_IMPLEMENTATION
TOTAL: 15
CONFIRMED: 9
PARTIAL: 3
REFUTED: 3
UNRESOLVED: 0
HELD_DECISIONS: 7
```
