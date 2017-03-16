artifacts/requested_table.xlsx: r/write_p_xls.R work/p_data_nons.Rdata
	$(R) '$<' $@

# dependencies ###################
work/titanic.Rdata: data/titanic.csv
work/transform.Rdata: work/titanic.Rdata
$(REPORT_DIR)/titanic.md: work/transform.Rdata


$(REPORT_DIR)/sample_report.pdf: doc/bibliography.bib doc/sample_texonly.tex $(REPORT_DIR)/sample_calc.tex doc/knitr_preamble.tex

# end deps 
