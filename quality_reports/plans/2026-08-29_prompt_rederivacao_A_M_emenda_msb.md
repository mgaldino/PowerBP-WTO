# Prompt de rederivação de A_M sob a emenda M/S/B

**Data:** 2026-08-29
**Emenda governante:**
`quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md`,
status APPROVED (aval autoral de 2026-08-29), SHA-256
`8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`.
**Alocação (decisão autoral de 2026-08-23):** `A_M` preferencialmente Fable,
Opus defensável. Revisores dos gates: nunca quem redigiu, nunca Fable.
**Regra de sessão:** a derivação ocorre em sessão NOVA e worktree dedicado. A
sessão autoral de 2026-08-29 (que redigiu a emenda) não deriva nem revisa.

## Pré-condições operacionais (autor executa antes de colar o prompt)

1. Criar o worktree da derivação a partir do snapshot que contém contrato,
   resultados exploratórios e certificado:

   ```bash
   git worktree add /private/tmp/PBP-am-msb -b agenda-extension-am-msb b675a37
   ```

2. Garantir que o derivador alcance os dois documentos novos — pelo caminho
   absoluto do checkout principal
   (`/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion`) ou por
   commit — e que os hashes confiram:
   - emenda: SHA-256
     `8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b`;
   - registro da revisão Sol 5.6
     (`quality_reports/2026-08-29_review_sol56_emenda_extensao_agenda.md`):
     SHA-256
     `a1b89479a44d7cef148859d8219701ce370cbcedcfe994d5436bc565980bc25a`.
3. Nenhuma edição nos artefatos do snapshot `b675a37`.

## Prompt — colar integralmente na sessão do derivador

```text
Estamos no repo PowerBayesianPersuasion, em um worktree dedicado criado a
partir do snapshot b675a37 do branch codex/agenda-extension-am-exploratory.
Você é o derivador de A_M (extensão de agenda sob maioria) sob o contrato
emendado; você não revisará o próprio trabalho.

Contexto em uma frase: a exploração de A_M terminou em certificado negativo —
sob o contrato original, a liberdade de kappa_M (seleção de continuação
dependente da proposta e do vetor de votos) e a liberdade ponto a ponto das
crenças em pontos não disciplinados impedem existência uniforme de PBE e
qualquer classificação informativa (AMX-014/015/016 BLOCKED). Em 2026-08-29 o
autor aprovou uma emenda ao Gate 0 (cláusulas M/S/B) que remove exatamente
essas duas liberdades. Sua tarefa é rederivar A_M sob a emenda.

Leia nesta ordem antes de derivar:
1. A emenda aprovada:
   quality_reports/plans/2026-08-29_emenda_extensao_agenda_markov_crencas.md,
   no checkout principal
   (/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion),
   SHA-256 8f0f3a0e430e8005bd7a1da99477a7b0e27e163b85aa87c2ad349d9578aab21b.
   Verifique o hash. Ela prevalece sobre o contrato original onde conflitarem.
2. O contrato base:
   quality_reports/plans/2026-08-26_agenda_extension_gate0_simplified.md
   (neste worktree). Tudo que a emenda não toca permanece válido — inclusive a
   regra local de Bayes por vizinhanças (§3.1), os desempates (§3, itens 1–2)
   e a exclusão de D1/Critério Intuitivo do baseline (§3.2).
3. O certificado e as testemunhas:
   model_redesign/agenda_extension_A_M_explicit_majority_results.md
   (Seções 2–6) e
   quality_reports/2026-08-29_memoria_resultado_extensao_agenda_maioria.md.
4. O registro da revisão incorporada:
   quality_reports/2026-08-29_review_sol56_emenda_extensao_agenda.md
   (checkout principal, SHA-256
   a1b89479a44d7cef148859d8219701ce370cbcedcfe994d5436bc565980bc25a).

Resumo operacional das cláusulas; o texto integral da emenda prevalece:
- M: kappa_g(h) = kappa_hat_g(phi_g(h)), com phi_g(h) = (instituição, estágio
  de entrada da continuação, posterior público no fechamento do ballot).
  Vedada dependência da identidade da proposta rejeitada e do vetor de votos.
  Parâmetros fixos (N, m, k, beta, o_0, o_1) são constantes globais.
- S: seleção na classe de equivalência anônima de payoffs de C_g;
  representante literal: quando um fraco é reconhecido, os parceiros de
  coalizão são sorteados uniformemente entre as coalizões admissíveis do
  tamanho requerido; o membro cíclico só entra como implementação, mediante
  verificação de payoff-equivalência.
- B: pontos disciplinados seguem o limite local de Bayes (limite inexistente
  em ponto disciplinado para e escala); em todo ponto não disciplinado —
  existe vizinhança relativa com massa pública zero — vale mu(y) = nu_off, um
  único escalar em [0,1] por assessment, com nu_off = nu nos endpoints do
  prior. Na comparação principal de AC, o mesmo nu_off nas duas instituições.
- Desempates inalterados: voto fraco as-if-pivotal, aceitação na indiferença,
  T^Y.

Entregáveis, nesta ordem:
1. Lema de existência de PBE sob M/S/B, por região paramétrica, pela rota
   construtiva: o conjunto de propostas aceitas, incluída a indiferença, é
   fechado, logo o melhor acordo é atingido; o valor de rejeição é atingido
   por proposta claramente rejeitada; o ótimo de H é o maior dos dois. Não
   alegue semicontinuidade superior global do payoff de H: ela é falsa em
   fronteiras de aceitação onde a continuação excede o acordo-limite.
2. Verificações de membership: o representante uniforme é membro literal do
   C_M congelado; payoff-equivalência entre o membro cíclico das construções e
   o representante uniforme.
3. Classificação das classes de assinatura dos PBEs, indexadas por
   (nu, nu_off) e pelos objetos on-path exigidos por Bayes. Assinatura mínima:
   payoffs por tipo de H; payoffs interinos dos fracos; probabilidade de
   acordo e de atraso por tipo; distribuição de outcomes terminais por tipo;
   posterior nos sinais alcançados. Reduzir a variação on-path a um número
   finito de classes por (nu, nu_off) é teorema a provar; se não for
   demonstrável, reporte as classes com os objetos on-path necessários e
   escale.
4. Re-validação das testemunhas das Seções 3–4 dos resultados exploratórios
   como candidatos sob o contrato emendado; nada é herdado automaticamente.
5. Ledger AMX atualizado com os novos escopos; o certificado negativo
   permanece como resultado e motivação — não o descarte nem o enfraqueça.

Disciplina:
- Findings escalam por default; toda ambiguidade e toda definição faltando
  escalam. Se uma prova exigir protocolo novo não coberto pela emenda, marque
  pending protocol decision, explique as consequências e pare o ramo.
- Não edite artefatos congelados: baseline N1–N7, tag
  v6-essential-input-2026-08-25, artefatos do snapshot b675a37. AC e AR estão
  reabertos e não devem ser consumidos; A_U precisa de auditoria própria pela
  mesma liberdade antes de qualquer consumo.
- Salve scripts R em arquivo antes de rodar; verificação mecânica não
  substitui prova; relatórios completos em quality_reports/ com data no nome.
- Você não revisa o próprio trabalho. Ao final, o pacote vai para dois
  revisores independentes sem edição de arquivos; Fable é inelegível como
  revisor desta cadeia.
- Sem tag. Commit apenas do trabalho novo no branch dedicado, com preflight e
  manifesto de hashes no padrão dos snapshots anteriores.
```
