# Integração final de N6 — comparação privada

Data: 2026-08-21
Estado: PASS / frozen
Escopo: Goal 3 exclusivamente para N6, m>=3 e PBE com ballots puros
Parada: antes de N7

## 1. Autoridade, método e fontes

A integração foi feita exclusivamente na worktree
/private/tmp/PowerBayesianPersuasion-essential-input-n6-pure, branch
codex/essential-input-goal3-n6-pure, a partir do HEAD obrigatório
1a12b749f967d460f819d8732634992ba75fdcf8.

A autoridade posterior é
quality_reports/2026-08-21_autorizacao_goal3_n6.md, no hash
4c18e9bfd244b8024f2d707f714d3ce57f7b635d603def1577430899bf3951cd.
Ela autoriza somente a comparação dos jogos privados em N6 e não autoriza N7,
benchmark público, renda informacional, beta=1, extensão, estratégia mista de
ballot ou manuscrito.

N6 consumiu N3 e N4 somente pelas interfaces frozen:

- N3: ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d;
- N4: f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b.

Não houve rederivação nem edição de ancestral. A prova matemática, a
integridade do schema e os pareceres substantivos permaneceram separados.

## 2. Partição comum

O refinamento comum exigido pelo schema contém exatamente três células:

1. nu=0: maioria e unanimidade têm PBE puro; a comparação existe;
2. 0<nu<=nu_star: maioria tem PBE puro, unanimidade não tem; a comparação é
   none, sem payoff e sem registro sentinela;
3. nu_star<nu<=1: maioria e unanimidade têm PBE puro; a comparação existe.

A fronteira nu=nu_star pertence à célula none. As células cobrem todo o domínio
autorizado m>=3. A subpartição econômica interna distingue C0-S, C0-E, CH-S,
CH-P, CH-E e CH-EP sem duplicar o único registro-família de N3.

## 3. Certificado none

Na região 0<nu<=nu_star, a proposta factível s_dagger satisfaz
Q_L-A=1-beta>0 e paga A aos weak responders. Como o valor de continuação
as-if-pivotal pertence a [B,A], todos votam sim, incluindo a igualdade fechada
por T^Y.

Os quatro perfis puros de H são exauridos:

- YY falha pelo desvio estrito de H1;
- NN falha porque H0 fica indiferente e T^Y exige sim;
- YN falha porque H0 imita o não de H1 e obtém h>ell;
- NY falha porque H1 imita o não de H0 e obtém h>ell.

Não há quinto perfil puro. O registro é exclusivamente técnico e não inicia
qualquer análise de ballot misto.

## 4. Contrastes de payoff e outcomes

Todos os contrastes usam a orientação unanimidade menos maioria.

Em nu=0:

- se maioria seleciona screening, o contraste de payoff de H é (0,0) e os
  quatro contrastes de outcome são zero;
- se maioria seleciona exclusão, o contraste de payoff é
  (-(1-beta)o_0, -(1-beta)o_1) e o de outcome é (1,-1,0,0).

Em nu_star<nu<=1:

- contra screening: payoff (beta(o_1-o_0),0) e outcome (nu,0,0,-nu);
- contra pooling: payoff e outcome iguais a zero;
- contra exclusão: payoff (beta o_1-o_0, -(1-beta)o_1) e outcome
  (1,-1,0,0).

Falha tem massa zero em todas as células comparáveis. Unanimidade não tem delay
com probabilidade positiva em suas células existentes; quando maioria seleciona
screening, unanimidade remove o delay de massa nu.

O tipo alto de H nunca melhora sob unanimidade na célula alta. O tipo baixo
melhora contra screening, empata contra pooling e tem sinal beta o_1-o_0 contra
exclusão. Não existe ranking escalar uniforme e nenhuma média sobre parâmetros
foi construída.

## 5. Multiplicidade, conjuntos e simetria

A interface preserva atomicamente a família identificada F=(F_i)_i de N3.
Payoffs dos dois tipos e os quatro outcomes usam a mesma F.

No empate residual exclusão/pooling, a mesma massa agregada lambda determina:

- H_M(lambda)=lambda(o_0,o_1)+(1-lambda)(beta o_1,beta o_1);
- O_M(lambda)=(1-lambda,lambda,0,0);
- DeltaH(lambda)=lambda(beta o_1-o_0, -(1-beta)o_1);
- DeltaO(lambda)=(lambda,-lambda,0,0).

Esse segmento já pertence à correspondência frozen de N3; não é convexificação
criada por N6. Os envelopes são apenas mínimos e máximos coordenados derivados
do conjunto conjunto exato e não autorizam recombinação de marginais.

Permutações de identidades fracas preservam payoff de H e outcomes. O relatório
pode usar representantes de órbita, mas a interface mantém IDs, coalizões,
F_i, massas e hashes de origem.

## 6. Artefatos e pareceres

Artefatos matemáticos frozen:

- derivação:
  353afbd50681b4a107bee5560da9ec26089b1a4a9bad18fcc7e7806fdb2dad23;
- interface private_information_comparison_v1:
  a9cfd5935377197b51637a525f26627c296eed1e21bfe8cfcf6906b4d90a5a92;
- ledger:
  02ef4e633445cd6904996ad64a49e370a6534a2fa90575010d1c04571551e958;
- relatório legível:
  c144795051cacb0179b5214ec2f4e826157966198a789b619882d1ab7118031d;
- verifier N6:
  1a9eb385a783073e59a1bf67b4756fec9cc07c732ff9a72e827cb20f579c424d;
- manifesto candidato:
  a59b4db15b84ffa06d4ced1e2cc0b9b31e62be2e40502df8d339a6977f00316e.

Exatamente dois pareceres read-only independentes incidiram sobre a mesma
interface e o mesmo manifesto:

- formal_design, reviewer
  codex-formal-design-n6-private-final-20260821: PASS 0/0/0; relatório
  dc788a4aa1e9eab1559a3926526477cc1d6e2154bf904edb3aa72aa174f383fb;
- game_theory, reviewer codex-game-theory-n6-pure-final-20260821:
  PASS 0/0/0; relatório
  a85e2e5d83900d1d8564a1e9d6b79939cb8499d079abb9f4388a6a175fc86513.

O manifesto final dos pareceres tem hash
eaafd074f66ab0bd5cec1c7fdc55f8d970642a55cae7a26be0586b40733fff4f.

## 7. Integração e validação

O DAG integrado tem hash
c7ceac8552599b19147742fe7f31edd636f44d563cd72f63ece86665489034c3.
N6 está pass/frozen, com ordens 9/10, dependências N3/N4 nos hashes acima e
exatamente os dois pareceres PASS 0/0/0. A interface embutida no DAG é
objeto-idêntica ao arquivo standalone frozen.

Após a promoção, os seguintes checks retornaram PASS:

- verifier N6: schema, 60 identidades dirigidas, certificado none,
  simetria/atomicidade e 5/5 negativas;
- Gate 0: N1/N2/N3/N4/N6 pass/frozen e N7 pending;
- verifier dirigido N3/N4: prova, álgebra e enumeração finita;
- checker do DAG com ordem de execução: VALID;
- git diff --check.

O manifesto candidato registra deliberadamente o snapshot pré-integração usado
pelos pareceristas. Por isso seus dois pins administrativos de DAG e Gate 0 não
são reaplicados como hashes finais; os onze demais objetos revisados permanecem
imutáveis. O fechamento usa um manifesto final separado para o estado
pós-integração.

## 8. Estado e parada

N1, N2, N3, N4 e N6 estão pass/frozen. N7 permanece pending, com interface
null e sem artifact, hash, ordens ou reviews. O checker pode reportar Ready: N7
apenas como prontidão topológica; isso não é autorização.

O trabalho para aqui. Não foram editados nem compilados formal_model_v5.Rmd ou
formal_model_v6.Rmd. Não houve push, merge ou tag.
