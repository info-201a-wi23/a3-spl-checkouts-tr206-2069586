# Do year vs popularity of lord of the rings vs harry potter vs Percy Jackson to see if one is more popular than the other.

library(ggplot2)
library(dplyr)
library(tidyverse)

SPL_df <- read.csv("2013-2023-5-Checkouts-SPL.csv")

SPL_df_subset_title <- SPL_df %>% select(Title, CheckoutYear, Checkouts)

SPL_df_LOR <- SPL_df_subset_title %>% filter(grepl('The lord of the rings', Title)) %>% add_column(book = "LOR")
SPL_df_HP <- SPL_df_subset_title %>% filter(grepl('Harry Potter', Title)) %>% add_column(book = "HP")
SPL_df_PJ <- SPL_df_subset_title %>% filter(grepl('Percy Jackson', Title)) %>% add_column(book = "PJ")
SPL_df_both <- rbind(SPL_df_LOR, SPL_df_HP, SPL_df_PJ)

SPL_df_grouped_titles <- SPL_df_both %>% group_by(book, CheckoutYear) %>% summarize(tot = sum(Checkouts))

graph2 <- ggplot(data = SPL_df_grouped_titles) +
  geom_line(mapping = aes(y = tot, x = CheckoutYear, color = book)) +
  scale_x_continuous(name = "Year", breaks = seq(2013, 2023, 1)) + 
  scale_y_continuous(name = "Number Of Checkouts", breaks = seq(0, 500000, 50000)) +
  labs(title = 'Harry Potter(HP) Vs Lord of the rings(LOR) VS Percy Jackson(PJ)', color = 'Book series') +
  theme(plot.title = element_text(color = "black", size = 14))
graph2