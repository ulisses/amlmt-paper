UNAME := $(shell uname -s)
REL=modLangCorta11
PDF=$(REL).pdf
TEX=$(REL).tex
SECS="abstract.tex $(shell for f in $(find sections); do echo "$f"; done)"

all:${PDF} open

# Compile the PDF file
$(PDF):$(TEX) $(SECS)
ifeq ($(UNAME),Darwin)
	latexmk -e '$$pdflatex=q/pdflatex -synctex=1 %T/' -pdf $(TEX)
endif
ifeq ($(UNAME),Linux)
	latexmk -pdf $(TEX)
endif

# Silly rules
$(SUBSECS):
$(SECS):

# open PDF file
open:$(PDF)
ifeq ($(UNAME),Darwin)
	open $(PDF)
endif
ifeq ($(UNAME),Linux)
	xpdf $(PDF)
endif

clean:
	@echo "Cleaning the shop"
	@find . -maxdepth 1 \( \! -iname "*.bib" \! -iname "*.tex" -type f \! -iname "makefile" \! -iname "*.sty" \! -iname "*.cls" \) -exec rm '{}' \;
	@find . \( -name *~ -or -name *.*~ \) -exec rm '{}' \;

clean_git:
	@echo "Cleaning the git shop"
	@find . -maxdepth 1 \( \! -iname "*.pdf" \! -iname "*.bib" \! -iname "*.tex" -type f \! -iname "makefile" \! -iname "*.sty" \! -iname "*.cls" \) -exec rm '{}' \;
	@find . \( -name *~ -or -name *.*~ \) -exec rm '{}' \;
