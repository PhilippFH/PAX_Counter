library(tidyverse)
library(rgdal)
library(broom)
library(ggplot2)
library(dplyr)
library(shiny)
library(plotly)
library(lattice)
library(lubridate)

#Heatmap
NHSBoards <- readOGR(dsn ="C:/Users/pmoer/Desktop/Shapefile") 
NHSBoards_tidy <- tidy(NHSBoards)
NHSBoards$id <- row.names(NHSBoards)
NHSBoards_tidy <- merge(NHSBoards_tidy,datatest,by.x = "FID",by.y = "ROOM_ID")
NHSBoards_tidy$Flooring_Time_Hour <- floor_date(NHSBoards_tidy$Time,"hour")
NHSBoards_tidy_tmp <- NHSBoards_tidy %>% select(long,lat,NUMBER,FID,Flooring_Time_Hour,group)#%>% group_by(long,lat,FID,Flooring_Time_Hour,group) %>% summarise(Persons = NUMBER)

ggplot(NHSBoards_tidy_tmp, aes(x = long, y = lat,group = group,fill = Persons)) +
  geom_polygon(color = "black", size = 0.1) +
  coord_equal() +
  scale_fill_gradient2(low = "white", mid = "yellow", high = "red", # colors
                       midpoint = 20, name = "Anzahl") + # legend options
  theme_void() +
  labs(title = "FH Villach EG ein Raum") +
  theme(plot.title = element_text(margin = margin(t = 0, b = 0)))

#Boxplot
ggplot(datatest, aes(y = NUMBER )) + geom_boxplot(col = "black")  + labs(title = "Besucheranzahl")

#For the line Diagram
datatest$Time <- as.POSIXct(paste0(as.character(datatest$DATE),substr(as.character(datatest$TIME),11,20)))
p<-ggplot(datatest, aes(x=Time,y=NUMBER)) + geom_line()+ labs(title = "Anzahl der Besucher über die Zeit")
p
