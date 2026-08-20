# Finding consolidado — N3 v2, rodada 1

**Data:** 2026-08-19  
**Status:** autorização autoral concedida; reparo e nova revisão pendentes
**Candidato preservado:** `sha256:0954f7b7070c69f442981bec46f212cfa91b9f55bb337645fa91e991a2e54bb1`  
**Pareceres independentes no mesmo hash:**

- `formal_design`: **FAIL — 2 major / 1 minor / 0 epistemic**;
- `game_theory`: **NÃO PASSA — 0 major / 0 minor / 1 epistemic**.

N3 permanece `pending/unfrozen`. N6 e N7 não podem começar.

## 1. Fatos em que os dois pareceres convergem

Os dois revisores rederivaram a matemática de N3 a partir de N1 e não
encontraram erro nos cutoffs, nas onze células, nos payoffs, nos outcomes, nas
multiplicidades puras ou nas misturas de fronteira. Ambos, porém, demonstraram
que o verificador corrente imprime PASS para mutações semanticamente inválidas
quando o pin de hash é neutralizado da mesma maneira usada pelos próprios
fixtures negativos. Entre os contraexemplos aceitos estão:

1. proposta low-type-only sem concessão necessária a H ou aos weak voters;
2. posterior arbitrário numa falha de probabilidade positiva, contra Bayes;
3. mapa weak corrompido para `C_l=999`.

O pin de hash protege os bytes atuais, mas não prova que o conteúdo repinado
de um candidato futuro satisfaz a semântica do jogo.

## 2. Reparo substantivo da interface já determinado pelas fontes

Nos quatro registros low-type-only, a interface define corretamente posterior
um na falha on-path de probabilidade positiva, mas só explicita posterior
arbitrário para todo vetor de votos zero-probabilidade quando `nu=0`. Para
`nu>0`, outros vetores zero-probabilidade ficam sem posterior exportado.

A própria derivação fria já demonstra a regra completa: para **todo** vetor
proposta-votos de probabilidade zero, `eta_i(s,v)` pode ser qualquer elemento de
`[0,1]`; na falha de probabilidade positiva, Bayes fixa o posterior em um. N1
torna a crença off-path payoff-irrelevante, mas não dispensa sua declaração no
assessment PBE.

Assim, o conteúdo matemático do reparo é unívoco e não muda schema, jogo,
topologia, estratégia, payoff ou seleção:

- exportar explicitamente a regra completa em cada registro low-type-only;
- preservar posterior um na única falha de probabilidade positiva;
- corrigir a prova P0 para usar invariância do mapa de respostas sob N1, e não
  a afirmação falsa de que uma proposta desviada preserva a crença.

## 3. Escolha ainda não determinada: arquitetura do verificador

O parecer `game_theory` classifica a insuficiência do verificador como finding
epistêmico porque há mais de uma arquitetura razoável. A regra da Seção 11.1
impede escolher uma delas silenciosamente.

### Opção A — comparação estrutural exata

O builder gera o objeto esperado a partir de funções canônicas e o verificador
faz comparação profunda, campo a campo, contra o candidato e o ledger.

- **Vantagem:** fecha exatamente o schema aprovado e rejeita drift textual ou
  estrutural em qualquer campo.
- **Limite:** builder e verifier podem compartilhar o mesmo erro algébrico se
  a comparação não tiver checks independentes.

### Opção B — avaliador algébrico independente

O verificador reavalia cutoffs, propostas, payoffs, crenças e outcomes a partir
de N1 e das primitivas, sem reutilizar os objetos esperados do builder.

- **Vantagem:** reduz common-mode failure entre construção e verificação.
- **Limite:** exige uma representação executável ou parsing controlado das
  expressões simbólicas e deixa mais liberdade de implementação.

### Opção C — enumeração semântica por domínio e fronteiras

O verificador instancia pontos interiores, fronteiras e endpoints de cada
célula, avalia todas as condições e testa a partição e os mapas resultantes.

- **Vantagem:** forte auditoria comportamental e boa detecção de erros de
  fronteira.
- **Limite:** sozinha, uma grade finita não certifica toda string ou estrutura
  exportada e precisa ser combinada com invariantes exatos.

## 4. Recomendação

Recomenda-se autorizar uma combinação estritamente verificadora, sem mudança de
modelo: **Opção A como fechamento integral do schema, acrescida da Opção B para
as identidades algébricas centrais e de fixtures negativos dirigidos aos
contraexemplos dos dois pareceres**. A enumeração da Opção C pode ser usada
apenas como stress test complementar de regiões e endpoints, nunca como prova
única.

Essa combinação é mais exigente que qualquer opção isolada, não introduz nova
primitiva ou seleção e deixa explícita a independência entre bytes, estrutura e
semântica. Ainda assim, por ser uma escolha entre arquiteturas possíveis, só
pode ser implementada após autorização autoral expressa.

## 5. Consequência operacional

Após a decisão:

1. um implementador que não seja nenhum dos dois revisores corrige candidato,
   derivação, ledger, builder e verifier;
2. a bateria deve incluir negativas específicas para cada contraexemplo da
   rodada 1;
3. qualquer novo hash retorna aos mesmos dois papéis independentes,
   `formal_design` e `game_theory`;
4. N3 só pode voltar a `pass/frozen` após ambos emitirem `PASS 0/0/0` no mesmo
   hash.

Até lá, o hash da rodada 1 e seus pareceres permanecem como proveniência, sem
reparo implícito.

## 6. Decisão autoral posterior

O autor respondeu literalmente: `Autorizo o reparo N3 recomendado e a Opção A
de N4`. Para este finding, isso autoriza a recomendação da Seção 4: completar
as crenças off-path, adotar comparação estrutural integral, acrescentar oracle
algébrico independente e incluir negativas dirigidas aos contraexemplos da
rodada 1. A autorização não altera jogo, schema, topologia ou protocolo de
revisão. N3 permanece `pending/unfrozen`, e qualquer novo hash retorna aos dois
papéis independentes read-only antes de consumo ou congelamento.
