# {{cookiecutter.project_name}}

Data analysis for {{cookiecutter.project_short_description}}.
Created by {{cookiecutter.full_name}} {{cookiecutter.email}}.

Started on {{cookiecutter.release_date}}. 

All results are put in the `artifacts` directory.


The finalized project should be able to run using `make`.


## Example Project
When checked out it contains the working example project. 
This works on [CERN Higgs data](http://opendata.cern.ch/record/300).

The example project consist of following steps:

1. Obtain input data:
 a. [CERN Higgs data](http://opendata.cern.ch/record/300) is downloaded to 
2. A sample conversion to `transform.Rdata`
3. Create a markdown report which is then converted to `.docx` (word)
   `artifacts/titanic.docx` via [pandoc](https://pandoc.org/)
4. Create a `Rnw` report which is then rendered with other tex files to
   a `pdf`: `artifacts/sample_report.pdf` via `latexmk`.

If all is setup `make` should build all data files.

Individual files are created using e.g. `make work/transform.RDS`
## Idioms

### General

This work flow depends on make.
Make is picky about file names. In particular avoid spaces. 
Input data often comes in annoying characters - I find the command [detox](https://linux.die.net/man/1/detox) handy for this task.

### Folder structure

I came up with following structure. 
In particular the folders `data`, `render`, `artifacts` are excluded from git and also may recreate automatically.
The files in folder `data-raw` are not altered by the scripts.

#### R
- `R` holds R commands, these should be loadable with `devtools_load_all()`.
- 'scripts' R scripts that create data and binary files such as images.
- `doc` holds `Rnw` and `Rmd` files.

#### data
- `data-raw` for unprocessed data. Files in here must not get altered by scripts.
- `data` in processed form - `Rdata` or `RDS`. Every file in `data` is created by commands in `scripts/`.

#### outputs
- `render` - output from `Rnw` and `Rmd` files together with their embedded images.  The content of this directory can get deleted.
- `artifacts` - completed products

### Script Patterns

#### `scripts/create_myname.R`
A script to create `data/myname.RDS`.
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




## Tricks

### general

- I reference files from the project root. Both in Makefile and also in R. This helps to keep references consistent.

### R

- I (ab)use `devtools`.  In particular often `devtools::load_all()`.  This requires the folder be named as valid R package and the `DESCRIPTION` file being valid.  The most common issue that an R package name may only contain characters, numbers and `.`, and must start with a character.


### git

- git only stores files - not directories. To keep the structure there are empty files `.gitkeep`.
- git does not handle binary files well. Use [git lfs](https://git-lfs.github.com/) for binary files like `Rdata` or preferable store them externally.


### Make

- For tasks that are independent on the rest of the project a separate `Makefile` may be used in a subdir. I perform the download of external data to `data-raw`. The file `data-raw/Makefile` contains the code. 
Inside the main `Makefile` I use the code:

```
data-raw/%: data-raw/Makefile
	make -C data-raw $(patsubst data-raw/%,%,$@)
```

This way even if `data-raw/Makefile` defines more data files but those are not used. 
Only the required ones should download to save space and bandwidth.
