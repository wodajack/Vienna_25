#' Author: Ted Kwartler
#' Date: July 4, 2025
#' Purpose: Build a regression model
#' 

# libs
library(tidyverse)
library(ggplot2)
library(dplyr)

# Data
data('diamonds') 
set.seed(1234)

# This is a simple down-sample, not a partitioning schema.  
# There is a difference because you could use the function twice and get the same rows. 
# When you partition you want to ensure no overlap of records between train/test
sampDiamonds <- sample_n(diamonds, 1000)

# EDA
summary(sampDiamonds)

# Remember this?
p <- ggplot(sampDiamonds, aes(carat, price)) + geom_point(alpha=0.5)
p

# Since we see a relationship let's make a linear model to predict prices
fit <- lm(price ~ carat, sampDiamonds)
fit

# Add out model predictions
p <- p + geom_abline(intercept =  coefficients(fit)[1], 
                     slope = coefficients(fit)[2], 
                     color='red')
p

# End
