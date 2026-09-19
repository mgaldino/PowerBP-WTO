# Lema de suporte para a proposta unânime de preço alto

Data: 2026-09-19. Candidata de implementação de F-002, confirmada em `adjudication/preliminary_v1.json`; aguarda revisão independente. O manuscrito e todas as notas v1 permanecem intactos. Este documento fecha somente as duas invocações de \(x^h\) em B.8, não reabre QI-05 nem certifica os demais resultados.

## Premissas consumidas

Usam-se a interface unânime de `r1_interface.md` e o contrato de agenda de `agenda_transport.md`, copiados para v2. Sob unanimidade, \(C=N\) é constante e identificamos \((N,x)\) com \(x\) no simplex compacto \(\mathcal X\). Fixe \(0<p<1\), \(0<\ell<h<1\) e \(0<\beta<1\). Escreva

\[
p^*=\frac{h-\ell}{1-\ell}\in(0,1),\qquad
\mathcal P_C=\{0\}\cup(p^*,1],
\]

\[
r_U(o)=\frac{\beta(1-\beta o)}m,\qquad
z_L=1-\beta+\beta^2\ell,\quad
z_H=1-\beta+\beta^2h,\quad d=\beta^2h,
\]

\[
x^h=(z_H,r_U(h),\ldots,r_U(h)).
\]

Sejam \(\sigma_\ell,\sigma_h\) leis Borel de propostas, \(\bar\sigma=(1-p)\sigma_\ell+p\sigma_h\), \(S=\operatorname{supp}(\bar\sigma)\) e \(\mu\) o posterior público. Em cada ponto de \(S\), inclusive pontos de massa zero, o contrato exige existência do limite local de Bayes por bolas euclidianas relativas e \(\mu(x)\in\mathcal P_C\). Fora de \(S\), \(\mu(x)=\mu^{off}\in\mathcal P_C\).

A primeira redução de B.8 já fornece o valor comum \(V_\ell=V_h=V\). Cada lei atribui probabilidade um aos melhores retornos do respectivo tipo, e as desigualdades contra desvios valem em **todo** ponto de \(\mathcal X\). Além disso,

\[
d\le V\le z_H.
\tag{US1}
\]

Para o limite inferior, o alto pode propor \((1,0,\ldots,0)\), obter recusa e receber \(d\) em qualquer posterior admissível. Para o superior, qualquer proposta aprovada paga a cada fraco ao menos \(r_U(h)\), enquanto toda recusa dá a cada tipo no máximo \(d<z_H\). Esses limites não supõem que uma proposta particular esteja fora do suporte.

## Identidade média de Bayes nas bolas

A medida finita \(p\sigma_h\) é absolutamente contínua em relação a \(\bar\sigma\). Ponha

\[
f=\frac{d(p\sigma_h)}{d\bar\sigma},\qquad 0\le f\le1
\quad\bar\sigma\text{-quase certamente}.
\]

As medidas são Borel finitas em um simplex euclidiano compacto. Estendendo-as por zero ao espaço euclidiano ambiente, o teorema de diferenciação de medidas por bolas identifica o limite local da razão com \(f\), \(\bar\sigma\)-quase certamente. As bolas relativas são exatamente as interseções das bolas ambientes com o simplex, de modo que a mesma razão é usada pelo contrato. Como \(\mu\) é esse limite em todo o suporte, \(\mu=f\) quase certamente. Portanto, para **todo** conjunto Borel \(E\),

\[
p\sigma_h(E)=\int_E\mu(x)\,\bar\sigma(dx).
\tag{US2}
\]

Em particular, \(\sigma_h(\{\mu=0\})=0\). O argumento não exige que as leis tenham densidades de Lebesgue, átomos ou suporte finito.

## Lema US-1

**Enunciado.** Em qualquer assessment admissível que satisfaça as premissas acima, se \(\mu^{off}>p^*\), então

\[
V=z_H,\qquad
\sigma_\ell=\sigma_h=\delta_{x^h}.
\tag{US3}
\]

Consequentemente, \(\mu(x^h)=p>p^*\). O enunciado abrange o caso em que, antes de impor os incentivos, \(x^h\) pertence ao suporte topológico com massa zero.

**Prova.** Suponha, para obter contradição, que \(V<z_H\). A coordenada \(x\mapsto x_H\) é contínua. Logo existe \(\varepsilon_0>0\) tal que

\[
x_H>V\quad\text{em }B_{\mathcal X}(x^h,\varepsilon_0).
\tag{US4}
\]

Se \(x^h\notin S\), seu posterior é \(\mu^{off}>p^*\). Os fracos aceitam suas parcelas \(r_U(h)\), inclusive na igualdade, e ambos os tipos recebem \(z_H>V\). Isso viola a desigualdade contra desvios. Resta o caso \(x^h\in S\), sem presumir massa positiva no singleton.

Considere o conjunto Borel

\[
E_0=B_{\mathcal X}(x^h,\varepsilon_0)\cap\{\mu=0\}.
\]

Por (US2), \(\sigma_h(E_0)=0\). O baixo também não pode atribuir massa positiva a \(E_0\). Em sua parte aprovada, ele receberia \(x_H>V\); em sua parte rejeitada, receberia \(\beta^2\ell<d\le V\). Nenhum desses retornos é igual a \(V\), como deve ocorrer \(\sigma_\ell\)-quase certamente. Assim,

\[
\sigma_\ell(E_0)=\sigma_h(E_0)=\bar\sigma(E_0)=0.
\tag{US5}
\]

Para cada \(0<\varepsilon\le\varepsilon_0\), a bola \(B_\varepsilon=B_{\mathcal X}(x^h,\varepsilon)\) tem massa pública positiva, pois \(x^h\in S\). Como \(\bar\sigma\) se concentra em \(S\), a admissibilidade e (US5) implicam \(\mu>p^*\), \(\bar\sigma\)-quase certamente nessa bola. Aplicando (US2),

\[
\frac{p\sigma_h(B_\varepsilon)}{\bar\sigma(B_\varepsilon)}
=\frac{\int_{B_\varepsilon}\mu\,d\bar\sigma}
       {\bar\sigma(B_\varepsilon)}
>p^*.
\tag{US6}
\]

O limite exigido no ponto \(x^h\) satisfaz, portanto, \(\mu(x^h)\ge p^*\). Não se troca indevidamente essa conclusão por uma desigualdade estrita de limites. A estriteza vem da admissibilidade: \(p^*>0\) exclui o posterior zero, e \(p^*\notin\mathcal P_C\) exclui a igualdade. Assim \(\mu(x^h)>p^*\). Nesse posterior, \(x^h\) passa e entrega \(z_H>V\), contradizendo a condição de desvio **no próprio ponto de suporte**, mesmo que tenha massa zero.

Logo \(V\ge z_H\), e (US1) dá \(V=z_H\). Uma proposta rejeitada rende no máximo \(d<z_H\), de modo que ambas as leis se concentram em propostas aprovadas com \(x_H=z_H\). Um posterior zero permitiria no máximo \(z_L<z_H\); no posterior alto, cada parcela fraca precisa ser ao menos \(r_U(h)\). Como \(z_H+mr_U(h)=1\), a factibilidade força cada parcela fraca a ser exatamente \(r_U(h)\). A única proposta usada é, portanto, \(x^h\). Bayes no átomo comum dá \(\mu(x^h)=p\), cuja admissibilidade e positividade implicam \(p>p^*\). Isso prova (US3). □

## As duas aplicações em B.8

1. **Massa positiva em posterior zero.** Se \(\lambda_0=\bar\sigma(\{\mu=0\})>0\), a segunda redução de B.8 fornece \(d\le V\le z_L\). Caso \(\mu^{off}>p^*\), US-1 exigiria \(V=z_H>z_L\), uma contradição. A admissibilidade deixa apenas \(\mu^{off}=0\). Este passo substitui a invocação original nas linhas 1889–1893 e não presume que \(x^h\) esteja fora do suporte.
2. **Massa zero em posterior zero.** Se \(\lambda_0=0\) e \(\mu^{off}>p^*\), US-1 dá diretamente \(V=z_H\) e \(\sigma_\ell=\sigma_h=\delta_{x^h}\), substituindo o atalho das linhas 1938–1943. A identificação \((N,x)\leftrightarrow x\) transporta o mesmo argumento para o protocolo aprovado.

As linhas citadas pertencem à fonte histórica SHA-256 `6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411`. O patch puro `../proof_repairs_manuscript_patch.py` prepara a inserção do lema e as duas substituições, sem aplicar a migração nem recompor qualquer preview. A prova usa identidades de medidas; os checks aritméticos de F-001 não a validam numericamente.
