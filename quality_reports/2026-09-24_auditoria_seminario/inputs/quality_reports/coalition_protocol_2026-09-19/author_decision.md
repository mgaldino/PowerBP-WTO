# Decisão autoral: protocolo de coalizão com alocações restritas aos participantes

Data: 19 de setembro de 2026. Esta decisão sucede a rejeição de A1 e a discussão de acesso a mercado na tarefa de preparação para PEIO 2027.

## Proposta submetida ao autor e aprovação

O autor perguntou: “a variante que restringe as alocações aos membros de C. Pq nao seguir com essa restrição? Simplifica bastante, não?”

O coordenador recomendou uma candidata com coalizão explícita, alocações restritas aos participantes, consentimento de todos os convidados, pie fixa e implementação automática; explicou que uma recusa de qualquer convidado faz o pacote inteiro fracassar e que H excluído conserva sua opção externa. O autor respondeu: **“ok, vamos nessa direção”**.

## Especificação adotada para derivação, revisão e integração

1. O proponente escolhe uma coalizão C que o contém e satisfaz a quota institucional, junto de um vetor x não negativo.
2. A soma das alocações é no máximo 1; x_j=0 para todo j fora de C. Não há teto adicional para a parcela de H dentro de C. A restrição vale para todos os jogadores.
3. Os membros convidados de C votam simultaneamente; o proponente conta como sim. Todos os membros precisam consentir com aquele pacote. A quota majoritária permite uma coalizão sem H; a quota unânime força C=N.
4. Se todos consentem, o acordo é implementado automaticamente: cada membro recebe a parcela aprovada. Não existe uma decisão individual posterior de execução, produção ou recebimento de x_H.
5. Se um membro recusa, o pacote inteiro fracassa. Em R1, o jogo continua conforme o protocolo de reconhecimento e desconto; em R2, termina no desacordo. Não há saída irreversível de H durante a votação nem exercício imediato da opção externa quando ainda há uma rodada.
6. Quando uma coalizão sem H implementa seu acordo, H recebe sua opção externa privada o, fora da pie; fracos excluídos recebem zero. Quando H participa do acordo implementado, recebe x_H.
7. Permanecem pie fixa, duas rodadas, reconhecimento uniforme somente dos fracos no baseline, informação privada somente de H, fracos simétricos com opção externa zero, ausência de externalidades, disciplina de crenças compatível com propostas desinformadas e desempates aprovados. A extensão com H proponente exige análise própria das propostas (C,x) e de sua informação.

## Incidência explícita nas instruções anteriores

- **Fundamento 1 / protocolo:** representação por coalizão-alvo e consentimento de todos os convidados substitui votação universal por quota de votos; reconhecimento, rodadas e desconto são preservados.
- **Fundamento 2:** a comparação institucional continua variando apenas a quota admissível, com a mesma economia e o mesmo protocolo de consentimento sob ambas as regras.
- **Fundamentos 4 e 5:** a factibilidade agora restringe as alocações aos membros de C. Uma aprovação implementa o vetor integralmente; uma recusa de convidado impede aprovação do pacote. Não se cancela x_H depois da aprovação nem se devolve sua parcela ao proponente.
- **Fundamentos 3, 6, 7 e 8:** preservados. O excedente não depende da presença de H e não são importadas as produtividades de PowerPieDependent.
- A exigência anterior de permitir parcelas positivas a não membros está superada pela escolha explícita da variante restrita. A ausência de acúmulo será consequência da nova arquitetura de contrato e de sua factibilidade, não um resultado de racionalidade que elimine propostas factíveis.
- A candidata A1–A3 com execução individual e sua alternativa de desembolso condicionado a uma prestação não são adotadas. A aceitação anterior de A2/A3 não introduz essas etapas no novo protocolo.

## Autorização e fronteiras

O pedido original já autoriza preparar as derivações, revisar independentemente, adjudicar, integrar correções e produzir o candidato PEIO. Esta decisão resolve a escolha de arquitetura para essas etapas; não requer nova autorização para a mesma integração. Permanecem fora do escopo submissão, publicação, push e comunicação a terceiros.

O checkpoint e hashes anteriores estão em `preflight/manifest.json`. Manuscrito, contratos congelados e pareceres históricos são preservados até a derivação e revisão necessárias; um parecer anterior continua limitado aos seus próprios bytes e claims. A comparação focal de 8/9 é um ponto de partida, não certificação da agenda inteira ou do futuro manuscrito.
