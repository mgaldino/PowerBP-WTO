# IPE Expert Review — Formal Model V3

**Score: 27/100** (severo, mas inclui -25 pela figura errada que já foi corrigida. Score ajustado sem a figura: ~52/100)

## Problemas Críticos (já corrigidos)

- **Figura 5 contradizia o resultado** — usava p=0.3 > p*. Corrigido: agora usa p=0.15, g=0.5.

## Problemas Maiores (pendentes)

### 1. Parâmetro g faz trabalho pesado sem grounding empírico (-10)
- g é free parameter que pode ser tuned para qualquer resultado
- "If the hegemon cares enough about broad membership, it prefers consensus" — quase tautológico
- Precisa: bounds analíticos para g, ou calibração empírica (g = X% do pie para os EUA na OMC)

### 2. Entry condition conflata belief e payoff (-10)
- A condição `mu + V_W(R, mu) >= c` soma probabilidade (mu) com payoff (V_W)
- mu = Pr(θ=1|s) é crença, não payoff
- Precisa explicitar: W recebe E[θ|s] = mu como payoff direto MAIS V_W do bargaining

### 3. Dois rounds não justificado substantivamente (-5)
- BF padrão é horizonte infinito
- 2 rounds é o que cria o screening — seria artefato da estrutura finita?
- Precisa: justificativa substantiva (rodadas ministeriais na OMC?) ou verificação com mais rounds

### 4. Pacotes institucionais pré-selecionam resposta (-5)
- Bundling voting rule + agenda é pressuposto, não resultado
- Package B dominado por C depende da especificação de 2 rounds
- O design institucional é mais rico que A vs C

### 5. Literatura faltante (-5)
- Fang (2008, APSR) — BP-adjacent em setting hierárquico
- Gilligan & Krehbiel (1987, AJPS) — legislative bargaining + informação
- Drezner (2007) — poder hegemônico em instituições econômicas
- Voeten (2001, IO) — governança informal em OIs

### 6. Corolário de Erosão sem prova formal (-5)
- Estática comparativa em p apresentada como dinâmica
- Modelo é estático — não há learning
- "Erosão" é interpretação, não resultado

## Problemas Menores

- **Notação**: v usado para pie ratio E value function v(mu,R). Renomear um dos dois.
- **δ vs β**: intro usa δ, modelo usa β. Inconsistente.
- **Intro overreach**: "Multilateralism is the hegemon's commitment device" não é derivado do modelo.
- **Conceito de equilíbrio**: PBE não formalmente declarado.
- **Discussion muito longa**: 1/3 do paper.

## Plausibilidade Empírica (WTO)
- θ binário — simplificação forte (acordos reais são contínuos)
- W's simétricos — GATT/WTO tem membros muito heterogêneos
- Hegemon único — EUA + EC co-desenharam
- Custo c exógeno — na realidade, endógeno aos termos

## Recomendações Prioritárias
1. Clarificar entry condition (mu como payoff direto)
2. Bound g analiticamente
3. Justificar 2 rounds
4. Declarar PBE
5. Resolver notação v
6. Adicionar citações faltantes
