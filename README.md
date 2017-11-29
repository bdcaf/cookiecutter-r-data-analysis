R data analysis template
========================

Over years I came up with a quite standardized template. Though it usually degraded to copying a number of files from previous projects.  With this template I try to formalize this approach.

[cookiecutter](https://github.com/audreyr/cookiecutter) is a tool to template new project files and folder structures.  It still seems quite active and has templates beyond a single language it seems a promising home for this task.
 
These templates also contain some sample code for my reference how to achieve typical tasks.  The most code is written in R files and derivatives like rmd and rnw.  But I also make use of `make` for building the project, and additional shell utilites like latexmk and pandoc.  At some future point I will provide a setup script - at the moment you will need to weed through dependencies manually.

News
------

I am learning more and more about the R package workflow.  Combining this *and* a Make based workflow seems a waste.  I start the package [vignetteEngineMake](https://github.com/bdcaf/vignetteEngineMake) to bring make based vignettes to R packages.   Watch this for future developments.

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
