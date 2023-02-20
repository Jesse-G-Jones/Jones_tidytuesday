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
stocks_analysis <- stocks %>% #assigns this function to this text
  filter(stock_symbol %in% c("AMZN","GOOGL", "TSLA", "MSFT", "NVDA")) %>% #Only includes these categories
  filter(complete.cases(.)) %>% #removes NAs (rows with missing data)
  filter(date>"2020-07-31",
         date<"2020-09-01") %>% #filtering for only August, 2020
  pivot_longer(c(open,close), #Not exactly sure, but it categorizes "open" and "close" prices such that I can create sub-plots for them; re-orients them from wide to long data on my dataframe?
               names_to = "Variables", #Creats a new column "Variables" that includes these names 
               values_to="Values") %>% #Creates a new column "Values" for the values of these names
  group_by(stock_symbol, date, Values, Variables) #groups my data by these columns
stocks_analysis %>% 
  ggplot(aes(x=date,y=Values, #create a plot with these aesthetics
             color=stock_symbol))+
  geom_point()+ #making a scatterplot
  theme_light()+ #change the theme to light
  geom_smooth()+ #adds lines that track the change of plotted points over time
  facet_wrap(~Variables)+ #Separates close and open into sub-plots
  labs(title="Opening and Closing Stock Prices of Major Companies in August, 2020", #relabeling my chart and axis titles
       y="Price",
       x="Date") +
ggsave(here("Output","TidyTuesday_2023-02-20.png"), #location I am saving my data
       width=14, height=8)
