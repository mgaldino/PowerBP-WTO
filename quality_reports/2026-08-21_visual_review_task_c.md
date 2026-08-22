# Parecer independente — Tarefa C

## Resultado

**PASS para uso como rascunho**, nota **A−**. Não encontrei finding crítico, alto ou médio, nem divergência entre os PDFs, os CSVs e as funções que os geram. Os três PDFs são legíveis, têm hierarquia clara, captions e fontes, e não apresentam clipping.

## Findings por severidade

Nenhum finding P0/P1/P2.

- **[P3 — baixa] O endpoint `nu=0` de N4 é praticamente invisível na Figura C.2.** O CSV registra corretamente `Acordo low-only (L)` em uma observação, mas uma faixa de largura `1/1200`, parcialmente recortada na borda, não comunica visualmente essa célula de medida zero. Antes de uso no manuscrito, valeria marcar `nu=0` com um ponto ou anotação explícita.

- **[P3 — baixa] A linha de `nu_star` atravessa também a faixa de N3 na Figura C.2.** O cutoff é de N2/N4, enquanto a mudança efetiva de N3 ocorre perto de `nu=0,294`. A caption é correta, mas o traço vertical sobre ambas as faixas pode sugerir que `nu_star` também é a fronteira de N3. Uma futura versão poderia limitar o traço à faixa N4 ou acrescentar e rotular o cutoff relevante de N3.

- **[P3 — baixa] As classes substantivas, exceto “No pure-vote PBE”, dependem principalmente de cor.** A região vazia satisfaz plenamente o requisito de redundância visual por hachura e rótulo direto. Para publicação/impressão em escala de cinza, seria útil considerar rótulos diretos ou texturas adicionais nas demais classes.

## Auditoria por artefato

### Figura C.1

- A região `No pure-vote PBE` está hachurada e diretamente rotulada.
- A fronteira `o_1=1/m=0,25` aparece corretamente como linha tracejada.
- As facetas N3/N4, eixos, legenda e caption são legíveis e não se sobrepõem.
- O CSV contém 22.650 linhas, exatamente 11.325 pontos por painel, compatível com a malha triangular `o_0<o_1` de resolução 151.
- Em N4, os 7.387 pontos `No pure-vote PBE` e 3.938 `Pooling (P)` correspondem à geometria exibida.
- Não há clipping de título, eixos, legenda ou caption.

### Figura C.2

- O cutoff teórico é `nu_star=(0,35-0,10)/(1-0,10)=0,2777778`, e a linha tracejada está na posição correta.
- O CSV tem 1.201 pontos por painel.
- N4 está corretamente codificado como:

  - `nu=0`: `Acordo low-only (L)`;
  - `0<nu<=nu_star`: `No pure-vote PBE`;
  - `nu>nu_star`: `Pooling (P)`.

- A primeira observação de pooling aparece em `nu=0,278333`, diferença esperada da discretização.
- N3 muda de screening para exclusão em `nu=0,294167`, compatível com a malha.
- Hachura, rótulo direto, legenda e caption estão legíveis e sem clipping.

### Tabela C.1

Os cinco registros do PDF correspondem byte-logicamente ao CSV e às fórmulas:

- `o_0-1/m=0,10-0,25=-0,15`;
- `o_1-1/m=0,35-0,25=+0,10`;
- `nu-nu_star=0,35-0,2777778=+0,0722222`;
- `E-R=0,55-0,225=+0,325`;
- `1-beta=0,10`.

A alternância de fundo, o alinhamento monoespaçado dos valores e a separação das colunas tornam a tabela especialmente clara. Não há corte na coluna `Status` nem na caption.

## Verificações realizadas

- Leitura integral dos dois scripts.
- Inspeção de todos os CSVs.
- `pdfinfo` nos três PDFs: uma página cada, sem criptografia ou JavaScript.
- `pdftotext -layout` para detectar perda/corte de texto.
- Renderização independente a PNG, 160 dpi, com `pdftoppm`, seguida de inspeção visual.
- Contagem de classes e identificação das transições nos CSVs.
- `pdffonts`: apenas fontes core Helvetica, Courier e Symbol; não incorporadas, mas aceitáveis para estes rascunhos.
- SHA-256 dos PDFs:

  - C1: `0daa590a69af0445ac3282f9db827d58c08932a36f11e4a254b69b8761360d88`;
  - C2: `1ece52a3fb71a6af08ef870687056f83bfd40ff16cc3b37a9e7a8aae39524bfa`;
  - Tabela C1: `4f4ef2df0e2669dfe86b29382411cbac8093294c45dd326280b66c19e17678e7`.

## Limitações

A revisão foi estritamente read-only: não regenerei os PDFs, para não sobrescrever artefatos. Portanto, verifiquei os PDFs existentes, sua correspondência estrutural com os scripts/CSVs e a presença do guard de hashes no gerador, mas não testei reprodutibilidade byte a byte. Também não fiz prova física em papel nem simulação automatizada de daltonismo.

Nenhum arquivo do repositório foi alterado; as renderizações ficaram apenas em diretório temporário fora da worktree.
