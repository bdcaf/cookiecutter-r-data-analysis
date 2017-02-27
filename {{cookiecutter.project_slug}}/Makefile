R:=Rscript
report_dir:=work/report
FIGUREDIR= figures
CACHEDIR= cache

.PHONY= all clean

all: reports data 

data: 
reports: 


# {{{ generic commands

work/%.Rdata: r/create_%.R
	$R $< $@

$(report_dir)/%.md : doc/%.Rmd
	mkdir -p $(@D)
	echo $@
	Rscript -e "require(knitr); require(markdown);" \
	-e "require(knitr)" \
	-e "knitr::opts_knit[['set']](root.dir = normalizePath('./'))" \
	-e "knitr::opts_chunk[['set']](fig.path='$(FIGUREDIR)/$*-')" \
	-e "knitr::opts_chunk[['set']](cache.path='$(CACHEDIR)/$*-')" \
	-e "knitr::opts_chunk[['set']](fig.lp='fig:')" \
	-e "knitr::opts_chunk[['set']](fig.align='center')" \
	-e "knitr::opts_chunk[['set']](dpi=144, fig.width=7, fig.height=6)" \
	-e "knitr::opts_chunk[['set']](echo=FALSE, warning=FALSE, results='asis');" \
	-e "knit('$<', '$(@)'); "

artifacts/%.docx: $(report_dir)/%.md
		pandoc $+ -o $@
# end generic }}}

#{{{ cleaning
clean: docclean alldocclean dataclean

dataclean:
	-rm -rf work/*.Rdata

articlean:
	-rm -rf artifacts/*

docclean:
	-rm -rf $(report_dir)/*
	-rm -rf $(FIGUREDIR)/*
# end cleaning }}}

artifacts/requested_table.xlsx: r/write_p_xls.R work/p_data_nons.Rdata
	$(R) '$<' $@

# {{{ dependencies ###################
# end deps }}}
