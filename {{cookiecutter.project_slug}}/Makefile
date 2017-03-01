R:=Rscript
REPORT_DIR:=work/report
FIGURE_DIR= figures
CACHEDIR= cache
LMK=latexmk -pdf -f --interaction=nonstopmode -outdir=$(REPORT_DIR) -bibtex
.PHONY= all clean

all: reports data 

data: 
reports: artifacts/titanic.docx artifacts/sample_report.pdf

# generic commands

work/%.Rdata: r/create_%.R
	$R $< $@

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
	-e "knitr::opts_chunk[['set']](fig.align='center')" \
	-e "knitr::opts_chunk[['set']](dpi=144, fig.width=7, fig.height=6)" \
	-e "knitr::opts_chunk[['set']](echo=FALSE, warning=FALSE, results='asis');" \
	-e "panderOptions('table.split.cells', 20)" \
	-e "panderOptions('table.split.table', Inf)" \
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
		-e "knitr::opts_chunk[['set']](echo=FALSE, warning=FALSE, results='asis', dpi=144, fig.width=4, fig.height=3)" \
		-e "knitr::knit('$<', output='$@')"


artifacts/%.pdf: $(REPORT_DIR)/%.pdf
	cp $< $@

$(REPORT_DIR)/%.pdf: $(REPORT_DIR)/%.tex $(REPORT_DIR)/bibliography.bib
	$(LMK) $<

$(REPORT_DIR)/%.pdf: doc/%.tex $(REPORT_DIR)/bibliography.bib
	$(LMK) $<

# end generic 

#cleaning
clean: docclean alldocclean dataclean

dataclean:
	-rm -rf work/*.Rdata

articlean:
	-rm -rf artifacts/*

docclean:
	-rm -rf $(REPORT_DIR)/*
# end cleaning 

artifacts/requested_table.xlsx: r/write_p_xls.R work/p_data_nons.Rdata
	$(R) '$<' $@

# dependencies ###################
work/titanic.Rdata: data/titanic.csv
work/transform.Rdata: work/titanic.Rdata
$(REPORT_DIR)/titanic.md: work/transform.Rdata


$(REPORT_DIR)/sample_report.pdf: doc/bibliography.bib doc/sample_texonly.tex $(REPORT_DIR)/sample_calc.tex doc/knitr_preamble.tex

# end deps 
