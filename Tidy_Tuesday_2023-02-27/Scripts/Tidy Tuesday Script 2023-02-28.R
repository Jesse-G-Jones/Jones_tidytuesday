###Tidy Tuesday Week 05
###Created by: Jesse Jones
###Date Created: 2023-02-21
###Date Modified: 2023-02-28
#Data Sources: 
#FeederWatch: https://feederwatch.org/explore/raw-dataset-requests/
#TidyTuesday Data Link: https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-01-10/readme.md
# Article Link: https://www.frontiersin.org/articles/10.3389/fevo.2021.619682/full
#AUTHORS: Bonter David N., Greig Emma I.
#Libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
#Data
feederwatch <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-10/PFW_2021_public.csv') 
mydata <- feederwatch %>% #creates a function "my data" and loads feederwatch csv
  drop_na(effort_hrs_atleast) %>% #removes NA values from these columns
  drop_na(snow_dep_atleast) %>% 
  group_by(effort_hrs_atleast, snow_dep_atleast) %>% #groups my data by these columns
  summarise(Avg_seen=mean(how_many, na.rm=TRUE)) #summarises the "how_many" column by average for effort and snow depth?
mydata %>%  #loads mydata data frame
  ggplot(aes(x=snow_dep_atleast, y=Avg_seen, #creates a plot with these assigned aesthetics
             color=effort_hrs_atleast))+
  geom_point(size=4, alpha=.8)+ #I want to create a scatterplot
  labs(title="Average Number of Individual Birds Seen by Snow Depth and Observation Time", #my labels for title, axes, and caption
       x="Snow Depth (no units provided)",
       y="Average Number of Individuals Seen",
       color="Hours Spent",
       captions="Effort, but not snow depth, appears to correlate with the number of individuals observed per session.")+
  ggsave(here("Tidy_Tuesday_2023-02-27","Output","Graph.png"),
         width=8, height=8)