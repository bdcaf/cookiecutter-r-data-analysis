library(dplyr)
load('work/titanic.Rdata')

trans.data <- titanic %>% 
  select(pclass, sex, age, survived, embarked) %>%
  mutate(survived = factor(survived),
  		 gender = factor(sex),
  		 class = factor(pclass)) %>%
  select(-sex, -pclass)
levels(trans.data$survived) <- c('died', 'survived')

args <- commandArgs(trailingOnly = TRUE)
save(trans.data, file=args[[1]])
