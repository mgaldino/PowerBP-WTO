# Leitura de seção 04 — extensão de agenda e Apêndices E–F

## Identidade e cobertura

- reader_id: reader-extension:/root/contract_extension
- modo: somente leitura; extração argumental sem crítica ou edição do manuscrito
- artefato: formal_model_v6.pdf; SHA-256 146fee55cb063b645121f2a6802a85c58816c542a5474442691c0903af5fafc4
- fonte: formal_model_v6.Rmd; SHA-256 ec9f281efb5e28c4e0b3c1c0c2756a2684aa85f0670e5ce42544ec886c3f0a97
- cobertura exclusiva: S06, PDF pp. 23–29 / Rmd 868–1167; S15–S17, PDF pp. 43–62 / Rmd 1665–2499
- consulta auxiliar indispensável: interface da extensão em Rmd 431–440 e glossário em Rmd 1647–1661.

## Tese das unidades

A extensão restaura separadamente o poder formal de agenda do hegemon: depois de observar seu tipo, \(H\) deve fazer uma proposta anterior na data \(A\). Se ela falha, o jogo entra na continuação completa e congelada da Rodada 1, descontada exatamente uma vez. O benchmark sem agenda continua sendo o modelo principal.

Com tipo público, agenda pode favorecer qualquer regra: maioria tem vantagem para outside options baixos; unanimidade pode ganhar quando o outside option torna o atraso sob maioria atraente. Com tipo privado, o paper preserva multiplicidade, vetores ligados por tipo, fibras de crença off path e células vazias. O contraste institucional só é formado entre binders completos da mesma economia e fibra. As identidades centrais são

\[
\Delta V^A=\Delta v^A+\Delta IR^A,
\qquad
T_g=D_g+I_g.
\]

A primeira separa o gap público do diferencial de renda informacional; a segunda separa o efeito direto público da agenda de sua interação com informação. Ambas valem membro a membro e por tipo antes da agregação ex ante. \(T_g\) é causal apenas no sentido estrutural interno ao modelo; \(Q_g\) muda agenda e informação simultaneamente e não é efeito causal de um único fator.

## Contrato formal da extensão

- Primitivas:
  \[
  \mathbf d=(m,k,e,\beta,\ell,h,\bar x_H,\mathcal X,p),\quad
  m\ge3,\quad k=\lfloor(m+1)/2\rfloor,\quad e=m-k,
  \]
  com \(0<\beta<1\), \(0<\ell<h<1\), \(h\le\bar x_H\le1\) e \(p\in[0,1]\). Localizador: PDF p. 43, E.1; Rmd 1669–1676.
- Na data \(A\), \(H\) propõe depois de observar seu tipo; a proposta conta como seu voto sim. Estados fracos votam simultaneamente em estratégias puras de ballot. Maioria exige \(k\) votos fracos e unanimidade todos os \(m\). Localizador: PDF pp. 43–44, E.1; Rmd 1678–1687.
- Aprovação implementa imediatamente o pacote. Rejeição leva à continuação congelada da Rodada 1, com exatamente um fator \(\beta\). \(H\) não pode pular o estágio mantendo payoff de data \(A\). Localizadores: PDF p. 23, §6; Rmd 870–877; PDF p. 44, E.1; Rmd 1687–1688.
- Um histórico rejeitado retém regra, proposta, proponente, ballot completo, resultado e posterior. O seletor é total, público, Borel, comum aos tipos compatíveis e devolve um registro completo da Rodada 1; payoff escalar não pode substituí-lo. Localizador: PDF p. 44, E.1; Rmd 1690–1695.
- Para prior interior, leis de proposta são medidas de Borel. Bayes fixa crenças em propostas disciplinadas. Nas demais, a restrição M/S/B usa
  \[
  \mu^{\mathrm{off}}=b_\rho(p)=\frac{p\rho}{1-p+p\rho},
  \quad \rho\in[0,\infty],
  \]
  com \(b_0(p)=0\) e \(b_\infty(p)=1\). Nos endpoints, \(\mu^{\mathrm{off}}=p\), a fibra é \((*,p)\) e \(\rho\) é irrelevante. Localizador: PDF p. 44, E.1; Rmd 1697–1713.
- O voto segue as regras as-if-pivotal e indifference-to-yes do benchmark. Localizador: Rmd 1711–1713.
- O binder unanimista
  \[
  R_U=(\sigma_\ell,\sigma_h,\mu,\mu^{\mathrm{off}},
  \widehat\kappa_U,v,\Omega,\Gamma_\ell,\Gamma_h)
  \]
  liga leis de proposta, posterior, continuação literal, ballots, leis terminais e pushforwards realizados; não se recombinam componentes de membros distintos. Localizador: PDF pp. 46–47, E.3; Rmd 1820–1842.
- O registro majoritário
  \[
  R_M=(\rho,\mu^{\mathrm{off}},\sigma_\ell,\sigma_h,\lambda,\pi,\chi,a,u_\ell,u_h)
  \]
  retém lei pública da proposta, posterior, continuação, ballots e payoffs dos dois tipos. Inclui misturas de Borel arbitrárias e suportes atomless. Localizador: PDF pp. 45–46, E.2; Rmd 1776–1786.

## Correspondências públicas e privadas

| regra/regime | caracterização | domínio/hedge | localizador |
|---|---|---|---|
| Unanimidade, público | \(v_U^A(o)=1-\beta+\beta^2o\); acordo imediato, rejeição pior por \(1-\beta\). | Todo \(o\in(0,1)\). | Rmd 900–906, 2095–2108. |
| Maioria, público, \(o\le1/m\) | Compra \(k\) votos por \(r_M(o)=\beta(1-\beta o)/m\); \(v_M^A(o)=1-k\beta(1-\beta o)/m\). | Qualquer loteria sobre coalizões mínimas; passagem domina atraso. | Rmd 910–916, 2061–2074. |
| Maioria, público, \(o>1/m\) | \(v_M^A(o)=\max\{v_M^{\mathrm{safe}},\beta o\}\), \(v_M^{\mathrm{safe}}=1-k\beta/m\), \(o_M^*=v_M^{\mathrm{safe}}/\beta>1/m\). | Passa abaixo do cutoff; mistura ligada no cutoff; atrasa acima. A última célula pode estar fora de \((0,1)\). | Rmd 917–925, 2076–2093. |
| Maioria, privado | Pooling agreement, pooling delay, separating agreement–agreement, low agreement/high delay e separating delay–delay; low delay/high agreement é impossível. | Condições necessárias/suficientes em \(A_\mu,D_{o,\mu},O_o(\rho)\); não há cutoff único em \(\rho\). | PDF pp. 44–46, E.2; Rmd 1717–1774. |
| Maioria, privado misto | Leis de Borel suportadas nas respostas globais ótimas, com binder completo. | Existe PBE para algum \(\rho\) em toda economia/prior, não em toda fibra fixa. | Rmd 1776–1795. |
| Unanimidade, família baixa | Payoff ligado \((v_U^A(\ell),v_U^A(\ell))\). | \(0<p<1\), \(v_U^A(\ell)\ge\beta^2h\), \(\mu^{\mathrm{off}}=0\). Para \(0<p\le p^*\), é a única família. | Rmd 1844–1876, 1904–1908. |
| Unanimidade, família alta, \(\mu^{\mathrm{off}}=0\) | \((u,u)\), com \(u\in[\max\{v_U^A(\ell),\beta^2h\},v_U^A(h)]\). | \(p^*<p<1\); se \(u>\beta^2h\), acordo certo; em igualdade pode haver rejeição em mistura. | Rmd 1878–1898. |
| Unanimidade, off path positivo | Payoff alto singleton se \(\mu^{\mathrm{off}}\in(p^*,1]\); vazio se \(\mu^{\mathrm{off}}\in(0,p^*]\). | Somente \(p^*<p<1\). | Rmd 1899–1908. |
| Unanimidade, endpoints | Em \(p=0\), \((v_U^A(\ell),\max\{v_U^A(\ell),\beta^2h\})\); em \(p=1\), \((v_U^A(h),v_U^A(h))\). | Correspondências Borel completas, não limites laterais; tipo de probabilidade zero permanece no registro. | Rmd 1910–1934. |

A imagem de payoff unanimista é exatamente a união dessas células e é vazia nas demais. Ela não substitui o binder nem transforma o intervalo de vetores ligados \((u,u)\) em produto cartesiano. Localizador: PDF p. 50, E.3; Rmd 1936–1951.

## Comparação majority/unanimity e fibras

O conjunto admissível é
\[
\mathcal J_A^{\mathrm{bind}}(\mathbf d,\rho,\mu^{\mathrm{off}})
=\mathcal B_M(\mathbf d,\rho,\mu^{\mathrm{off}})
\times_{(\mathbf d,\rho,\mu^{\mathrm{off}})}
\mathcal B_U(\mathbf d,\rho,\mu^{\mathrm{off}}).
\]
Ele exige primitivas e fibra idênticas, mas não proposta, continuação realizada ou randomização cross-world comum. O contraste usa vetores completos:
\[
\Delta V^A(o)=V_U^A(o)-V_M^A(o),\qquad
\Delta V_E^A=(1-p)\Delta V^A(\ell)+p\Delta V^A(h).
\]
A média afim vem somente depois de preservar o vetor por tipo. Se uma fonte falta, o contraste é vazio. Localizadores: PDF p. 25, §6.2; Rmd 1017–1031; PDF pp. 50–51, E.4; Rmd 1982–2011.

Dominância é setwise: unanimidade domina apenas se todo membro é positivo; maioria apenas se todo membro é negativo. Um conjunto que cruza zero é dependente de seleção; fibra vazia é none, não sinal zero.

Se \(\beta h<e/m\), então, em toda fibra comum não vazia,
\[
V_U^A(o)-V_M^A(o)\le-\beta(e/m-\beta h)<0
\]
para ambos os tipos e ex ante. Igualdade dá vantagem majoritária fraca. A condição é suficiente, não necessária; E.5 fornece contraexemplo paramétrico à necessidade. Localizadores: Rmd 1033–1046, 2013–2046.

## Claims explícitos

| claim | localizador | evidência | scope/hedge |
|---|---|---|---|
| O gap público é negativo em \(o\le1/m\) e, em \(o>1/m\), tem o sinal de \(\beta o-e/m\). | PDF pp. 24–25; Rmd 927–949, 2110–2127. | Subtração branchwise dos jogos públicos. | Fórmulas coincidem no kink; não é ranking universal. |
| Se \(\beta h<e/m\), maioria dá payoff maior aos dois tipos com informação pública. | Rmd 944–949. | Fronteira aplicada ao maior tipo. | Em igualdade, ranking fraco. |
| A correspondência privada majoritária não é substituída por seleção ou envelopes marginais. | Rmd 990–996, 1717–1795. | Classes puras e registros Borel completos. | Propostas podem ser mistas; ballots permanecem puros. |
| Em toda célula unanimista existente, \(IR_U^A(\ell)\ge0\) e \(IR_U^A(h)\le0\), com ao menos uma desigualdade estrita. | Rmd 1065–1069, 2129–2177. | Tradução do vetor privado pelo benchmark público. | Não implica sinal global de \(\Delta IR^A\). |
| Se \(\Delta v^A(\ell)<0\) e um membro privado tem \(\Delta V^A(\ell)>0\), então \(\Delta IR^A(\ell)>-\Delta v^A(\ell)>0\). | Rmd 1070–1078, 2179–2207. | Identidade de decomposição. | Membro específico; não seleciona equilíbrio. |
| A Figura 4 ilustra uma reversão informacional ligada. | Rmd 970–986, 2209–2216. | Valores públicos, privados e de informação satisfazem a identidade. | Ilustração teórica, não calibração ou ranking global. |
| Agenda reduz fracamente a renda informacional unanimista em toda fibra high-prior existente. | Rmd 1080–1090, 2417–2448. | Correspondência exata de \(I_U\). | Estrita para ambos exatamente se \(\mu^{\mathrm{off}}=0\) e \(u<v_U^A(h)\); em \(p=0\), cai só a coordenada contrafactual alta. |
| \(T_g=D_g+I_g\) por tipo e ex ante quando ambos os braços existem. | Rmd 1092–1129, 2218–2243. | Substituição de \(V=v+IR\) nos braços A e B. | Correspondência sob multiplicidade; causal apenas dentro do modelo. |
| \(D_U(o)=1-\beta\); \(D_M(o)\ge0\) e pode ser zero se tratamento e controle induzem o mesmo atraso. | Rmd 1131–1148, 2245–2279. | Diferença entre agenda pública e benchmark redatado. | \(D_M\) é branchwise e salta à direita de \(1/m\) pela seleção congelada. |
| Onde ambos os braços existem, todo membro de \(T_U\) beneficia fracamente os dois tipos, com ganho máximo \(1-\beta\). | Rmd 1150–1151, 2281–2304. | Células exatas de \(T_U\). | Fonte ausente propaga \(\varnothing\). |
| Não há sinal geral de \(T_M\); seu sinal depende de \(I_M\) relativamente a \(-D_M\). | Rmd 1152–1156, 2306–2319. | \(T_M=D_M+I_M\). | Sem ranking selection-free se a correspondência cruza o threshold. |
| Across rules, \(\Delta T=\Delta D+\Delta I\) membro a membro. | Rmd 1157–1163, 2320–2325. | Diferença das identidades por regra. | Exige produto completo; robustez requer toda a correspondência do mesmo lado do threshold. |
| \(Q_g=v_g^A-\beta V_g^B=D_g-\beta IR_g^B\) muda dois fatores. | Rmd 1164–1166, 2327–2358. | Identidade definicional. | Não é efeito causal isolado; pode existir com \(T_U\) vazio. |
| Nível exato, summary econômico e binder preservam informações distintas. | Rmd 1936–1980, 2362–2395. | Definição das assinaturas e fatorização após o produto. | Operações off-path-sensitive consomem binder; summaries não identificam propostas, lotteries ou planos. |
| O envelope entre ínfimo e supremo pode conter valores não atingidos. | Rmd 2397–2403. | Identidades de inf/sup. | Interval hull não é a correspondência. |
| O outcome entre regras é par de leis marginais, não distribuição contrafactual conjunta. | Rmd 2404–2415. | Definição de \(\mathcal O_A\). | Cross-world draw ou splicing adicionaria primitiva ausente. |
| Fontes ausentes propagam \(\varnothing\), nunca zero, NA, infinito ou payoff ficcional. | Rmd 2466–2479. | Regras de existência. | Cada contraste requer todas as fontes de sua definição. |
| Scripts não provam completude de PBE, mensurabilidade abstrata, fatorização universal ou ausência de desvios não enumerados. | Rmd 2478–2483. | Limite explícito da evidência mecânica. | Essas conclusões vêm das provas textuais fixadas pelos manifests. |
| \(T_g\) inclui oportunidade anterior e proposta obrigatória. | Rmd 2485–2492. | Definição dos braços. | Não descreve direito opcional de propor. |
| Claim livre de seleção exige a correspondência inteira do mesmo lado do threshold. | Rmd 2494–2498. | Regra explícita de interpretação. | Seis corolários consultivos posteriores não viram teoremas congelados. |

## Decomposições D/I/T/Q

| objeto | definição na data A | interpretação | existência/scope |
|---|---|---|---|
| \(D_g(o)\) | \(v_g^A(o)-\beta v_g^B(o)\) | efeito da agenda com tipo público | Singleton público; controle começa uma data depois. |
| \(I_g(o)\) | \(IR_g^A(o)-\beta IR_g^B(o)\) | interação agenda–informação | Diferença de Minkowski de registros ligados; vazia se faltar fonte. |
| \(T_g(o)\) | \(V_g^A(o)-\beta V_g^B(o)\) | efeito total da agenda com tipo privado | Contraste estrutural; correspondência sob multiplicidade. |
| \(Q_g(o)\) | \(v_g^A(o)-\beta V_g^B(o)\) | contraste diagonal | Muda dois fatores; não é efeito causal isolado. |

Localizadores: Rmd 1092–1166, 2218–2358, 2417–2498.

## Domínios, mecanismos e estática comparativa

- Em unanimidade privada, as células exatas dependem de \(p\), \(\mu^{\mathrm{off}}\) e \(v_U^A(\ell)\ge\beta^2h\); endpoints são correspondências completas, não limites. Localizador: Rmd 1844–1951.
- \(T_U\) pode ser vazio por falta do controle, do tratamento ou de ambos. \(Q_U\) pode existir quando \(T_U\) é vazio porque não usa o braço privado com agenda. Localizadores: Rmd 2281–2304, 2339–2358.
- Maioria preserva multiplicidade de coalizões, mensagens, continuações e leis Borel. Existe PBE para algum \(\rho\), não para cada \(\rho\) fixo. Localizador: Rmd 1717–1795.
- Um mesmo binder, vetor e mixture weight ligam tipos e outcomes; não se escolhem marginais independentemente. Localizadores: Rmd 1024–1031, 1950–1951, 1995–2011, 2397–2415.
- Mecanismo público: maioria pode deixar \(e=m-k\) fracos fora da coalizão; unanimidade compra todos. O cutoff \(o_M^*\) cria atraso deliberado apenas sob maioria. Localizadores: Rmd 879–925, 2061–2108.
- Mecanismo informacional: pooling unanimista no threshold alto pode dar ao tipo baixo a concessão desenhada para o alto. Localizadores: Rmd 1048–1078, 2129–2177.
- \(e/m=1/2\) para \(m\) par e \((m-1)/(2m)\) para \(m\) ímpar. Em célula low-prior existente, \(\beta\ell<e/m\) dá margem local mais fraca; em \(p=0\), garante apenas conclusão ex ante salvo uso do vetor contrafactual completo. Localizador: Rmd 2048–2059.
- Não encontrei derivadas globais em \(m,\beta,\ell,h,p\), monotonicidade universal de \(T_M,\Delta I,\Delta T\) ou ranking universal fora das regiões declaradas.

## Evidência

- Definicional: estágio A, regra de passagem, data, crenças e binders.
- Formal: condições necessárias/suficientes majoritárias, famílias unanimistas, identidades, bounds e classificação setwise.
- Construtiva: witnesses puros, leis Borel e contraexemplo à necessidade de \(\beta h<e/m\).
- Numérica: Figura 4 ilustra reversão em um membro; explicitamente não é calibração.
- Mecânica: scripts checam hashes, schemas, identidades finitas, desigualdades e células enumeradas, com limites expressos em F.3.
- Não encontrei estimação empírica, teste histórico da WTO ou seleção empírica de um membro.

## Não-afirmações

- O estágio A não substitui o benchmark e não é opcional.
- \(\beta\) multiplica o braço sem agenda exatamente uma vez.
- None/\(\varnothing\) não é zero, NA, infinito, interpolação ou sinal.
- Imagem de payoff ou summary não substitui binder e não autoriza splicing.
- Média ex ante não precede o vetor ligado por tipo.
- Envelopes não são necessariamente conjuntos atingidos.
- O outcome entre regras não é joint counterfactual distribution.
- \(\beta h<e/m\) é suficiente, não necessária.
- A reversão da Figura 4 não é calibração nem ranking global.
- A incidência \(IR_U^A(\ell)\ge0\), \(IR_U^A(h)\le0\) não dá sinal global a \(\Delta IR^A\).
- \(T_g\) não é estimando empiricamente identificado; \(Q_g\) não é causal em um fator.
- Não há sinal geral para \(T_M\), \(\Delta I\) ou \(\Delta T\).
- Verificação mecânica não prova os resultados abstratos enumerados em F.3.

## Ambiguidades textuais reais

1. E.1 inclui \(\bar x_H\) em \(\mathbf d\) e mantém \(h\le\bar x_H\le1\), mas define \(\mathcal X\) sem \(x_H\le\bar x_H\) (Rmd 1669–1683). Não fica resolvido se o teto é herdado ou omitido no estágio A.
2. M/S/B aparece como restrição e nos nomes AU-MSB-L/H, mas não encontrei expansão literal da sigla. Seu conteúdo operacional é dado por \(\rho\), \(\mu^{\mathrm{off}}\), famílias, binders e domínios.
3. S06 usa “pure-PBE M/S/B architecture”, enquanto E.2–E.3 admitem leis de proposta Borel mistas/atomless e E.1 restringe expressamente ballots a estratégias puras. A formulação localizada é pure ballot strategies, não propostas necessariamente puras.
4. E.2 fixa seleção Markov anônima \(\chi\) para definir \(A_\chi,D_{\chi,o}\), e \(R_M\) inclui \(\chi\). A correspondência parece variar sobre seletores admissíveis, mas não encontrei frase isolada que escreva essa união; convém manter \(\chi\) no binder.
5. O glossário chama \(Q_g\) de comparação “agenda-only versus information-only”; E.14 e F.4 resolvem que o objeto muda dois fatores e não é efeito causal isolado.

## Terminologia vinculante

- agenda arm A; baseline/no-agenda arm B; earlier mandatory hegemonic proposal stage;
- public payoff \(v_g^A\); private correspondence \(V_g^A\); linked type-payoff vector;
- complete binder/record; same economy; same fiber; same off-path specification;
- M/S/B restriction; \(\rho\); \(\mu^{\mathrm{off}}\); disciplined/undisciplined proposals;
- as-if-pivotal; indifference-to-yes; support-preserving endpoints; pure ballot strategies;
- public institutional gap \(\Delta v^A\) e private institutional contrast \(\Delta V^A\), sempre unanimidade menos maioria;
- informational rent; direct public agenda effect \(D\); agenda–information interaction \(I\); total private agenda effect \(T\); diagonal contrast \(Q\);
- set-valued, member-specific, selection-free, setwise dominance;
- empty correspondence/none/\(\varnothing\), nunca zero;
- exact signature; economic summary; diagonal relabeling orbit; realized laws; pushforward;
- Minkowski difference de registros ligados, não combinação independente de marginais;
- structural causal contrast inside the model, não empirically identified estimand.

## Perguntas para o agente macro

1. Manter a ausência de \(x_H\le\bar x_H\) em E.1 como ambiguidade, em vez de herdar silenciosamente o teto?
2. Registrar M/S/B sem inventar expansão?
3. Usar “PBE com estratégias puras de ballot e leis de proposta potencialmente mistas de Borel”?
4. Manter \(\chi\) no binder majoritário ou há outro localizador que explicite a união sobre seletores?
5. Preservar a ordem binder completo → produto da mesma fibra → mapas → summary econômico?
6. Registrar que dominance é setwise e que interval hull não é conjunto necessariamente atingido?
7. Distinguir os motivos de \(T_U=\varnothing\): controle ausente, tratamento ausente ou ambos?
8. Preservar a incidência por tipo sem inferir sinal para \(\Delta IR^A\)?
9. Registrar separadamente \(\Delta V^A=\Delta v^A+\Delta IR^A\) e \(T_g=D_g+I_g\), ambas membro a membro?
10. Qualificar \(T_g\) como estrutural interno e \(Q_g\) como diagonal não causal?
11. Registrar \(\beta h<e/m\) como condição apenas suficiente e restrita a fibras comuns não vazias?
12. Incluir existência majoritária para algum \(\rho\), não para toda fibra fixa?

## Itens não encontrados

- expansão literal de M/S/B;
- ranking institucional privado universal;
- sinal geral de \(T_M,\Delta I,\Delta T\);
- seleção empírica de membro;
- calibração empírica da Figura 4;
- prova computacional de completude de PBE ou mensurabilidade abstrata;
- direito opcional de pular a agenda;
- distribuição contrafactual conjunta entre regras;
- autorização para recombinar marginais, tipos, lotteries ou continuations.
