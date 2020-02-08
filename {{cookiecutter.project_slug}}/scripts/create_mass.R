source("r/cern_magnitude.R")
source("r/cern_invmass.R")

jpsi <- read.csv("dataraw/Jpsimumu.csv")
jpsimass <- invmass(jpsi$px1, jpsi$px2, jpsi$py1, jpsi$py2, jpsi$pz1, jpsi$pz2, jpsi$E1, jpsi$E2)

#save results ------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
saveRDS(jpsimass, file=args[[1]])