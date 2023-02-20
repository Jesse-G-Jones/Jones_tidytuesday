#TidyTuesday Practice Submission 1
#Created By: Jesse Jones
#Date: 2023-02-19
###Libraries
library(here)
library(tidyverse)
###Data
stocks <- tidytuesdayR::tt_load('2023-02-07')
stocks <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-07/big_tech_stock_prices.csv')
glimpse(stocks) #provides a brief view of dataframe
stocks_analysis <- stocks %>%
  filter(stock_symbol %in% c("AMZN","GOOGL", "TSLA", "MSFT", "NVDA")) %>% 
  filter(complete.cases(.)) %>%
  filter(date>"2020-07-31",
         date<"2020-09-01") %>% 
  pivot_longer(c(open,close),
               names_to = "Variables",
               values_to="Values") %>%
  group_by(stock_symbol, date, Values, Variables)
stocks_analysis %>% 
  ggplot(aes(x=date,y=Values,
             color=stock_symbol))+
  geom_point()+
  theme_light()+
  geom_smooth()+
  facet_wrap(~Variables)+
  labs(title="Opening and Closing Stock Prices of Major Companies in August, 2020",
       y="Price",
       x="Date") +
ggsave(here("Output","TidyTuesday_2023-02-20.png"),
       width=14, height=8)
