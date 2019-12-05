3.1.txt: Points.tla Three.tla Three.cfg
	pcal Points
	tlc Three | tee $@

%.pdf: %.tla
	tlatex -latexCommand /usr/local/texlive/2019/bin/x86_64-darwin/pdflatex $*
	rm $*.aux $*.log $*.tex
