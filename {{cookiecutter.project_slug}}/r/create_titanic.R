titanic <- read.csv('data/titanic.csv')

# save results ------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
save(titanic, file=args[[1]])
