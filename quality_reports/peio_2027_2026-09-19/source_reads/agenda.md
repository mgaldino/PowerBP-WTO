# Leitura independente: agenda, correspondências e consumidores do baseline

**Reader ID:** `agenda_source_read`  
**Data:** 2026-09-19  
**Papel:** leitor de compreensão e dependências; sem crítica científica, derivação nova ou edição do manuscrito.  
**Fonte principal:** `formal_model_v6.Rmd`, SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`.  
**Checkout observado:** branch `codex/exposition-items20-28`, HEAD `26b1a40cb98933ae3cd5fd43dd4b7e691b13f5ba`. No início, a única linha de `git status --short` era o diretório não rastreado `quality_reports/peio_2027_2026-09-19/`.  
**Cobertura integral atribuída e lida:** seção 6, linhas 888–1241; B.7–B.9, linhas 1648–2027; E/F, linhas 2140–3118. Foram consultadas definições e remissões das seções 1/2/4/5/7/8 e A.2 para resolver termos e dependências. Os localizadores abaixo são linhas da fonte Rmd, não páginas do PDF.

O argumento da extensão acrescenta uma proposta obrigatória de H numa data anterior ao baseline e usa o próprio baseline como continuação após rejeição. Seus objetos completos incluem estratégias, crenças, seletores de continuação e leis de resultados; os vetores de payoffs são imagens desses objetos. A comparação institucional preserva economia, especificação off-path e ligação entre tipos. Os resultados quantitativos têm domínios expressos de existência e seleção.

A leitura não atribui adoção autoral a A1–A3. A nota `quality_reports/architecture_2026-09-08/architecture_note.Rmd`, SHA-256 `493f513a096bd78d9addf32d1c407c9a9e8be3945edf6580497d4c27630dd3b3`, afirma transporte econômico condicional e exclui expressamente a certificação das assinaturas completas de agenda. O mapa ao final identifica os consumidores a revalidar **caso** essa arquitetura seja adotada; não demonstra que o levantamento já existe.

## 1. Seção 6: jogo de agenda e comparação pública

**Tese da unidade.** Propor antes do baseline cria um componente público de poder de agenda cujo sinal institucional varia com o payoff de desacordo. A data e a obrigatoriedade fazem parte do experimento teórico.

| Claim explícito | Localizador | Evidência usada pelo texto | Escopo/hedge |
|---|---|---|---|
| A extensão é um jogo separado: H deve propor em A; rejeição entra em R1 e desconta uma vez por β. | 890–897; 466–479 | Descrição do protocolo; E.1, 2152–2162. | Sem opção de saltar A e obter imediatamente a continuação. |
| Unanimidade pública paga `1−β+β²o`; maioria usa a fórmula com inclusão até `o=1/m` e máximo entre passagem segura e `βo` acima. | 926–973 | Proposição `agenda-public`; E.6–E.8. | `o∈(0,1)`, β estritamente abaixo de um; seleção de igualdade `o=1/m`. |
| Sob maioria pública, há passagem, empate passagem/atraso ou atraso conforme `o` relativamente a `o_M*=1/β−k/m`. | 939–948 | Maximização entre proposta mínima que passa e rejeição deliberada. | Todas as loterias sobre coalizões mínimas são retidas; mistura no empate deve ligar resultados e probabilidade. O ramo de atraso pode ser vazio no domínio. |
| `Δv^A=v_U^A−v_M^A` é negativo no primeiro ramo; acima de `1/m`, seu sinal é o de `βo−e/m`. | 950–977 | Subtração das fórmulas públicas, E.8. | Não há ranking público uniforme. |
| Figura pública é ilustração de `m=4, β=.90, k=e=2` e mostra igualdade e limite à direita separados. | 979–997 | `figure_agenda_public_gap.pdf`; caption com três pontos de referência. | Não é evidência empírica ou generalização para outros parâmetros. |

**Não-afirmações.** A seção não afirma que agenda pública sempre favoreça unanimidade ou maioria; não equipara o direito obrigatório em A a um direito opcional; não identifica o contraste com uma mudança empírica na OMC.

**Ambiguidade textual localizada.** As linhas 992–995 dizem que “majority buys the hegemon's relatively cheap vote”. Em A, H é proponente e compra votos fracos; E.6 e o próprio início da seção identificam o preço como herdado da continuação majoritária em que um fraco propõe. A leitura consistente é que a frase se refere ao regime do baseline que determina o preço em A. O referente temporal não está explicitado naquela frase. Registro de compreensão, sem julgamento da validade das fórmulas.

**Termos a preservar.** `A`/`B` identificam jogos/datas; `k` é número de votos fracos exigidos em A; `e=m−k`; `v_M^safe`; `o_M*`; unanimidade menos maioria é sempre a orientação de `Δ`.

## 2. Seção 6: agenda privada, multiplicidade e região uniforme

**Tese da unidade.** A comparação privada é uma correspondência de pares de assessments completos compatíveis. Apesar da multiplicidade, existe uma condição suficiente que dá vantagem à maioria para ambos os tipos e ex ante em toda a correspondência.

| Claim explícito | Localizador | Evidência usada pelo texto | Escopo/hedge |
|---|---|---|---|
| `B_g(d,ρ,μ^off)` é correspondência de assessments completos; seus payoffs por tipo formam vetores ligados. | 1025–1038 | Definição; E.2/E.3. | Inclui propostas Borel, pooling, separação, acordo e atraso admissíveis; não reduz a forma pura preferida. |
| Unanimidade tem a imagem de payoffs por células expressa em 1042–1052. | 1039–1056 | B.8/E.3, distinção entre famílias baixa/alta e endpoints. | `∅` significa inexistência na classe mantida de votos puros, nas crenças e parâmetros especificados. |
| Figura de existência mostra apenas as células do exemplo `m=4, β=.90, ℓ=.10, h=.35`; a família de prior baixo falha em sua condição de payoff. | 1058–1080 | `figure_agenda_unanimity_existence.pdf`; aplicação da correspondência. | Cinza não recebe comparação de payoff; endpoints só preservam `(0,0)` e `(1,1)`. |
| O produto de comparação exige mesma economia e mesmo par de crenças off-path; o ex ante é calculado depois do vetor por tipo. | 1084–1099 | `J_A^cmp`; E.4. | Não combina o tipo baixo de um assessment com o alto de outro. |
| Se ambos os lados existem e `βh<e/m`, toda diferença é no máximo `−β(e/m−βh)<0`. | 1104–1126 | Limite inferior majoritário B.7 e superior unânime B.8. | Suficiente, não necessário; igualdade dá ranking fraco. Exemplo de não necessidade em E.5. |

**Não-afirmações.** Não afirma existência de maioria para todo `ρ` fixo, existência unânime em todas as células, ranking em célula vazia nem necessidade de `βh<e/m`. Não promove o intervalo escalar de um tipo a produto cartesiano livre entre tipos.

**Ambiguidades.** Nenhuma ambiguidade material remanescente sobre o domínio das comparações após ler E.2–E.5. A expressão “complete assessment” precisa manter o sentido definido em 435–442; não é sinônimo de vetor de payoff.

**Termos.** `d`, `ρ`, `μ^off`, `B_g`, `V_g^A`, `J_A^cmp`, `p*`, `∅`, “selection-free”, “linked”.

## 3. Seção 6: rendas e contabilidade da etapa de agenda

**Tese da unidade.** O ganho privado pode ser decomposto em ganho público e diferença de renda informacional; a comparação de agenda com baseline precisa usar datas iguais e manter as fontes completas de cada parcela.

| Claim explícito | Localizador | Evidência usada pelo texto | Escopo/hedge |
|---|---|---|---|
| `IR_g^A(o)=V_g^A(o)−v_g^A(o)` e `ΔV^A=Δv^A+ΔIR^A`. | 1130–1143 | Definições e álgebra; E.9/E.10. | Identidade por assessment e tipo; ex ante usa o mesmo vetor. |
| Em toda unanimidade existente, a renda do baixo é não negativa e a do alto não positiva, com ao menos uma desigualdade estrita. | 1145–1157 | Imagem exata unânime; B.8 e E.9. | Não é claim de que ambos os tipos ganhem com informação privada. |
| Se o baixo tem desvantagem pública unânime e vantagem privada unânime num par comparável, a diferença de renda mais que compensa a desvantagem. | 1158–1166; 1001–1020 | Identidade; exemplo teórico `.5905/.1810/.7290`. | “Se” e “para esse assessment”; não é resultado universal. A tabela altera `h` para `.90`. |
| `I_g=IR_g^A−βIR_g^B`; unanimidade reduz fracamente a renda nos parâmetros de prior alto em que as fontes existem. | 1168–1178 | F.2. | Maioria e diferença institucional podem permanecer set-valued. Uma única aplicação adicional de β. |
| `T_g=V_g^A−βV_g^B=D_g+I_g`, com `D_g=v_g^A−βv_g^B`. | 1180–1203 | E.11; substituição de `V=v+IR`. | Identidade contábil entre jogos definidos, não estimação empírica. |
| `D_U=1−β`; `D_M≥0`, podendo ser zero; `T_U≥0` onde ambos os jogos existem. | 1191–1222 | E.12/E.13. | `D_M` contém descontinuidade da seleção em `1/m`; não agrega células inexistentes. |
| `T_M` e `ΔT=ΔD+ΔI` dependem da correspondência; `Q=v^A−βV^B` altera agenda e informação simultaneamente. | 1224–1240 | E.13/E.14. | Não atribui signo global a `T_M`; `Q` é contraste composto. |

**Não-afirmações.** Renda informacional positiva não é atribuída ao alto sob unanimidade; o exemplo não é calibração. `T` não é efeito de conceder um direito opcional sem alterar a data. `Q` não é medida isolada de agenda.

**Ambiguidades.** Nenhuma material sobre decomposição após E.11–E.14/F.2–F.4. O uso de “total” permanece ligado aos dois jogos e datas definidos.

**Termos.** Renda informacional, componente público, interação, contraste institucional, vetor ligado, data A, total `T`, direto `D`, interação `I`, diagonal `Q`.

## 4. B.7: correspondência privada de maioria com agenda

**Tese da unidade.** Fixado um seletor anônimo Borel Markov de membros da continuação majoritária, a proposta de H enfrenta um preço positivo comum por voto fraco e uma opção de rejeição por tipo; esses objetos geram formas puras, um critério de membership para misturas e um limite inferior uniforme.

| Claim explícito | Localizador | Evidência/estrutura da prova apresentada | Escopo/hedge |
|---|---|---|---|
| `χ:[0,1]→C_M` seleciona estados E/S/P/EP; `r_χ=βc_χ`, `d_χ,o=βh_χ,o`; `0<r≤β/m`. | 1650–1683 | Interface de continuação; preço pivotal e passagem com exatamente k votos. | χ fixado, anônimo, Borel e Markov; não é toda escolha arbitrária de continuação. |
| Para suporte puro finito, o supremo off-support é `O_o=max{a^pass(μ^off),d_o(μ^off)}`. | 1685–1701 | Propostas perturbadas que evitam o suporte; rejeição disponível. | Uso de supremo, inclusive quando a proposta canônica cai no suporte. |
| Enumeração pooling/separação × aprovação/rejeição é exaustiva para formas puras. | 1703–1737 | Restrições de imitação, factibilidade e desvios; tabela E.2. | Baixo atrasa/alto passa é impossível segundo a comparação estrita citada; separação com mesmo payoff pode ter mensagens distintas. |
| Membership Borel exige desigualdade em todo suporte, igualdade quase certamente sob a lei de cada tipo e limite dos desvios fora do suporte. | 1739–1778 | `u_o`, integral V, supremo off-support e prova de Borelidade. | Inclui suportes atomless e pontos limite de massa zero; igualdade não é postulada em todos os pontos. |
| Endpoints preservam posterior e as medidas podem variar no argmax por tipo. | 1780–1784 | Suporte do prior e problema de maximização. | Conserva o tipo de probabilidade zero. |
| Há existência para algum ρ em toda economia admissível; todo assessment paga ao menos `max{v_M^safe,β²o}`. | 1786–1829 | Três construções em torno de T e proposta segura com pagamentos β/m. | Existência não é para todo ρ; limite independe da seleção entre assessments existentes. |

**Não-afirmações.** A prova não substitui medidas Borel por enumeração numérica finita nem o supremo pelo máximo sem checar atingimento; não permite que χ varie oportunisticamente durante uma comparação a posterior/ρ fixado.

**Ambiguidades resolvidas por fonte de derivação.** O símbolo `C_M` do manuscrito registra rótulos compactos; os representantes concretos são loterias uniformes sobre coalizões e misturas E/P com o mesmo peso em todos os objetos. A fonte `agenda_extension_A_M_msb_results.md`, 183–267 e 305–323, explicita membership literal, função de payoff e kernel. Isso esclarece a leitura da referência abreviada; não transporta sua validade automaticamente para outra árvore.

**Termos.** Estado de continuação, representante uniforme, χ, cutoff, membership, suporte, quase certamente, supremo, argmax, Borel.

## 5. B.8: correspondência privada de unanimidade com agenda

**Tese da unidade.** A inexistência do baseline unânime em certos posteriores restringe todo sinal de agenda, inclusive os que permitiriam rejeição apenas por desvio de voto; dadas essas restrições, duas famílias esgotam a correspondência interior.

| Claim explícito | Localizador | Evidência/estrutura da prova apresentada | Escopo/hedge |
|---|---|---|---|
| Todo posterior disciplinado e off-support deve pertencer a `P_C={0}∪(p*,1]`. | 1833–1867 | Um voto não pode rejeitar e requerer continuação no mesmo posterior; baseline vazio no intervalo excluído. | Independe de a proposta ser aceita no caminho. |
| No interior, ambos os tipos recebem o mesmo payoff em equilíbrio. | 1869–1880 | Imitação bilateral; rejeição e propostas de posterior zero. | Desvios pontuais continuam regulados em pontos de massa zero. |
| Massa positiva de posterior zero exige `z_L≥d`, `μ^off=0`, payoff `z_L` e átomo baixo em `x^ℓ`. | 1882–1918 | Divisão pela massa λ₀ e testemunha pura `x^ℓ/x^S`. | Família de posterior baixo; atraso em sinais altos só na igualdade `z_L=d`. |
| Sem massa de posterior zero, `p>p*`; com off-support zero, payoff comum é intervalo `[max{z_L,d},z_H]`. | 1920–1936 | Bayes plausibility, melhores desvios e pooling que realiza cada z. | Leis Borel completas ainda obedecem às restrições pontuais de E.3. |
| Com off-support alto, só `δ_xh` para ambas as leis; não há terceira família. | 1938–1945 | Desvio `x^h`, limite de factibilidade e inexistência de continuação no intervalo baixo positivo. | Multiplicidade interna da continuação continua no assessment. |
| Endpoints são correspondências completas; todo payoff unânime é no máximo `z_H`. | 1947–1964 | Argmax por tipo, preços mínimos e valor da rejeição. | Preserva tipo de probabilidade zero e não usa limites laterais como substituto. |

**Não-afirmações.** O texto não afirma payoff privado superior ao público para o alto, unicidade de todo assessment quando o payoff é único ou que qualquer posterior obtido por qualquer lei Borel seja admissível.

**Ambiguidades.** Nenhuma material remanescente. A referência à continuação literal deve continuar incluindo estratégias off-path, ainda que o preço e payoff sejam constantes numa célula.

**Termos.** `P_C`, `z_L`, `z_H`, `d=β²h`, `λ₀`, família de posterior baixo/alto, prior versus posterior, endpoint, tipo contrafactual.

## 6. B.9 e F.1: identidade exata e representação econômica

**Tese da unidade.** Duas reduções distintas organizam os resultados: a assinatura exata preserva a órbita diagonal do par de leis realizadas; o resumo econômico retira nomes dos fracos de cada tupla e permite fatorar observáveis anônimos. Nenhuma dessas operações substitui o assessment para operações sensíveis ao off-path.

| Claim explícito | Localizador | Evidência/estrutura apresentada | Escopo/hedge |
|---|---|---|---|
| `Z_g` registra proposta nomeada, posterior, passagem, estado de continuação e tupla terminal; é compacto polonês. | 1968–1982 | Construções concretas E.2/E.3 e ação finita de permutações. | Relabeling preserva feasibility, payoffs, Bayes, ballots, kernels e desvios. |
| A lei uniforme da órbita diagonal em `P(Z_g)^2` é Borel e invariante completo dessa equivalência. | 1984–2000 | Soma finita; coincidência das órbitas inferida por massa em singleton. | Invariante das leis realizadas sob uma mesma permutação para ambos os tipos, não código de todo plano off-path. |
| Todo observável Borel anônimo na tupla fatora pelo quociente; integrais fatoram pelas leis pushforward. | 2002–2026 | Transversal Borel finita e invariância. | As funções off-path e suportes nomeados ficam no assessment. |
| Produto institucional precede a fatorização econômica. | 2983–2997 | E.4 e fórmula `C_econ= Cbar_econ(Sum_M,Sum_U)`. | Sem recombinar coordenadas, estratégias ou mensagens de fontes diferentes. |
| Envelope escalar usa extremos de conjuntos; seu intervalo é hull e pode não ser atingido. | 2999–3023 | Definições de imagens M/U e de contrastes. | Não afirma que o conjunto exato de contrastes seja o intervalo inteiro. |
| O objeto de outcomes é par ordenado de leis marginais anônimas por instituição e tipo. | 3024–3038 | `O_A` como imagem do produto de assessments. | Uma realização aleatória comum entre regras precisaria de primitiva adicional. |

**Não-afirmações.** A assinatura exata não é assessment médio nem substitui estratégias completas. Igualdade de resumos econômicos não estabelece igualdade de propostas nomeadas, suportes, crenças ou planos fora do caminho. Não existe acoplamento contrafactual comum implicitamente autorizado.

**Ambiguidades.** O adjetivo “exact” seria ambíguo se isolado; E.3:2558–2565 e F.1:2976–2997 o restringem explicitamente à órbita das leis realizadas. Essa restrição resolve a leitura.

**Termos.** `Γ_o`, `Λ_γ`, `Sig^ex`, `Sum^econ`, `q_#Γ`, ação diagonal, lei conjunta dentro de um jogo, marginais entre jogos, complete assessment/binder, intervalo hull.

## 7. E.1–E.3: contratos, medidas e objetos completos

**Tese da unidade.** Estes apêndices tornam operacionais o jogo de agenda, o uso do baseline e a parametrização completa das estratégias; não são apenas tabelas de payoffs.

| Claim explícito | Localizador | Evidência | Escopo/hedge |
|---|---|---|---|
| H conta como sim em A; votos fracos são simultâneos e puros; passagem implementa; rejeição entra em R1. | 2142–2162 | Contrato explícito do jogo. | H não tem um segundo voto separado em A. |
| Toda história rejeitada tem seletor total, público e Borel que devolve um assessment completo, comum aos tipos compatíveis. | 2164–2169 | Lista de estratégias, crenças, reconhecimento, ballots, payoffs e resultados. | Um escalar de continuação não satisfaz o tipo da interface. |
| ρ fixa a mesma crença em todo sinal não disciplinado; crenças dentro do baseline seguem A.2. | 2171–2193 | Regras de atualização e distinção expressa de níveis. | Regra global de agenda é mais forte que a liberdade local por votação do baseline; endpoints preservam suporte. |
| `R_M=(ρ,μoff,σℓ,σh,σbar,μhat,χ,b_M,uℓ,uh)`. | 2258–2305 | Medidas de proposta, restrições de membership, argmax de endpoints. | `b_M` é indicador escalar gerado pelo vetor de votos completo. |
| `Ω_D^M`, `K^D_o,ξ`, `L_o^{R_M}` e `Γ_o^{M,R_M}` registram realizações literais das continuações. | 2307–2360 | Integral conjunta que usa a mesma σ, μ, χ e kernel. | Liga proposta, posterior, passagem, rótulo e terminal; assinatura não descarta essa ligação. |
| `R_U=(σℓ,σh,μ,μoff,κhat_U,b_U,Ω,Γℓ,Γh)` inclui continuação completa e full ballot map. | 2385–2405 | Definição dos componentes e condições pontuais. | `b_U` é vetor de votos; `a_U` será indicador de passagem, 2533–2539. |
| Famílias baixa/alta incluem leis assimétricas, discretas, semipooling, mistas e atomless nas condições declaradas. | 2407–2497 | Member generators, rejeição em igualdade e endpoints. | Anonimidade da continuação não impõe simetria à proposta corrente. |
| A imagem unânime é intervalo de vetores ligados, unidimensional. | 2499–2517 | Fórmula por células. | Não é um retângulo obtido cruzando intervalos marginais. |
| `C_U`, `Ω_D^U`, `Z_U`, `Γ` e assinaturas ligam continuação literal e law realizada. | 2519–2567 | Definição de espaços e pushforwards. | Multiplicidade off-path continua no assessment, mesmo quando a lei corrente é única. |

**Não-afirmações.** Nem o seletor nem os kernels podem ser substituídos livremente por qualquer objeto de mesmo payoff; o baseline não adota por isso a restrição Markov da agenda. A ausência de uma continuação não pode ser convertida em valor zero.

**Ambiguidades resolvidas com os contratos de derivação.** E.1 lista a história inteira, enquanto E.2 usa χ(μ) e E.3 usa κ̂_U(μ). Os documentos de origem explicitam que a seleção de agenda depende apenas de regra, estágio e posterior, não de proposta nem vetor rejeitado: `agenda_extension_A_M_msb_results.md`, 90–103, e `agenda_extension_A_U_msb_contract.md`, 39–47/128–133. A história é retida no assessment; a dependência admissível do seletor é mais estreita. “Disciplinado” corresponde a todo suporte, inclusive pontos de massa zero, e exige limite local de Bayes existente: fonte de maioria 106–144. O manuscrito usa essa regra abreviadamente em B.7/E.3.

**Termos.** Assessment/binder, seletor total, estado Markov, anonimidade, membro literal, lei Borel, suporte versus átomo, disciplined/undisciplined, kernel, Ω, Γ.

## 8. E.4–E.10: comparação, benchmarks e renda

**Tese da unidade.** A comparação exata e seus corolários são imagens de fontes completas; os resultados públicos e as rendas por tipo oferecem decomposição e limites sem eliminar multiplicidade.

| Claim explícito | Localizador | Evidência | Escopo/hedge |
|---|---|---|---|
| Comparação é produto restrito na mesma economia/off-path; dominância é setwise; cruzamento significa seleção; vazio não tem ranking. | 2569–2606 | Definições e imagens afins. | Propostas e realizações de continuação podem diferir entre regras. |
| A região `βh<e/m` é suficiente; há exemplo de não necessidade e condição local mais fraca. | 2608–2656 | Limites B.7/B.8 e exemplo `m=4,β=.9,ℓ=.5,h=.6,p=0`. | No endpoint, condição local sozinha garante apenas o ex ante sem usar vetor contrafactual completo. |
| Benchmarks públicos majoritário/unânime e gap têm todos os ramos e convenções de empate descritos. | 2658–2724 | E.6/E.7/E.8; preços e maximização de H. | Peso de mistura público liga proposta, resultado e probabilidade; igualdade `o=1/m` pertence ao primeiro ramo. |
| Renda é translação por vetor público fixo; unanimidade tem incidência por tipo expressa em tabela. | 2726–2775 | Tabela `auri` e imagens por célula. | Maioria não recebe sinal global imposto. |
| A decomposição de diferença de rendas não determina seu sinal, mesmo sob o limite favorável à maioria. | 2777–2814 | Identidade e desigualdade vinculadas a cada assessment. | Exemplo teórico somente; incidência por tipo precede agregação. |

**Não-afirmações.** Nem envelope, exemplo numérico ou limite suficiente representam uma escolha única de equilíbrio. Não se elimina a dependência de crenças nem se infere que o componente informacional sempre favoreça unanimidade.

**Ambiguidades.** Nenhuma material remanescente. A condição local em 2653–2656 é distinta do limite global em `h`, e deve continuar distinguida.

**Termos.** Comparável, setwise, margem, condição suficiente/local, translação por vetor fixo, incidência por tipo.

## 9. E.11–E.14 e F.2–F.4: diferenças entre jogos e limites

**Tese da unidade.** Toda diferença entre agenda e baseline é calculada na data A a partir das fontes requeridas; inexistência se propaga, e o resultado inclui o valor de antecipar o jogo e impor a proposta obrigatória.

| Claim explícito | Localizador | Evidência | Escopo/hedge |
|---|---|---|---|
| A tabela de quatro quantidades usa β apenas nos valores baseline; `T=D+I`. | 2816–2840 | Definições e substituição algébrica. | Data mais cedo e proposta obrigatória integram T. |
| `D_M`, `D_U` e `ΔD` têm ramos completos e seleção de igualdade explícita. | 2842–2875 | Fórmulas e salto à direita de `1/m`. | Cutoff de atraso pode sair do domínio. |
| `T_U` é não negativo onde existe, limitado por `1−β`; maioria preserva o signo assessment a assessment. | 2877–2921 | Células exatas, requisitos das fontes e comparação com `−D`. | Prior baixo pode ter agenda existente e baseline vazio; o inverso também ocorre em célula off-path baixa positiva. |
| `Q` muda dois fatores; pode existir onde T é vazio. | 2923–2954 | Public agenda menos private baseline. | Não é total privado nem interação isolada. |
| `I_g` é diferença de Minkowski de vetores ligados vindos de assessments completos. | 3040–3079 | Células unânimes e fonte baseline. | Não faz Minkowski de marginais por tipo separadamente; nenhuma escolha arbitrária de signo majoritário. |
| Inexistência de qualquer fonte requerida propaga `∅`; não há fator β adicional nos valores já na data A. | 3081–3104 | Regras de existência e datas. | Verificação abstrata referenciada a B.7–B.9, não inferida de checks numéricos. |
| Interpretação de T é restrita à alteração modelada; signos robustos são setwise. | 3106–3117 | Declaração explícita de escopo. | Nem direito opcional nem estimativa empírica para OMC. |

**Não-afirmações.** Não há comparação institucional ou de agenda definida por preencher uma fonte vazia; não há claim empírico causal; não se confunde supremo de contraste com contraste atingido.

**Ambiguidades.** Nenhuma material remanescente. O termo “interaction” designa a diferença de rendas entre os dois jogos, não efeito estimado em dados.

**Termos.** Data nativa R1, transporte para A, diferença de Minkowski de vetores, fonte vazia, contraste diagonal, seleção, total modelado.

## 10. Mapa condicional de transporte/levantamento da arquitetura A1–A3

Este é um inventário de obrigações de dependência inferidas dos tipos dos objetos acima e dos limites expressos na nota; não é prova de que sejam satisfeitas. A nota distingue preservação de estratégias/votos/crenças após projetar a execução e identidade literal de jogos (`architecture_note.Rmd`, 415–466), mantém ambos os usos ótimos do recurso no empate (`258–261`), e exclui certificação de membership/assinaturas de agenda (`500–514`, `523–533`).

| Consumidor ou objeto | O que importa do baseline | Localizador | Consequência a verificar se A1–A3 forem adotadas |
|---|---|---|---|
| Protocolo de passagem em A | H proponente conta como sim e implementa pacote. | E.1:2152–2162; nota:194–207/523–525 | Tornar o sim automático abrangido pelo compromisso de A3. O nó novo “H não + aprovação” não é acionado nessa passagem. |
| Seletor total de continuação | Um assessment completo após toda história rejeitada, inclusive desvios. | E.1:2164–2169 | Sua imagem deve conter estratégias de execução e a nova árvore; igualdade de payoff isolada é insuficiente. |
| Regra Markov/anônima da seleção de agenda | Mesmo membro por regra/estágio/posterior; representantes anônimos literais. | B.7:1650–1666; E.2:2197–2209; fontes M:90–103/212–267 e U:39–47 | O levantamento precisa respeitar o estado de seleção e nomes fracos. Não pode tornar a seleção dependente de proposta ou vetor, nem importar Markov para o baseline inteiro. |
| `χ` e espaço `C_M={E,S,P}⊔({EP}×[0,1])` | Representantes uniformes de continuação R1; mistura E/P comum. | B.7:1650–1667; E.2:2307–2328 | Definir quais assessments da nova árvore são representados pelos rótulos e peso. Preservar o mesmo peso em propostas, kernel, payoffs e outcomes. |
| `c_χ,h_χ,r_χ,d_χ,a^pass` | Valores nativos por fraco/tipo e limites para votes/pass/reject. | B.7:1658–1683; E.2:2197–2213 | Transporte econômico condicional deve sustentar esses extratores e todos os argumentos de cutoff/desvio no jogo de agenda. β entra uma vez. |
| `R_M`, medidas σ, posterior, suporte, b e u | Continuação como coordenada do assessment; mapas de payoff em todas as propostas. | B.7:1739–1778; E.2:2258–2293 | Levantar fontes completas e verificar critérios pointwise e quase certamente com o mesmo posterior/lei. Preservar também plano de execução fora do caminho e tipos de peso zero. |
| `κ̂_U`, `R_U`, domínio `P_C` e member generators | Continuação literal unânime e sua existência em cada posterior. | B.8:1850–1856; E.3:2374–2405/2407–2497 | Identificar a continuação unânime correspondente na nova especificação; o ramo novo é inacessível sob unanimidade, mas a identidade usada precisa ser declarada. Não preencher células vazias. |
| `K^D_{o,ξ}`, `Ω_D^M`, `Ω_D^U` | Tuplas e kernels literais de reconhecimento, coalizão, proposta, votos e terminal. | E.2:2307–2339; E.3:2519–2545 | Determinar a representação dos terminais da nova árvore e o vínculo de suas leis com as antigas, incluindo ação de execução quando pertinente. Uma alegação de preservação deve declarar se usa projeção ou espaço ampliado. |
| `L_o^R` e leis realizadas `Γℓ,Γh` | Mistura entre terminal imediato de A e kernel baseline selecionado, sob cada lei de propostas. | E.2:2323–2337; E.3:2533–2545 | Verificar composição de medidas/kernels e compatibilidade das leis ligadas. Payoff preservado não basta para identificar a lei conjunta inteira. |
| Mensurabilidade | Seletor Borel, posterior pointwise, kernel Borel, ballot e payoff Borel. | B.7:1772–1778; B.9:1968–2026; E.1–E.3 | Qualquer levantamento/representante de execução deve ser compatível com os espaços e mapas Borel efetivamente usados; não apenas existir separadamente em cada história. |
| `Sig^ex_g`, órbita diagonal | Par ligado de leis realizadas e ação de `S_m`. | B.9:1976–2000; E.2:2341–2360; E.3:2547–2565; F.1 | Verificar transporte de relabeling/equivariance e indicar a relação entre assinaturas dos espaços velho e novo. Assinatura não recertifica planos off-path. |
| `Sum^econ_g` e fatorização | Quotiente por nomes e extratores anônimos de payoffs, passagem, atraso e outcomes. | B.9:2002–2026; F.1:2960–2997 | Revalidar os observáveis que realmente fatoram, mantendo a distinção entre identidade de laws e projeção econômica. |
| `J_A^cmp`, `C^A`, `O_A` | Dois assessments completos existentes na mesma fibra e economia. | E.4:2569–2606; F.1:2999–3038 | Transportar o domínio e os pares completos antes de resumir; não introduzir draw comum ou colagem de marginais. |
| Rendas `IR^A`, interações I e contrastes D/T/Q | Payoffs agenda completos mais benchmarks público/privado baseline e domínios. | E.9–E.14; F.2–F.4 | Revalidar fontes da translação e da diferença de vetores. As identidades algébricas não provam, por si, membership ou existência das novas fontes. |
| Figuras/tabelas da seção 6 | Fórmulas públicas, células de existência unânime e assessment numérico selecionado. | 979–1020/1058–1080; E.5/E.10 | Preservação numérica precisa ser atribuída às fontes transportadas e ao mesmo assessment; verificações de pixels não certificam levantamento. |

Uma distinção decisiva para o macro: o novo movimento de execução altera o **assessment completo** mesmo quando o caminho prescrito e a law realizada projetada permanecem os mesmos. O próprio manuscrito separa essa estrutura off-path de `Sig^ex`, que codifica laws realizadas. Logo não seria fiel exigir que a assinatura atual já codificasse toda estratégia de execução, nem seria fiel dizer que preservar a assinatura resolve automaticamente a completude das estratégias. São duas obrigações distintas.

Outra distinção: a regra `T^Y` é desempate de voto. A nota mantém correspondência de execução `{C,O}` em `x_H=o`; um representante que selecione C nesse empate é mencionado como possível, sem eliminar outras extensões ótimas. Qualquer uso de representante versus correspondência completa deve preservar esse alcance. Este relatório não escolhe representante novo.

## 11. Dependências de artefatos para retomada

Os arquivos históricos abaixo foram consultados em trechos delimitados para esclarecer os consumidores e o vocabulário. Seus hashes foram lidos do checkout, não tomados como certificação de arquitetura nova.

| Fonte | SHA-256 observado | Uso nesta leitura |
|---|---|---|
| `model_redesign/agenda_extension_A_M_msb_results.md` | `7159a7e9f84b076000b3313d89b4de9ca692a055a31cdbb9f5a5561a30a283a3` | 61–103, 106–144, 183–267, 305–323, 705–757, 790–876: membership literal uniforme, estado Markov, Bayes local, critérios Borel. |
| `model_redesign/agenda_extension_A_U_msb_contract.md` | `348ffc702d75e47ec8f8008bccb71338174649f57d90af8fc78e919cfd4ded26` | 27–90/124–146: seletores, tipos completos de continuação, restrição Markov, suporte e compromisso das coordenadas. |
| `model_redesign/agenda_extension_A_U_msb_results.md` | `e2e2ec8cabc3d44b0c72bfa8ae1ef3d35256078448ce688db79bb7c1a96cdc11` | Busca localizada por binder/literal/Borel: fontes da dupla camada e multiplicidade off-path. |
| `model_redesign/agenda_extension_AC_msb_results.md` | `8cadee000f6b8a9f94aff754fdb680f427b731bccf121ae642126a9383693d0a` | 34–63/137–188: produto de binders e alcance da fatorização econômica; ausência de acoplamento cross-world. |
| `model_redesign/agenda_extension_AR_msb_results.md` | `7a7913b6999a5cd69446d5f3e191f507f417582cd1c8617f7af0d5d8e8d331db` | Busca localizada por binder/assessment: referências às fontes indivisíveis de renda e interação. |
| `model_redesign/agenda_extension_AT_msb_results.md` | `090289d665ba39a388a69e571c10b877d8e514c611971e610c3b4a3fe0733b60` | Índice de unidades para retomada; não revisão integral. |

O status `agenda_extension_STATUS.md` e seu JSON foram usados apenas como índice para esses objetos. Cláusulas históricas de domínio (`m≥2`, `y_bar`) neles não foram importadas ao manuscrito: a fonte atual mantém `m≥3`, simplex sem teto adicional e as decisões autorais posteriores prevalecem. Este leitor não adjudicou os pareceres históricos, não executou verificadores matemáticos, não compilou nem inspecionou o PDF e não recalculou as figuras.

## 12. Perguntas e resoluções para o agente macro

1. **Referente da frase da figura pública (992–995).** A interpretação sustentada por E.6 é a compra de H na continuação baseline que define os preços de A. Convém que o contrato macro explicite essa leitura; não atribuir à extensão um voto separado de H em A.
2. **Regra de crenças de agenda versus baseline.** O contrato deve preservar o nível distinto: ρ único fora do suporte de propostas de H em A; liberdade por votação/voto de H dentro de R1/R2 segundo A.2. Uma crítica que atribua a mesma disciplina a ambos leria jogos diferentes como um só.
3. **Correspondência completa versus representante.** O codomínio de maioria em B.7/E.2 usa representantes uniformes literais, escolhidos pela extensão. Isso não declara que todo baseline admissível seja Markov nem uniforme. A seleção é parte da restrição do consumidor.
4. **Escopo da assinatura exata.** É órbita de leis realizadas, não serialização de todo plano off-path. Qualquer levantamento condicional precisa separar atualização do binder e prova sobre sua law realizada.
5. **Estado autoral.** Não encontrei, nas fontes examinadas para esta leitura, adoção de A1–A3. A nota diz o contrário em 35–55. O estado deve ser atualizado apenas por decisão nova recebida pelo agente principal, sem reatribuir aprovação retroativa.

**Estado desta entrega:** leitura atribuída completa e mapa condicional pronto para síntese. Não contém veredicto sobre validade científica do paper nem afirma que o gate global passou. A única dúvida expositiva localizada é o referente temporal em 992–995; os objetos formais dão a leitura consistente descrita acima.
