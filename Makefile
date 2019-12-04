3.1: three.tla three.txt three.sh three.cfg

%.cfg: %.tla
	grep -ie '--algorithm' && pcal $^
	touch $@

%.pdf: %.tla %.cfg
	tlatex -latexCommand /usr/local/texlive/2019/bin/x86_64-darwin/pdflatex $*
	rm $*.aux $*.log $*.tex
