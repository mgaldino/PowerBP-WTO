#!/usr/bin/env python3
"""Create the bounded, source-bound adjudication; never modify the repository."""
from __future__ import annotations
import hashlib
import json
from collections import Counter
from datetime import datetime
from fractions import Fraction as F
from pathlib import Path

ROOT = Path('/private/tmp/pbp-architecture-clarification-2026-09-05')
OUT = ROOT / 'adjudication'
OUT.mkdir(exist_ok=True)
PREFLIGHT = json.loads((ROOT / 'preflight.json').read_text(encoding='utf-8'))
REPO = Path(PREFLIGHT['repo'])

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def write_json(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')

reviews = {
    'R1': ROOT / 'review_sources/architecture_dependency.md',
    'R2': ROOT / 'review_sources/offpath_requirement.md',
}
AUTHOR_PATH = ROOT / 'review_sources/author_correction.md'
AUTHOR_TEXT = AUTHOR_PATH.read_text(encoding='utf-8')
def quote(review, start, end=None):
    lines = reviews[review].read_text(encoding='utf-8').splitlines()
    return '\n'.join(lines[start - 1:end or start])

identities = []
for rel, expected in PREFLIGHT['selected_hashes'].items():
    snap, live = ROOT / 'before' / rel, REPO / rel
    snap.read_text(encoding='utf-8')
    row = {'path': rel, 'expected_sha256': expected, 'snapshot_sha256': sha(snap),
           'live_sha256_at_adjudication': sha(live), 'utf8_readable': True}
    row['matches_preflight'] = expected == row['snapshot_sha256'] == row['live_sha256_at_adjudication']
    assert row['matches_preflight'], row
    identities.append(row)
write_json(OUT / 'identity_checks.json', identities)

# Exact-rational sanity checks support elementary implications only.
# They are not an equilibrium search or a certification of the manuscript.
m, beta, xh, xi, weak = 3, F(3, 5), F(1, 5), F(2, 5), [F(1, 5), F(1, 5)]
k, w = (m + 1) // 2, beta / m
assert xh + xi + sum(weak) == xi + xh + sum(weak) == 1
assert sum(v >= w for v in weak) >= k
assert (xi + xh) - xi == xh > 0
mu, reject, passed = [F(1, 2), F(1, 2)], [False, True], [True, True]
p_reject = sum(p for p, r in zip(mu, reject) if r)
p_joint = sum(p for p, r, a in zip(mu, reject, passed) if r and a)
assert p_reject != 1 and p_joint > 0
mu_zero = [F(1), F(0)]
assert sum(p for p, r, a in zip(mu_zero, reject, passed) if r and a) == 0
assert any(r and a for r, a in zip(reject, passed))
assert all((n + 1) // 2 <= n - 1 for n in range(3, 101))
assert F(2, 5) > F(3, 10) and F(2, 5) + F(3, 10) > F(2, 5)
checks = {
    'command': f'python3 {OUT / "build_adjudication.py"}',
    'scope': 'Identidade de arquivos, leitura UTF-8 e exemplos aritméticos exatos. Não certifica equilíbrios nem a arquitetura completa.',
    'C1_reallocation': {'m': m, 'beta': str(beta), 'x_H': str(xh), 'x_i': str(xi), 'weak_allocations': [str(v) for v in weak], 'w': str(w), 'k': k, 'sum_preserved': True, 'weak_yes_preserved': True, 'proposer_gain': str(xh)},
    'C2_probability_logic': {'prior': [str(v) for v in mu], 'H_rejects': reject, 'passage': passed, 'P_rejection': str(p_reject), 'P_pass_and_H_no': str(p_joint), 'interpretation': 'Contraexemplo apenas à implicação lógica: não rejeição certa não implica ausência do evento conjunto. Não afirma equilíbrio desse vetor.'},
    'C3_zero_posterior': {'posterior': [str(v) for v in mu_zero], 'P_pass_and_H_no': '0', 'some_feasible_type_has_joint_event': True, 'interpretation': 'Probabilidade local zero não verifica todos os tipos factíveis. Exemplo lógico, sem alegar alcançabilidade de uma crença específica.'},
    'C4_terminal_quota': {'m_checked': '3..100', 'all_pass': True, 'general_argument': 'Para m>=3, (m+1)/2 <= m-1, logo floor((m+1)/2) <= m-1. O limite do ganho do proponente com x_H>0 é 1-x_H<1; a proposta que lhe atribui 1 passa pelos votos fracos.'},
    'C5_payoff_sensitivity': {'x_H': '2/5', 'o': '3/10', 'exclusive_Y_minus_N': '1/10', 'hypothetical_additive_N_minus_Y': '3/10', 'interpretation': 'Ilustração condicional da dependência do voto de H. O ramo aditivo não é adotado.'},
    'C6_certain_failure': {'continuation_both_proposals': '2/5', 'payoff_difference': '0', 'interpretation': 'Se ambas fracassam certamente e mantêm a mesma continuação, não há ganho estrito. Não afirma que esse par seja ótimo no baseline.'},
}
write_json(OUT / 'mechanical_checks.json', checks)

def finding(fid, rev, lines, title, typ, severity, dimension, status, locations, evidence, reasoning, fix, disposition, held=False, role='diagnosis', refs=()):
    return {'finding_id': fid, 'source_review': rev, 'source_review_lines': list(lines),
            'title': title, 'quoted_finding': quote(rev, *lines), 'type': typ, 'severity': severity,
            'scientific_dimension': dimension, 'held_decision': held, 'finding_role': role,
            'status': status, 'source_locations': locations, 'defect_evidence': evidence,
            'refuting_evidence': [], 'mechanical_checks': list(refs), 'reasoning': reasoning,
            'proposed_fix_assessment': fix, 'disposition': disposition}

findings = [
finding('R1-F001', 'R1', (5, 7), 'A regra contestada ainda aparece como primitiva',
        'scope_or_consistency', 'major', 'mechanism_and_instruction_fidelity', 'CONFIRMED',
        ['AGENTS.md:21,27,33,39', 'formal_model_v6.Rmd:340-348,1385-1397', 'quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:24-32'],
        ['AGENTS.md:21 determina o recebimento de o_theta sem x_H e o não pagamento da fatia; a frase final afirma que H nunca recebe ambos.',
         'O manuscrito define essa regra antes das provas, e o memo a lista no mandato como correção de payoff recebida como input.',
         'review_sources/author_correction.md:5 exige sustentação pela arquitetura e pelos incentivos e contesta essa solução por estipulação.'],
        'Há incompatibilidade entre o caráter inviolável dado à regra no AGENTS e o mandato atual. Isso não demonstra que as provas antigas sejam internamente falsas no jogo que especificam. Demonstra que usar esse input como evidência do novo requisito seria circular. A transcrição literal da correção autoral foi preservada como fonte adicional.',
        'safe', 'Atualizar apenas as instruções e a nota de estado: identificar a antiga regra como contestada e registrar a obrigação de prova. Preservar manuscrito, contratos e candidatos históricos; não instalar uma nova função de payoff.',
        held=True),
finding('R1-F002', 'R1', (9, 15), 'A dominância é condicional e antecede a votação',
        'logic_or_proof', 'major', 'mechanism_and_scope', 'CONFIRMED',
        ['formal_model_v6.Rmd:1429-1443,1479-1499', 'quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:73-118'],
        ['A prova fixa a classe em que pelo menos k respondedores fracos aprovam, mantém suas alocações e muda a proposta para x_H=0 e x_i+x_H.',
         'O ganho x_H usa o pagamento do proponente e a preservação da aprovação. Não equivale a uma transferência automática após o resultado da votação.',
         'Em R1, a independência dos votos fracos usa a continuação terminal 1/m; portanto, reaproveitar o argumento depende de preservar ou rederivar essa interface.'],
        'O parecer descreve corretamente uma parte condicional reaproveitável: a identidade do ganho não precisa do payoff específico de H quando o pagamento do proponente e a aprovação são mantidos. Não há aqui validação de uma arquitetura alternativa completa nem licença para transplantar seus resultados de R1. A comparação ocorre entre propostas factíveis antes do ballot.',
        'needs_design', 'Reter como evidência delimitada e como requisito para uma derivação futura. Não confundir a alteração da proposta com reversão automática da fatia.', refs=['mechanical_checks.json:C1_reallocation']),
finding('R1-F003', 'R1', (17, 17), 'O voto de H fora do caminho depende do payoff disputado',
        'logic_or_proof', 'major', 'implementation_fidelity_and_mechanism', 'CONFIRMED',
        ['formal_model_v6.Rmd:1433-1435,1482-1489', 'quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:130-137,343-360'],
        ['Os limiares não pivotais x_H>=o comparam explicitamente u_H(Y)=x_H e u_H(N)=o.',
         'O memo distingue alteração da estratégia completa de invariância dos resultados reportados, sujeita a revisão.'],
        'A sensibilidade é verificável diretamente: no exemplo hipotético aditivo, u_H(N)-u_H(Y)=o>0. Isso refaz a resposta ótima de H naquele ramo e mostra por que a regra antiga não pode ser retirada sem examinar estratégias completas. O exemplo é condicional; não define o jogo vigente.',
        'needs_design', 'Manter pendente a resposta completa de H sob qualquer arquitetura substituta. Não afirmar invariância das estratégias nem reusar o limiar por analogia.', refs=['mechanical_checks.json:C5_payoff_sensitivity']),
finding('R1-F004', 'R1', (19, 25), 'A arquitetura que satisfaz todo o requisito ainda não está estabelecida',
        'logic_or_proof', 'major', 'mechanism_and_scope', 'UNRESOLVED',
        ['AGENTS.md:21,22,43-47', 'formal_model_v6.Rmd:314-354,1385-1423', 'review_sources/architecture_dependency.md:19-25', 'review_sources/offpath_requirement.md:13-17,29-35'],
        [],
        'As fontes verificadas definem o ramo disputado por cancelamento. Os pareceres oferecem uma obrigação sobre propostas ótimas e distinguem sua cobertura das histórias após desvios arbitrários; não fornecem outra arquitetura completa, nem uma prova que satisfaça toda a exigência autoral. Não é possível certificar a ausência de recebimento conjunto em toda história pertinente ou escolher uma nova regra de payoff a partir deste diagnóstico estreito. Isso não é uma prova de impossibilidade universal.',
        'needs_design', 'Preservar a pendência no registro global. Uma revisão substantiva do jogo e sua derivação exigem escopo próprio; a correção de instruções pode apenas tornar a pendência explícita.', held=True),
finding('R2-F001', 'R2', (7, 11), 'Rejeição certa e rejeição de alguns tipos são condições distintas',
        'method', 'major', 'information_and_scope', 'CONFIRMED',
        ['formal_model_v6.Rmd:301-306,330-337,1401-1423', 'review_sources/offpath_requirement.md:7-11'],
        ['O proponente fraco não observa o tipo de H; uma condição de conhecimento deve usar seu conjunto de informação, a crença admissível e a estratégia de H.',
         'Pode-se ter probabilidade de rejeição 1/2 e de aprovação com voto não 1/2. Uma condição acionada apenas por rejeição certa não cobre esse caso lógico.'],
        'A insuficiência lógica é confirmada sem afirmar que o vetor usado no exemplo seja um equilíbrio. O evento a verificar deve conter aprovação e voto não, preservando a possibilidade de screening em que o voto não faz a proposta fracassar.',
        'safe', 'Na obrigação de prova, exigir a verificação do evento conjunto aprovação e voto não para propostas ótimas com x_H>0. Não proibir de partida ofertas que algum tipo rejeitaria.', refs=['mechanical_checks.json:C2_probability_logic']),
finding('R2-F002', 'R2', (13, 17), 'Dois sentidos de fora do caminho e tipos de probabilidade zero',
        'scope_or_consistency', 'major', 'equilibrium_scope', 'CONFIRMED',
        ['AGENTS.md:22,43,45', 'formal_model_v6.Rmd:314-337,1401-1423', 'review_sources/offpath_requirement.md:13-17'],
        ['O simplex permite x_H>0 e os votos simultâneos incluem um vetor em que fracos aprovam e H vota não. A eliminação de uma proposta da escolha ótima não a retira do conjunto de ações factíveis.',
         'O manuscrito exige regras de crença e racionalidade em propostas fora do caminho e contempla posteriores degenerados; probabilidade local zero não é cobertura tipo a tipo.'],
        'É correta a distinção entre otimizar em conjuntos de informação não alcançados e definir payoffs após uma ação desviadora. A garantia probabilística sob uma crença não cobre, por si, tipos factíveis aos quais essa crença atribui zero. Isso define uma fronteira de verificação, sem alegar que toda crença hipotética seja alcançável.',
        'safe', 'Exigir cobertura explícita dos dois sentidos de fora do caminho e declarar se o resultado cobre tipos de probabilidade posterior zero. Preservar o espaço de propostas e o timing até decisão substantiva.', refs=['mechanical_checks.json:C3_zero_posterior']),
finding('R2-F003', 'R2', (19, 23), 'O lema terminal é independente do payoff disputado de H',
        'logic_or_proof', 'minor', 'bounded_formal_result', 'CONFIRMED',
        ['formal_model_v6.Rmd:301-318,330-353,1385-1393,1419-1443', 'review_sources/offpath_requirement.md:19-23'],
        ['m>=3 implica floor((m+1)/2)<=m-1; os votos fracos bastam sob maioria.',
         'Com desacordo terminal zero e sim na indiferença, alocações zero aos respondedores passam. O proponente pode receber 1, enquanto qualquer x_H>0 limita seu payoff aprovado a 1-x_H<1 e o rejeitado a zero.'],
        'O resultado auxiliar está confirmado sob os payoffs dos fracos, o simplex, a quota e o desempate citados. Não utiliza a regra disputada de H. Não demonstra o resultado dinâmico completo nem exclui da árvore uma proposta arbitrária positiva. A checagem finita da quota apenas acompanha a desigualdade algébrica geral registrada.',
        'safe', 'Usar somente como resultado auxiliar terminal e entrada para trabalho posterior. Não migrar uma nova arquitetura para o manuscrito nesta tarefa.', role='supporting_result', refs=['mechanical_checks.json:C4_terminal_quota']),
finding('R2-F004', 'R2', (25, 29), 'Desperdício exige preservação da aprovação e ganho estrito',
        'method', 'major', 'dynamic_incentives', 'CONFIRMED',
        ['quality_reports/2026-09-01_b1_b3_exclusion_derivation.md:75-102', 'formal_model_v6.Rmd:350-356,1479-1499', 'review_sources/offpath_requirement.md:25-29'],
        ['A prova atual verifica que os votos fracos continuam bastando e que o ganho é x_H>0. Essa checagem faz parte da prova; não pode ser substituída pela palavra desperdício.',
         'Se duas propostas fracassam certamente e levam à mesma continuação, seus payoffs são iguais. Isso não sustenta uma eliminação estrita por racionalidade.'],
        'O alerta é correto como condição lógica. Ele não mostra que a situação de indiferença seja ótima ou ocorra no equilíbrio do baseline. A rederivação precisa verificar votos, aprovação e valores de continuação pertinentes. O exemplo aditivo reforça a dependência de H já registrada em R1-F003 e não é uma recomendação de adotá-lo.',
        'safe', 'Registrar uma comparação explícita de desvios como obrigação. Não inserir desempate, hipótese de estriteza ou restrição às ofertas para recuperar o resultado.', refs=['mechanical_checks.json:C6_certain_failure']),
finding('R2-F005', 'R2', (31, 35), 'A instrução deve exigir uma demonstração e manter a pendência visível',
        'scope_or_consistency', 'major', 'instruction_fidelity', 'CONFIRMED',
        ['AGENTS.md:21-27,33,39,43-56', 'review_sources/offpath_requirement.md:31-35', 'review_sources/architecture_dependency.md:19-25'],
        ['O AGENTS atual trata o cancelamento e a ausência de recebimento conjunto como regras já fixadas; não atribui a ausência de acúmulo a uma obrigação de demonstração pendente.',
         'As cláusulas de autorização e separação de revisão já existentes permitem registrar a exigência sem editar primitivas, provas ou manuscrito.'],
        'A direção operacional proposta é compatível com a correção literal em review_sources/author_correction.md:5: tornar a antiga estipulação contestada e exigir derivação das propostas e das respostas em cada histórico pertinente. A redação precisa preservar a distinção entre alvos de prova e restrições ao jogo. A implementação deve apontar para a nota dessa decisão.',
        'safe', 'Corrigir apenas AGENTS e nota de estado, mantendo payoffs dos fracos, votos simultâneos e continuação quando a proposta fracassa. Proibir a certificação do requisito com base apenas na antiga estipulação; não fixar automaticamente uma arquitetura alternativa.', held=True),
]

def summary(items):
    c = Counter(f['status'] for f in items)
    return {'total': len(items), 'confirmed': c['CONFIRMED'], 'partial': c['PARTIAL'], 'refuted': c['REFUTED'],
            'unresolved': c['UNRESOLVED'], 'held_decisions': sum(f['held_decision'] for f in items)}

base = {
    'schema_version': '1.0', 'adjudication_id': 'pbp-architecture-clarification:695069a7b432:round1-global',
    'source': {'reviewed_artifact': str(ROOT / 'before/AGENTS.md'), 'sha256': PREFLIGHT['selected_hashes']['AGENTS.md'], 'artifact_intact': True},
    'contract': {'required': False, 'path': None, 'sha256': None, 'contract_id': None, 'artifact_sha256': None, 'status': None, 'stale': False},
    'contract_scope_reason': 'Diagnóstico estreito da regra de payoff e de sua obrigação de prova, conforme o mandato recebido. Não é uma revisão integral do argumento ou do manuscrito.',
    'review_sources': [{'review_id': rid, 'path': str(path), 'sha256': sha(path)} for rid, path in reviews.items()],
    'author_correction_source': {'path': str(AUTHOR_PATH), 'sha256': sha(AUTHOR_PATH), 'quoted_author_correction': AUTHOR_TEXT.splitlines()[4]},
    'supporting_sources': identities,
    'identity_notes': ['Os snapshots e os seis arquivos selecionados no repositório coincidem com preflight.json e são legíveis em UTF-8.',
                       'Os pareceres salvos são transcrições identificadas dos revisores; não incorporam hashes próprios dos inputs. Seus localizadores e alegações pertinentes foram conferidos diretamente nos snapshots com hash verificado. Isso não é certificação de que os revisores leram o paper inteiro.'],
    'mandate': {'latest_author_correction': 'A ausência de acúmulo deve decorrer da arquitetura econômica e da racionalidade, inclusive fora do caminho. Estipular H-no-pass recebe o e cancelar x_H não basta; se a arquitetura não gera o requisito, sua revisão deve ser apresentada sem vedação de partida.',
                'provenance': 'Transcrição literal preservada em review_sources/author_correction.md:5. O resumo neste campo é uma paráfrase; a transcrição e seu hash constam em author_correction_source.',
                'allowed_component': 'Atualização segura das instruções e de uma nota de estado; sem redefinir jogo ou editar provas.',
                'held_decision': True},
    'findings': findings, 'summary': summary(findings),
    'adjudication': {'verdict': 'BLOCKED', 'checked_at': datetime.now().astimezone().isoformat(),
                     'reasons': ['R1-F004 é material e permanece não resolvido: nenhuma arquitetura alternativa completa foi especificada e verificada para cumprir todo o requisito.',
                                 'A integridade das fontes foi confirmada. O bloqueio é substantivo e limitado à conclusão sobre a arquitetura.',
                                 'A correção de instruções é independente: um record delimitado mantém a pendência e autoriza tecnicamente apenas a marcação de status e a obrigação de prova.']},
    'count_interpretation': 'As contagens referem-se a nove observações normalizadas, incluindo limites de prova e um resultado auxiliar. Não significam oito defeitos distintos do manuscrito.',
    'unsafe_fixes': ['Converter o evento a provar em restrição adicional ao espaço de propostas.', 'Manter o cancelamento de x_H como axioma e apresentá-lo como consequência de racionalidade.', 'Adotar x_H+o como nova regra de payoff sem desenho e autorização.', 'Eliminar histórias factíveis após desvios por serem subótimas.', 'Inserir uma escolha de H depois da divulgação dos votos, um opt-out imediato após fracasso ou um novo desempate.', 'Transportar limiares, estratégias completas ou resultados históricos para uma arquitetura nova sem rederivação.'],
    'owner_decisions': ['Qual revisão substantiva da arquitetura adotar, se necessária, e qual seu escopo de implementação. A exigência de sustentar a ausência de acúmulo é mantida; a solução econômica ainda não foi escolhida.'],
    'not_performed': ['Nenhuma edição de repositório, candidato ou artefato congelado.', 'Nenhuma auditoria integral do paper ou da extensão de agenda.', 'Nenhuma busca de equilíbrio, nova solução de jogo ou certificação matemática global.'],
}
global_path = OUT / 'adjudication_round1_global.json'
write_json(global_path, base)
component = json.loads(json.dumps(base))
component['adjudication_id'] = 'pbp-architecture-clarification:695069a7b432:round1-agents-only'
component['findings'] = [f for f in findings if f['finding_id'] in {'R1-F001', 'R2-F005'}]
component['summary'] = summary(component['findings'])
component['count_interpretation'] = 'As contagens deste componente cobrem apenas duas correções de instruções. As demais observações e a pendência material permanecem no registro global.'
component['global_record'] = {'path': str(global_path), 'sha256': sha(global_path), 'verdict': 'BLOCKED'}
component['component_boundary'] = {
    'artifact': 'AGENTS.md e nota de estado; o candidato não foi revisado por esta adjudicação.',
    'independence_evidence': ['Os dois findings encaminhados corrigem a afirmação de que a antiga primitiva encerra a questão. Sua correção consiste em marcar que a questão está em aberto.',
                             'A redação de uma obrigação de prova não escolhe o payoff do ramo contestado, não modifica as ações ou as crenças e não pressupõe que o resultado desejado exista.',
                             'R1-F004 deve continuar identificado como não resolvido na nota e nas instruções. A revisão da arquitetura ou migração ao manuscrito não é encaminhada.'],
    'other_findings_retained_in_global_record': [f['finding_id'] for f in findings if f['finding_id'] not in {'R1-F001', 'R2-F005'}],
    'unresolved_dependency_not_resolved': 'R1-F004: não impede registrar uma pendência; impede certificar ou implementar uma arquitetura que a resolva.',
}
component['adjudication'] = {'verdict': 'READY_FOR_IMPLEMENTATION', 'checked_at': base['adjudication']['checked_at'],
                           'reasons': ['R1-F001 e R2-F005 confirmam a necessidade de atualizar as instruções após a correção autoral.',
                                       'As intervenções seguras registram status e obrigação de prova sem depender da resolução de R1-F004.',
                                       'O record global BLOCKED é preservado e referenciado; nenhuma revisão substantiva do jogo é encaminhada.']}
write_json(OUT / 'adjudication_round1_agents_only.json', component)

def render(record):
    lines = ['# Adjudicação: exclusão e obrigação de prova', '',
             f"Veredicto: `{record['adjudication']['verdict']}`. Registro: `{record['adjudication_id']}`.", '',
             '## Fonte e escopo', '', f"Artefato principal: `{record['source']['reviewed_artifact']}`.",
             f"SHA-256: `{record['source']['sha256']}`.", '', record['contract_scope_reason'], '',
             f"A transcrição literal da correção autoral está em `{AUTHOR_PATH}`, SHA-256 `{sha(AUTHOR_PATH)}`. O JSON preserva a transcrição e distingue dela o resumo do mandato.", '',
             'As identidades adicionais e os hashes dos pareceres constam no JSON e em `identity_checks.json`. Todos os inputs selecionados conferiram com os snapshots.', '',
             '## Encaminhamento', '']
    lines += ['- ' + reason for reason in record['adjudication']['reasons']]
    if 'global_record' in record:
        lines += ['', f"Registro global preservado: `{record['global_record']['path']}`, SHA-256 `{record['global_record']['sha256']}`.", '',
                  'Independência da parte segura:', '']
        lines += ['- ' + e for e in record['component_boundary']['independence_evidence']]
        lines += ['', 'Demais IDs mantidos no registro global: ' + ', '.join(record['component_boundary']['other_findings_retained_in_global_record']) + '.', '', record['component_boundary']['unresolved_dependency_not_resolved']]
    lines += ['', '## Findings', '', '| ID | Status | Objeto | Correção proposta |', '| --- | --- | --- | --- |']
    for f in record['findings']:
        lines.append(f"| {f['finding_id']} | {f['status']} | {f['title']} | {f['proposed_fix_assessment']} |")
    lines += ['', record['count_interpretation'], '']
    for f in record['findings']:
        lines += [f"## {f['finding_id']}: {f['title']}", '', f"Status: `{f['status']}`. Tipo: `{f['type']}`. Severidade: `{f['severity']}`. Dimensão: `{f['scientific_dimension']}`.", '',
                  f"Fonte: {f['source_review']}, linhas {f['source_review_lines'][0]}–{f['source_review_lines'][-1]}. Decisão mantida do autor: {'sim' if f['held_decision'] else 'não'}.", '', 'Texto do parecer:', '']
        lines += ['> ' + line for line in f['quoted_finding'].splitlines()]
        lines += ['', 'Localizadores: ' + '; '.join(f['source_locations']) + '.', '', 'Evidência:', '']
        lines += ['- ' + e for e in f['defect_evidence']] or ['Não há evidência suficiente para decidir a questão substantiva.']
        lines += ['', f['reasoning'], '', 'Encaminhamento: ' + f['disposition']]
        if f['mechanical_checks']:
            lines += ['', 'Checagens: ' + ', '.join(f['mechanical_checks']) + '.']
        lines += ['']
    lines += ['## Correções inseguras e decisões do autor', ''] + ['- ' + e for e in record['unsafe_fixes']]
    lines += [''] + ['- ' + e for e in record['owner_decisions']]
    lines += ['', '## Pendências e limites', '', 'R1-F004 permanece não resolvido no registro global. A ausência de um finding refutado não equivale a uma certificação global das proposições do manuscrito.', '']
    lines += ['- ' + e for e in record['not_performed']]
    lines += ['', 'Contagens: ' + json.dumps(record['summary'], ensure_ascii=False) + '.', '', f"Veredicto: `{record['adjudication']['verdict']}`.", '']
    return '\n'.join(lines)

for suffix, record in [('global', base), ('agents_only', component)]:
    (OUT / f'adjudication_round1_{suffix}.md').write_text(render(record), encoding='utf-8')

(OUT / 'report.md').write_text('''# Relatório da adjudicação

A correção de instruções pode seguir; a questão da arquitetura permanece aberta.

O AGENTS atual, o manuscrito e o memorando B.1/B.3 estipulam que, após aprovação sem o voto de H, ele recebe apenas a opção externa e sua fatia não é paga. As provas de dominância também usam a comparação entre propostas para eliminar x_H positivo quando os votos fracos já bastam. Essa comparação não retira da árvore histórias que seguem a uma proposta desviadora. A exigência autoral atual não pode ser certificada apenas pela antiga estipulação.

O registro global é BLOCKED por R1-F004. Isso preserva a pergunta sobre a arquitetura completa, as respostas fora do caminho e a cobertura de tipos com probabilidade posterior zero. Não significa que foi provada a inexistência de uma arquitetura adequada.

O registro delimitado ao AGENTS é READY_FOR_IMPLEMENTATION para R1-F001 e R2-F005: marcar a regra antiga como contestada, exigir a demonstração pelas primitivas e incentivos e manter a pendência visível. A intervenção não escolhe novos payoffs, restringe propostas, modifica votos ou autoriza uma migração de provas.

Os demais pontos confirmados delimitam a obrigação de prova: rejeição certa não cobre rejeição de alguns tipos; propostas ótimas fora do caminho não esgotam histórias após desvios arbitrários; e probabilidade local zero não é garantia tipo a tipo. O argumento terminal x_H=0 foi verificado apenas sob os payoffs dos fracos, a quota, a viabilidade e o desempate. Os registros não promovem essa observação a solução do jogo dinâmico.

Arquivos: adjudication_round1_global.json e .md; adjudication_round1_agents_only.json e .md; identity_checks.json; mechanical_checks.json. A construção é reproduzível por build_adjudication.py. O relatório validation.txt registra a execução do validador da skill.

Nenhum arquivo do repositório, candidato do implementador ou artefato congelado foi editado por esta adjudicação.
''', encoding='utf-8')
print(json.dumps({'global': base['adjudication']['verdict'], 'global_summary': base['summary'], 'agents_only': component['adjudication']['verdict'], 'agents_summary': component['summary']}, ensure_ascii=False))
