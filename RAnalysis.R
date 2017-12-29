# Titanic Data Set Analysis - Logistic Regression Example 
# Goal: Use Logit Regression Analysis to determine Titanic survival 
# Predict probability someone will survive Titanic based on certain factors 

# Open datasets 
  
test <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\test.csv', header = TRUE)


# Step 1 - Clean Data: prepare data for analysis (scrub for missing/corrupted data)
# Use na.strings=c("") to code missing values as NA
training.data.raw <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\train.csv', header = TRUE, na.strings = c(""))

# Step 2: use sapply() to check for missing values/look how many unique values 
# there are for each variable 
# sapply() applies function passed as argument to each column of dataframe
sapply(training.data.raw, function(x) sum(is.na(x))) # Tally of all missing values: 177 NAs in Age variable

sapply(training.data.raw, function(x) length(unique(x))) # number of unique values

# S1B: Visualize missing values using Amelia package - maybe it's depricated
??Amelia
