## Parecer independente N3 — Round 2

- `reviewer_role=game_theory`
- `reviewer_id=review-n3-beta-game-2026-08-18-r2`
- Modo: read-only; nenhum arquivo editado
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- N1 congelada: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Candidato N3: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`
- Verificador novo: `sha256:932234025f671ee1ace5e20f77b0dda593febe70f20608c1ead6bacaddc2bda7`
- Derivação: `sha256:b0e5e69e5eb774c2bb13170f00752fe138882282d268b8172c9c39dff5fefdd5`
- Ledger: `sha256:7219ef5572ae1df2fab8b2e00f534f209b8fdda0b70283d08c74b245afbc3b22`

## Reauditoria matemática

A reconstrução integral confirmou novamente:

- `w=beta/m` e `t_theta=beta*o_theta`, com desconto exatamente uma vez;
- weak nonproposer vota sim se e somente se `x_j>=w`, com `T^Y` na igualdade;
- `H` não pivotal compara corretamente `y` com `y+o_theta` e vota não;
- `H` pivotal aceita se e somente se `y>=t_theta`;
- `D=1-beta*q/m>0`, pois `q<=m` e `beta<1`;
- rejeição deliberada, delay puro e slack são estritamente inferiores à exclusão;
- o delay do tipo alto permanece quando screening é selecionado;
- as famílias E/S/P, seus cutoffs, feasibility, endpoints e todos os empates estão corretos;
- o empate residual E=P preserva as propostas e misturas não eliminadas pelo tie-break;
- `F_i` mantém a multiplicidade indexada por identidade sem impor simetria;
- crenças após propostas e vetores de probabilidade zero permanecem irrestritas;
- tipos de prior zero continuam integralmente especificados;
- payoffs e outcomes permanecem atômicos no mesmo registro.

Não encontrei erro no candidato, na derivação matemática ou no ledger atual.

## Fechamento de N3-GT-01

A parte estrutural do finding anterior foi reparada:

- o verificador não copia mais candidato ou ledger como sua própria referência;
- constrói objetos esperados independentes;
- com as âncoras exatas desativadas, rejeitou E com `y>0`, S com `t_1`, `H_star=max`, `F_i` apoiada em R, outcomes trocados, `delay=0*I_D`, `beta=1/D=0/R` coordenados e claims C01/C04/C10 falsos;
- mutações novas de cutoff, fronteira, payoff não pivotal, seleção, ledger e campos adicionais também foram rejeitadas.

Portanto N3-GT-01 está fechado para a interface estruturada e o ledger.

## Finding remanescente

### N3-GT-02 — major — apêndice contraditório interno escapa sem a âncora textual

**Texto exato do finding:**

> Com a âncora integral da derivação desativada, `validate_derivation()` ainda aceita um apêndice contraditório inserido antes da seção terminal, desde que ele preserve os headings e o último parágrafo e use paráfrases fora da denylist literal. Logo, a alegação de que contradições na derivação são rejeitadas semanticamente sem a âncora exata ainda é falsa.

Mutação aceita:

> **Apêndice contraditório.** O caso sem impaciência também pertence ao baseline; nele a vantagem da exclusão pode desaparecer, propostas destinadas à recusa podem maximizar e o tipo alto conclui na primeira rodada após screening.

O bloco foi inserido imediatamente antes de `## 8. Invalidação`. Ele contradiz simultaneamente `beta<1`, `D>0`, a eliminação de R e a sobrevivência do delay alto, mas:

- preserva a lista exata de headings;
- preserva o parágrafo terminal;
- evita as poucas frases literais da denylist;
- é aceito por `validate_derivation(..., check_exact_anchor=FALSE)`.

Contradições acrescentadas após o fim do documento foram rejeitadas pelo teste do parágrafo terminal. O bypass demonstra que essa rejeição é posicional, não substantiva.

A severidade é major porque o Round 2 solicitou expressamente neutralização das âncoras, paráfrases novas e apêndices contraditórios. O hash ativo rejeitaria a alteração, mas não satisfaz sozinho esse teste adversarial.

## Execução

- Verificador N3 oficial: PASS.
- Gate 0: PASS.
- Checker `--require-execution-order`: VALID.
- Checker `--candidate N3`: VALID.
- `git diff --check`: limpo.
- N3 permanece `pending/null`, dependente exclusivamente de N1.
- Stress test matemático separado não encontrou violação da solução.

## Veredicto

**FAIL** no hash N3 `63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`.

- Critical: `0`
- Major: `1`
- Minor: `0`

O candidato substantivo permanece correto; o FAIL decorre exclusivamente do bypass remanescente no verificador da derivação.
