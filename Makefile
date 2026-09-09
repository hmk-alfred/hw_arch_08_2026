OUT := build

.PHONY: all pdf plan clean

all: pdf plan

pdf:
	latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=$(OUT) main.tex

plan:
	latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=$(OUT) sepnov_plan.tex

clean:
	latexmk -C -outdir=$(OUT) main.tex
	latexmk -C -outdir=$(OUT) sepnov_plan.tex
	rm -f $(OUT)/*.aux $(OUT)/*.log $(OUT)/*.toc $(OUT)/*.out $(OUT)/*.fls $(OUT)/*.fdb_latexmk
