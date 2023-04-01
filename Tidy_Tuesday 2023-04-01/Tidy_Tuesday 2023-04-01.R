###Created by: Jesse Jones
###Date Created: 2023-03-31
###Last Modified: 2023-04-01
###Credits & Links to Sources
#Link to the offical tidytuesday repository: tidytuesday - https://github.com/rfordatascience/tidytuesday 
#2019-02-19 tidytuesday dataset (includes data dictionary): US PhD's Awarded - https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-02-19
#Link to data source: NSF - https://ncses.nsf.gov/pubs/nsf19301/data
#Link to "article": #epicbookclub - https://twitter.com/EpiEllie/status/1096876638632140805
#Twitter Post by: Dr Ellie Murray, ScD
###Libraries
library(here)
library(tidyverse)
library(patchwork)
library(extrafont)
#Data & Wrangling
phds_data <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-19/phd_by_field.csv")
view(phds_data) #view the data
phds_broad_field <- phds_data %>% #create a function for a new dataset with tidy data
  select(broad_field, n_phds, year)  #select for only these columns

per_field_per_year <- ggplot(data=phds_broad_field, #create a function to plot this data
                             aes(x=broad_field, y=n_phds, #x axis is represents the academic field; y represents 
                                 fill=broad_field, #fill based on academic field
                                 color=broad_field))+ # color based on academic field
  geom_col()+ #make it a column plot
  facet_wrap(~year)+ #create sub-plots based on year
  theme_classic()+ #use the classic theme for the panel
  theme(axis.text.x=element_blank())+ #no x axis tick mark/column text
  labs(y="PhDs Awarded", #this is my y axis title
       title="Number of PhDs Awarded by Field and Year in the U.S.", #this is my plot title
       fill="Field", #this is my fill legend title
       x="Field", #this is my x axis title
       color="Field") + #this is my color legend title
  theme(text=element_text(family="Century Gothic", size=30),
        axis.text.x=element_blank()) #use the Century Gothic font for my plot text, font size 16

per_year <- ggplot(data=phds_broad_field)+ #create a function for plotting this data
  geom_col(aes(y=n_phds, x=year, fill=year, color=year))+ #create a column plot with number of PhDs on the y axis, year on the x axis and also represented by fill & color
  theme_classic()+ #use this classic theme for the panel
  labs(y="PhDs Awarded", #this is my y axis title
       x="Year", #this is my x axis title
       title="Total Number of PhDs Awarded per Year in the U.S.", #this is my plot title
       fill="Year", #Fill legend is named "Year"
       color="Year", #Color legend is named "Year"
       caption="Data Provided by the National Science Foundation")+ 
  scale_fill_viridis_b()+ #use these fill colors for my columns (color blind-friendly?)
  scale_color_viridis_b()+ #use these colors to represent columns
    scale_x_discrete(limits=c(2008, 2009, 2010, 2011, 2012,
                            2013, 2014, 2015, 2016, 2017))+ #make the x axis tick marks exactly at these values
  theme(text=element_text(family="Century Gothic", size=30), #use Century Gothic font, size 13 for my plot
        plot.caption=element_text(hjust=0.5)) #center the plot caption
per_field_per_year/per_year + #use patchwork to stack the plots on top of each other in this order
  ggsave(here("Tidy_Tuesday 2023-04-01", "Output", "USA_PhDs_Plot.png"), #location and field type for saving my plot
         height=20, width=20) #dimensions in inches of my plot png image
  