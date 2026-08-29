# Decisões pós-parecer externo — pacote A_M sob M/S/B

**Data:** 2026-08-29
**Status:** PROPOSED — aguardando aval autoral.
**Objeto:** o parecer técnico externo não formal
`quality_reports/external_reviews/2026-08-29_consulta_tecnica_chatgpt_web_A_M_msb.md`
(SHA-256 `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c`)
sobre o pacote de derivação de `A_M` sob M/S/B produzido pelo Codex. Veredito
do parecer: FAIL para os bytes exatos com núcleo recuperável por correções
locais; 0 `critical`, 5 `important`, 6 `minor`. O parecer não constitui gate:
os dois pareceres independentes formais do protocolo permanecem pendentes e
rodarão sobre os bytes reparados.

## Decisão 1 — arquitetura de crenças: reparametrização `rho` como coordenada

- **Escolha**: adotar a reparametrização do §8.4 do parecer,
  `nu_off = b_rho(nu) = nu*rho/(1-nu+nu*rho)`, com `rho in [0,infty]` mantido
  como **coordenada do assessment** (livre por equilíbrio, nunca fixado ex
  ante), e as convenções usuais nos extremos e em priors degenerados.
  Entregáveis de robustez associados: benchmark `rho = 1` (passive beliefs
  genuína); sensibilidade das classes em `rho`, incluindo os limites `0` e
  `infty`; destaque das classes válidas para todo `rho`, quando existirem, sem
  alegar existência geral dessa subclasse.
- **Motivo**: como coordenada, é reparametrização pura — preserva todos os
  resultados atuais — e dá conteúdo econômico ao escalar: `nu_off` deixa de
  ser número livre e vira razão de verossimilhança de lapses com suporte pleno
  comum aos tipos. O parecer é explícito de que a racionalização é no nível
  dos sinais e não prova consistência sequencial do assessment completo; essa
  ressalva deve constar do texto.
- **Alternativas descartadas**:
  - fixar `rho = 1` ex ante (passiva estrita): o contraexemplo §7.1 do parecer
    (`N=3, m=2, k=1, beta=0.9, o_0=0.04, o_1=0.73, nu=0.05`) mostra todas as
    classes puras falhando sob `nu_off = nu` e existindo sob `nu_off = 1`;
    invalidaria a prova de existência pura. Já descartada na emenda; o parecer
    confirma com números.
  - eliminar a liberdade de `nu_off` por outra via preservando a existência
    global e a classificação escalar: o parecer registra que nenhuma alteração
    atende às três exigências simultaneamente (§8.4, conclusão).

## Decisão 2 — assinatura downstream: versão preferível (lei conjunta)

- **Escolha**: adotar a correção preferível do §10.4: a interface inclui
  `nu_off` (equivalentemente `rho`) e uma lei conjunta por tipo,
  `Gamma_theta = L_theta(y, pi(y), a(y), chi(pi(y)), omega_T)`, em espaço
  terminal disjunto para acordo e atraso, com `V`, `W`, `p_A`, `Q`, `G_pi`
  derivados como marginais. A comparação `AC` é feita por produto fibrado no
  MESMO `rho`/`nu_off`, nunca por produto cartesiano de correspondências
  marginais — concretização verificável da vinculação institucional já
  aprovada na emenda. O quociente de anonimato (clarificação §2 e §4)
  aplica-se a `Gamma_theta`.
- **Alternativas descartadas**:
  - `Sig+` mínima: não garante a compatibilidade por fibra nem a correlação
    timing–sinal–outcome que operações futuras de `AC` podem exigir;
  - assinatura atual sem `nu_off`: é o FAIL de AMX-016 — na instância atomless
    com `E` único, a mesma assinatura é compatível com qualquer `nu_off`.

## Decisão 3 — IC/D1: benchmark separado, não bloqueante

- **Escolha**: manter Critério Intuitivo e D1 fora do baseline (contrato §3.2
  e emenda) e registrar o entregável futuro `IC/D1-BENCHMARK` na forma do
  §8.4 do parecer: para cada proposta inesperada, definir a correspondência de
  tipos que podem ganhar sob alguma resposta sequencialmente racional dos
  votantes e algum membro permitido de `C_M`, e aplicar IC/D1 a essa
  correspondência, como resultado novo e rotulado. Não bloqueia o fechamento
  de `A_M`.
- **Motivo**: o exemplo §7.2 do parecer mostra que a testemunha regional da
  banda intermediária não sobrevive a IC — o benchmark tem valor real; mas
  gera crenças específicas por proposta, incompatíveis com a Cláusula B
  inalterada, e exige decidir se a resposta dos receptores inclui a seleção
  `chi`. É derivação própria.
- **Alternativa descartada**: aplicar IC/D1 silenciosamente sobre B — vetado
  pelo próprio contrato e pelo parecer.

## Decisão 4 — reparos técnicos: aplicar integralmente

- **Escolha**: o Codex aplica, num passe de reparo sobre o pacote:
  1. **10.1** — definição de Bayes local com bolas euclidianas relativas,
     identificação via teorema de diferenciação de Besicovitch
     (`pi = d(nu*sigma_1)/d(lambda)` λ-q.c.), inadmissibilidade do assessment
     quando o limite falha em ponto do suporte, e o anúncio explícito de que a
     exigência pointwise em todo o suporte é disciplina adicional ao PBE usual;
  2. **10.2** — Teorema 4 bem formado: `sigma_theta in P(Y)`, `nu_off`
     (ou `rho`) incluído no objeto reduzido `R`, mensurabilidade Borel de
     `pi, a, u_0, u_1` imposta ou provada;
  3. **10.3** — já absorvido no §4 da clarificação aprovada: kernel terminal
     uniforme obrigatório; ciclo apenas para cálculo de payoffs interinos;
  4. **10.5** — retítulo do Teorema 6 para a versão cardinal: incontavelmente
     muitas assinaturas exatas, nenhuma lista finita as representa; sem alegar
     inexistência de parametrização finita;
  5. **10.6** — estatuto de AMX-NEG-001: anexar `kappa_old`, a crença antiga e
     `g_theta` completo, ou declará-lo lema histórico importado, não
     revalidável pelo pacote autocontido; definir o "antigo intervalo" de
     AMX-009 ou rebaixar o claim;
  6. os seis achados `minor` (§9.6–9.7), incluindo antecipar o lema do supremo
     off-path para suporte puro finito, mencionar o empate residual `E/P`,
     provar `0 < r <= beta/m`, explicitar os valores off-path do Finding 1,
     construir por escrito as misturas de fronteira e restringir "testemunhas
     adjacentes" a priors interiores;
  7. incluir no pacote o script mecânico e os outputs de AMX-013, para
     reprodutibilidade da evidência `2891 PASS`;
  8. o passe de re-corte por anonimato da clarificação (§3, item 4), se o
     pacote tratou rotulagens como classes distintas.
- **Consequência**: os bytes corrigidos formam candidato novo. `AC` permanece
  proibido de consumir `A_M` até que: a interface carregue `rho`/`nu_off`; a
  comparação seja na mesma fibra; a lei conjunta esteja definida (ou provada a
  suficiência das marginais); e `A_U` tenha auditoria própria. Depois do
  reparo, seguem os dois pareceres independentes formais do protocolo
  (nunca quem redigiu, nunca Fable).

**Aprovação autoral:** pendente.
