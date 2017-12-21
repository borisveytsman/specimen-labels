#
# Makefile for specimen-labels package
#
# This file is in public domain
#

PACKAGE = specimen-labels

SAMPLES = \
#	specimen-labels-sample.tex

PDF = $(PACKAGE).pdf ${SAMPLES:%.tex=%.pdf}

all:  ${PDF}


%.pdf:  %.dtx   $(PACKAGE).cls
	pdflatex $<
	- bibtex $*
	pdflatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done

%.cls:   %.ins %.dtx
	pdflatex $<

%.pdf:  %.tex   $(PACKAGE).cls 
	pdflatex $<
	- bibtex $*
	pdflatex $<
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done

.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).cls


clean:
	$(RM)  $(PACKAGE).cls *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi

distclean: clean
	$(RM) $(PDF)  *-converted-to.pdf

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	COPYFILE_DISABLE=1 tar -C .. -czvf ../$(PACKAGE).tgz \
	--exclude '*~' --exclude '*.tgz' --exclude '*.zip'  \
	--exclude '.git*' $(PACKAGE); mv ../$(PACKAGE).tgz .



