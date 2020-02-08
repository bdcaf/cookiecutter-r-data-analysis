R data analysis template
========================

Over years I came up with a quite standardized template. Though it usually degraded to copying a number of files from previous projects.  With this template I try to formalize this approach.

[cookiecutter](https://github.com/audreyr/cookiecutter) is a tool to template new project files and folder structures.  It still seems quite active and has templates beyond a single language it seems a promising home for this task.

These templates also contain some sample code for my reference how to achieve typical tasks.  The most code is written in R files and derivatives like `.Rmd` and `.Rnw`.  But I also make use of `make` for building the project, and additionale shell utilities like `latexmk` and `pandoc`.  At some future point I will provide a setup script - at the moment you will need to weed through dependencies manually.


Requirements
------------
Install `cookiecutter` command line: `pip install cookiecutter`

Or with [homebrew](https://brew.sh/) `cookiecutter` command line: `brew install cookiecutter`

Usage
-----
Generate a new Cookiecutter template layout: `cookiecutter gh:bdcaf/cookiecutter-r-data-analysis`.
It creates a minimal project that can be run typing `make`.
Explore the `Readme.md` in the generated directory for more.  

If your `.cookiecutterrc` is configured a quicker start is:
 `cookiecutter gh:bdcaf/cookiecutter-r-data-analysis project_name="This is Magic"`

**Note**
Many functions used require that the project is a valid R package.
The slug must be a valid package name, therefore it must only consist of characters, numbers and `.`, also it must start with a character.
I wrote a simple replacement for spaces to dots, but for the rest you are on your own!


Requirements
------------

Besides `cookiecutter`s dependencies it uses `make`, a `perl` script for dependency discovery. 

Obviously a working `R` installation is also required.
To have the automatic loading of code in `R` the `devtools` package is required. 
For the creation of reports `knitr` is required.

The exemplary work flow has plenty of dependencies. The main ones are:
 - `R` with `knitr`, `pander`, `dplyr`, `ggplot` packages
 - `pandoc` to convert into Word file
 - `latex` for pdf generation
 - `curl` to download the example data


License
-------
This project is licensed under the terms of the [MIT License](/LICENSE)
