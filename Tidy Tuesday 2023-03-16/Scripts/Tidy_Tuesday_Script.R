#Created By: Jesse Jones
#Date Created: 2023-03-13
#Credits & Sources...
#Link to the offical tidytuesday repository: https://github.com/rfordatascience/tidytuesday
#Link to numbats tidytuesday dataset (includes data dictionary): https://github.com/rfordatascience/tidytuesday/blob/master/data/2023/2023-03-07/readme.md
#Link to Data Source: https://www.ala.org.au/
#Link to Article: https://bie.ala.org.au/species/https://biodiversity.org.au/afd/taxa/6c72d199-f0f1-44d3-8197-224a2f7cff5f
#Link to Google Maps: https://www.google.com/maps/
#Libraries...
library(here)
library(tidyverse)
library(stringr)
library(ggmap)
#Data...
numbats_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-07/numbats.csv')
australia_map <- data.frame(lon=134, lat=-22)
map1 <- get_map(australia_map, zoom=4)
numbats <- numbats_data
ggmap(map1)+
  geom_point(data=numbats, size=1.5, alpha=0.7,
             aes(x=decimalLongitude,
                 y=decimalLatitude,
                 color=scientificName))+
  scale_color_manual(values=c("maroon","midnightblue"))+
  xlim(115,155)+
  ylim(-40,-10)+
labs(title="Location of Numbats Seen In Australia",
     x="Longitude",
     y="Latitude",
     color="Species")+
  ggsave(here())