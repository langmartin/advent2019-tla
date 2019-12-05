4.2: Four2.tlc
4.1: Four.tlc

3.1: Three.tlc-pcal

# %.cfg: %.tla
# 	grep -ie '--algorithm' && pcal $^
# 	touch $@

%.tlc: %.tla %.cfg
	tlc $*

%.pcal-tlc: %.tla
	pcal $*
	tlc $*

%.pdf: %.tla %.cfg
	tlatex -latexCommand /usr/local/texlive/2019/bin/x86_64-darwin/pdflatex $*
	rm $*.aux $*.log $*.tex
