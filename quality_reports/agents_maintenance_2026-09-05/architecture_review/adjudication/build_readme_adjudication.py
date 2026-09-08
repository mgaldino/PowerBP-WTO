#!/usr/bin/env python3
"""Adjudicate only the reported residual wording in the README snapshot."""
import copy
import hashlib
import json
from datetime import datetime
from pathlib import Path

ROOT = Path('/private/tmp/pbp-architecture-clarification-2026-09-05')
OUT = ROOT / 'adjudication'
snapshot = OUT / 'README.candidate_before_local_fix.md'
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(snapshot) == '8d1c9037e685ca1bfddfdf4eb7e79f0589a2e9a8416816c50360d082b9a0d6b8'
lines = snapshot.read_text(encoding='utf-8').splitlines()
assert 'apenas quando vota sim' in lines[54]
assert 'ainda precisa ser estabelecida' in lines[58]
review = OUT / 'README_review_from_coordinator.md'
review.write_text('''# Finding local transmitido pelo coordenador

Fonte: mensagem de /root para /root/review_instructions em 2026-09-05. Transcrição da parte relativa ao README; não é um novo parecer integral sobre o candidato.

> Primeira revisão do candidato localizou README.md candidato linha55 frase residual “H recebe x_H apenas quando vota sim e a proposta é aprovada”; remover “apenas” evita concluir a necessidade do voto sim no ramo contestado.
''', encoding='utf-8')
record = copy.deepcopy(json.loads((OUT / 'adjudication_round1_global.json').read_text(encoding='utf-8')))
record['adjudication_id'] = 'pbp-architecture-clarification:8d1c9037e685:readme-local-round1'
record['source'] = {'reviewed_artifact': str(snapshot), 'sha256': sha(snapshot), 'artifact_intact': True}
record['review_sources'] = [{'review_id': 'R3', 'path': str(review), 'sha256': sha(review)}]
record['findings'] = [{
    'finding_id': 'R3-F001', 'source_review': 'R3',
    'quoted_finding': review.read_text(encoding='utf-8').splitlines()[4],
    'title': 'Necessidade residual do voto sim no resumo do item 4',
    'type': 'scope_or_consistency', 'severity': 'minor', 'scientific_dimension': 'instruction_fidelity',
    'held_decision': True, 'status': 'PARTIAL',
    'source_locations': ['README.candidate_before_local_fix.md:55', 'README.candidate_before_local_fix.md:57-67', 'review_sources/author_correction.md:5'],
    'defect_evidence': ['A linha 55 afirma no presente que o item 4 explicita o recebimento de x_H apenas quando H vota sim. Isso sugere necessidade do voto sim também no ramo cujo payoff e mecanismo estão em discussão.'],
    'refuting_evidence': ['A seção imediatamente posterior, linhas 57-67, identifica a correção de arquitetura como vigente e diz que a ausência de acúmulo ainda precisa ser estabelecida após propostas desviantes. O defeito não descreve a posição geral do candidato.'],
    'mechanical_checks': [{'command': f'python3 {OUT / "build_readme_adjudication.py"}', 'result': 'Hash do snapshot verificado; presença de apenas quando na linha 55 e de ainda precisa ser estabelecida na linha 59 confirmada.'}],
    'reasoning': 'O finding é procedente como resíduo local de redação. A evidência posterior impede ampliá-lo para a alegação de que o candidato inteiro continua a adotar a vedação contestada. Retirar apenas preserva a suficiência da condição sim e aprovação sem afirmar sua necessidade no ramo disputado.',
    'proposed_fix_assessment': 'safe',
    'disposition': 'Retirar apenas da frase da linha 55 ou identificá-la explicitamente como descrição histórica superada. Essa correção não escolhe payoffs nem resolve a arquitetura.'
}]
record['summary'] = {'total': 1, 'confirmed': 0, 'partial': 1, 'refuted': 0, 'unresolved': 0, 'held_decisions': 1}
record['global_record'] = {'path': str(OUT / 'adjudication_round1_global.json'), 'sha256': sha(OUT / 'adjudication_round1_global.json'), 'verdict': 'BLOCKED'}
record['component_boundary'] = {'scope': 'Apenas a frase da linha 55 no snapshot do README; não é revisão do candidato completo ou dos novos resultados adicionados depois.',
                                'independence_evidence': 'A correção retira uma necessidade não demonstrada de um resumo e mantém a discussão do ramo contestado aberta. Não depende de escolher uma solução para R1-F004.',
                                'implementation_status': 'O coordenador informou que já retirou apenas do candidato após este finding ter sido adjudicado por mensagem. A verificação final dos bytes posteriores pertence à revisão do candidato.'}
record['adjudication'] = {'verdict': 'READY_FOR_IMPLEMENTATION', 'checked_at': datetime.now().astimezone().isoformat(),
                        'reasons': ['R3-F001 confirma parcialmente uma inconsistência de redação delimitada.', 'A correção segura não depende da arquitetura ainda em aberto. O record global permanece preservado.']}
record['count_interpretation'] = 'Uma inconsistência local de redação, classificada como PARTIAL; nenhuma afirmação de defeito global do candidato.'
record['identity_notes'] = ['Snapshot preservado antes da correção local, com hash 8d1c9037e685ca1bfddfdf4eb7e79f0589a2e9a8416816c50360d082b9a0d6b8. O candidato posterior já tem outros bytes e exige sua revisão própria.']
out = OUT / 'adjudication_readme_local.json'
out.write_text(json.dumps(record, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
f = record['findings'][0]
text = f'''# Adjudicação local do README

Veredicto: READY_FOR_IMPLEMENTATION. Finding R3-F001: PARTIAL.

Fonte: `{snapshot}`. SHA-256: `{sha(snapshot)}`.

Contrato argumental não exigido: o escopo é uma frase de resumo de instruções. O finding foi transmitido pelo coordenador e está preservado em `README_review_from_coordinator.md`.

## Evidência e raciocínio

- Linha 55: {lines[54]}
- Linhas 57-67: a seção posterior marca a exigência de arquitetura e a demonstração como abertas.

{f['reasoning']}

Correção proposta: {f['disposition']}

## Limite do encaminhamento

O coordenador informou que já retirou “apenas” do candidato após a adjudicação transmitida por mensagem. Este record documenta o snapshot anterior; não certifica os bytes posteriores.

O registro global `adjudication_round1_global.json` permanece BLOCKED para a questão da arquitetura. A correção local é independente dessa questão. As demais pendências e decisões do autor permanecem no registro global.

Contagens: 0 CONFIRMED; 1 PARTIAL; 0 REFUTED; 0 UNRESOLVED. Não foi editado candidato ou arquivo do repositório.
'''
(OUT / 'adjudication_readme_local.md').write_text(text, encoding='utf-8')
print(json.dumps({'verdict': record['adjudication']['verdict'], 'summary': record['summary']}))
