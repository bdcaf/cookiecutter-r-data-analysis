devtools::load_all()

jpsi <- read.csv("data-raw/Jpsimumu.csv")

#save results ------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
saveRDS(jpsi, file=args[[1]])
