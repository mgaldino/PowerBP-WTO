# Status do passo 3 — revisões e adjudicação de `A_U` sob M/S/B

**Data:** 2026-08-29

**Natureza:** registro administrativo e de decisão pendente; não contém nova
derivação e não altera os bytes do candidato

## Resultado

O passo 2 foi concluído com sucesso em dois commits auditáveis:

- blind-lock: `c193f3bdd99c6b127e76e595d851051fa005e247`;
- pacote final pós-comparação: `b59ce1bf5b5ee7b57707684de92c38d4fa325b30`.

O manifesto final do implementador tem SHA-256
`f95322c800e113ac74dbf8d378d7a329b9e6a06cb27e7e016c0a1c6322d2be81`,
com 26/26 entradas verificadas. O harness final foi reproduzido com
`1095 PASS / 0 FAIL`.

O passo 3 foi executado sobre exatamente esse snapshot:

| Parecer | Veredito | Findings | SHA-256 |
|---|---|---:|---|
| `quality_reports/2026-08-29_A_U_msb_formal_review_1.md` | `PASS` | `0/0/0` | `36e1e092ff2135e5610b2d942a81b7955ed899702ae266986ca2c712659f380d` |
| `quality_reports/2026-08-29_A_U_msb_formal_review_2.md` | `FAIL` | `0/1/0` | `79a335f6557b4274786256011cc850fbf8dd81e606b43ef7f2d04d951aa4ea57` |

A adjudicação independente em
`quality_reports/adjudication/A_U_msb/b59ce1bf5b5/adjudication_round1.md`
classificou `R2-I-1` como `CONFIRMED`, de severidade `important`, e encerrou a
rodada como `BLOCKED`. O JSON autoritativo foi validado no schema 1.0.

## O que sobreviveu

Os dois pareceres e a adjudicação preservam a matemática estratégica de
`A_U`: forma extensiva, consumo literal de `C_U`, aplicação única de `beta`,
domínio de crenças, cortes de voto, imitação entre tipos, fronteira `Delta`,
famílias de PBE, endpoints, atraso e imagens de payoff.

Isso confirma que o candidato histórico não precisava ser descartado. Dez de
seus claims foram preservados literalmente; três tinham fórmulas corretas mas
famílias incompletas sob M/S/B; um gerador foi superado pelas cláusulas M e B;
um claim misturava preço esperado de voto e payoff realizado de tipo
contrafactual; e um era apenas evidência mecânica histórica.

## Finding confirmado e limite

O candidato atual trata cada órbita sob uma permutação comum dos Estados fracos
como uma classe formal exata e separa misturas com pesos diferentes sobre
relabelings. A clarificação geral aprovada havia determinado que essas misturas
pertencessem à mesma classe. A decisão posterior que resolve essa tensão com
duas camadas — identidade formal exata e resumo econômico anônimo — tem escopo
textual exclusivo de `A_M`.

O conflito não muda payoffs ou existência. Ele muda a contagem/identidade das
classes de equilíbrio e o objeto que `AC` poderá consumir. Por isso não pode ser
reparado como mera edição de prosa.

## Decisão autoral pendente

Escolher uma das alternativas:

1. **Estender a arquitetura em duas camadas a `A_U`.** Preservar uma assinatura
   formal exata por órbita diagonal e adicionar um resumo econômico anônimo no
   qual misturas economicamente equivalentes podem coincidir. Esta opção
   harmoniza `A_U` com `A_M`, mas exige definição e provas próprias para `A_U`.
2. **Manter o quociente anônimo anterior.** Fazer misturas sobre relabelings
   pertencerem à mesma classe de assinatura em `A_U`, reconstruindo uma relação
   única que ainda preserve diferenças de revelação. Esta opção mantém a letra
   da clarificação geral, mas reabre o desenho da equivalência e da interface.

Nenhuma opção foi escolhida automaticamente. A autorização condicional para
congelar depois de dois pareceres favoráveis não foi acionada, porque o segundo
parecer falhou e o finding foi confirmado. `A_U` permanece
`pending/unfrozen`; `AC`, manuscrito, tag, merge e push permanecem não
autorizados.
