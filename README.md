R data analysis template
========================

A template for my standard R workflow.  

Requirements
------------
Install `cookiecutter` command line: `pip install cookiecutter`    

or alternatively

Install `cookiecutter` command line: `brew install cookiecutter`    

Usage
-----
Generate a new Cookiecutter template layout: `cookiecutter gh:bdcaf/cookiecutter-r-data-analysis-template`    

Workflow
----------

 + Input data is put in the `data` directory.
 + Transformed data which can be recreated in the `work` directory
 + Output for publication or else is put in the `artifacts` folder
 + `R` source code is put in the `r` folder
 + Textual stuff like markdown, tex, rmd and rnw files in the doc
 	 folder
 


Requirements
------------

This workflow has plenty of dependencies. The main ones are:
 - R with knitr, pander, dplyr, ggplot packages
 - pandoc for Word file
 - latex for pdf generation.


License
-------
This project is licensed under the terms of the [MIT License](/LICENSE)
