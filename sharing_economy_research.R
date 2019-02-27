#' Title: Sharing Economy Research
#' Author: Tim de Rooij
#' Date: 27-2-2019

# set working director
setwd("/Users/TdR/Coding/Machine Learning/sharing-economy/")

# load libraries
library(tidyverse)

# load data (trend data from Google Trends)
googleScoreUS <- read.csv("/Users/TdR/Coding/Machine Learning/sharing-economy/multiTimelineUS.csv")
googleScoreWorld <- read.csv("/Users/TdR/Coding/Machine Learning/sharing-economy/multiTimelineWorldwide.csv")

# view last 10 rows
tail(googleScoreUS, 10)
tail(googleScoreWorld, 10)

# get structure
str(googleScoreUS)
str(googleScoreWorld)

# drop Month old column
googleScoreUS$Month.old <- NULL
googleScoreWorld$Month.old <- NULL

# change Month from factor to character type
googleScoreUS$Month <- as.character(googleScoreUS$Month)
googleScoreWorld$Month <- as.character(googleScoreWorld$Month)

# get structure
str(googleScoreUS)
str(googleScoreWorld)

# change Score for World from factor to integer
googleScoreWorld$Worldwide <- as.integer(googleScoreWorld$Worldwide)

# change Month from character to date
googleScoreUS$Month <- as.Date(googleScoreUS$Month)
googleScoreWorld$Month <- as.Date(googleScoreWorld$Month)

# get structure
str(googleScoreUS)
str(googleScoreWorld)

# combine to one dataframe
googleScore <- cbind( googleScoreUS, googleScoreWorld$Worldwide )
head( googleScore )

# simplify column name
colnames(googleScore)[3] <- "World"

# view results
head(googleScore)

# open file
jpeg("googleScore.jpg", width = 2222, height = 816)

# visualize data
ggplot( data = googleScore, aes( x = Month ) ) + 
  geom_line( aes( y = US, colour = "US" ) ) + 
  geom_line( aes( y = World, colour= "World") ) +
  labs( title = "Relative interest in Sharing Economy, measured by Google Searches",
        subtitle = "Interest",
        caption = "Data source: Google Trends",
        tag = "Figure 1",
        x = "Time",
        y = "Relative Interest",
        colours = "Gears") +
  scale_colour_manual("", 
                      breaks = c("US", "World"),
                      values = c("Dodgerblue3", "Grey50")) +
  theme_light()

# Close the file
dev.off()
