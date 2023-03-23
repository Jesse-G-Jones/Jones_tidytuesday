#Created By: Jesse Jones
#Date Created: 2023-03-22
#Date Last Modified: 2023-03-23
#Data Source: European Medicines Agency - https://www.ema.europa.eu/en/medicines/download-medicine-data
#Article: Dissecting 28 years of European pharmaceutical development - https://towardsdatascience.com/dissecting-28-years-of-european-pharmaceutical-development-3affd8f87dc0
#Tidy Tuesday European Drug Development Webpage with Data Dictionary - https://github.com/rfordatascience/tidytuesday/tree/master/data/2023
#Tidy Tuesday Repository - https://github.com/rfordatascience/tidytuesday
#Libraries
library(here)
library(tidyverse)
library(lubridate)
#Data
eudrugs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-03-14/drugs.csv') #create a function to load this csv
drugs_data <- eudrugs %>% #new function for working with data
  mutate(year_authorized=year(marketing_authorisation_date)) %>% #create a new column for the year the medicine was authorized
  drop_na(year_authorized) %>% #remove NAs (data that is missing for year of authorization)
  mutate(BIOSIMILAR=case_when(biosimilar=="TRUE"~"BIOSIMILAR", #create a new column for biosimilars wherein "TRUE" is assigned to "BIOSIMILAR"
                   biosimilar=="FALSE"~"NON-BIOSIMILAR"))
#, #and "FALSE" is assigned to "NON-BIOSIMILAR"
                   #TRUE~as.character(drugs_data$biosimilar))) #not exactly sure what this does, but I need to use this command to run this line of code
#maybe it 
drugs_data %>% #load this data set
  ggplot(aes(x=year_authorized, #create a plot with year of authorization on my x axis
             fill=additional_monitoring))+ #use color fill to represent whether the drug underwent additional monitoring
  stat_count()+ #create a bar plot
  facet_wrap(~BIOSIMILAR)+ #create sub-plots based on whether they are a biosimilar
  theme_minimal()+ #use this theme
  labs(title="Number of Biosimilar vs Non-biosimilar Medicines Authorized in Europe per Year
       and Whether They Underwent Additional Monitoring", #Create a title for my plot
       fill="Additional Monitoring", #Rename the fill legend title
       y="Count", #create y axis title
       x="Year of Authroziation")+ #create x axis title
  ggsave(here("Tidy_Tuesday_2023-03-22","Output","Drugs_Plot.PDF"),
         width=8)