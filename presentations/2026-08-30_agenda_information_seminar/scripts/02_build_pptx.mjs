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
  addCard(slide, 875, 145, 300, 300, "A pergunta", "Como o consenso pode elevar o payoff de um hegemon em relação à maioria?", C.orange);
  textbox(slide, "Manoel Galdino  •  Seminário de Economia Política Internacional", { left: 98, top: 618, width: 780, height: 36 }, {
    fontSize: 16, color: C.muted,
  });
}

// 2. Puzzle
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "O paradoxo da OMC", 2);
  addCard(slide, 70, 145, 520, 400, "Igualdade formal", "• Primeiro, consenso.\n• Se não houver consenso, votação.\n• Cada membro tem um voto.\n\nMas os Estados Unidos continuam capazes de moldar resultados.", C.blue);
  addCard(slide, 635, 145, 565, 400, "A pergunta", "Quando o tipo de baixa exigência pode obter mais sob consenso do que sob maioria?", C.orange);
  addFooter(slide, "Art. IX. Com sim na indiferença, consenso e unanimidade são equivalentes no domínio modelado; aplicação teórica.");
}

// 3. Conventional answer
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "A resposta convencional: pesos invisíveis", 3);
  addCard(slide, 70, 142, 340, 355, "Agenda e informação", "Controle do texto, do timing e das alternativas; aprendizado sobre as restrições dos fracos.", C.blue);
  addCard(slide, 470, 142, 340, 355, "Poder material", "Ameaça de saída, coerção e fechamento de opções.", C.orange);
  addCard(slide, 870, 142, 340, 355, "Consenso", "Legitima formalmente um acordo já moldado na negociação informal.", C.teal);
  textbox(slide, "Nossa pergunta adicional: o que a regra faz com a informação privada do hegemon?", { left: 120, top: 548, width: 1035, height: 74 }, {
    fontSize: 27, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addFooter(slide, "Steinberg (2002), “In the Shadow of Law or Power?”.");
}

// 4. Open margin
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "A margem que Steinberg deixa em aberto", 4);
  addCard(slide, 70, 140, 535, 360, "Na explicação convencional", "• A potência molda texto, timing e alternativas.\n• Sua força material disciplina os fracos.\n• O consenso ratifica um pacote trabalhado informalmente.", C.blue);
  addCard(slide, 675, 140, 535, 360, "No nosso contrafactual", "• H conhece sua própria exigência para aceitar.\n• Os proponentes fracos não a observam.\n• Retiramos de H a iniciativa formal: πH = 0.", C.orange);
  textbox(slide, "A regra pode dar poder à informação do hegemon antes de lhe devolvermos a agenda?", { left: 125, top: 540, width: 1030, height: 75 }, {
    fontSize: 27, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addFooter(slide, "πH = 0 remove o direito formal de propor; não elimina toda a influência informal sobre agenda descrita por Steinberg.");
}

// 5. Model
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Arquitetura mínima do modelo", 5);
  addCard(slide, 70, 145, 520, 390, "Atores e informação", "• Um hegemon H e m ≥ 3 Estados fracos.\n• H conhece sua exigência mínima: o₁ > o₀.\n• Os fracos conhecem apenas ν = Pr(θ = 1).", C.blue);
  addCard(slide, 635, 145, 565, 390, "Instituições e tempo", "• Dois períodos; desconto β.\n• O pacote y concede excedente a H.\n• Maioria pode excluir H.\n• Unanimidade exige seu sim.", C.orange);
  textbox(slide, "A regra muda se uma coalizão pode contornar o voto informado.", { left: 150, top: 555, width: 980, height: 48 }, {
    fontSize: 26, color: C.navy, bold: true, alignment: "center",
  });
  addFooter(slide, "R1: fraco propõe → votos → acordo/continuação β → R2 terminal: fraco propõe → acordo/desacordo.");
}

addImageSlide("figura_1_substituto_informacional.png", "Figura 1: maioria pode substituir H; unanimidade torna H essencial."); // 6
addImageSlide("figura_2_gap_publico.png", "Figura 2: vantagem pública da maioria por opção externa."); // 7

// 8. Private information
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Com informação privada, as regras ativam jogos distintos", 8);
  addCard(slide, 70, 145, 525, 420, "Maioria", "• Pode contornar H.\n• Screening, pooling e exclusão.\n• A exigência de H pode ser evitada por uma coalizão alternativa.", C.blue);
  addCard(slide, 665, 145, 545, 420, "Unanimidade", "• Todo acordo compra o sim de H.\n• Crença baixa: oferta ao tipo baixo.\n• Crença intermediária: não há PBE puro.\n• Crença alta: pooling no limiar alto.", C.orange);
  textbox(slide, "No pooling, a baixa exigência é paga como se pudesse ser alta.", { left: 175, top: 588, width: 930, height: 52 }, {
    fontSize: 25, color: C.navy, bold: true, alignment: "center",
  });
}

// 9. Identification
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Como identificar a fonte do ganho", 9);
  addCard(slide, 90, 145, 1100, 118, "Fixe um par de equilíbrios comparáveis (sM, sU)", "RIgθ(sg) = Vg(priv, θ; sg) − hg(oθ)", C.blue);
  addCard(slide, 90, 292, 1100, 118, "Mudança institucional do prêmio", "ΔRIθ(sU,sM) = RIUθ(sU) − RIMθ(sM)", C.orange);
  addCard(slide, 90, 439, 1100, 130, "Teste da reversão", "δθ(sU,sM) = −G(oθ) + ΔRIθ(sU,sM)", C.teal);
  textbox(slide, "Se G(o₀) > 0 e δ₀ > 0, então ΔRI₀ > G(o₀). Resultado existencial equilíbrio a equilíbrio.", { left: 130, top: 603, width: 1020, height: 40 }, {
    fontSize: 20, color: C.muted, alignment: "center",
  });
}

addImageSlide("figura_3_ponte_reversao.png", "Figura 3: a renda informacional carrega a reversão."); // 10

// 11. GEB positioning
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "GEB: a mesma base institucional, outra arquitetura", 11);
  addCard(slide, 70, 135, 535, 430, "Piazolo–Vanberg", "• Dois respondentes simétricos têm custos privados.\n• Maioria disciplina por exclusão: recorre ao outro, também informado.\n• Unanimidade aumenta o valor de parecer exigente.\n• Rejeição altera preços futuros; também há pooling imediato.", C.blue);
  addCard(slide, 675, 135, 535, 430, "Este modelo", "• Toda a informação privada está num único H.\n• Maioria o substitui por coalizão sem informação sobre θ.\n• Unanimidade torna a única exigência privada incontornável.\n• Mapeamos RIgθ e ΔRIθ por tipo.", C.orange);
  textbox(slide, "Não contrapomos sinalização e indispensabilidade. Mudamos a arquitetura e o estimando.", { left: 130, top: 595, width: 1020, height: 54 }, {
    fontSize: 23, color: C.navy, bold: true, alignment: "center",
  });
  addFooter(slide, "No GEB, uma oferta alta também deixa renda ao tipo baixo: a espécie da renda não é nova.");
}

// 12. Public Choice positioning
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Public Choice: o mesmo seguro, outro portador do poder", 12);
  addCard(slide, 70, 135, 535, 430, "Glynia–Thum–Xefteris", "• Agenda setter fixo e desinformado.\n• Dois respondentes simétricos conhecem seus custos.\n• Uma oferta: seguro caro versus aposta barata.\n• Foco em aprovação, transferências e payoff do proponente.", C.teal);
  addCard(slide, 675, 135, 535, 430, "Nossa mudança de estimando", "• Payoff interino do único ator assimétrico.\n• Benchmark público do mesmo tipo e regra.\n• Maioria pode eliminar toda a informação de H da coalizão.\n• Na extensão, o mesmo H informado recebe agenda.", C.orange);
  textbox(slide, "Não reivindicamos uma nova renda de pooling: seguimos quem a recebe e como ela muda com agenda.", { left: 115, top: 595, width: 1050, height: 54 }, {
    fontSize: 23, color: C.navy, bold: true, alignment: "center",
  });
  addFooter(slide, "O Public Choice também contém benchmark público e renda do tipo barato numa oferta aceita por ambos.");
}

// 13. Agenda role crossing
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Segundo resultado: o ator informado atravessa o balcão", 13);
  addCard(slide, 80, 135, 440, 185, "Sem agenda de H (N)", "Fraco desinformado propõe.\nH informado responde.", C.blue);
  textbox(slide, "⟶", { left: 575, top: 195, width: 130, height: 70 }, {
    fontSize: 54, color: C.orange, bold: true, alignment: "center", verticalAlignment: "middle",
  });
  addCard(slide, 760, 135, 440, 185, "Com agenda de H (A)", "H informado propõe.\nEstados fracos respondem.", C.orange);
  textbox(slide, "Em cada lado: tipo conhecido e tipo privado", { left: 345, top: 326, width: 590, height: 34 }, {
    fontSize: 19, color: C.muted, bold: true, alignment: "center",
  });
  addCard(slide, 80, 365, 350, 185, "Efeito direto D", "Ganho de propor quando o tipo é conhecido.", C.blue);
  addCard(slide, 465, 365, 350, 185, "Interação I", "Mudança na renda informacional causada pela agenda.", C.orange);
  addCard(slide, 850, 365, 350, 185, "Efeito total T", "Tgθ = Dgθ + Igθ", C.teal);
  textbox(slide, "A agenda muda o papel do informado e a composição da renda que ele extrai.", { left: 130, top: 595, width: 1020, height: 54 }, {
    fontSize: 25, color: C.navy, bold: true, alignment: "center",
  });
  addFooter(slide, "A proposta de H é uma etapa anterior e obrigatória; T = D + I é uma identidade fatorial.");
}

addImageSlide("figura_5_efeito_direto_agenda.png", "Figura 5: agenda pode elevar o payoff e comprimir a renda informacional."); // 14

// 15. WTO answer
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Quando os EUA de baixa exigência podem receber mais sob consenso", 15);
  const body = "1. Exigência mínima para aceitar parcialmente privada.\n\n2. Maioria sem os EUA viável e capaz de contornar sua informação.\n\n3. Consenso torna a objeção norte-americana incontornável no domínio modelado.\n\n4. Crença alta sustenta pooling.\n\n5. ΔRI₀(sU,sM) > G(o₀).";
  addCard(slide, 90, 135, 1100, 420, "As cinco condições", body, C.orange);
  textbox(slide, "Sem agenda: preferência interina do tipo baixo. Com agenda: o ranking entre regras depende de D e I.", { left: 140, top: 580, width: 1000, height: 66 }, {
    fontSize: 24, color: C.navy, bold: true, alignment: "center",
  });
}

// 16. Conclusion
{
  const slide = deck.slides.add(); slide.background.fill = C.white; addHeader(slide, "Três poderes, uma conclusão", 16);
  addCard(slide, 75, 155, 345, 240, "Exigência externa", "Força fora da instituição.", C.blue);
  addCard(slide, 467, 155, 345, 240, "Pivotalidade", "Ausência de substituto para o voto.", C.orange);
  addCard(slide, 860, 155, 345, 240, "Agenda", "Capacidade de escolher a proposta.", C.teal);
  textbox(slide, "CONSENSO TRANSFORMA INFORMAÇÃO EM PODER QUANDO O VOTO INFORMADO É INCONTORNÁVEL.\nAGENDA ELEVA A EXTRAÇÃO DIRETA, MAS PODE COMPRIMIR A PARCELA INFORMACIONAL.", { left: 105, top: 440, width: 1070, height: 150 }, {
    fontSize: 29, color: C.navy, bold: true, alignment: "center", verticalAlignment: "middle",
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
