# why
define VIGNETTE_OPTIONS
	%\VignetteIndexEntry{ {{ cookiecutter.project_name }} }
	%\VignetteAuthor{ {{ cookiecutter.full_name }} }
	%\VignetteKeyword{vignette}
	%\VignetteEngine{vignetteEngineMake::make}
	%\VignetteTangle{FALSE}
endef
# for use with vignette engine have this moved into the vignettes directory

THIS:={{ cookiecutter.project_slug }}

$(THIS).pdf:
	cd $(THIS); make vignette.pdf
	cp $(THIS)/vignette.pdf $@

include Makefile

