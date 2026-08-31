import fs from "node:fs/promises";
import path from "node:path";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const { Presentation, PresentationFile } = require("@oai/artifact-tool");

const ROOT = "/Users/manoelgaldino/Documents/DCP/Papers/PowerBayesianPersuasion";
const OUT = path.join(ROOT, "presentations/2026-08-30_agenda_information_seminar");
const FIG = path.join(OUT, "figures");
const PREVIEW = path.join(OUT, "build/pptx_preview");
const FIGURE_NAMES = [
  "figura_1_substituto_informacional.png",
  "figura_2_gap_publico.png",
  "figura_3_ponte_reversao.png",
  "figura_4_incidencia_por_tipo.png",
  "figura_5_efeito_direto_agenda.png",
];
const FIGURE_BYTES = Object.fromEntries(
  await Promise.all(FIGURE_NAMES.map(async (name) => [name, new Uint8Array(await fs.readFile(path.join(FIG, name)))])),
);

const C = {
  navy: "#143B5D",
  blue: "#2C7FB8",
  orange: "#E76F51",
  teal: "#2A9D8F",
  ink: "#17212B",
  muted: "#66727E",
  pale: "#EEF3F6",
  line: "#D8E1E7",
  white: "#FFFFFF",
};

async function writeBlob(filePath, blob) {
  await fs.writeFile(filePath, new Uint8Array(await blob.arrayBuffer()));
}

const deck = Presentation.create({ slideSize: { width: 1280, height: 720 } });

function shape(slide, geometry, position, fill = "none", line = "none", radius = undefined) {
  return slide.shapes.add({
    geometry,
    position,
    fill,
    line: line === "none" ? { style: "solid", fill: "none", width: 0 } : line,
    ...(radius ? { borderRadius: radius } : {}),
  });
}

function textbox(slide, text, position, style = {}) {
  const box = shape(slide, "textbox", position, "none");
  box.text = text;
  box.text.style = {
    fontSize: style.fontSize ?? 25,
    color: style.color ?? C.ink,
    bold: style.bold ?? false,
    alignment: style.alignment ?? "left",
    verticalAlignment: style.verticalAlignment ?? "top",
    autoFit: "shrinkText",
    insets: style.insets ?? { left: 4, right: 4, top: 3, bottom: 3 },
  };
  return box;
}

function addHeader(slide, title, number) {
  textbox(slide, title, { left: 70, top: 36, width: 1030, height: 54 }, {
    fontSize: 32, color: C.navy, bold: true, verticalAlignment: "middle",
  });
  shape(slide, "rect", { left: 70, top: 100, width: 92, height: 5 }, C.orange);
  textbox(slide, String(number), { left: 1170, top: 42, width: 45, height: 36 }, {
    fontSize: 15, color: C.muted, alignment: "right", verticalAlignment: "middle",
  });
}

function addFooter(slide, source) {
  textbox(slide, source, { left: 72, top: 680, width: 1120, height: 24 }, {
    fontSize: 11, color: C.muted, verticalAlignment: "middle",
  });
}

function addCard(slide, x, y, w, h, title, body, accent = C.blue) {
  const card = shape(slide, "roundRect", { left: x, top: y, width: w, height: h }, C.white,
    { style: "solid", fill: C.line, width: 1 }, "rounded-xl");
  card.shadow = "shadow-sm";
  shape(slide, "rect", { left: x, top: y, width: 8, height: h }, accent);
  textbox(slide, title, { left: x + 24, top: y + 18, width: w - 42, height: 38 }, {
    fontSize: 23, color: C.navy, bold: true,
  });
  textbox(slide, body, { left: x + 24, top: y + 65, width: w - 45, height: h - 82 }, {
    fontSize: 19, color: C.ink,
  });
}

function addImageSlide(imageName, alt) {
  const slide = deck.slides.add();
  slide.background.fill = C.white;
  slide.images.add({
    blob: FIGURE_BYTES[imageName],
    contentType: "image/png",
    alt,
    fit: "contain",
    position: { left: 0, top: 0, width: 1280, height: 720 },
  });
  return slide;
}

// 1. Title
{
  const slide = deck.slides.add();
  slide.background.fill = C.white;
  shape(slide, "rect", { left: 0, top: 0, width: 22, height: 720 }, C.orange);
  textbox(slide, "QUANDO O CONSENSO\nPODE DAR PODER AO HEGEMON", { left: 94, top: 132, width: 730, height: 190 }, {
    fontSize: 50, color: C.navy, bold: true, verticalAlignment: "middle",
  });
  textbox(slide, "Agenda, indispensabilidade e renda informacional", { left: 98, top: 340, width: 710, height: 55 }, {
    fontSize: 25, color: C.muted,
  });
  addCard(slide, 875, 145, 300, 300, "A pergunta", "Por que um hegemon como os Estados Unidos poderia preferir consenso a maioria?", C.orange);
  textbox(slide, "Manoel Galdino  •  Seminário de Economia Política Internacional", { left: 98, top: 618, width: 780, height: 36 }, {
    fontSize: 16, color: C.muted,
  });
}

// 2. Puzzle
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "O paradoxo da OMC", 2);
  addCard(slide, 70, 145, 520, 400, "Igualdade formal", "• Primeiro, consenso.\n• Se não houver consenso, votação.\n• Cada membro tem um voto.\n\nMas os Estados Unidos continuam capazes de moldar resultados.", C.blue);
  addCard(slide, 635, 145, 565, 400, "A pergunta", "Por que um hegemon aceitaria — e às vezes preferiria — uma regra que dá veto formal a todos?", C.orange);
  addFooter(slide, "Acordo de Marrakesh, Art. IX. Aplicação aos EUA: interpretação teórica, não teste empírico.");
}

// 3. Conventional answer
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "A resposta convencional: pesos invisíveis", 3);
  addCard(slide, 70, 142, 340, 355, "Agenda", "Controle do texto, do timing e do conjunto de alternativas.", C.blue);
  addCard(slide, 470, 142, 340, 355, "Poder material", "Ameaça de saída, coerção e fechamento de opções.", C.orange);
  addCard(slide, 870, 142, 340, 355, "Consenso", "Legitima formalmente um acordo já moldado na negociação informal.", C.teal);
  textbox(slide, "Nossa pergunta adicional: o que a regra faz com a informação privada do hegemon?", { left: 120, top: 548, width: 1035, height: 74 }, {
    fontSize: 27, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addFooter(slide, "Steinberg (2002), “In the Shadow of Law or Power?”.");
}

// 4. Neighbors
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "O que a teoria próxima já ensina", 4);
  addCard(slide, 70, 140, 535, 420, "Piazolo–Vanberg (GEB)", "• Proponente fixo.\n• Dois respondentes informados.\n• Rejeição sinaliza força sob unanimidade.\n• Respondentes mais caros; atraso e desacordo.", C.blue);
  addCard(slide, 675, 140, 535, 420, "Glynia–Thum–Xefteris", "• Respondentes conhecem seus custos.\n• Proponente conhece a distribuição.\n• Escolha entre proposta segura e aposta.\n• Rankings não monotônicos.", C.teal);
  textbox(slide, "O GEB já mostra sinalização e exclusão; perguntamos quem captura o prêmio sem agenda hegemônica.", { left: 120, top: 585, width: 1040, height: 62 }, {
    fontSize: 23, color: C.orange, bold: true, alignment: "center",
  });
}

// 5. Question
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "A pergunta que resta", 5);
  textbox(slide, "Quando a informação gera poder mesmo sem agenda hegemônica ou votos extras?", { left: 130, top: 160, width: 1020, height: 130 }, {
    fontSize: 38, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addCard(slide, 345, 340, 590, 150, "Benchmark deliberadamente exigente", "πH = 0: apenas Estados fracos propõem nos dois períodos.", C.orange);
  textbox(slide, "Se H ganhar sob unanimidade, o ganho não pode ser atribuído à iniciativa formal.", { left: 180, top: 535, width: 920, height: 70 }, {
    fontSize: 24, color: C.ink, alignment: "center",
  });
}

// 6. Model
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Arquitetura mínima do modelo", 6);
  addCard(slide, 70, 145, 520, 390, "Atores e informação", "• Um hegemon H e m ≥ 3 Estados fracos.\n• H conhece sua exigência mínima: o₁ > o₀.\n• Os fracos conhecem apenas ν = Pr(θ = 1).", C.blue);
  addCard(slide, 635, 145, 565, 390, "Instituições e tempo", "• Dois períodos; desconto β.\n• O pacote y concede excedente a H.\n• Maioria pode excluir H.\n• Unanimidade exige seu sim.", C.orange);
  textbox(slide, "A regra muda se uma coalizão pode contornar o voto informado.", { left: 150, top: 555, width: 980, height: 48 }, {
    fontSize: 26, color: C.navy, bold: true, alignment: "center",
  });
  addFooter(slide, "R1: fraco propõe → votos → acordo/continuação β → R2 terminal: fraco propõe → acordo/desacordo.");
}

addImageSlide("figura_1_substituto_informacional.png", "Figura 1: maioria pode substituir H; unanimidade torna H essencial.");
addImageSlide("figura_2_gap_publico.png", "Figura 2: vantagem pública da maioria por opção externa.");

// 9. Private information
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Com informação privada, as regras ativam jogos distintos", 9);
  addCard(slide, 70, 145, 525, 420, "Maioria", "• Pode contornar H.\n• Screening, pooling e exclusão.\n• A exigência de H pode ser evitada por uma coalizão alternativa.", C.blue);
  addCard(slide, 665, 145, 545, 420, "Unanimidade", "• Todo acordo compra o sim de H.\n• Crença baixa: oferta ao tipo baixo.\n• Crença intermediária: não há PBE puro.\n• Crença alta: pooling no limiar alto.", C.orange);
  textbox(slide, "No pooling, a baixa exigência é paga como se pudesse ser alta.", { left: 175, top: 588, width: 930, height: 52 }, {
    fontSize: 25, color: C.navy, bold: true, alignment: "center",
  });
}

addImageSlide("figura_4_incidencia_por_tipo.png", "Figura 4: incidência da renda por tipo.");

// 11. Identification
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Como identificar a fonte do ganho", 11);
  addCard(slide, 90, 145, 1100, 118, "Fixe um par de equilíbrios comparáveis (sM, sU)", "RIgθ(sg) = Vg(priv, θ; sg) − hg(oθ)", C.blue);
  addCard(slide, 90, 292, 1100, 118, "Mudança institucional do prêmio", "ΔRIθ(sU,sM) = RIUθ(sU) − RIMθ(sM)", C.orange);
  addCard(slide, 90, 439, 1100, 130, "Teste da reversão", "δθ(sU,sM) = −G(oθ) + ΔRIθ(sU,sM)", C.teal);
  textbox(slide, "Se G(o₀) > 0 e δ₀ > 0, então ΔRI₀ > G(o₀). Resultado existencial equilíbrio a equilíbrio.", { left: 130, top: 603, width: 1020, height: 40 }, {
    fontSize: 20, color: C.muted, alignment: "center",
  });
}

addImageSlide("figura_3_ponte_reversao.png", "Figura 3: a renda informacional carrega a reversão.");

// 13. Literature positioning
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "A contribuição diante dos dois papers próximos", 13);
  addCard(slide, 55, 135, 365, 445, "GEB", "Informados: dois respondentes simétricos.\n\nAgenda: proponente fixo.\n\nRegra: muda sinal da rejeição e preço dos votos.\n\nObjeto: custo, atraso, desacordo.", C.blue);
  addCard(slide, 458, 135, 365, 445, "Public Choice", "Informação: respondentes conhecem seus custos; proponente conhece a distribuição.\n\nAgenda: agenda setter fixo.\n\nRegra: muda seguro versus aposta.\n\nObjeto: aprovação e transferências.", C.teal);
  addCard(slide, 860, 135, 365, 445, "Este modelo", "Informado: um único hegemon.\n\nAgenda: retirada e devolvida.\n\nRegra: torna sua informação evitável ou incontornável.\n\nObjeto: incidência, reversão e três poderes.", C.orange);
  textbox(slide, "Não descobrimos o sinal da rejeição: isolamos quem captura o prêmio sem agenda hegemônica.", { left: 140, top: 610, width: 1000, height: 45 }, {
    fontSize: 22, color: C.navy, bold: true, alignment: "center",
  });
}

// 14. Agenda epilogue
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Epílogo: devolvendo a agenda ao hegemon", 14);
  textbox(slide, "Agenda acrescenta duas coisas diferentes", { left: 140, top: 130, width: 1000, height: 80 }, {
    fontSize: 31, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addCard(slide, 105, 250, 500, 265, "Efeito direto", "Sob unanimidade, DU = 1 − β > 0. Dar a proposta a H eleva diretamente seu payoff.", C.blue);
  addCard(slide, 675, 250, 500, 265, "Interação informacional", "Em células comparáveis de alta exigência, IU¹ ≤ 0. Agenda pode comprimir o prêmio informacional.", C.orange);
  textbox(slide, "Agenda aumenta o payoff, mas pode substituir parte do poder de informação.", { left: 145, top: 565, width: 990, height: 60 }, {
    fontSize: 24, color: C.teal, bold: true, alignment: "center",
  });
  addFooter(slide, "A_T: resultado revisado, ainda não congelado. Nos pares provados sob unanimidade, o efeito total é não negativo.");
}

// 15. WTO answer
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Quando os EUA de baixa exigência podem receber mais sob consenso", 15);
  const body = "1. Exigência mínima para aceitar parcialmente privada.\n\n2. Maioria sem os EUA viável e capaz de contornar sua informação.\n\n3. Consenso torna a objeção norte-americana incontornável no domínio modelado.\n\n4. Crença alta sustenta pooling.\n\n5. ΔRI₀(sU,sM) > G(o₀).";
  addCard(slide, 90, 135, 1100, 420, "As cinco condições", body, C.orange);
  textbox(slide, "Preferência interina do tipo baixo, sob regra fixa — não uma preferência ex ante de todos os tipos.", { left: 150, top: 585, width: 980, height: 56 }, {
    fontSize: 27, color: C.navy, bold: true, alignment: "center",
  });
}

// 16. Conclusion
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Três poderes, uma conclusão", 16);
  addCard(slide, 75, 155, 345, 240, "Exigência externa", "Força fora da instituição.", C.blue);
  addCard(slide, 467, 155, 345, 240, "Pivotalidade", "Ausência de substituto para o voto.", C.orange);
  addCard(slide, 860, 155, 345, 240, "Agenda", "Capacidade de escolher a proposta.", C.teal);
  textbox(slide, "CONSENSO PODE TRANSFORMAR INFORMAÇÃO PRIVADA EM PODER QUANDO TORNA O VOTO INFORMADO INCONTORNÁVEL.", { left: 120, top: 465, width: 1040, height: 110 }, {
    fontSize: 34, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  textbox(slide, "Comparação institucional condicional; sem estágio endógeno de escolha da regra e sem teste de um episódio específico da OMC.", { left: 160, top: 620, width: 960, height: 40 }, {
    fontSize: 16, color: C.muted, alignment: "center",
  });
}

async function main() {
  await fs.rm(PREVIEW, { recursive: true, force: true });
  await fs.mkdir(PREVIEW, { recursive: true });
  for (const [index, slide] of deck.slides.items.entries()) {
    const stem = `slide-${String(index + 1).padStart(2, "0")}`;
    await writeBlob(path.join(PREVIEW, `${stem}.png`), await deck.export({ slide, format: "png", scale: 1 }));
    const layout = await slide.export({ format: "layout" });
    await fs.writeFile(path.join(PREVIEW, `${stem}.layout.json`), await layout.text());
  }
  await writeBlob(path.join(PREVIEW, "deck-montage.webp"), await deck.export({ format: "webp", montage: true, scale: 1 }));
  const pptx = await PresentationFile.exportPptx(deck);
  await pptx.save(path.join(OUT, "seminario_agenda_informacao.pptx"));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
