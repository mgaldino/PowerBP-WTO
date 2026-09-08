# Aprovação do AGENTS.md e esclarecimento dos payoffs

Data: 2026-09-05.

O autor aprovou o restante do resumo dos fundamentos, do índice e da proposta integral de `AGENTS.md`, corrigindo a generalização da regra de exclusão aos Estados fracos. Este registro preserva a sequência de decisões. A interpretação vigente do ramo em que H vota não e a proposta passa está na correção posterior registrada abaixo e em `architecture_clarification.md`.

## Esclarecimento autoral

Quando uma proposta é aprovada, cada Estado fraco recebe apenas a alocação que a proposta lhe atribui. Seu voto não substitui essa alocação por uma opção externa. H, ao votar não, pode exercer sua opção externa quando o acordo é aprovado sem ele; nesse caso, recebe o payoff externo em lugar da alocação prevista para ele.

H não recebe uma alocação positiva somada ao payoff externo. A fatia reservada a H excluído não é paga a ninguém, conforme a emenda de setembro, e não é devolvida automaticamente ao proponente.

O usuário encerrou a correção com “No mais, de acordo.”. Isso aprova a instalação da proposta integral com essa precisão. O item 7 também explicita que o voto não de um fraco não o exclui da distribuição aprovada, para que sua redação não reintroduza a generalização corrigida.

O esclarecimento trata dos payoffs quando uma proposta passa. Ele não acrescenta uma decisão de H depois da divulgação dos votos nem altera a continuação após uma votação fracassada.

## Esclarecimento posterior: aprovação e término do jogo

O autor explicitou, na mesma conversa: H recebe `x_H` quando vota sim e a proposta é aprovada. Se a proposta é rejeitada e o jogo termina, H recebe a opção externa, independentemente de seu voto. Se ainda há uma rodada prevista, a rejeição leva à continuação conforme o protocolo.

Permanece a regra já aprovada para uma proposta que passa sem H: se ele votou não, recebe a opção externa sem acumular sua alocação. Este esclarecimento foi incorporado ao item 4 do arquivo ativo e de sua cópia aprovada.

## Alcance da implementação

- `AGENTS.approved.md` registra a versão aprovada; seu conteúdo é instalado como `AGENTS.md` na raiz.
- `AGENTS.proposed.md` permanece como registro da proposta anterior à correção.
- `AGENTS.pre-approval.md` preserva o arquivo ativo intermediário, anterior à instalação integral.
- Contratos congelados, manuscrito, provas e resultados permanecem intactos. Este registro explicita a interpretação autoral nas instruções de trabalho.
- A aprovação abrange estas instruções; não altera o estado de revisão ou publicação do artigo.

## Correção posterior: o resultado deve decorrer da arquitetura

O autor esclareceu que a ausência de recebimento simultâneo de alocação positiva e opção externa por H precisa decorrer da arquitetura e da racionalidade, inclusive fora do caminho de equilíbrio. Rejeitou tratá-la como uma vedação primitiva que simplesmente cancela `x_H` quando H vota não. Sugeriu examinar se os proponentes fracos jamais ofereceriam uma alocação positiva a H sabendo que ele a rejeitaria, à luz de suas crenças, e determinou rever a arquitetura caso ela não sustente o resultado.

Essa correção substitui, neste assunto, as passagens anteriores deste registro que apresentam “a fatia não é paga a ninguém” como solução vigente. Preserva os pagamentos dos fracos após aprovação, de H após aprovação com voto sim e de H no desacordo terminal. Não autoriza tratar o pagamento aditivo como nova regra já aprovada nem acrescenta uma etapa de decisão depois da votação.

O `AGENTS.md` e sua cópia `AGENTS.approved.md` passam a registrar a obrigação de derivação. `architecture_clarification.md` distingue a decisão do autor, a formulação técnica candidata, um resultado delimitado para propostas ótimas nas duas rodadas e as questões de arquitetura ainda abertas. A atualização não apresenta uma nova arquitetura como aprovada nem o requisito completo como demonstrado.
