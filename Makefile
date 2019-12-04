3.1: three.tla three.txt three.sh three.cfg

%.cfg: %.tla
	pcal $^
