# Parecer independente de desenho formal — N3 v2, rodada 1

**Data:** 2026-08-19  
**Papel:** `formal_design`  
**Modo:** read-only; o revisor não editou nenhum artefato  
**Candidato auditado:** `sha256:0954f7b7070c69f442981bec46f212cfa91b9f55bb337645fa91e991a2e54bb1`  
**Commit que preserva o candidato:** `274b2aecba00ad652f1aa5102766f759dba30024`  
**Veredicto:** **FAIL**  
**Contagem:** `major=2`, `minor=1`, `epistemic=0`

## Preflight

- Raiz: `/Users/manoelgaldino/.codex/worktrees/592e/PowerBayesianPersuasion`.
- Branch: `codex/essential-input-goal4-n7-phaseb`.
- HEAD auditado: `5a165a56a6e7be30a43dd4c46807758f71e14d35`.
- A tag `pre-essential-input-2026-08-12`, após peeling, apontava para
  `f53e6769624ce3dd6e64e21ad40d08230b0950a7`.
- O candidato N3 v2 estava byte a byte no hash acima e idêntico ao commit
  `274b2ae`.
- N1 foi confirmado em
  `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`,
  `pass/frozen`, com dois pareceres `PASS 0/0/0`.
- Gate0, o verificador de N1 e o verificador N3 v2 terminaram com exit code
  zero; o checker independente do DAG retornou `VALID` e `Ready: N3, N4`.
- N3 permanecia corretamente `pending`; N4 não foi examinado nem usado.

## Findings

### 1. Major — crenças off-path incompletas nos registros low-type-only

Nos quatro registros low-type-only, o campo
`belief_system.published_vote_vector` atribui posterior um à única falha
on-path e declara `eta_i(s,v)` arbitrário apenas quando `nu=0`. Quando `nu>0`,
o registro não define o posterior de vetores proposta-votos de probabilidade
zero — por exemplo, após o desvio de um weak voter em uma proposta de suporte.

`kappa_i(s)` define apenas a crença no ballot depois de uma proposta com peso
zero. A afirmação de que toda continuação consome N1 também não escolhe o
posterior que entra em R2. A omissão contradiz a regra completa já demonstrada
em `N3V2-C14`, segundo a qual todo vetor de proposta e votos de probabilidade
zero recebe `eta_i(s,v) in [0,1]` irrestrito, e torna excessiva a claim C13 do
ledger. N1 faz a omissão ser payoff-irrelevante, mas a interface deixa de
exportar um assessment PBE localmente fechado.

Evidência principal:

- `model_redesign/essential_input_interfaces/n3_r1_majority_candidate_v2.json`,
  linhas 62, 242, 512 e 692;
- `model_redesign/essential_input_n3_r1_majority_derivation_v2.md`, claim
  `N3V2-C14`;
- `model_redesign/essential_input_n3_claim_ledger_v2.json`, claim C13.

### 2. Major — checker semântico e negativas aceitam corrupção material

O teste de crenças do verificador exige apenas a ocorrência da palavra
`arbitrary`. O checker não valida semanticamente o mapa weak por identidade nem
o conteúdo completo da proposta selecionada; o ledger é aceito quando `branch`
e `claim` são apenas não vazios e apontam para um anchor.

Neutralizando somente o pin de hash em memória, sem editar o repositório, o
revisor demonstrou que:

- `validate_candidate()` aceitou `C_l=999`;
- aceitou uma proposta low com `y=0`, nenhum weak pago e `r_i=1`;
- aceitou posterior on-path zero;
- aceitou a omissão específica do posterior para histórias de voto
  zero-probabilidade quando `nu>0`;
- `validate_ledger()` aceitou claim de desconto duplo e branch falso.

As negativas correntes, portanto, não sustentam os PASS anunciados para mapas
weak, estratégias, crenças e ledger. O novo verificador deve rejeitar essas
mutações semanticamente, além de repinar o hash do candidato corrigido.

### 3. Minor — C06 diz incorretamente que mudar a proposta preserva crenças

A prova de P0 afirma que elevar `r_i` numa proposta com folga preserva crenças.
Como `r_i` integra a proposta pública, a proposta desviada pode receber uma
crença off-path distinta. O resultado P0 pode ser preservado pela propriedade
já derivada de que votos e outcomes relevantes são invariantes à crença sob a
continuação N1; a alegação de preservação literal da crença deve ser removida.

## Dimensões sem finding adicional

O parecer não encontrou outro erro em:

- dependência exclusiva em N1 e desconto aplicado exatamente uma vez;
- schema `equilibrium_correspondence_v1` e topologia;
- partição de onze células, inclusive `nu=0,1`, `o_0=1/m`, `o_1=1/m` e
  `beta<1`;
- stage-undominance, `T^Y` e tie-break do proponente;
- multiplicidade por identidade e mistura no empate `E=P`;
- payoffs, outcomes e campos destinados ao transporte para N6.

## Consequência de lifecycle

N3 deve permanecer `pending/unfrozen`. Este parecer não autoriza N6. Qualquer
novo hash substantivo ou técnico do candidato deve retornar a este mesmo papel
e ao revisor `game_theory`, ambos read-only, antes de qualquer freeze.
