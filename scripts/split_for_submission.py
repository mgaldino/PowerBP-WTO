#!/usr/bin/env python3
"""
Split formal_model_v5.tex into main manuscript + supplementary appendix
for RIO submission. Run from the project root after rmarkdown::render().

Usage:
    python3 scripts/split_for_submission.py
"""

import os
import re
import shutil

PROJECT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TEX_SRC = os.path.join(PROJECT, "formal_model_v5.tex")
OUT_DIR = os.path.join(PROJECT, "RIO submission files")
FIG_DIR = os.path.join(PROJECT, "formal_model_v5_files", "figure-latex")

# Text fixups applied to both main and appendix after generation
TEXT_FIXUPS = [
    # Remove self-referential phrase (B.5a references itself inside B.5a)
    (" The decomposition is derived in Appendix B.5a.", ""),
]

# Figure path replacements (pandoc paths -> flat names)
FIG_RENAMES = {
    "formal_model_v5_files/figure-latex/parameter-regions-1.pdf": "fig3_parameter_regions.pdf",
    "formal_model_v5_files/figure-latex/heatmap-alpha-mu-1.pdf": "fig4_heatmap_alpha_mu.pdf",
}

# TikZ figure label -> external PDF filename
TIKZ_FIGURES = {
    "fig:gametree-b": "fig1_gametree.pdf",
    "fig:screening-schematic": "fig2_screening_schematic.pdf",
}


def replace_tikz_figures(text):
    """Replace inline TikZ figure environments with \\includegraphics.

    Uses line-by-line parsing to find figure blocks containing tikzpicture,
    extracts caption and label, and replaces with \\includegraphics.
    Handles \\begin{landscape} wrappers.
    """
    lines = text.split('\n')
    result = []
    i = 0
    while i < len(lines):
        line = lines[i]

        # Detect start of a TikZ figure block (possibly inside landscape)
        is_landscape = '\\begin{landscape}' in line
        fig_start = None
        if is_landscape:
            # Look ahead for \begin{figure}
            for j in range(i + 1, min(i + 5, len(lines))):
                if '\\begin{figure}' in lines[j]:
                    fig_start = j
                    break
        elif '\\begin{figure}' in line:
            fig_start = i

        # Check if this figure contains tikzpicture
        if fig_start is not None:
            has_tikz = False
            fig_end = None
            landscape_end = None
            caption_lines = []
            label_line = None
            in_caption = False
            brace_depth = 0

            for j in range(fig_start, min(fig_start + 200, len(lines))):
                if '\\begin{tikzpicture}' in lines[j]:
                    has_tikz = True
                if '\\end{figure}' in lines[j]:
                    fig_end = j
                    # Check for landscape close after figure
                    if is_landscape:
                        for k in range(j + 1, min(j + 5, len(lines))):
                            if '\\end{landscape}' in lines[k]:
                                landscape_end = k
                                break
                    break
                # Capture caption (may span multiple lines due to nested braces)
                if '\\caption' in lines[j] and not in_caption:
                    in_caption = True
                if in_caption:
                    caption_lines.append(lines[j])
                    brace_depth += lines[j].count('{') - lines[j].count('}')
                    if brace_depth <= 0:
                        in_caption = False
                # Capture label
                if '\\label{' in lines[j] and not in_caption:
                    label_line = lines[j]

            if has_tikz and fig_end is not None:
                # Find which TikZ figure this is by label
                pdf_name = None
                for fig_label, fname in TIKZ_FIGURES.items():
                    if label_line and fig_label in label_line:
                        pdf_name = fname
                        break

                if pdf_name:
                    caption_text = '\n'.join(caption_lines)
                    label_text = label_line.strip() if label_line else ''
                    result.append('\\begin{figure}[H]')
                    result.append('\\centering')
                    result.append(f'\\includegraphics[width=\\textwidth]{{{pdf_name}}}')
                    result.append(caption_text)
                    if label_text and label_text not in caption_text:
                        result.append(label_text)
                    result.append('\\end{figure}')
                    result.append('')
                    end_idx = landscape_end if landscape_end is not None else fig_end
                    i = end_idx + 1
                    continue

        result.append(line)
        i += 1

    return '\n'.join(result)


def main():
    if not os.path.exists(TEX_SRC):
        print(f"ERROR: {TEX_SRC} not found. Run rmarkdown::render() first with keep_tex=TRUE.")
        return

    os.makedirs(OUT_DIR, exist_ok=True)

    with open(TEX_SRC) as f:
        lines = f.readlines()

    # Find markers
    begin_doc = next(i for i, l in enumerate(lines) if r'\begin{document}' in l)
    appendix = next(i for i, l in enumerate(lines) if l.strip() == r'\appendix')
    refs_start = next(i for i, l in enumerate(lines) if r'\section*{References}' in l)
    refs_end = next(i for i, l in enumerate(lines) if r'\end{CSLReferences}' in l)

    print(f"Markers: begin_doc={begin_doc+1}, appendix={appendix+1}, "
          f"refs={refs_start+1}-{refs_end+1}, total={len(lines)}")

    # --- Main manuscript (anonymized) ---
    main = ['%!TEX TS-program = xelatex\n']
    for line in lines[:begin_doc]:
        if r'\author{' in line:
            main.append('\\author{}\n')
        elif r'\date{' in line:
            main.append('\\date{\\vspace{-2.5em}}\n')
        elif 'pdfauthor=' in line:
            continue  # skip author in PDF metadata
        else:
            main.append(line)
    main.extend(lines[begin_doc:appendix])
    main.append('\n')
    main.extend(lines[refs_start:refs_end + 1])
    main.append('\n\\end{document}\n')

    main_text = ''.join(main)
    for old, new in FIG_RENAMES.items():
        main_text = main_text.replace(old, new)

    # Replace inline TikZ figures with \includegraphics (Springer requires separate figure files)
    main_text = replace_tikz_figures(main_text)
    for old, new in TEXT_FIXUPS:
        main_text = main_text.replace(old, new)

    with open(os.path.join(OUT_DIR, "01_manuscript.tex"), "w") as f:
        f.write(main_text)
    print(f"01_manuscript.tex: {main_text.count(chr(10))} lines")

    # --- Supplementary appendix ---
    app = ['%!TEX TS-program = xelatex\n']
    for line in lines[:begin_doc]:
        if r'\title{' in line:
            app.append('\\title{Online Appendix: Informational Power Through Pivotality}\n')
        elif r'\author{' in line:
            app.append('\\author{}\n')
        elif r'\date{' in line:
            app.append('\\date{}\n')
        elif 'pdfauthor=' in line:
            continue
        else:
            app.append(line)
    # Cross-reference labels from the main manuscript (Theorem 1, Corollary, etc.)
    app.append('\\usepackage{xr}\n')
    app.append('\\externaldocument{01_manuscript}\n')
    app.append('\\begin{document}\n\\maketitle\n\n')
    app.extend(lines[appendix:refs_start])
    app.append('\n\\end{document}\n')

    app_text = ''.join(app)
    for old, new in TEXT_FIXUPS:
        app_text = app_text.replace(old, new)

    with open(os.path.join(OUT_DIR, "02_supplementary_appendix.tex"), "w") as f:
        f.write(app_text)
    print(f"02_supplementary_appendix.tex: {sum(1 for _ in app)} lines")

    # --- Copy R-generated figures ---
    for old_name, new_name in FIG_RENAMES.items():
        src = os.path.join(PROJECT, old_name)
        dst = os.path.join(OUT_DIR, new_name)
        if os.path.exists(src):
            shutil.copy2(src, dst)
            print(f"Copied {new_name}")
        else:
            print(f"WARNING: {src} not found")

    # --- Copy TikZ standalone figures ---
    fig_src_dir = os.path.join(PROJECT, "figures")
    for label, pdf_name in TIKZ_FIGURES.items():
        src = os.path.join(fig_src_dir, pdf_name)
        dst = os.path.join(OUT_DIR, pdf_name)
        if os.path.exists(src):
            shutil.copy2(src, dst)
            print(f"Copied {pdf_name}")
        else:
            print(f"WARNING: {src} not found — compile figures/{pdf_name.replace('.pdf','.tex')} first")

    print("\nDone. Compile with:")
    print(f"  cd '{OUT_DIR}'")
    print("  xelatex 01_manuscript.tex")
    print("  xelatex 02_supplementary_appendix.tex")

if __name__ == "__main__":
    main()
