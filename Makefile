# -*- makefile -*-

TEX=platex
BIBTEX=bibtex
DVI2PDF=dvipdfmx

SOURCES = \
	manuscript.tex \
	$(NULL)

MDSCRIPT = \
	contents.md \
	$(NULL)


all: convertmd dvi2pdf clean

convertmd: $(MDSCRIPT)
	cat $^ \
	| sed s/.png/.eps/g \
	| sed s/.jpg/.eps/g \
	| pandoc -t latex \
	| sed 's/includegraphics/includegraphics[width=0.6\\columnwidth]/g' \
	| sed 's/\[htbp\]/\[tb\]/g' \
	> $(MDSCRIPT:%.md=%.tex)



.tex.dvi: 
	@${TEX} $<
#	@${BIBTEX} ${<:.tex=}
	@${TEX} $<	

dvi2pdf: $(SOURCES:.tex=.dvi)
	@${DVI2PDF} $^

# copypdf: $(SOURCES:.tex=.pdf)
# 	cp $^ $(COPYTARGET)

clean: 
	@rm -f *.dvi *.aux *.log

