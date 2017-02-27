library(dplyr)
library(tidyr)

load('work/integrations.Rdata')
load('work/demography.Rdata')

breath.data= filter(integrations.bv,
					measurement=='Patients',
					integration=='(QI)') %>%
					  select(pat.id,compound,CAS, breath=value)

ra.data = filter(integrations.bv,
					measurement!='Patients',
					integration=='(QI)') %>%
					  select(pat.id,compound,CAS, ra=value)

conc.data <- inner_join(breath.data, ra.data,
						by=c('pat.id','compound','CAS')) %>%
						  mutate(diff=breath-ra)

big.data <- inner_join(demo.table, conc.data, by='pat.id')
big.data <- big.data %>% filter(pat.id != 'JOWI-027')
# save results ------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
save(big.data, file=args[[1]])
