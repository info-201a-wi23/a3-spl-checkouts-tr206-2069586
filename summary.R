library(ggplot2)
library(dplyr)

SPL_df <- read.csv("2013-2023-5-Checkouts-SPL.csv")

Most_Popular_Physical_Year <- SPL_df %>% 
  select(UsageClass, CheckoutYear, Checkouts) %>% 
  filter(UsageClass == "Physical") %>%
  group_by(UsageClass, CheckoutYear) %>% 
  summarize(tot = sum(Checkouts)) %>% 
  filter(tot == max(tot)) %>%
  pull(CheckoutYear)

Physical_prep_val2 <- SPL_df %>% 
  filter(UsageClass == "Physical") %>%
  select(UsageClass, CheckoutYear, Checkouts) %>%
  group_by(UsageClass, CheckoutYear) %>% 
  summarize(tot = sum(Checkouts))

Digital_prep_val2 <- SPL_df %>% 
  filter(UsageClass == "Digital") %>%
  select(UsageClass, CheckoutYear, Checkouts) %>%
  group_by(UsageClass, CheckoutYear) %>% 
  summarize(tot = sum(Checkouts))

merge_prep_val2 <- left_join(Digital_prep_val2,Physical_prep_val2, by= "CheckoutYear")

Year_Digital_Beats_Physical <- merge_prep_val2 %>%
  filter(tot.x > tot.y) %>% 
  filter(CheckoutYear == min(CheckoutYear)) %>%
  pull(CheckoutYear)
  
Most_Popular_Month <- SPL_df %>% 
  select(CheckoutMonth, Checkouts) %>% 
  group_by(CheckoutMonth) %>% 
  summarize(tot = sum(Checkouts)) %>% 
  filter(tot == max(tot)) %>%
  pull(CheckoutMonth) 

Least_Popular_Month <- SPL_df %>% 
  select(CheckoutMonth, Checkouts) %>% 
  group_by(CheckoutMonth) %>% 
  summarize(tot = sum(Checkouts)) %>% 
  filter(tot == min(tot)) %>%
  pull(CheckoutMonth) 

HP_Most_Popular_Year <- SPL_df %>% 
  filter(grepl('Harry Potter', Title)) %>% 
  select(CheckoutYear, Checkouts) %>% 
  group_by(CheckoutYear) %>% 
  summarize(tot = sum(Checkouts)) %>%
  filter(tot == max(tot)) %>%
  pull(CheckoutYear) 
  
  
