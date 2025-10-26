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
