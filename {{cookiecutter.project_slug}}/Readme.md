# {{cookiecutter.project_name}}

Data analysis for {{cookiecutter.project_desc}}.
Created by {{cookiecutter.full_name}} {{cookiecutter.email}}.

Started on {{cookiecutter.release_date}}. 

Place input files in the `data` directory.  These files are *not* to
be modified. 

Intermediate files may be put in the `work` directory.  The contents
there may be deleted.

All results are to be put in the `artifacts` directory.


The finalized project should be able to run using `make`.

For now I use [kaggles](https://www.kaggle.com) [titanic
train.csv](https://www.kaggle.com/c/titanic/data) as sample data.
Once I have some time I will replace it with something simpler.


## Example Project

The example project consist of following steps:

1. convert titanic.csv into native R data (titanic.Rdata)
2. does a sample conversion to transform.Rdata
3. create a markdown report which is then converted to docx (word)
   artifacts/titanic.docx via pandoc
4. create a Rnw report which is then rendered with other tex files to
   a pdf: artifacts/sample_report.pdf via latexmk

If all is setup correctly `make` should build all data files.

Individual files can be created using e.g. `make work/transform.Rdata`

