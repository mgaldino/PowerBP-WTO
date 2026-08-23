# Comentários finais do Fable — Plano v3 (fechado pelo autor)

**Data:** 2026-08-23
**Objeto:** `quality_reports/plans/2026-08-23_agenda_extension_gated_plan_v3.md`
**SHA-256 do objeto:** `1706cda1b6902cbca4f368e5ad61f567cb0eb40f8f4850169cd595bbcf0ab17e`
**Verificação de proveniência:** o hash do parecer Fable citado no v3
(`f4d8a185...d9a6b9`) confere com os bytes atuais do arquivo — a triagem do
Codex cobriu o parecer completo, incluindo Adendo 1 e a nota sobre trembles.
**Natureza:** comentários finais de leitura. Nenhum é bloqueante. Nada aqui
altera o v3, que está fechado; itens 2–4 são sugestões para o texto do
contrato do Gate 0, onde o autor decidirá.

## 1. Veredito

Pronto para abrir o Gate 0 quando o autor der o GO. Os três bloqueantes do
parecer foram resolvidos, e dois pontos merecem registro explícito de que a
resolução do v3 é **superior** às minhas recomendações:

- **§0.7–0.8 contra o meu B3.** Eu recomendei cortar o domínio de `A_U` para
  `{0} ∪ (ν*, 1]`. O v3 está certo em recusar: com mistura de propostas
  permitida (§0.3), uma estratégia semi-separadora pode fazer split do prior
  em posteriores `{0}` e `(ν*, 1]` cuja média bayesiana é qualquer prior da
  banda — toda continuação alcançada existe, e `A_U` pode ser não vazio na
  banda onde `C_U` é vazio. Existência como resultado, não como recorte.
  E o §0.8 formula corretamente o estatuto: crença off-path que exige
  continuação inexistente invalida a avaliação — isso é condição necessária
  de equilíbrio, não seleção autoral.
- **§0.4–0.5 e §2.3 contra a minha recomendação de crenças passivas como
  regra primária.** O v3 deriva a passividade como limite de perturbação
  simétrica pré-especificada, em vez de assumi-la como primitiva, e mantém a
  correspondência baseline publicada ao lado. Mais trabalho, epistemicamente
  mais limpo, e imune à crítica de convenção ad hoc.

## 2. Previsões a registrar antes da derivação (para ninguém se surpreender)

1. **Onde o tremble trabalha.** No jogo perturbado, propostas fora dos átomos
   de equilíbrio carregam posterior = prior (só o componente comum de erro as
   produz). Em priors da célula de pooling `(ν*, 1]`, prevejo que o limite
   `ε → 0` elimina tanto os poolings submáximos quanto o equilíbrio de atraso
   sustentados por crenças pessimistas — a camada de robustez fará trabalho
   real exatamente onde o gatilho do §2.4 a acionar.
2. **Onde o tremble devolve "não robusto".** Em priors na banda `(0, ν*]`,
   propostas de tremble rejeitadas entram em `C_U` no prior — célula `none`.
   Pelo §2.3.8 isso é resultado de não robustez, não licença para outro
   posterior. Ou seja: a banda pode ter baseline não vazio (via splitting) e
   robustez indefinida. Esperado e pré-registrado; não tratar como anomalia.
3. **D1/IC.** Mantenho a previsão de silêncio em candidatos de pooling puro
   (Adendo 1 do parecer), com a ressalva que o próprio v3 já faz: sob mistura
   e semi-pooling a análise é outra e deve ser refeita do zero.

## 3. Sugestões pontuais para o contrato do Gate 0

1. **Congelamento por célula.** A correspondência baseline de `A_U` em
   `[0,1]` com mistura e splitting pode ser grande. O contrato deve permitir
   congelar claims por célula — resultados em `{0} ∪ (ν*, 1]` com dois PASS
   enquanto a banda fica `pending`/`conjecture` — para que a dificuldade da
   banda não faça refém o resto da extensão. O §1 já admite status com
   domínio explícito; falta dizer que o freeze também é por domínio.
2. **Menu fechado para o §2.3.5.** Pré-registrar uma das duas construções
   canônicas para `Y` contínuo: (a) `λ` atomless com densidade e Bayes por
   razão de densidades (átomos de equilíbrio dominam nos átomos; posterior
   passivo fora deles), ou (b) grade finita com limite `ε → 0` e depois
   refinamento da malha. Sem essa escolha no contrato, o protocolo de
   trembling vira projeto de pesquisa próprio.
3. **Leitura do §9, primeiro bullet.** Estou lendo "manter o resultado sem
   agenda como principal e tipo-contingente; imagem ex ante como objeto
   derivado" como a ratificação autoral da pergunta que estava aberta
   (tipo a tipo versus ex ante). Se a leitura estiver certa, a pendência
   está fechada e os registros de coordenação devem refleti-lo; se o bullet
   era provisório, a pendência continua.

## 4. Declaração de papel

Meu envolvimento nesta cadeia (conjecturas de guardanapo, parecer, estes
comentários) me exclui dos dois pareceres independentes do Gate 0 e dos nós
`A_M`/`A_U`. O reconstrutor cego do Goal 3 não deve ter acesso ao parecer,
aos adendos, a estes comentários nem às notas de guardanapo.
