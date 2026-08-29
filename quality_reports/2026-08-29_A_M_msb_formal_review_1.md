# Parecer formal 1 — `A_M` sob M/S/B

**Data:** 2026-08-29
**Papel:** parecerista formal/game-theoretic 1, read-only, não implementador
**Objeto:** pacote `A_M` sob as cláusulas M/S/B
**Branch:** `agenda-extension-am-msb`

## 1. Declaração de independência

Não implementei o candidato, não editei nenhum artefato substantivo, não fiz
commit, tag ou merge e não abri nem consultei o arquivo do outro parecer formal.
O relatório de implementação e a consulta técnica externa foram lidos somente
depois da reconstrução matemática principal e tratados como proveniência, não
como autoridade. Um stress-test adversarial auxiliar, também read-only e
expressamente impedido de acessar os pareceres formais, foi usado para tentar
refutar a parte mista e a anonimização; a adjudicação e o veredito abaixo são
meus.

Este parecer aplicou a skill `game-theory-audit`, adaptada a um jogo finito de
barganha e signaling bayesiano. A checagem foi claim a claim, com reconstrução
das condições de melhor resposta, Bayes, mensurabilidade, imitação e
factibilidade.

## 2. Identidade do candidato e bytes revisados

### 2.1 Identidade Git e manifesto

- `HEAD` observado: `6b94f2f57aaf8615972e27479435be1db7d44d7f` — coincide com o esperado.
- Commit substantivo: `b2b7a34a2a320a5696f57ed8533495ffe3f4e6b6` — é ancestral de `HEAD`.
- O diff entre o commit substantivo e `HEAD` não altera resultados, ledger,
  script ou output; acrescenta apenas o relatório de reparo e o manifesto.
- SHA-256 externo do manifesto:
  `7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6`
  — coincide com o esperado.
- `shasum -a 256 -c quality_reports/2026-08-29_A_M_msb_post_review_repair_manifest.sha256`:
  todas as 21 entradas retornaram `OK`.
- O worktree estava limpo no preflight.

### 2.2 Arquivos normativos e substantivos

| Artefato | Bytes | SHA-256 |
|---|---:|---|
| manifesto pós-reparo | 3.026 | `7905d48837f64f7ff89d661c3458462d24e6296ae44c047710786343e1e51bd6` |
| emenda M/S/B | 17.654 | `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b` |
| clarificação de anonimato/kernel | 7.650 | `6c73fa57c34eb1529259e7c56ef8e6ddbf906fa1977aacf551c429aa29b248c3` |
| decisões pós-parecer | 6.931 | `3000a25c89510f3e0ea471d4406c0c59282f41fd07662b5c077fa81f281e1471` |
| Gate 0 simplificado | 23.474 | `fb2cd323a74b30432746dc37d622014cd7768e6d5442877ed3a8e043df546dc4` |
| interface congelada N3 | 7.040 | `ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d` |
| resultados `A_M` M/S/B | 47.646 | `020ffbb1d67daaabf9a330be1f0f3ea91d42b55e3b7047787a8c8eb06f6912ed` |
| ledger `A_M` M/S/B | 21.343 | `56073462c367277a1863d2a4eeb817e49c57845b4cd0f04c404ff57bfc4b38e1` |
| verificador R | 22.547 | `0e460d286b2647ef5ed17485339ad69e3e332346494e22b9ffdca362b7c7374f` |
| output preservado do verificador | 776 | `13716a16506c68e9153617194c71ccd608f6ccc3a2911ba87167ee17705f4ecb` |
| artefato histórico de maioria explícita | 37.491 | `1e385fabd2e25a5b72344d22982d9648e28be92eb68665d484cd8116aaa7772f` |
| relatório de implementação pós-reparo | 11.271 | `1038ae8c513564f5c78648ccc933e51e0a2c881bad15fb940e292b8c7c59bfb1` |
| consulta técnica externa, proveniência | 31.457 | `d4928d7cf90ae01b37848d43b6d38d32498332822b1f73d955eebb7f1dabc47c` |

Como checagem transitiva do transporte, também conferi a interface N1 citada
por N3: 4.043 bytes e SHA-256
`1a171791ebd329ac325410038d92dae719fa9edc053aa068772bc6564ed981b5`,
idêntico ao hash preso em N3.

## 3. Tipo de jogo e objeto de equilíbrio

Trata-se de um jogo finito de **barganha legislativa bayesiana com signaling**:
Natureza escolhe o tipo binário privado de `H`; `H` envia uma proposta pública
num simplex compacto; os fracos votam simultaneamente sob maioria; aprovação
implementa o pacote e rejeição entra numa continuação congelada. O conceito é a
correspondência de PBE, acrescida das restrições autorais: voto fraco
as-if-pivotal, `T^Y` na igualdade, Bayes local pointwise, suporte do prior e as
cláusulas M/S/B. Não é um problema de mecanismo direto; IC/D1 não integra o
baseline.

## 4. Reconstrução mínima

Para `m=N-1`, `q=floor(N/2)+1` e `k=q-1`, o representante anônimo de N3
entrega a cada fraco o payoff interino nativo `c_chi(mu)` e a `H` o payoff
nativo `h_chi_theta(mu)`. Em unidades da nova data `A_M`,

```text
r_chi(mu)       = beta*c_chi(mu),
D_chi_theta(mu) = beta*h_chi_theta(mu),
A_chi(mu)       = 1-k*r_chi(mu).
```

O fator `beta` é aplicado uma vez no transporte de N3 para `A_M`. Os fatores
`beta` já presentes em `w`, `t_0`, `t_1` e nos ramos `S/P` são internos à data
nativa de N3 e não constituem nova aplicação. A anonimidade de S torna o preço
pivotal comum; `T^Y` produz `sim` em `x_j=r_chi(mu)`. Como
`0<r_chi(mu)<=beta/m` e `k<m`, o melhor acordo é factível e deixa
`A_chi(mu)>0` para `H`; uma proposta com pagamentos fracos nulos produz
rejeição e payoff `D_chi_theta(mu)`.

Em suporte puro finito, qualquer proposta não disciplinada enfrenta o mesmo
`nu_off`, e a densidade de `Y` depois de retirar o suporte finito justifica

```text
O_theta(rho)=max{A_chi(nu_off),D_chi_theta(nu_off)}.
```

As condições puras do candidato são exatamente as de factibilidade, imitação
bilateral e ausência de desvio off-path. Para medidas gerais, o Teorema
AM-MSB-T4 usa corretamente o supremo exato no complemento do suporte, sem
substituí-lo por um pacote que possa pertencer ao próprio suporte.

## 5. Checklist formal

| Item auditado | Veredito | Evidência/localizador |
|---|---|---|
| Identidade do candidato | PASS | preflight da Seção 2; manifesto integral `OK` |
| Jogadores, tipos, informação, simplex e quota | PASS | Gate 0, linhas 80–195; resultados, linhas 55–91 |
| Transporte de N3 e `beta` uma única vez | PASS | N3, linhas 31–116; resultados, linhas 174–183 e 278–300 |
| Cláusula M | PASS | emenda, linhas 60–101; resultados, linhas 77–90 |
| Cláusula S e membership literal | PASS | emenda, linhas 103–131; clarificação, linhas 99–118; resultados, linhas 170–276 |
| Cláusula B e `nu_off` constante | PASS | emenda, linhas 133–196; resultados, linhas 93–168 |
| Bayes local pointwise | PASS | resultados, linhas 93–131 e 716–753 |
| Borelidade de `pi`, `chi`, ballot e payoffs | PASS | resultados, linhas 122–131, 232–254 e 737–742 |
| Reparametrização `rho`, inversa e endpoints | PASS | resultados, linhas 133–168, 623–637 e 979–1026 |
| Melhor resposta de `H` e atingimento a posterior fixo | PASS | resultados, linhas 278–328 |
| Contraexemplo ao fechamento global | PASS | resultados, linhas 330–375 |
| Existência regional de algum PBE para algum `rho` | PASS | resultados, linhas 376–403 e 639–680 |
| Supremo off-path em suporte puro finito | PASS | resultados, linhas 405–440 |
| Classificação pura completa e imitação | PASS | resultados, linhas 443–523 |
| Fronteiras, igualdade e endpoints puros | PASS | resultados, linhas 524–637 |
| Teorema misto AM-MSB-T4, inclusive desvios mistos | PASS | resultados, linhas 682–801 |
| Factibilidade e cutoff uniforme | PASS | resultados, linhas 289–310 |
| Kernel terminal literalmente uniforme e empate `E/P` | PASS | resultados, linhas 199–254 e 271–276 |
| Definição da lei conjunta `Gamma_theta` | PASS | resultados, linhas 814–918 |
| Payoffs fracos condicionados ao tipo | PASS | resultados, linhas 884–914 |
| Fechamento do conjunto de PBEs sob permutação comum | PASS | resultados, linhas 920–949 |
| Reynolds como quociente diagonal exato | **FAIL** | clarificação, linhas 59–68; resultados, linhas 951–977; Finding `AM-FR1-ANON` |
| Produto fibrado na mesma coordenada `rho` | PASS condicional | resultados, linhas 1028–1056; a fibra está correta, mas a assinatura dentro dela requer o reparo de `AM-FR1-ANON` |
| Teorema cardinal atomless | PASS | resultados, linhas 1058–1091 |
| Testemunhas semipooling e misturas de fronteira | PASS | resultados, linhas 1093–1169 |
| Limites de payoff e impossibilidades | PASS | resultados, linhas 1171–1197 |
| Escopo/proveniência de AMX-009 | PASS limitado ao comparador histórico `E_F`; não é família corrente sob S | resultados, linhas 1198–1217; artefato histórico, linhas 466–603 |
| Escopo/proveniência de AMX-NEG-001 | PASS como lema histórico importado; não revalidado pelo pacote corrente | resultados, linhas 1219–1244; artefato histórico, linhas 732–819 |
| Limites do verificador | PASS | script, linhas 1–7; output preservado; Gate 0, linhas 522–556 |
| IC/D1, `A_U`, `AC` e `AR` não importados silenciosamente | PASS | decisões, linhas 58–73 e 104–109; resultados, linhas 10–11, 1046–1056 e 1265–1272 |

## 6. Tabela claim a claim do ledger

`PASS` significa que o enunciado exato da linha sobreviveu à auditoria dentro
do escopo declarado. `FAIL` identifica linha materialmente afetada por um
finding. `N/A` indica entregável autoralmente fora do baseline corrente.

| Claim | Veredito | Razão resumida |
|---|---|---|
| AMX-MSB-001 | PASS | loteria uniforme é membro literal de N3; ciclo só reproduz payoffs e não entra no kernel |
| AMX-MSB-002 | PASS | cutoff comum segue de M/S e do voto pivotal; igualdade aceita |
| AMX-MSB-003 | PASS | conjunto aceito condicional é compacto; acordo e rejeição são atingidos |
| AMX-MSB-004 | PASS | o separating numérico é PBE e refuta fechamento global |
| AMX-001 | PASS | as três regiões cobrem o domínio e dão testemunha construtiva; quantificador é `existe rho` |
| AMX-002 | PASS | pooling com acordo: `O_1<=A_nu` é necessário e suficiente |
| AMX-MSB-005 | PASS | pooling com atraso: as duas restrições off-path são exatas |
| AMX-MSB-006 | PASS | imitação força parcela comum; posterior alcançado preserva separação de pooling |
| AMX-003 | PASS | intervalo do caso baixo-acordo/alto-atraso contém exatamente IC, factibilidade e off-path |
| AMX-MSB-007 | PASS | no sinal baixo, `D_1(0)>D_0(0)` contradiz a imitação bilateral |
| AMX-004 | PASS | quatro desigualdades de atraso–atraso são necessárias e suficientes |
| AMX-005 | PASS | suporte do prior fixa crenças; medidas endpoint ficam no argmax global tipo a tipo |
| AMX-006 | PASS | condições `beta*o_1>=Z_E` e `A(mu_A)>=beta*o_1` cobrem todos os desvios da família |
| AMX-MSB-008 | PASS | capacidade uniforme `.5914` é menor que `.63`; testemunha histórica falha sob S |
| AMX-007 | PASS | medidas de fronteira, incluindo `ell=0,1`, obedecem Bayes e incentivos |
| AMX-008 | PASS | S elimina a geometria admissível de preços por incidência; sobra preço comum |
| AMX-009 | PASS | comparador histórico foi definido e corretamente separado do singleton uniforme corrente; não é claim de existência corrente |
| AMX-010 | PASS | limites seguem de desvios garantidos e da diferença payoff a payoff entre tipos |
| AMX-011 | PASS | aprovação usada pelo alto com probabilidade positiva mais imitação e `u_1>=u_0` força valores iguais |
| AMX-012 | PASS | quatro impossibilidades puras seguem da mesma proposta ou da imitação; atraso–atraso exige `o_0>1/m` |
| AMX-013 | PASS limitado | `3944 PASS / 0 FAIL` foi reproduzido; é somente cobertura mecânica |
| AMX-014 | PASS | cinco classes esgotam perfis puros; endpoints são os membros de Dirac das classes de argmax |
| AMX-015 | PASS | T4 é um `iff` bem tipado e cobre todo `Y`; a sobreafirmação local da Seção 8.3 não altera o teste de membership |
| AMX-MSB-009 | PASS | a família atomless é injetiva em `epsilon` e a linha é fixa pelo grupo |
| AMX-016 | **FAIL** | `Gamma_theta` é correta antes do quociente, mas a média de Reynolds não identifica exatamente órbitas diagonais |
| AMX-NEG-001 | PASS limitado | status de lema histórico importado e limite de revalidação estão explícitos |
| AMX-MSB-010 | **FAIL** | fechamento por permutação passa; a afirmação de que Reynolds elimina somente rotulação estéril é falsa |
| AMX-MSB-011 | PASS | `b_rho` é homeomorfismo no prior interior e as fibras são pré-imagens exatas para `chi` fixa |
| IC-D1-BENCHMARK | N/A | corretamente `pending/nonblocking`; não foi aplicado silenciosamente ao baseline |

## 7. Findings

### AM-FR1-ANON — `important`

**Enunciado.** O operador de Reynolds definido sobre a dupla de leis não é um
invariante completo do quociente pela ação diagonal exigida pela clarificação.
Ele pode identificar órbitas diagonais distintas.

**Norma aplicável.** A clarificação, linhas 59–68, exige que a **mesma**
permutação atue sobre o perfil inteiro. Os resultados, linhas 951–964, definem

```text
Anon(Gamma_0,Gamma_1)
  = |G|^{-1} sum_g (g#Gamma_0,g#Gamma_1).
```

Como a soma num produto vetorial é coordenada a coordenada, essa expressão é
igual ao par das duas médias marginais. O fato de se escrever o mesmo `g` em
cada parcela não preserva a relação entre as duas coordenadas depois da soma.

**Contraexemplo interno.** Use `N=5`, `m=4`, `k=2`, `beta=.9`, `o_0=.7`,
`o_1=.8`, `nu=.5`, `rho=1`. O ramo `E` é único, o preço é `.225`, o melhor
acordo dá `.55` e atrasar dá `.63` ao tipo baixo e `.72` ao alto. Para cada
coalizão `C` de dois fracos, seja

```text
y_C=(.8, .1*1_C),
```

que é factível e rejeitada. Compare dois PBEs separating com atraso dos dois
tipos:

```text
P=(delta_{y_{12}}, delta_{y_{34}}),
Q=(delta_{y_{12}}, delta_{y_{13}}).
```

Nenhuma permutação comum leva `P` a `Q`, pois a interseção entre as coalizões
dos dois tipos tem cardinalidade zero em `P` e um em `Q`, invariante sob
`S_4`. Contudo, Reynolds torna cada marginal uniforme sobre as seis coalizões
de tamanho dois e, portanto, `Anon(P)=Anon(Q)`.

**Consequência.** O lema de fechamento por permutação continua correto, assim
como `Gamma_theta` antes de anonimizar. Falham, porém, a alegação de que a média
remove *somente* rotulação estéril e a exatidão downstream de `AMX-016`. O
problema também pode gerar uma média que não é a imagem de um único assessment
com um mapa público pointwise `pi(y)`. Sob a decisão autoral já aprovada, a
assinatura precisa guardar um objeto completo da órbita diagonal da dupla; se
se desejar uma equivalência marginal mais grossa, isso exige nova decisão
autoral, não pode ser obtido chamando a média atual de quociente diagonal.

**Claims afetados:** `AMX-016` e a segunda metade de `AMX-MSB-010`.

### AM-FR2-POINTWISE — `minor`

**Enunciado.** As três primeiras afirmações locais da Seção 8.3 são escritas
ponto a ponto, mas T4 garante igualdade de payoff somente
`sigma_theta`-quase em toda parte. Em suporte atomless, um ponto do suporte pode
ter massa zero e payoff estritamente abaixo do valor de equilíbrio.

**Contraexemplo interno.** Na mesma instância acima, ponha `r=.225` e, para
`0<=t<=delta<.225`,

```text
y(t)=(.55,.225,.225-t,t,0).
```

Em `t=0`, dois fracos recebem o cutoff e o pacote passa, dando `.55` a `H`.
Em todo `t>0`, apenas um fraco cobre o cutoff e o pacote é rejeitado. Se
`sigma_0=sigma_1` é atomless com suporte nessa curva, então `pi=.5` em todo o
suporte e `y(0)` pertence ao suporte, mas tem massa zero. Quase certamente há
atraso, logo `V_0=.63` e `V_1=.72`, enquanto `z_H(y(0))=.55`. Portanto
`0<pi(y(0))<1` e aprovação não implicam pontualmente
`V_0=V_1=z_H(y(0))`.

**Consequência.** É necessário formular essas observações em termos de átomos,
uso com probabilidade positiva ou igualdade quase em toda parte. O `iff` de T4
permanece válido porque suas linhas 780–783 já usam a formulação correta. O
claim mais estreito `AMX-011`, sobre aprovação usada pelo tipo alto com
probabilidade positiva, também permanece válido.

**Claims afetados:** nenhuma linha substantiva do ledger é refutada; o texto de
apoio da Seção 8.3 precisa de qualificação.

## 8. Contagens exatas

| Severidade | Contagem |
|---|---:|
| critical | 0 |
| important | 1 |
| minor | 1 |

Contagem final: **0 critical / 1 important / 1 minor**.

## 9. Verificações mecânicas e seu limite

Reexecutei:

```text
Rscript --vanilla scripts/verify_agenda_extension_A_M_msb.R
SUMMARY | 3944 PASS | 0 FAIL
```

Também usei um contraexemplo combinatório independente para `m=4,k=2`: pares
de coalizões com interseção zero e um pertencem a órbitas diagonais distintas,
mas suas duas médias marginais têm o mesmo suporte uniforme de seis coalizões.

Essas verificações sustentam aritmética, factibilidade, cutoffs e exemplos. Não
provam existência/completude de PBE, limites de Bayes em todo suporte,
mensurabilidade abstrata, necessidade/suficiência de T4 ou exatidão do
quociente. Em particular, `3944/0` não foi tratado como prova.

## 10. Possível formalização

| Componente | Formalização sugerida | Observação |
|---|---|---|
| limites `0<r<=beta/m`, `kr<1` e `T>1/m` | Lean, baixa dificuldade | álgebra finita e desigualdades |
| condições puras de imitação | Lean, baixa–média | enumeração das quatro combinações de outcomes |
| contraexemplo de Reynolds em `S_4` | Lean ou verificador exaustivo, baixa | ação finita e cardinalidade de interseção |
| lema do suporte finito | Lean, média | exige topologia básica do simplex |
| Bayes pointwise/Besicovitch e T4 em medidas Borel | não prometer sem infraestrutura nova | MeasureTheory e kernels são substancialmente mais difíceis |

## 11. Limites honestos do parecer

1. Não formalizei os resultados em Lean e não substituo prova matemática por
   enumeração numérica.
2. O teorema de diferenciação de Besicovitch foi verificado quanto à aplicação
   padrão no simplex euclidiano finito-dimensional, não reprovido do zero.
3. AMX-NEG-001 foi auditado quanto a escopo, lógica do argumento importado,
   caminho e hash; continua explicitamente um lema histórico, não uma prova
   autocontida do pacote M/S/B.
4. AMX-009 foi aceito somente como comparador histórico do ramo `E_F` e como
   afirmação negativa sobre seu transporte para S; não como família atual para
   todo posterior.
5. Não auditei `A_U`, `AC`, `AR`, IC/D1 nem o manuscrito. Eles estão fora do
   escopo autoral deste nó e não foram importados silenciosamente.
6. Não fiz verificação bibliográfica externa; as referências não são usadas
   para preencher nenhuma etapa algébrica ou estratégica faltante.

## 12. Veredito final

FAIL
