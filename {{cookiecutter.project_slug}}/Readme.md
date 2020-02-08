# {{cookiecutter.project_name}}

Data analysis for {{cookiecutter.project_short_description}}.
Created by {{cookiecutter.full_name}} {{cookiecutter.email}}.

Started on {{cookiecutter.release_date}}. 

All results are put in the `artifacts` directory.


The finalized project should be able to run using `make`.

For now I use [kaggles](https://www.kaggle.com) [titanic
train.csv](https://www.kaggle.com/c/titanic/data) as sample data.
Once I have some time I will replace it with something simpler.

## Idioms

### General

This work flow depends on make.
Make is picky about file names. In particular avoid spaces. 
Input data often comes in annoying characters - I find the command [detox](https://linux.die.net/man/1/detox) handy for this task.

### Folder structure

#### R
- `R` holds R commands
- 'scripts' R scripts 

#### data
- `data-raw` for unprocessed data. Files in here must not get altered by scripts.
- `data` in processed form - `Rdata` or `RDS`. Every file in `data` is created by commands in `scripts/`.

#### outputs
- `render` - output from `Rnw` and `Rmd` files together with their embedded images.  The content of this directory can get deleted.
- `artifacts` - completed products

### Script Patterns

#### `scripts/create_(dataname).R`
A script to create `data/(dataname).RDS`.
By using this pattern the Makefile rule is automatic.

I set it so the target file is also first argument. 
That way I don't need to repeat the filename inside the script. 
Also makes moving to a different name automatic.

Inside the script end with:
```{r}
#save results ------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
saveRDS(mydata, file=args[[1]])
```



## Example Project

The example project consist of following steps:

1. Convert `titanic.csv` into native R data (`titanic.Rdata`)
2. A sample conversion to `transform.Rdata`
3. Create a markdown report which is then converted to `.docx` (word)
   `artifacts/titanic.docx` via [pandoc](https://pandoc.org/)
4. Create a `Rnw` report which is then rendered with other tex files to
   a `pdf`: `artifacts/sample_report.pdf` via `latexmk`.

If all is setup correctly `make` should build all data files.

Individual files can be created using e.g. `make work/transform.Rdata`


## Tricks

### git

- git only stores files - not directories. To keep the structure there are empty files `.gitkeep`.
- git does not handle binary files well. Use [git lfs](https://git-lfs.github.com/) for binary files like `Rdata` or preferable store them externally.

