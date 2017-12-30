# Titanic Data Set Analysis - Logistic Regression Example 
# Goal: Use Logit Regression Analysis to determine Titanic survival 
# Predict probability someone will survive Titanic based on certain factors 
browseURL("https://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/")

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

# S1C: Use subset() to focus on most relavent data 
# Irrelevant: PassId, Name, Cabin, Ticket, Parch? 
str(training.data.raw) #  2, 3, 5, 6, 7, 8, 10, 12
rawData <- subset(training.data.raw,select=c(2, 3, 5, 6, 7, 8, 10, 12)) # store important columns in df
rawData 

# Step 2 - Account for Missing Values: Deal with NAs
# Replace NAs "by hand" <- Replace NA values with either: 1. average 2. median 3. mean
# Use mean in this example (refer to sapply - sum(is.na(x)))
rawData$Age[is.na(rawData$Age)] <- mean(rawData$Age,na.rm = TRUE) # Age had an NA count of 177
rawData$Age[is.na(rawData$Age)] # no values in the variable Age are NA values 

# Use is.factor to check if categorical variables are encoded as factors
# factor = how R deals categorical variables 
is.factor(rawData$Sex)
is.factor(rawData$Embarked)
