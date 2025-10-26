#!/bin/bash

# ============================================
# Setup Script for Modular LaTeX Project
# Creates complete folder structure and template files
# ============================================

echo "Setting up modular LaTeX capstone project..."
echo ""

# Project name
PROJECT_NAME="capstone_paper"

# Create project directory
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# -------------------- CREATE FOLDER STRUCTURE --------------------
echo "Creating folder structure..."

mkdir -p config
mkdir -p frontmatter
mkdir -p chapters
mkdir -p appendices
mkdir -p figures/methodology
mkdir -p figures/findings
mkdir -p figures/appendix
mkdir -p tables
mkdir -p references
mkdir -p scripts

echo "   ✓ Folders created"

# -------------------- CREATE CONFIG FILES --------------------
echo "Creating configuration files..."

# config/preamble.tex
cat > config/preamble.tex << 'EOF'
% Package imports
\usepackage[utf8]{inputenc}
\usepackage[margin=1in]{geometry}
\usepackage{setspace}
\usepackage{indentfirst}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{graphicx}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{float}
\usepackage{booktabs}
\usepackage{multirow}
\usepackage{array}
\usepackage{fancyhdr}
\usepackage{titlesec}
\usepackage{tocloft}
\usepackage[title]{appendix}
\usepackage{etoolbox}
\usepackage{mathptmx}
\usepackage[style=apa, backend=biber]{biblatex}
\usepackage{tcolorbox}
\usepackage{listings}
\usepackage{xcolor}
\usepackage[hidelinks]{hyperref}
EOF

# config/formatting.tex
cat > config/formatting.tex << 'EOF'
% Spacing
\doublespacing
\setlength{\parindent}{0.5in}
\setlength{\parskip}{0pt}

% Headings
\titleformat{\section}{\normalfont\fontsize{14}{16}\bfseries\centering}{\thesection}{1em}{}
\titleformat{\subsection}{\normalfont\fontsize{12}{14}\bfseries\raggedright}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalfont\fontsize{12}{14}\bfseries\itshape\raggedright}{\thesubsubsection}{1em}{}
\setcounter{secnumdepth}{0}

% TOC
\setcounter{tocdepth}{2}
\renewcommand{\cfttoctitlefont}{\hfill\fontsize{14}{16}\bfseries}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftsubsecindent}{2em}

% Captions
\captionsetup{labelfont=bf, textfont=it, justification=centering, singlelinecheck=false}

% Headers/Footers
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\thepage}
EOF

# config/colors.tex
cat > config/colors.tex << 'EOF'
% Color definitions
\definecolor{promptbg}{RGB}{240,248,255}
\definecolor{outputbg}{RGB}{255,250,240}
\definecolor{promptborder}{RGB}{70,130,180}
\definecolor{outputborder}{RGB}{218,165,32}

% Prompt box
\newtcolorbox{promptbox}[1][]{
  colback=promptbg,
  colframe=promptborder,
  arc=2mm,
  boxrule=0.5pt,
  left=5pt, right=5pt, top=5pt, bottom=5pt,
  fonttitle=\bfseries,
  title=Prompt,
  #1
}

% Output box
\newtcolorbox{outputbox}[1][]{
  colback=outputbg,
  colframe=outputborder,
  arc=2mm,
  boxrule=0.5pt,
  left=5pt, right=5pt, top=5pt, bottom=5pt,
  fonttitle=\bfseries,
  title=LLM Output,
  #1
}
EOF

# config/commands.tex
cat > config/commands.tex << 'EOF'
% Custom commands
\newcommand{\ie}{\textit{i.e.,}\ }
\newcommand{\eg}{\textit{e.g.,}\ }
\newcommand{\etal}{\textit{et al.}\ }
\newcommand{\modelrf}{Random Forest}
\newcommand{\modellr}{Logistic Regression}
\newcommand{\modelgpt}{GPT-4}
EOF

echo "   ✓ Config files created"

# -------------------- CREATE FRONTMATTER FILES --------------------
echo "Creating frontmatter files..."

# frontmatter/titlepage.tex
cat > frontmatter/titlepage.tex << 'EOF'
\begin{titlepage}
\centering
\vspace*{2in}
{\fontsize{18}{22}\bfseries\selectfont
Your Paper Title Here\par}
\vspace{1in}
{\fontsize{12}{14}\selectfont
Your Name\\
Advisor Name\par}
\vspace{0.5in}
{\fontsize{14}{16}\selectfont
University of Chicago\\
Master of Science in Analytics\\
Capstone Project\par}
\vspace{0.5in}
{\fontsize{14}{16}\selectfont\today\par}
\end{titlepage}
EOF

# frontmatter/abstract.tex
cat > frontmatter/abstract.tex << 'EOF'
\newpage
\pagenumbering{roman}
\setcounter{page}{1}
\section{Abstract}
\noindent [Your abstract text here - 50-100 words]

\vspace{1in}
\noindent \textbf{Keywords:} keyword1, keyword2, keyword3, keyword4, keyword5, keyword6
EOF

# frontmatter/executive_summary.tex
cat > frontmatter/executive_summary.tex << 'EOF'
\newpage
\section{Executive Summary}
[Your executive summary here - maximum one page]
EOF

# frontmatter/toc.tex
cat > frontmatter/toc.tex << 'EOF'
\newpage
\tableofcontents
\vspace{1em}
\section*{List of Figures}
\addcontentsline{toc}{section}{List of Figures}
\listoffigures
\vspace{1em}
\section*{List of Tables}
\addcontentsline{toc}{section}{List of Tables}
\listoftables
\vspace{1em}
\section*{List of Appendices}
\addcontentsline{toc}{section}{List of Appendices}
\noindent Appendix A: Additional Data Analysis \dotfill \pageref{appendix:a}\\
\noindent Appendix B: Code Documentation \dotfill \pageref{appendix:b}\\
\noindent Appendix C: LLM Prompt Examples \dotfill \pageref{appendix:c}
EOF

echo "   ✓ Frontmatter created"

# -------------------- CREATE CHAPTER FILES --------------------
echo "Creating chapter files..."

for i in {01..07}; do
  case $i in
    01) chapter="Introduction" ;;
    02) chapter="Background" ;;
    03) chapter="Data" ;;
    04) chapter="Methodology" ;;
    05) chapter="Findings" ;;
    06) chapter="Discussion" ;;
    07) chapter="Conclusion" ;;
  esac
  
  cat > chapters/${i}_$(echo $chapter | tr '[:upper:]' '[:lower:]').tex << EOF
% Chapter: $chapter
$([ "$i" == "01" ] && echo "\newpage\n\pagenumbering{arabic}\n\setcounter{page}{1}")
\section{$chapter}
[Your $chapter content here]
EOF
done

echo "   ✓ Chapters created"

# -------------------- CREATE APPENDIX FILES --------------------
echo "Creating appendix files..."

cat > appendices/appendix_a.tex << 'EOF'
\section{Additional Data Analysis}
\label{appendix:a}
[Additional analysis content]
EOF

cat > appendices/appendix_b.tex << 'EOF'
\section{Code Documentation}
\label{appendix:b}
[Code documentation]
EOF

cat > appendices/appendix_c.tex << 'EOF'
\section{LLM Prompt Examples and Outputs}
\label{appendix:c}
[LLM prompts and outputs]
EOF

echo "   ✓ Appendices created"

# -------------------- CREATE MAIN.TEX --------------------
echo "Creating main.tex..."

cat > main.tex << 'EOF'
\documentclass[12pt, letterpaper]{article}

% Configuration
\input{config/preamble}
\input{config/formatting}
\input{config/colors}
\input{config/commands}

% Bibliography
\addbibresource{references/references.bib}

\begin{document}

% Front matter
\input{frontmatter/titlepage}
\input{frontmatter/abstract}
\input{frontmatter/executive_summary}
\input{frontmatter/toc}

% Main content
\input{chapters/01_introduction}
\input{chapters/02_background}
\input{chapters/03_data}
\input{chapters/04_methodology}
\input{chapters/05_findings}
\input{chapters/06_discussion}
\input{chapters/07_conclusion}

% References
\newpage
\printbibliography[title={References}]

% Appendices
\newpage
\begin{appendices}
\input{appendices/appendix_a}
\input{appendices/appendix_b}
\input{appendices/appendix_c}
\end{appendices}

\end{document}
EOF

echo "   ✓ main.tex created"

# -------------------- CREATE REFERENCES --------------------
echo "Creating references file..."

cat > references/references.bib << 'EOF'
@book{hastie2022,
  author = {Hastie, Trevor and Tibshirani, Robert and Friedman, Jerome},
  title = {The Elements of Statistical Learning},
  year = {2022},
  edition = {3rd},
  publisher = {Springer},
  address = {New York, NY}
}
EOF

echo "   ✓ references.bib created"

# -------------------- CREATE MAKEFILE --------------------
echo "Creating Makefile..."

cat > Makefile << 'EOF'
MAIN = main
LATEX = pdflatex
BIBER = biber
PYTHON = python3

.PHONY: all clean cleanall figures quick help

all: figures $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex
	$(LATEX) -interaction=nonstopmode $(MAIN)
	$(BIBER) $(MAIN)
	$(LATEX) -interaction=nonstopmode $(MAIN)
	$(LATEX) -interaction=nonstopmode $(MAIN)

figures:
	cd scripts && $(PYTHON) generate_figures.py

quick:
	$(LATEX) -interaction=nonstopmode $(MAIN)

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.toc *.lof *.lot *.run.xml

cleanall: clean
	rm -f $(MAIN).pdf

help:
	@echo "Targets: all, quick, clean, cleanall, figures, help"
EOF

echo "   ✓ Makefile created"

# -------------------- CREATE .GITIGNORE --------------------
echo "Creating .gitignore..."

cat > .gitignore << 'EOF'
*.aux
*.bbl
*.bcf
*.blg
*.log
*.out
*.toc
*.lof
*.lot
*.fls
*.fdb_latexmk
*.synctex.gz
*.run.xml
.DS_Store
__pycache__/
*.pyc
EOF

echo "   ✓ .gitignore created"

# -------------------- CREATE README --------------------
echo "Creating README.md..."

cat > README.md << 'EOF'
# Capstone Research Paper

## Project Structure

Modular LaTeX project with organized folders for chapters, figures, and configuration.

## Building

```bash
make              # Build complete PDF
make quick        # Quick build (single pass)
make clean        # Remove auxiliary files
make figures      # Generate figures from Python
```

## Editing

- Edit chapters in `chapters/`
- Add figures to `figures/`
- Update bibliography in `references/references.bib`
- Modify formatting in `config/`
EOF

echo "   ✓ README.md created"

# -------------------- CREATE PYTHON SCRIPT --------------------
echo "Creating Python figure generation script..."

cat > scripts/generate_figures.py << 'EOF'
"""
Generate all figures for the paper
"""
import matplotlib.pyplot as plt
import numpy as np

# Configure for publication quality
plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.size'] = 10
plt.rcParams['figure.dpi'] = 300

def create_example_figure():
    """Create an example figure"""
    fig, ax = plt.subplots(figsize=(6, 4))
    x = np.linspace(0, 10, 100)
    y = np.sin(x)
    ax.plot(x, y, linewidth=2)
    ax.set_xlabel('X axis')
    ax.set_ylabel('Y axis')
    ax.grid(alpha=0.3)
    plt.tight_layout()
    plt.savefig('../figures/findings/example.pdf', bbox_inches='tight')
    plt.close()
    print("✓ Created example figure")

if __name__ == "__main__":
    print("Generating figures...")
    create_example_figure()
    print("All figures generated!")
EOF

chmod +x scripts/generate_figures.py

echo "   ✓ Python script created"

# -------------------- SUMMARY --------------------
echo ""
echo "Project setup complete!"
echo ""
echo "Project structure:"
echo "   $PROJECT_NAME/"
echo "   ├── main.tex"
echo "   ├── Makefile"
echo "   ├── config/"
echo "   ├── frontmatter/"
echo "   ├── chapters/"
echo "   ├── appendices/"
echo "   ├── figures/"
echo "   ├── tables/"
echo "   ├── references/"
echo "   └── scripts/"
echo ""
echo "Next steps:"
echo "   1. cd $PROJECT_NAME"
echo "   2. Edit your content in chapters/"
echo "   3. make        # Build the PDF"
echo ""
echo "Tips:"
echo "   - Use 'make quick' for fast rebuilds during editing"
echo "   - Use 'make figures' to regenerate all figures"
echo "   - See README.md for more information"
echo ""