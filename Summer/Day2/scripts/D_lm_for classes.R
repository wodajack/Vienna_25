#' Author: Ted Kwartler
#' Date: July 4 2025
#' Purpose: What happens when regression is applied to a binary outcome?
#' 

# libs
library(ggplot2)
library(dplyr)
library(tidyverse)

# Data
data('diamonds')

# Convert to binary
diamonds$icedOut <- ifelse(diamonds$price >= 11000,1, 0)
diamonds$price   <- NULL

set.seed(1234)
sampDiamonds <- sample_n(diamonds, 1000)

# Remember this?
p <- ggplot(sampDiamonds, aes(carat, icedOut)) +geom_point(alpha=0.5)
p

# Since we see a relationship let's make a linear model to predict prices
fit <- lm(icedOut ~ carat, sampDiamonds)
coefficients(fit)

# Add out model predictions; does this look like a good fit?
p <- p + geom_abline(intercept =  coefficients(fit)[1], 
                     slope     = coefficients(fit)[2],
                     color='red')
p

# Suppose you *could* get a 12 carat diamond
hopeDiamond  <- data.frame(carat = 12)
bigRock <- predict(fit, hopeDiamond)

# 1= Yes, the diamonds is more than $11k; 0 means no.  What does this mean?  We must have used the wrong method!
bigRock

# End

