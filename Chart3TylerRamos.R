# Do month vs how many checkouts to see if there is a day of the week which is most popular

library(ggplot2)
SPL_df <- read.csv("2013-2023-5-Checkouts-SPL.csv")

SPL_df_subset_month <- SPL_df %>% select(CheckoutMonth, Checkouts)

SPL_df_grouped_Month <- SPL_df_subset_month %>% group_by(CheckoutMonth) %>% summarize(tot = sum(Checkouts))
myMonths <- c('January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August', 
            'September',
            'October',
            'November',
            'December')
SPL_df_grouped_Month$Month <- myMonths[SPL_df_grouped_Month$CheckoutMonth]

graph3 <- 
  SPL_df_grouped_Month %>%
  mutate(Month = fct_reorder(Month, CheckoutMonth)) %>%
  ggplot( aes(x=Month, y=tot)) +
  geom_bar(stat="identity") + 
  scale_y_continuous(name = "Number Of Checkouts", breaks = seq(0, 5000000, 500000)) +
  labs(title = 'Total checkouts by Month', x = "Month") +
  theme(plot.title = element_text(color = "black", size = 30))
graph3