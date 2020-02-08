devtools::load_all()

jpsi <- readRDS("data/jpsi.RDS")
jpsimass <- invmass(jpsi$px1, jpsi$px2, jpsi$py1, jpsi$py2, jpsi$pz1, jpsi$pz2, jpsi$E1, jpsi$E2)

#save results ------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
saveRDS(jpsimass, file=args[[1]])
