UNAME := $(shell uname -s)
REL=modLangCorta11
BIB=$(REL).bib
PDF=${REL}.pdf
TEX=${REL}.tex
SD=sections/
SECS=$(SD)intro.tex $(SD)massess.tex $(SD)applymetrics.tex\
  $(SD)casestudy.tex $(SD)tools.tex $(SD)conc.tex abstract.tex
SUBSECS=$(SD)sdmetrics.tex $(SD)sparkx.tex $(SD)ibmrational.tex

all:${PDF}

# Compile the PDF file
$(PDF): $(TEX) $(BIB) $(SECS) $(SUBSECS) 
ifeq ($(UNAME),Darwin)
	latexmk -e '$$pdflatex=q/pdflatex -synctex=1 %T/' -pdf $(TEX)
endif
ifeq ($(UNAME),Linux)
	latexmk -pdf $(TEX)
endif

# open PDF file
open:$(PDF)
ifeq ($(UNAME),Darwin)
	open $(PDF)
endif
ifeq ($(UNAME),Linux)
	xpdf $(PDF)
endif

clean:
	@find . -maxdepth 1 \( \! -iname "*.bib" \! -iname "*.tex" -type f \! -iname "makefile" \! -iname "*.sty" \! -iname "*.cls" \) -exec rm '{}' \;
	@find . \( -name *~ -or -name *.*~ \) -exec rm '{}' \;
