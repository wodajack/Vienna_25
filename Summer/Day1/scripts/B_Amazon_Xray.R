#' Purpose: Explore some amazon X-Ray data
#' Author: Ted Kwartler
#' email: edwardkwartler@fas.harvard.edu
#' Date: 5-26-2025
#'

# Turn off scientific notation
options(scipen = 999)

# URL to the file
movieURL <- 'https://raw.githubusercontent.com/kwartler/teaching-datasets/main/forceAwakens_definedScenes.csv'

### 2. Load libraries to customize R
library(ggplot2)
library(ggthemes)

### 3. Read in data
# Use the read.csv function for your specific definedScenes.csv file
scenesDF   <- read.csv(movieURL)

### 4. Apply functions to clean up data & get insights/analysis
# Use the names function to review the names of scenesDF
names(scenesDF)

# Review the bottom 6 records of scenesDF
tail(scenesDF)

# Clean up the raw data with a "global substitution"
scenesDF$id <- gsub('/xray/scene/', "", scenesDF$id)
tail(scenesDF)

# Change ID class from string to numeric
scenesDF$id <- as.numeric(scenesDF$id)

# Remove a column
scenesDF$fictionalLocation <- NULL

# Make a new column & review
scenesDF$length <- scenesDF$end - scenesDF$start
head(scenesDF$length)

# Basic statistics
summary(scenesDF)

### 5. Project artifacts ie visuals & (if applicable)modeling results/KPI
# Quick plot
hist(scenesDF$length)
summary((scenesDF$length/1000) / 60)

# Identify the outlier, review; note the double ==
subset(scenesDF, scenesDF$length == max(scenesDF$length))

# Or you can use a different function to find the row
maximumLength <- which.max(scenesDF$length) #16
scenesDF[maximumLength,]

# Sometimes when parsing text there are unusual characters which can cause issues
# Here we enforce a UTF: Unicode Transformation Format – 8-bit; used by the internet
unique(scenesDF$name)
scenesDF$name <- stringi::stri_encode(scenesDF$name, "", "UTF-8")

# Create a variable to name your movie
movieTitle <- 'Star Wars'

# Apply a logical operator
plotDF <- scenesDF[1:38,]

################ BACK TO PPT FOR EXPLANATION ##################
ggplot(plotDF, aes(colour = name)) +
  geom_segment(aes(x = start, xend = end,
                   y = id,    yend = id), linewidth = 3) +
  geom_text(data=plotDF, aes(x = end, y = id, label = name),
            size = 2.25, color = 'black', alpha = 0.5, check_overlap = TRUE) +
  theme_gdocs() + theme(legend.position = "none") +
  ggtitle(movieTitle)

# End

