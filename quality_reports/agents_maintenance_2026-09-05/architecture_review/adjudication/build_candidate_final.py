#!/usr/bin/env python3
"""Adjudicate the exact final instructions/notes candidate after two reviews."""
import hashlib
import json
import subprocess
import sys
from datetime import datetime
from pathlib import Path

ROOT = Path('/private/tmp/pbp-architecture-clarification-2026-09-05')
OUT = ROOT / 'adjudication'
CANDIDATE = ROOT / 'candidate'
REL = 'quality_reports/agents_maintenance_2026-09-05/'
MANIFEST = ROOT / 'candidate_manifest.json'
expected = json.loads(MANIFEST.read_text(encoding='utf-8'))
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
assert expected['AGENTS.md'] == '122a3a53047f9c8c3305a6d768c20687a5833287bf001420661f7fb7564f0098'
assert expected[REL + 'architecture_clarification.md'] == '873715a6848e2747d9d9e31234001c5d37a1c83cd622b0cafa85d4fd96e14a9f'
identities = []
for rel, digest in expected.items():
    path = CANDIDATE / rel
    text = path.read_text(encoding='utf-8')
    actual = sha(path)
    assert actual == digest, (rel, actual, digest)
    identities.append({'path': str(path), 'relative_path': rel, 'sha256': actual, 'bytes': path.stat().st_size, 'utf8': True})
assert (CANDIDATE / 'AGENTS.md').read_bytes() == (CANDIDATE / (REL + 'AGENTS.approved.md')).read_bytes()
assert (CANDIDATE / (REL + 'AGENTS.before_architecture_clarification.md')).read_bytes() == (ROOT / 'before/AGENTS.md').read_bytes()

review_paths = [('R4', ROOT / 'candidate_reviews/formal_round2.md'),
                ('R5', ROOT / 'candidate_reviews/adversarial_round2.md'),
                ('R3', OUT / 'README_review_from_coordinator.md')]
review_texts = {rid: path.read_text(encoding='utf-8') for rid, path in review_paths}
for rid in ('R4', 'R5'):
    for digest in expected.values():
        assert digest in review_texts[rid], (rid, digest)
readme = (CANDIDATE / (REL + 'README.md')).read_text(encoding='utf-8').splitlines()
assert 'apenas quando' not in readme[54]
assert 'recebe `x_H` quando vota sim e a proposta é aprovada' in readme[54]
assert 'desvios nas propostas ou nos votos' in readme[58]
support = []
for rel, digest in {
    'formal_model_v6.Rmd': '6708eaafca2f7e8707c224b2da51684ff28e5fea5a43ac1490cbce6a0aa08411',
    'quality_reports/2026-09-01_b1_b3_exclusion_derivation.md': '2bb232030711cfb16dec5d439eaafac6411b03bc71ad4a2af927b5e9a124f256',
}.items():
    path = ROOT / 'before' / rel
    assert sha(path) == digest
    support.append({'path': str(path), 'sha256': digest})
author = ROOT / 'review_sources/author_correction.md'
global_path = OUT / 'adjudication_round1_global.json'
global_record = json.loads(global_path.read_text(encoding='utf-8'))
assert global_record['adjudication']['verdict'] == 'BLOCKED'

verifications = [
    {'topic': 'Fidelidade à decisão autoral',
     'locations': ['candidate/AGENTS.md:16-21,33,49-55', 'candidate/quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md:7-18', 'review_sources/author_correction.md:5'],
     'result': 'A regra de cancelamento está identificada como contestada. A ausência de acúmulo aparece como exigência de arquitetura e incentivos. Não se impõe x_H=0 ao espaço de propostas nem se adota x_H+o como regra substituta.'},
    {'topic': 'Protocolo e fronteiras de autorização',
     'locations': ['candidate/AGENTS.md:21-27,43-47,59-64', 'candidate/quality_reports/agents_maintenance_2026-09-05/approval.md:31-37'],
     'result': 'Preservados os pagamentos dos fracos, a alocação de H após sim e aprovação, o desacordo terminal, a continuação após fracasso em R1, os votos simultâneos, a disciplina aprovada de crenças e a revisão independente por hash. Não há escolha adicional de H após observar os votos.'},
    {'topic': 'Resultado delimitado nas duas rodadas',
     'locations': ['candidate/quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md:54-74', 'before/formal_model_v6.Rmd:301-337,350-354,413-421,1385-1393,1419-1423'],
     'result': 'A demonstração mantém explicitamente os payoffs dos fracos, a regra de votação e o reconhecimento. Em R2, a parcela 1 ao proponente passa e domina qualquer concessão positiva; a continuação dos fracos antes do sorteio independente é 1/m. Em R1, o limiar beta/m fixa os votos fracos; se eles bastam, a realocação ex ante de x_H ao proponente preserva aprovação e melhora seu payoff estritamente. A propriedade vale para propostas ótimas, respostas fracas prescritas e cada tipo, sem exigir a resposta ótima de H. Isso não completa o jogo nem prova existência de equilíbrio.'},
    {'topic': 'Quantificadores e desvios',
     'locations': ['candidate/AGENTS.md:51-55', 'candidate/quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md:35-50,72-82'],
     'result': 'O texto distingue aprovação com voto não de rejeição que faz a proposta fracassar; não elimina screening. Distingue propostas ótimas de propostas e votos desviantes. Tipos de posterior zero são explicitamente cobertos no resultado limitado. Payoffs e respostas após desvios permanecem abertos.'},
    {'topic': 'Diagnóstico das fontes anteriores',
     'locations': ['candidate/quality_reports/agents_maintenance_2026-09-05/architecture_clarification.md:24-31', 'before/formal_model_v6.Rmd:340-348,366-368,1385-1397,1429-1443,1479-1494', 'before/quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24-30,75-118,343-360'],
     'result': 'O diagnóstico é fiel aos hashes anteriores: cancelamento foi input, enquanto a realocação entre propostas tem parte independente dele. Não se conclui que o lema antigo era falso no jogo em que foi escrito.'},
    {'topic': 'Precedência documental e finding local',
     'locations': ['candidate/quality_reports/agents_maintenance_2026-09-05/approval.md:5,31-37', 'candidate/quality_reports/agents_maintenance_2026-09-05/README.md:9,33-35,55-67'],
     'result': 'As passagens antigas são marcadas como históricas e subordinadas à correção atual. README:55 passou a usar quando, retirando a necessidade residual. As declarações de estado estão preparadas para instalação; este parecer não verifica o estado instalado.'},
]

record = {
    'schema_version': '1.0',
    'adjudication_id': 'pbp-architecture-clarification:122a3a53047f:round2-candidate',
    'source': {'reviewed_artifact': str(CANDIDATE / 'AGENTS.md'), 'sha256': expected['AGENTS.md'], 'artifact_intact': True},
    'contract': {'required': False, 'path': None, 'sha256': None, 'contract_id': None, 'artifact_sha256': None, 'status': None, 'stale': False},
    'contract_scope_reason': 'Revisão delimitada de instruções e de uma nota curta com um argumento condicional nas duas rodadas, sem revisão integral do manuscrito ou certificação de arquitetura. O escopo foi explicitamente delimitado pelo coordenador.',
    'review_sources': [{'review_id': rid, 'path': str(path), 'sha256': sha(path)} for rid, path in review_paths],
    'candidate_manifest': {'path': str(MANIFEST), 'sha256': sha(MANIFEST)},
    'candidate_files': identities,
    'supporting_sources': support,
    'author_correction_source': {'path': str(author), 'sha256': sha(author)},
    'findings': [{
        'finding_id': 'R3-F001', 'source_review': 'R3',
        'quoted_finding': review_texts['R3'].splitlines()[4],
        'type': 'scope_or_consistency', 'severity': 'minor', 'scientific_dimension': 'instruction_fidelity',
        'held_decision': True, 'status': 'REFUTED',
        'source_locations': ['candidate/quality_reports/agents_maintenance_2026-09-05/README.md:55,59-67'],
        'defect_evidence': [],
        'refuting_evidence': ['README:55 afirma que H recebe x_H quando vota sim e a proposta é aprovada; o termo apenas foi retirado.', 'README:59-67 mantém abertos os payoffs e respostas após desvios nas propostas ou nos votos e não apresenta a propriedade delimitada como solução da arquitetura.'],
        'mechanical_checks': [{'command': f'python3 {OUT / "build_candidate_final.py"}', 'result': 'Hash do candidato e ausência de apenas quando no trecho atual verificados.'}],
        'reasoning': 'A afirmação de que o candidato atual conserva a necessidade residual é refutada pelos bytes atuais. O finding continua procedente no snapshot anterior, cuja adjudicação PARTIAL é preservada. REFUTED aqui significa ausência do defeito neste novo candidato; não revoga a conclusão histórica.',
        'proposed_fix_assessment': 'not_provided',
        'disposition': 'Nenhuma correção adicional. A retirada já foi incorporada e conferida pelos dois revisores finais.',
        'carried_over_from': {'record': str(OUT / 'adjudication_readme_local.json'), 'source_sha256': '8d1c9037e685ca1bfddfdf4eb7e79f0589a2e9a8416816c50360d082b9a0d6b8', 'previous_status': 'PARTIAL', 'resolution': 'RESOLVED'},
    }],
    'summary': {'total': 1, 'confirmed': 0, 'partial': 0, 'refuted': 1, 'unresolved': 0, 'held_decisions': 1},
    'adjudication': {'verdict': 'NO_CONFIRMED_DEFECTS', 'checked_at': datetime.now().astimezone().isoformat(),
                     'reasons': ['Os seis arquivos coincidem com os hashes registrados por ambos os revisores finais; os textos pertinentes foram confrontados diretamente com a decisão autoral e as fontes.',
                                 'A correção de instruções e a demonstração delimitada na nota são fiéis ao escopo declarado. Nenhum novo defeito do candidato foi confirmado.',
                                 'R3-F001 está resolvido nos novos bytes. A pendência global R1-F004 não foi encerrada; o candidato a conserva expressamente.']},
    'direct_verification': verifications,
    'mechanical_checks': {'command': f'python3 {OUT / "build_candidate_final.py"}', 'six_hashes_match_manifest': True,
                          'both_final_reviews_record_all_six_hashes': True, 'utf8': True, 'agents_and_approved_identical': True,
                          'historical_agents_snapshot_identical_to_preflight': True,
                          'source_rmd_and_memo_hashes_verified': True,
                          'numeric_equilibrium_tests_run': False},
    'external_source_check': {
        'title': 'Muhamet Yildiz, Graduate Game Theory, sections 1.1 and 4.1',
        'url': 'https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf',
        'access_date': '2026-09-05',
        'locators': ['Section 1.1, printed pages 4-6', 'Section 4.1, printed pages 104-108'],
        'result': 'A fonte foi aberta e conferida. A forma extensiva distingue árvore, ações e payoffs terminais; a discussão de racionalidade em conjuntos de informação sustenta a distinção geral usada na nota. A prova particular é do projeto e o conceito específico de crenças não é importado dessa referência.'},
    'global_architecture_boundary': {
        'record': str(global_path), 'sha256': sha(global_path), 'verdict': 'BLOCKED', 'unresolved_finding_id': 'R1-F004',
        'still_open': 'Completar economicamente os payoffs e respostas de H, inclusive após desvios nas propostas e nos votos, e demonstrar o requisito no alcance declarado.',
        'new_bounded_result': 'O resultado sobre propostas ótimas, sob respostas fracas prescritas, agora foi reconstituído e revisado nas duas rodadas. Ele não fecha os ramos após desvios nem certifica uma nova arquitetura.',
        'why_candidate_can_pass': 'O objeto desta etapa é verificar se as instruções e a nota expressam corretamente o mandato, o resultado limitado e a pendência. É possível confirmar essa fidelidade sem resolver a própria arquitetura. Não há item material não resolvido dentro desse escopo documental.',
        'authorization_limit': 'O veredicto não autoriza mudanças no manuscrito, contratos, payoffs ou estratégias. A instalação das instruções usa a autorização da conversa e deve verificar os mesmos bytes.'},
    'not_performed': ['Instalação ou alteração de candidato/repositório.', 'Auditoria integral do paper, compilação ou testes de equilíbrio.', 'Certificação de existência, estratégias completas ou arquitetura substituta.'],
}
out = OUT / 'candidate_final.json'
out.write_text(json.dumps(record, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
md = ['# Adjudicação final do candidato de instruções e nota', '',
      'Veredicto: NO_CONFIRMED_DEFECTS, limitado aos seis arquivos e hashes desta rodada.', '',
      f"Fonte principal: `{record['source']['reviewed_artifact']}`.", f"SHA-256: `{record['source']['sha256']}`.", '',
      '## Identidade e escopo', '', record['contract_scope_reason'], '',
      '| Arquivo relativo ao candidato | SHA-256 |', '| --- | --- |']
md += [f"| {r['relative_path']} | {r['sha256']} |" for r in identities]
md += ['', 'Pareceres finais: `candidate_reviews/formal_round2.md` e `candidate_reviews/adversarial_round2.md`. Ambos registram os mesmos seis hashes, recalculados nesta adjudicação. Seus próprios hashes estão no JSON.', '',
       'O AGENTS e sua cópia aprovada são idênticos. O snapshot histórico coincide com o arquivo anterior. Os seis arquivos são UTF-8. A instalação ainda pertence ao implementador.', '',
       '## Finding anterior', '',
       'R3-F001: REFUTED no candidato atual; RESOLVED como ocorrência histórica. README:55 usa “quando” e retirou “apenas”. A adjudicação PARTIAL do snapshot anterior permanece preservada em `adjudication_readme_local.json`.', '',
       'Contagens: 0 CONFIRMED; 0 PARTIAL; 1 REFUTED; 0 UNRESOLVED no escopo documental.', '',
       '## Verificação direta', '']
for v in verifications:
    md += ['### ' + v['topic'], '', v['result'], '', 'Localizadores: ' + '; '.join(v['locations']) + '.', '']
md += ['## Referência externa', '',
       'A fonte foi aberta para conferir a distinção geral entre forma extensiva, utilidades terminais e racionalidade em conjuntos de informação: [Muhamet Yıldız, Graduate Game Theory, seções 1.1 e 4.1](https://ocw.mit.edu/courses/14.126-game-theory-spring-2024/mit14_126_s24_yildiz-lecture-notes.pdf). A aplicação e a demonstração particular são do projeto; a nota preserva o conceito de crenças aprovado.', '',
       '## Pendência da arquitetura', '',
       f"O registro global `{global_path}` permanece BLOCKED, SHA-256 `{sha(global_path)}`. R1-F004 continua aberto.", '',
       record['global_architecture_boundary']['still_open'], '',
       record['global_architecture_boundary']['new_bounded_result'], '',
       record['global_architecture_boundary']['why_candidate_can_pass'], '',
       '## Encaminhamento e limites', '',
       record['global_architecture_boundary']['authorization_limit'], '',
       'Os arquivos do candidato não foram editados. Não houve auditoria integral, compilação, teste de existência de equilíbrio ou certificação da correspondência completa. A validação de schema está em `candidate_final_validation.txt` e `.json`.', '',
       'Veredicto final: NO_CONFIRMED_DEFECTS no escopo de instruções e nota. O requisito completo da arquitetura permanece aberto.', '']
(OUT / 'candidate_final.md').write_text('\n'.join(md), encoding='utf-8')
validator = '/Users/manoelgaldino/.codex/skills/adjudicate-review/scripts/validate_adjudication.py'
command = [sys.executable, validator, str(out), '--artifact', str(CANDIDATE / 'AGENTS.md')]
result = subprocess.run(command, text=True, capture_output=True)
validation = {'command': command, 'returncode': result.returncode, 'stdout': result.stdout, 'stderr': result.stderr,
              'record_sha256': sha(out), 'artifact_sha256': sha(CANDIDATE / 'AGENTS.md')}
(OUT / 'candidate_final_validation.json').write_text(json.dumps(validation, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
(OUT / 'candidate_final_validation.txt').write_text('COMMAND: ' + ' '.join(command) + '\n' + result.stdout + result.stderr, encoding='utf-8')
assert result.returncode == 0, validation
report = OUT / 'report.md'
report.write_text(report.read_text(encoding='utf-8') + '''
## Etapa posterior: candidato final

Os dois pareceres finais foram adjudicados no candidato AGENTS 122a3a53047f e na nota 873715a6848e. O resultado é NO_CONFIRMED_DEFECTS para instruções e nota. A demonstração limitada para propostas ótimas foi estendida e conferida também em R1, sob os componentes e respostas fracas prescritas declarados. R3-F001 está resolvido no README. O registro global original permanece preservado e a pendência R1-F004 continua aberta para payoffs e respostas após desvios nas propostas e nos votos. Esta evolução não é uma certificação da arquitetura completa.

Registro: candidate_final.json e candidate_final.md. Validação: candidate_final_validation.json e candidate_final_validation.txt.
''', encoding='utf-8')
manifest = {p.name: sha(p) for p in sorted(OUT.iterdir()) if p.is_file() and p.name != 'outputs_sha256.json'}
(OUT / 'outputs_sha256.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
print(result.stdout.strip())
print(json.dumps({'candidate_verdict': record['adjudication']['verdict'], 'candidate_sha256': record['source']['sha256'], 'record_sha256': sha(out)}, ensure_ascii=False))
