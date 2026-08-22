# Autorização autoral do Goal 3 — N6

**Data:** 2026-08-21  
**Escopo:** exclusivamente `N6`, comparação dos jogos com informação privada  
**Estatuto:** decisão autoral posterior; prevalece sobre propostas anteriores onde diferir

## 1. Escopo e fronteira

`N6` compara exclusivamente os jogos com informação privada consumindo as
interfaces congeladas de `N3` e `N4`. Benchmark público, rendas
informacionais, `RI_U`, `RI_M` e `DeltaRI` são entregáveis de `N7`, que só
poderá abrir depois de `N6` receber dois pareceres independentes `PASS 0/0/0`
no mesmo hash, ser integrado e congelado, e receber novo gate autoral.

`N6` não contém campo de contrafactual e não abre `N7`, extensões com
`beta=1`, migração para manuscrito ou qualquer etapa do Goal 5.

## 2. Conceito de solução

O interesse substantivo e o baseline do paper abrangem exclusivamente PBE com
estratégias puras nos ballots. Equilíbrios mistos futuros não são objeto de
preocupação do autor e não serão derivados, comparados, simulados ou tratados
como extensão pendente. A eventual menção a robustez de existência é decisão
exclusiva do Goal 5 e não integra `N6`.

## 3. Domínio e cobertura

A comparação é feita no mesmo ponto do espaço de parâmetros e fica restrita a
`m >= 3`, isto é, ao menos três Estados fracos. A cobertura de `N6` inclui todo
esse domínio, mas registros efetivos de comparação existem somente onde as duas
regras possuem PBE puro sob o pacote de conceito de solução de 2026-08-21, a
Emenda 1a e a errata de `N2`.

A região `0 < nu <= nu_star` permanece na cobertura em células isoladas com
`existence_status = none`. Não se imputa payoff e não se cria comparação nessa
região. O certificado de inexistência registra tecnicamente o ciclo entre o
voto informativo de `H` e o cálculo `as-if-pivotal` dos Estados fracos, sem
atribuir interpretação substantiva destinada ao manuscrito.

## 4. Multiplicidade, conjuntos e simetria

A multiplicidade de `N3` é preservada por registros atômicos e pelo reporte dos
conjuntos exatos. Envelopes são resumos derivados: não preenchem lacunas, não
convexificam conjuntos e não substituem os registros de origem. Não se calcula
média sobre o espaço de parâmetros como métrica de comparação; eventual nota
sobre medida nula é, no máximo, comentário lateral.

Duplicações que diferem apenas por permutações das identidades dos Estados
fracos podem ser quocientadas no relatório legível depois de demonstrada a
invariância dos payoffs de `H` e dos outcomes comparados. A interface preserva
os IDs de origem, a multiplicidade por identidade e a rastreabilidade de cada
classe; o quociente expositivo não autoriza apagar registros atômicos.

## 5. Gate de abertura verificado

`N3` e `N4` estão `pass/frozen`, cada um com exatamente dois pareceres
independentes `PASS 0/0/0` no mesmo hash:

- `N3`: `sha256:ff053798db1e2d4c103f3162e2e6525d20b68fc5ff376416c2deb66dae47330d`;
- `N4`: `sha256:f1c823123a9b218096d6d072ff5786775c91698ff0c2004791731d2d3406408b`.

O tratamento dos endpoints imposto pela Emenda 1a foi verificado no candidato
principal de `N4` pelos dois pareceres finais. Foi também verificado na
rederivação cega, que mantém todos os posteriores no suporte degenerado após os
quatro perfis puros de `H` e ambas as ações. Evidência cega pinada para o gate:

- interface: `sha256:9e35bd1207e9cbc65d31df54baacb52dcf17f04c106b6a85f64a166a753984b4`;
- derivação: `sha256:316eee4d886a9c6b3af100ce3c63b7e288d10b3bdc5bb06e51f3cbe535b89210`;
- ledger: `sha256:456b8d2ce72d749b312d13ebf81565dc9b718c4f94eed8f29360d51ae9a6e73e`;
- verificador: `sha256:0a670c4c5884fa572692fcd8f92b62f018546b34aada4b41b2427421cf3f5cf6`;
- resultado ao vivo: `PASS endpoint posterior-support audit for all four H profiles and both actions` e `PASS serialized endpoint records contain no out-of-support posterior`.

## 6. Execução, revisão e parada

`N6` deve consumir somente os objetos congelados e as decisões posteriores
explicitamente registradas. A validação deve priorizar identidades matemáticas,
cobertura estrutural, certificados de inexistência e um conjunto pequeno de
fixtures negativas representativas; não se fará mutação exaustiva campo a
campo do schema.

O implementador não revisa. O candidato permanece `pending/unfrozen` até dois
pareceres read-only independentes, `formal_design` e `game_theory`, retornarem
`PASS 0/0/0` no mesmo hash. Depois da integração administrativa e do freeze de
`N6`, a execução para. `N7` requer nova autorização explícita do autor.

## 7. Exceção administrativa de Markdown

O autor autorizou preservar os dois espaços finais intencionais que produzem
quebras de linha em arquivos Markdown já revisados e criar o checkpoint local
apesar desses avisos específicos de `git diff --cached --check`. A autorização
não cobre nenhuma outra classe de whitespace, não permite normalizar os
arquivos e não reabre `N3` ou `N4`.
