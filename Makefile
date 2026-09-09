MAIN := main
OUT  := build

.PHONY: all pdf clean

all: pdf

pdf:
	latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=$(OUT) $(MAIN).tex

clean:
	latexmk -C -outdir=$(OUT) $(MAIN).tex
	rm -f $(OUT)/*.aux $(OUT)/*.log $(OUT)/*.toc $(OUT)/*.out $(OUT)/*.fls $(OUT)/*.fdb_latexmk
