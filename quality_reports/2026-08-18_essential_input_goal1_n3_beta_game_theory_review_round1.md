## Parecer independente — N3 sob `beta<1`

- `reviewer_role=game_theory`
- `reviewer_id=review-n3-beta-game-2026-08-18-r1`
- Modo: read-only; nenhum arquivo editado
- Contrato: `sha256:2f1f79efe4b9fd13f5ccf95aa1178a7f0da50cebca71abb3ed4f4f34374e85f6`
- Dependência única N1: `sha256:1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`
- Candidato N3: `sha256:63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`
- Verificador N3: `sha256:f6586719f15aa5417e4ca05f2cbafcf9d7b07c094ef4b0dca9a637d3e9bc2ebd`

## Reconstrução independente

A interface congelada de N1 implica, em unidades de R1:

- continuação weak: `w=beta/m`;
- continuação de `H`: `t_theta=beta*o_theta`;
- ambos independentes do posterior de entrada em R2.

Para todo ballot de R1:

- weak nonproposer vota sim se e somente se `x_j>=w`; em `x_j=w`, há indiferença em todos os perfis e `T^Y` seleciona sim;
- se `k>=q-1`, `H` não é pivotal e compara corretamente `y` com `y+o_theta`, votando não estritamente;
- se `k=q-2`, `H` é pivotal e o tipo `theta` vota sim se e somente se `y>=t_theta`;
- se `k<=q-3`, ambos os votos levam à mesma continuação e `T^Y` seleciona sim.

Os candidatos reduzidos são:

- exclusão: `E=1-(q-1)w`;
- residual screening: `L=1-(q-2)w-t_0`;
- pooling: `P=1-(q-2)w-t_1`;
- payoff screening: `S(nu)=(1-nu)L+nu w`.

A exclusão domina estritamente rejeição deliberada:

`D=E-w=1-beta*q/m>0`,

pois `q<=m` e `beta<1`. Portanto propostas de rejeição pura e slack não são ótimas. Isso não elimina o delay informacional: quando screening é selecionado, o tipo alto rejeita e chega a N1 com probabilidade `nu`.

As diferenças relevantes estão corretas:

- `P-E=beta*(1/m-o_1)`;
- `S-E=(1-nu)beta*(1/m-o_0)-nu D`.

As regiões E/S/P, `nu_SP`, `nu_SE`, os endpoints, `o_0=1/m`, `o_1=1/m` e o empate residual E=P foram tratados corretamente. Nos empates S/E e S/P, screening reduz estritamente o payoff esperado de `H`. Quando E e P também empatam no payoff de `H`, ambos e suas misturas permanecem no suporte admissível.

A família `F_i` preserva corretamente:

- proposta mixing, pois somente ballots são obrigatoriamente puros;
- coalizões indexadas pela identidade;
- ausência de uma restrição simétrica `F_i=F_j`;
- payoffs weak indexados por identidade;
- registros atômicos de payoffs e outcomes.

Bayes está correto em propostas com massa positiva e após vetores públicos de votos. Propostas e vetores de probabilidade zero recebem crenças irrestritas explícitas. Tipos com prior zero continuam com estratégias e payoffs definidos. O desconto aparece exatamente uma vez, em `w` e `t_theta`.

Assim, não encontrei erro matemático ou game-theoretic no candidato ou na derivação.

## Finding

### N3-GT-01 — major — validação substantiva mascarada por autoidentidade canônica

**Texto exato do finding:**

> Depois de neutralizado o pin externo, o verificador N3 pode aprovar alterações substantivamente falsas em campos que definem as famílias E/S/P/R, o tie-break do proponente, o delay de screening e os claims do ledger. A comparação com `canonical_candidate` e `canonical_ledger` não fornece uma segunda âncora independente, pois ambos são cópias do próprio artefato recém-carregado. Consequentemente, a contagem de mutações rejeitadas não demonstra que esses campos centrais são validados semanticamente.

Evidência:

- O candidato é carregado e imediatamente copiado para `canonical_candidate`; o validator compara o objeto com essa cópia.
- `pure_candidate_families` não é comparado com um objeto esperado.
- Em `proposer_selection`, apenas `identity_rule` é validada; `V_star`, `H_star`, `A_i_star` e a estratégia condicional não são.
- O ledger é igualmente copiado para `canonical_ledger`; fora dessa autoidentidade, somente alguns keywords de C10, C15 e C17 são testados.
- As mutações genéricas são executadas depois da cópia canônica e, portanto, são rejeitadas pela autoidentidade, não necessariamente pelas condições substantivas.

Com hash e autoidentidade neutralizados em memória, foram indevidamente aceitas:

1. exclusão `E_i` redefinida com `y=0.1`;
2. screening `S_i` redefinido como oferta `y=t_1`, apagando a separação;
3. `R_i`, `assumptions_used` e `selection_status` coordenados para reintroduzir `beta=1`, `D=0` e rejeição selecionada;
4. `H_star` redefinido para maximizar, em vez de minimizar, o payoff esperado de `H`;
5. delay exportado como `0*I_D`, acompanhado de textos contraditórios que ainda continham os keywords exigidos;
6. claims C01 e C04 inteiramente falsos;
7. C10 contraditório, mas contendo as palavras `D>0` e `screening`.

As mutações diretas dos campos já comparados exatamente — domínio `beta`, definição de `D`, cutoff weak, IC de `H`, dependência N1 e identidade `F_i` — foram rejeitadas. O problema está na cobertura incompleta dos demais campos centrais.

A severidade é major porque o verificador é parte da evidência exigida e pode reportar PASS para uma correspondência ou ledger substantivamente falsos quando se executa precisamente o teste solicitado de neutralização dos pins. O finding não demonstra erro no hash atual do candidato.

## Execução

- `Rscript scripts/verify_essential_input_n3.R`: PASS no artefato atual.
- `Rscript scripts/verify_essential_input_gate0.R`: PASS.
- Checker com `--require-execution-order`: VALID.
- Checker com `--candidate N3`: VALID.
- `git diff --check`: limpo.
- Stress test adversarial auxiliar: 750.000 propostas factíveis, nenhuma superou `V_star`.
- N3 permanece corretamente `pending/null`; N1 é sua única dependência congelada.

## Veredicto

**FAIL** para o ciclo completo no hash N3 `63552db82d2434e3016341c9e3db928bca78707a9e74b5fb0b9cd3f9566a71ee`.

- Critical: `0`
- Major: `1`
- Minor: `0`

O candidato matemático está correto, mas o protocolo exige `0/0/0`; portanto o finding de verificação impede PASS neste ciclo.
