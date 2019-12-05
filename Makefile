4.2: 4/Four2.tlc
4.1: 4/Four.tlc
3.1: 3/Three.tlc-pcal

%.tlc: %.tla %.cfg
	cd $(dir $*); tlc $(notdir $*)

%.pcal-tlc: %.tla
	cd $(dir $*); pcal $(notdir $*)
	cd $(dir $*); tlc $(notdir $*)

%.pdf: %.tla %.cfg
	cd $(dir $*); tlatex -latexCommand /usr/local/texlive/2019/bin/x86_64-darwin/pdflatex $(notdir $*)
	cd $(dir $*); rm $*.aux $*.log $*.tex
