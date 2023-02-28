library(ggplot2)
library(dplyr)
SPL_df <- read.csv("2013-2023-5-Checkouts-SPL.csv")
SPL_df_subset_usage <- SPL_df %>% select(UsageClass, CheckoutYear, Checkouts)
SPL_df_grouped_usage <- SPL_df_subset_usage %>% group_by(UsageClass, CheckoutYear) %>% summarize(tot = sum(Checkouts))
ggplot(data = SPL_df_grouped_usage) +
  geom_line(mapping = aes(y = tot, x = CheckoutYear, color = UsageClass)) +
  scale_x_continuous(name = "Year", breaks = seq(2013, 2023, 1)) + 
  scale_y_continuous(name = "Number Of Checkouts", breaks = seq(0, 5500000, 500000)) +
  labs(title = 'Digital Media vs Physical Media', color = 'Content Type') +
  theme(plot.title = element_text(color = "black", size = 14))