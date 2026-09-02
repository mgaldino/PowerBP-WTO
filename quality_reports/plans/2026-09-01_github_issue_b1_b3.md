# Rascunho de GitHub Issue — correção de B.1/B.3 sob a regra de exclusão

**Status:** DRAFT LOCAL — NÃO PUBLICADA

**Motivo:** a autenticação local do GitHub estava inválida em 2026-09-01 e a
sessão do navegador não estava autenticada. Este arquivo preserva o texto da
Issue; ele não substitui os memorandos, pareceres, hashes ou decisões do autor.

## Título proposto

`[BLOCKER] Atualizar B.1/B.3 para a regra de exclusão mutuamente exclusiva`

## Corpo proposto

### Problema

As regras de transição e payoff do manuscrito já registram que, quando uma
proposta passa por maioria sem a participação de `H`, o hegemon recebe apenas
sua outside option `o` e a parcela `x_H` não é paga a ninguém. Duas passagens
das provas ainda usam a regra antiga `x_H+o`:

- Appendix B.1, terminal majority;
- Appendix B.3, ramo em que os votos fracos já bastam para a aprovação.

### Escopo autorizado

Corrigir e revisar as derivações de B.1 e B.3 sem editar o manuscrito até que a
arquitetura de prova seja aprovada. Auditar semanticamente toda a Appendix B
para verificar se a correção altera resultados, cutoffs, classes de resultado
ou multiplicidades.

### Invariantes que precisam ser demonstrados, não presumidos

- acordo e outside option são payoffs mutuamente exclusivos;
- quando os votos fracos já bastam, `H` compara `x_H` após sim com `o` após
  não e vota sim exatamente quando `x_H >= o`;
- nessa classe, todo `x_H>0` é estritamente subótimo para o proponente, pois
  pode ser transferido para sua própria alocação sem afetar a aprovação;
- quando `H` é pivotal em Round 1, seu limiar continua sendo `beta o`;
- a estratégia fora do caminho pode mudar mesmo que resultados, payoffs e
  cutoffs reportados permaneçam iguais;
- multiplicidades já declaradas devem ser preservadas, sem inventar uma nova
  família indexada por `x_H`.

### Checklist de gates

- [x] Isolar o trabalho em `codex/exclusion-proof-b1-b3`.
- [ ] Fixar o memorando de derivação candidato por commit e SHA-256.
- [ ] Obter parecer independente de design formal.
- [ ] Obter auditoria game-teórica adversarial independente.
- [ ] Adjudicar findings sem editar o manuscrito.
- [ ] Preparar pacote autocontido e hash para parecer técnico externo no
  ChatGPT Web.
- [ ] Autor enviar manualmente o pacote e devolver o parecer.
- [ ] Adjudicar o parecer externo.
- [ ] Obter dois PASS finais sobre a derivação congelada.
- [ ] Obter GO explícito do autor para migração.
- [ ] Criar tag anotada pré-migração em árvore limpa.
- [ ] Migrar somente as passagens autorizadas de B.1/B.3.
- [ ] Renderizar PDF e revisar a integração independentemente.
- [ ] Obter aprovação terminal antes de promover para `main`.

### Autoridade

A Issue funciona apenas como índice do ciclo de vida. A autoridade substantiva
continua nos registros de decisão, no memorando de derivação com hash, nos
pareceres independentes e nas aprovações explícitas do autor.
