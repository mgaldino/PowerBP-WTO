# Revisão matemática final — `A_M` sob M/S/B

**Data:** 2026-08-29  
**Revisor independente:** `am_msb_formal_review`  
**Modo:** somente leitura  
**Manifesto revisado:** `quality_reports/2026-08-29_A_M_msb_review_manifest.sha256`  
**SHA-256 do manifesto:** `1f2cf9bebc4ab9ac82748df5a4a9aeac7bd5d05576100cdb58eb11eb18d8d773`

## Veredicto

**PASS — Critical: 0; Important: 0; Minor: 0.**

As 18 entradas do manifesto foram recalculadas e passaram em
`shasum -a 256 -c`. O revisor confirmou que os novos hashes sustentam os
claims candidatos `AMX-001` a `AMX-016`, `AMX-MSB-*` e o certificado
histórico `AMX-NEG-001`, dentro dos domínios e escopos declarados. Nenhuma
regressão matemática, estratégico-formal, de mensurabilidade ou de
proveniência foi encontrada.

## Conclusões substantivas

1. O domínio preserva literalmente `0<o_0<o_1<1` e, separadamente,
   `o_1<=y_bar<=1`; a invariância em `y_bar` é demonstrada pelas propostas
   relevantes, que usam no máximo `t_1=beta o_1<o_1<=y_bar`.
2. A loteria uniforme sobre coalizões é membro literal do argmax permitido por
   `N3-SC-EQ-COMPLETE`. A incidência marginal uniforme coincide com a
   implementação cíclica, provando equivalência dos vetores de payoffs
   interinos sem identificar suas distribuições terminais.
3. Os valores nativos de `C_M` recebem exatamente um fator `beta` ao serem
   transportados para `A_M`: `r_chi(mu)=beta c_chi(mu)` e
   `D_chi_theta(mu)=beta h_chi_theta(mu)`.
4. O espaço canônico `X_M={E,S,P} union ({EP} times [0,1])` é Borel. Payoffs,
   cutoff, ballot e kernels uniformes são Borel; `c_S(mu)` é corretamente afim
   em `mu`.
5. As cinco classes de outcomes puros — pooling-acordo, pooling-atraso,
   separating acordo-acordo, acordo-atraso e atraso-atraso — esgotam os PBEs
   puros interiores. A combinação atraso-baixo/acordo-alto é corretamente
   excluída.
6. `AMX-015` fornece uma condição necessária e suficiente para PBEs mistos:
   Bayes local nos pontos disciplinados, `nu_off` fora do suporte, continuação
   Borel, votação correta, igualdade de payoff no suporte de cada tipo e bound
   exato sobre desvios fora do suporte.
7. `R_boundary` trata os endpoints sem divisões por `nu` ou `1-nu`, preserva a
   estratégia contrafactual do tipo de probabilidade zero e retém todos os
   componentes da assinatura.
8. As testemunhas construtivas cobrem todas as regiões: `o_1<=T`,
   `o_0<=T<=o_1` e `T<=o_0`. A região alta inclui corretamente
   `o_0>=T>1/m`.
9. O contraexemplo ao fechamento global é válido: propostas off-path aceitas
   convergem para um sinal on-path rejeitado. A existência não utiliza
   fechamento global nem semicontinuidade superior global.
10. A prova de `AMX-010` é robusta à crença induzida: pagar `beta/m` a
    quaisquer `k` fracos garante aprovação e payoff `Z_E`; a proposta
    `(1,0,...,0)` garante rejeição e pelo menos `beta^2 o_theta`.
11. O reescopo semipooling está correto, inclusive a rejeição da antiga
    testemunha assimétrica. Misturas entre coalizões e a família atomless
    demonstram que não existe redução finita geral das assinaturas.
12. O certificado histórico `sup g=51/100` sem maximizador permanece válido
    apenas no contrato anterior; M e B excluem os canais que o produziam.

## Controle mecânico

O script reproduziu `SUMMARY | 2891 PASS | 0 FAIL`. O resultado mecânico foi
usado apenas para conferir identidades, exemplos e regressões; o veredicto
decorre da revisão matemática independente.

O revisor não criou, editou ou removeu arquivos e não realizou commit.
