# Revisão independente read-only — fidelidade M/S/B, rodada 1

**Data:** 2026-08-29  
**Revisor:** agente Codex independente, adversarial/contrato  
**Edição de arquivos pelo revisor:** nenhuma  
**Snapshot:** `4bda7b71e1e6d4e836912b533fef8b28ee044c71`  
**Bytes candidatos revisados:** os mesmos quatro hashes de candidato do
manifesto da rodada 1 (`6e7948...`, `5a4685...`, `fd7c4b...`, `cc52c5...`).
O parecer declarou que os dez registros internos conferiam. Ele registrou
`97529d...` para o hash do próprio manifesto, divergindo da recalculação
independente `407114...`; essa linha é tratada como erro clerical do parecer,
não como identidade do snapshot.  
**Verificador reproduzido:** `2831 PASS / 0 FAIL`, sem força substantiva.

## Veredicto

```text
FAIL — 1 critical / 1 important / 1 minor
```

## Findings

1. **Critical — endpoints ausentes de AMX-016.** `R/Sig(R)` cobriam somente o
   prior interior. Medidas distintas de propostas rejeitadas ótimas em
   `nu=0` já geram `G_pi` distintos e não estavam na imagem alegada. Reparo:
   objetos endpoint com posterior constante e medidas Borel no argmax.
2. **Important — domínio de `chi` não fechado.** A assinatura terminal não
   podia consumir um “subconjunto anônimo literal” sem parametrização,
   σ-álgebra e kernels. Reparo preferido: fixar o representante uniforme
   literal por ramo e somente a mistura residual autorizada.
3. **Minor — papel de B no certificado.** M exclui o seletor histórico
   literal; B impede reconstruí-lo por crenças não disciplinadas.

## Resultados confirmados

- precedência correta entre emenda, Gate 0 e fontes históricas;
- nenhuma hipótese econômica, refinamento, tremble ou grade nova;
- Bayes local, `nu_off`, suporte do prior e endpoints substantivamente
  preservados;
- membership da loteria uniforme e equivalência de payoff com o ciclo;
- confirmação do finding de não fechamento global;
- suficiência da rota alternativa de existência, sem protocolo novo;
- perda correta da testemunha semipooling assimétrica (`.5914<.63`);
- escopo histórico correto do certificado negativo;
- ausência de edição/consumo de `A_U`, `AC`, `AR` e N1–N7.

O pacote não podia fechar `A_M` antes dos reparos de endpoints e do codomínio
mensurável da continuação.

