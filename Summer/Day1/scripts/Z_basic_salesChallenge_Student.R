#' Author: Ted Kwartler
#' Date: 6-30-2024
#' Purpose: Case Study - 
#' 
# Libraries
library(ggplot2)
library(ggthemes)
library(lubridate)
options(scipen = 999)

# Read in the data
salesData <- read.csv('https://raw.githubusercontent.com/kwartler/teaching-datasets/main/salesData.csv')

# Get a summary of the data
str(___)
summary(___)

# change Price.Each column to numeric
salesData$Price.Each <- as.numeric(___$___)

# Make sure the sales column is numeric
salesData$Price.Each <- as.numeric(___$___)

# Make sure the number ordered is numeric
salesData$Quantity.Ordered <- as.numeric(___$___)

# Density plot of Price.Each
ggplot(data = ___, aes(x = ___)) + 
  geom_density() +
  theme_gdocs() +
  ggtitle("Distribution of Unit Price")

# Tally the products
prodTally <- as.data.frame(table(___$___))

# Order the tally
prodTally <- ___[order(___$Freq, decreasing = T),]

# Select the top 5 products
topFive <- prodTally[1:5,]
topFive <- head(prodTally, 5)

# Create a col chart with x = Var1 & y = Freq
ggplot(data = ___, aes(x = ___, y = ___)) +
  geom_col() + theme_few() +
  ggtitle('top 5 product sales') + 
  theme(axis.text.x = element_text(angle = 90))

# Engineer variables from days; done for you to show the lubridate functions
salesData$Order.Date  <- mdy_hm(salesData$Order.Date) #overwrite as a data object
salesData$dayOfWeek   <- wday(salesData$Order.Date)
salesData$dayOfMonth  <- mday(salesData$Order.Date)
salesData$weekday     <- weekdays(salesData$Order.Date)
salesData$hourOfDay   <- hour(salesData$Order.Date)
salesData$dayOfYear   <- yday(salesData$Order.Date)
salesData$month       <- month(salesData$Order.Date)
salesData$year        <- year(salesData$Order.Date)


# Examine a portion of the data 
head(___)

# Tally (table) the year column to see if there is any data skew
table(___$___)

# Subset the data to just "2019" 
# hint: salesData <- subset(data object, column name == 2019) 
# *remember the double ==* 
salesData <- subset(___, ___ == ___)

# Let's aggregate Quantity.Ordered Times Price.Eachn to sum revenue by month
salesData$orderRevenue <- salesData$___ * salesData$___
monthlySales <- aggregate(orderRevenue ~ month, salesData, ___)
monthlySales

# Change to month name; left so you can see the built in month object
monthlySales$month <-  month.name[monthlySales$month]

# Find maximum month using which.max(); contrast this with max()
monthlySales[___(monthlySales$orderRevenue),]

# Data prep for visual; here we are declaring month not as a character but as a string
# This let's R plot it not alphabetically i.e. April, August, December but instead
# Temporally Jan, Feb, Mar ...
monthlySales$month <- factor(monthlySales$month, levels = month.name)

# Plot so that x  is month and y is orderRevenue
ggplot(monthlySales, aes(x = ___, y = ___,  group = 1)) + 
  geom_line() + 
  scale_x_discrete(limits = month.name) + 
  theme_gdocs() + 
  theme(axis.text.x = element_text(angle = 90)) +
  ggtitle('Sales by month')
# End

