UNAME := $(shell uname -s)
REL=modLangCorta11
BIB=$(REL).bib
PDF=${REL}.pdf
TEX=${REL}.tex
SECS=
#"sections/intro.tex sections/massess.tex\
# sections/applymetrics.tex sections/casestudy.tex\
# sections/tools.tex sections/conc.tex abstract.tex"
SUBSECS=
#"sections/sdmetrics.tex sections/sparkx.tex sections/ibmrational.tex"

all:${PDF} open

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
