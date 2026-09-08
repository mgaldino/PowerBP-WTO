# Auditoria independente das dependências da arquitetura

Revisor: `/root/audit_architecture_dependency`. Data: 2026-09-05. Transcrição da resposta final, com localizadores normalizados para caminhos relativos ao repositório. Nenhum arquivo editado pelo revisor.

A exigência nova ainda não está demonstrada pelas provas atuais. Elas demonstram a escolha ótima `x_H=0` quando os votos fracos bastam, mas definem previamente o pagamento de H após votar não como `o`, cancelando `x_H`.

1. **A vedação está nas primitivas.** O manuscrito (`formal_model_v6.Rmd:340`) diz que, após aprovação com voto não de H, sua fatia não é paga a ninguém; a Appendix A (`formal_model_v6.Rmd:1385`) repete a regra para todas as histórias. O memorando de derivação (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24`) a identifica expressamente como input. Portanto, não se pode apresentar essa exclusividade em toda história como conclusão de racionalidade.

2. **O resultado efetivamente derivado é mais delimitado.** Em B.1 (`formal_model_v6.Rmd:1429`) e B.3 (`formal_model_v6.Rmd:1479`), cada fraco vota por um limiar próprio, independente de `x_H` e das crenças: zero na rodada terminal, `β/m` na primeira. Se já há votos fracos suficientes, trocar a proposta por

   `x'_H=0`, `x'_i=x_i+x_H`, `x'_j=x_j` para `j≠i,H`

   preserva os votos fracos e a aprovação e aumenta estritamente o pagamento do proponente. Isso elimina `x_H>0` das propostas ótimas dessa classe. Trata-se de outra proposta escolhida antes da votação; não é devolução automática de uma fatia após a votação.

3. **A dominância tem uma parte aproveitável sem a vedação.** O ganho do proponente decorre de ele receber `x_i` sob a proposta original e `x_i+x_H` sob a alternativa. Esse cálculo, por si só, não exige cancelar o pagamento de H quando este vota não. O lema atual (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:86`) descreve a regra de cancelamento, mas seu argumento de escolha ótima pode ser reconstruído com outra regra completa de payoffs, desde que os votos fracos e sua continuação permaneçam independentes da mudança proposta. Isso precisa ser verificado novamente a partir da rodada terminal.

4. **As respostas completas de H dependem da arquitetura rejeitada.** O limiar não pivotal `x_H≥o` vem diretamente de comparar `u_H(Y)=x_H` com `u_H(N)=o`. Se uma arquitetura alternativa permitisse, na história desviante, `u_H(N)=x_H+o`, esse limiar desapareceria: H preferiria não estritamente para `o>0`. Assim, mesmo que as propostas ótimas e seus resultados fossem preservados, a correspondência de estratégias fora do caminho mudaria. O próprio memorando (`quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:343`) já distingue estratégias completas de resultados reportados.

Uma obrigação de prova precisa para o novo texto seria:

> Para todo histórico em que um fraco formula uma proposta, inclusive históricos fora do caminho, e para toda crença admissível nesse histórico, cada proposta ótima com `x_H>0` deve atribuir probabilidade zero ao evento conjunto “a proposta é aprovada e H vota não”. A conclusão deve ser derivada das primitivas, das respostas ótimas e da disciplina de crenças vigentes.

Essa formulação **preserva screening**: uma oferta positiva pode ser rejeitada por um tipo de H quando sua rejeição faz a proposta fracassar. “Nunca oferecer positivo se algum tipo pode rejeitar” seria uma restrição indevida.

Há ainda uma fronteira indispensável: otimização em todos os nós, inclusive os não alcançados, elimina ofertas dominadas do comportamento prescrito nesses nós. **Não elimina da árvore do jogo as histórias posteriores a uma oferta desviante.** Logo, a arquitetura ainda precisa especificar payoffs e respostas nessas histórias. Se o requisito for impedir o recebimento conjunto também após qualquer desvio arbitrário do proponente, o lema de dominância não basta; será necessária outra arquitetura substantiva, que não pode ser disfarçada como consequência já demonstrada.

Não alterei arquivos nem auditei a extensão de agenda. A conclusão acima é limitada ao baseline e às provas indicadas.
