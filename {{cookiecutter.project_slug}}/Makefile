REPORT_DIR:=render/report
CACHEDIR= cache
LMK=latexmk -pdf -f --interaction=nonstopmode -outdir=$(REPORT_DIR) -bibtex
.PHONY= all clean
WORKSCRIPTS:=$(wildcard scripts/*.R) 
DOCSCRIPTS:=$(wildcard doc/*.Rnw) $(wildcard doc/*/*.Rnw) $(wildcard doc/*.Rmd) $(wildcard doc/*/*.Rmd) $(wildcard doc/*.tex) $(wildcard doc/*/*.tex)

R:=Rscript
knitBase:= $R -e "require(knitr); require(markdown);" \
	-e "require(pander)" \
	-e "knitr::opts_knit[['set']](root.dir = normalizePath('./'))" \
	-e "knitr::opts_chunk[['set']](cache.path='$(REPORT_DIR)/$(basename $(@F))/')" \
	-e "knitr::opts_chunk[['set']](fig.path='$(REPORT_DIR)/$(basename $(@F))/')" \
	-e "knitr::opts_chunk[['set']](fig.lp='fig:')" \
	-e "knitr::opts_chunk[['set']](fig.show='asis')"

all: reports 

reports: artifacts/cern.docx artifacts/vignette.pdf

Makefile.auto: $(WORKSCRIPTS) $(DOCSCRIPTS)
	@REPORTDIR=$(REPORT_DIR) perl scripts/recursive.pl $^ > $@
include Makefile.auto
include Makefile.project

## data-raw
data-raw/%: data-raw/Makefile
	make -C data-raw $(patsubst data-raw/%,%,$@)

## data
data: 
data/%.RDS: scripts/create_%.R
	$R $< $@


$(REPORT_DIR)/%.md : doc/%.md
	-mkdir -p $(@D)
	cp $< $@
$(REPORT_DIR)/%.tex : doc/%.tex
	-mkdir -p $(@D)
	cp $< $@
## word report
# figures are not showing up yet!
$(REPORT_DIR)/%.md : doc/%.Rmd
	mkdir -p $(@D)
	mkdir -p '$(REPORT_DIR)/$(basename $(@F))/'
	echo $@
	$R -e "require(knitr); require(markdown);" \
	-e "require(pander)" \
	-e "knitr::opts_knit[['set']](root.dir = normalizePath('./'))" \
	-e "knitr::opts_chunk[['set']](cache.path='$(REPORT_DIR)/$(basename $(@F))/')" \
	-e "knitr::opts_chunk[['set']](fig.path='$(REPORT_DIR)/$(basename $(@F))/')" \
	-e "knitr::opts_chunk[['set']](fig.lp='fig:')" \
	-e "knitr::opts_chunk[['set']](fig.show='asis')" \
	-e "knitr::opts_chunk[['set']](dpi=144, fig.width=7, fig.height=6)" \
	-e "knit('$<', '$(@)'); "

artifacts/%.docx: $(REPORT_DIR)/%.md
		pandoc $+ -o $@


## latex report
$(REPORT_DIR)/%.bib: doc/%.bib
	-mkdir -p $(REPORT_DIR)	
	cp $< $@

$(REPORT_DIR)/%.tex: doc/%.Rnw
	-mkdir -p $(REPORT_DIR)	
	$R  -e "require(knitr)" \
		-e "knitr::opts_knit[['set']](root.dir = normalizePath('./'))" \
		-e "knitr::opts_chunk[['set']](cache.path='$(REPORT_DIR)/$(basename $(@F))/')" \
		-e "knitr::opts_chunk[['set']](fig.path='$(REPORT_DIR)/$(basename $(@F))/')" \
		-e "knitr::opts_chunk[['set']](fig.lp='fig:')" \
		-e "knitr::opts_chunk[['set']](echo=TRUE, warning=FALSE)" \
		-e "knitr::opts_chunk[['set']](results='asis', dpi=144, fig.width=4, fig.height=3)" \
		-e "knitr::knit('$<', output='$@')"


artifacts/%.pdf: $(REPORT_DIR)/%.pdf
	cp $< $@

$(REPORT_DIR)/%.pdf: $(REPORT_DIR)/%.tex $(REPORT_DIR)/bibliography.bib
	$(LMK) $<
# end generic 

#cleaning
clean: docclean articlean dataclean

dataclean:
	-rm -rf data/*

articlean:
	-rm -rf artifacts/*

docclean:
	-rm -rf $(REPORT_DIR)/*
# end cleaning 
