# Editorial notes: Literature Review & Scope rewrite (integrated)

**Arquivo original**: `formal_model_v5.Rmd`  
**Data**: 2026-04-29  
**Fontes**: Readability audit (2026-04-29) + Comparação Hirsch & Shotts (2026-04-27)

## Diagnóstico das versões originais

**Literature Review** (18.5% passiva, Flesch RE 12.0, FOG 19.6): Quatro passivas concentradas no parágrafo 1 ("can be grouped", "are chosen", "is not chosen", "It is preferred"). A organização é catalográfica — cada parágrafo mapeia um campo (OIs, bargaining, information & voting) sem explicitar por que a literatura existente falha. A predição discriminante (para 4) é um ponto forte que deve ser preservado.

**Scope** (22% passiva, Pangram 0.399): O score Pangram elevado reflete três padrões: (1) construções formulaicas ("This is a deliberate choice:", "The result should therefore be read as", "The present model focuses on"); (2) ~10 passivas distribuídas na seção; (3) uso pesado de em dashes. Adicionalmente, footnotes justificativas da Definition 1 estão no lugar errado — pertencem ao Scope (Hirsch B4).

## Principais mudanças

### Literature Review — reorganização para argumento-advancing (Hirsch)

A mudança estrutural mais importante é no parágrafo 1: cada explicação existente agora vem seguida de um "but" que identifica seu ponto cego específico:
- **Self-binding**: "but they treat consensus as a cost the hegemon bears, not a source of advantage"
- **Informal power**: "but they cannot explain why formal rules vary systematically across organizations"
- **Rational design**: "but do not specify through which mechanism a given rule creates advantage"

Isso transforma o parágrafo de catálogo em argumento: o leitor entende *por que* as explicações existentes são insuficientes antes de ver a contribuição do paper.

### Scope — migração de footnotes (Hirsch B4)

- **Footnote 2** ($\alpha V(\theta)$ proporcional) → novo parágrafo "Why proportional outside options?" com frase analítica adicionada conectando a escolha de modelagem ao mecanismo.
- **Footnote 4** (all-or-nothing, interpretação de $N$) → conteúdo único absorvido no parágrafo "Why all-or-nothing entry?"; footnote simplificada para cross-reference.
- Footnotes 1 ($d_W=0$ WLOG) e 3 (consensus = unanimity) mantidas — são curtas, técnicas, e adequadas para footnotes.

### Passive voice e readability

~25 passivas eliminadas, ~10 em dashes removidos/substituídos. Construções formulaicas AI-like substituídas por prosa direta.

## O que foi preservado

- Todos os claims substantivos, scope conditions, referências e citações.
- A estrutura Q&A com bold headers no Scope.
- O contraste "not why... but why..." no para "Why not compare..." (genuinamente analítico).
- Todas as fórmulas e notação LaTeX.
- Parágrafos que já estavam limpos: "Why symmetric proposal rights?", "Why binary types?", "When consensus favors the hegemon.", "When majority dominates."
- A predição discriminante (para 4 do Lit Review) — apenas ajustes menores de estilo.

## Pontos para verificação do autor

1. **Remoção da frase de abertura do Lit Review**: "The paper contributes to the literature on institutional design in international organizations." Se o autor considerar necessária como convenção de journal, pode ser mantida.

2. **"but" clauses no para 1**: As três frases adicionadas são interpretações do autor desta proposta sobre por que cada explicação é insuficiente. O autor deve verificar se concorda com essas caracterizações, especialmente:
   - "treat consensus as a cost the hegemon bears" — é isso que self-binding accounts realmente fazem?
   - "cannot explain why formal rules vary systematically" — é isso o blind spot central de informal power?
   - "do not specify through which mechanism" — rational design genuinamente não especifica o mecanismo?

3. **"generates a discriminating prediction"**: O termo "discriminating" é standard em ciência política empírica. Se o público de RIO não estiver familiarizado, manter "separates it from the main alternatives".

4. **Novo parágrafo "Why proportional outside options?"**: Contém uma frase analítica nova — "This proportional form separates informational power (which depends on $\theta$ being unknown to weak states) from pure bargaining power (which depends on $\alpha$)" — que não estava no footnote original. O autor deve verificar se esta interpretação é precisa e se quer incluí-la.

5. **Simplificação do footnote 4 na Definition 1**: O conteúdo moveu para o Scope, mas a footnote simplificada ("discussed in the Scope section") pode parecer estranha se o leitor lê a Definition antes do Scope. Alternativa: manter o footnote intacto e aceitar a duplicação.

6. **Merging do Eraslan survey**: @eraslan2019legislative foi absorvida como citation companion do Baron-Ferejohn. Se o autor quer destacar que Eraslan é um survey (não uma contribuição original), pode manter a frase dedicada.
