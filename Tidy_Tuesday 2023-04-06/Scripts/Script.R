###Created By: Jesse Jones
###Date Created: 2023-04-06
##Data Source: Popularity of games on Steam - https://www.kaggle.com/datasets/michau96/popularity-of-games-on-steam
## Article: SteamCharts - https://steamcharts.com/
## Tidy Tuesday Video Games and Sliced Webpage - https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-16/readme.md#video-games-and-sliced
## Tidy Tuesday Repository - https://github.com/rfordatascience/tidytuesday
## Data Dictionary - https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-16/readme.md#gamescsv
#Libraries
library(tidyverse)
library(here)
library(extrafont) #for importing fonts from my windows computer
#Get The Data:
games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-16/games.csv') #read the data in from this csv link
#Data Wrangling
games_data <- games %>% #crate a new dataframe for data wrangling
  filter(year %in% c("2018", "2019", "2020"), #select data from only these years
         gamename %in% c("Counter-Strike: Global Offensive", "Dota 2", "PLAYERUNKNOWN'S BATTLEGROUNDS")) #select data from only these games
#Make a Plot
ggplot(data=games_data,aes(x=factor(month, level=c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")), #order my x axis in the order I typed my months (chronologically)
                           y=avg, #plot the average player count on my y axis
                           color=gamename))+ #colors represent the title of the game
  geom_point()+ #create a scatterplot
  geom_line(aes(group=gamename, #connect my scatterplot points
            color=gamename))+ #color represents the title of the game
  scale_color_viridis_d()+ #color-blind friendly (I think)
  theme_light()+ #use the light theme
  facet_wrap(~year)+ #create subplots by year
theme(axis.text.x=element_text(angle=60, hjust=1), #orient my x axis text at 60 degrees, offset downward by one inch
      text=element_text(family="Trebuchet MS", #use this font for my plot text
                        size=14), #use size 14 for my plot text
      strip.text=element_text(color="grey30"), #make my facet titles this color
      strip.background=element_rect(fill="white", color="grey"), #make my facet title background filled white, outlined grey
      axis.text=element_text(size="8", face="bold"), #make my axis text size 8 & bold
      plot.title=element_text(hjust=0.48))+ #center my plot title
  
labs(title="2020 Monthly Average Player Count of CS:GO, Dota 2, and PUBG", #this is the title of my plot
     x="Month", #this is the title of my x axis
     y="Average Number of Players", #this is the title of my y axis
     color="Game Title")+ #this is the title of my color legend
  ggsave(here("Tidy_Tuesday 2023-04-06", "Output", "Plot.jpg"),
         height=6, width=14)