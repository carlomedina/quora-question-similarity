library(readr)
library(tidyverse)
library(ggplot2)
library(lubridate)
library(stringr)
library(glue)

quora<-read_delim("./data/quora_duplicate_questions.tsv", delim = "\t")


# some basic things
head(quora)

# number of similar and dissimilar pairs
table(quora$is_duplicate)
glue("The number of \nsimilar pairs: {similar} ({percSimilar}%)", 
     "\ndissimilar pairs: {dissimilar} ({percDissimilar}%)",
     similar = table(quora$is_duplicate)[1],
     dissimilar = table(quora$is_duplicate)[2],
     percSimilar = (table(quora$is_duplicate)[1] * 100 / nrow(quora)) %>% round(2),
     percDissimilar = (table(quora$is_duplicate)[2] * 100/ nrow(quora)) %>% round(2))


# create a subsample
set.seed(12345)
quora_sample <- quora %>%
  sample_frac(0.4)


# check proportions of similar and dissimilar if it is still the same
quora_sample %>%
  {
  glue("The number of \nsimilar pairs: {similar} ({percSimilar}%)", 
     "\ndissimilar pairs: {dissimilar} ({percDissimilar}%)",
     similar = table(.$is_duplicate)[1],
     dissimilar = table(.$is_duplicate)[2],
     percSimilar = (table(.$is_duplicate)[1] * 100 / nrow(.)) %>% round(2),
     percDissimilar = (table(.$is_duplicate)[2] * 100/ nrow(.)) %>% round(2))
  }

