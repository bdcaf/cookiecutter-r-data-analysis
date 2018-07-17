R:=Rscript
REPORT_DIR:=work/report
CACHEDIR= cache
LMK=latexmk -pdf -f --interaction=nonstopmode -outdir=$(REPORT_DIR) -bibtex
.PHONY= all clean

all: reports data 

## data
data/%.Rdata: r/create_%.R
	$R $< $@

## and raw data if required
data/mass.Rdata: dataraw/Jpsimumu.csv r/cern_invmass.R r/cern_magnitude.R

## word report
# figures are not showing up yet!
$(REPORT_DIR)/%.md : doc/%.Rmd
	mkdir -p $(@D)
	mkdir -p '$(REPORT_DIR)/$(basename $(@F))/'
	echo $@
	Rscript -e "require(knitr); require(markdown);" \
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

$(REPORT_DIR)/%.pdf: doc/%.tex $(REPORT_DIR)/bibliography.bib
	$(LMK) $<

# end generic 

#cleaning
clean: docclean articlean dataclean

dataclean:
	-rm -rf data/*.Rdata

articlean:
	-rm -rf artifacts/*

docclean:
	-rm -rf $(REPORT_DIR)/*
# end cleaning 

include dependencies.makefile
