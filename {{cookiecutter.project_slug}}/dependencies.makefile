data: 
reports: artifacts/cern.docx artifacts/vignette.pdf


# raw data - let's use cerns public data from the example at: http://opendata.cern.ch/record/300
dataraw/Jpsimumu.csv:
	curl "http://opendata.cern.ch/record/545/files/Jpsimumu.csv" -o "$@"

# dependencies ###################
$(REPORT_DIR)/cern.md $(REPORT_DIR)/sample_texonly.tex: data/mass.Rdata

$(REPORT_DIR)/vignette.pdf: doc/bibliography.bib doc/sample_texonly.tex $(REPORT_DIR)/sample_calc.tex doc/knitr_preamble.tex
# end deps 
