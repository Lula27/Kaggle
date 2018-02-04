# Open the CSV file exported through Jupytr Notebook
# Export files to csv 
browseURL("http://www.instantr.com/2012/12/11/exporting-a-dataset-from-r/")
browseURL("https://github.com/anurajaram/kaggle-titanic/blob/master/tree.R")


# Don't forget to remove extra added column on the far left - for exporting dataset
write.csv(Tsurvival, "C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\LA_Titanic.csv", row.names=FALSE)

# Clear workspace
rm(list = ls())


# Use Decision Trees to Analyse Datasets 

# Access libraries 
install.packages("tree")
library(tree)
library(ISLR)
library(rpart)
library(MASS)

# y_train: dependent variable 
# x_train: independent variable 
# x : training data 


?cbind
?tree


# Try with Anu Rajaram's work
# Load and label dataframes 
# A: train dataset 
?read.delim # Reads a file in table format and creates a data frame from it, with cases corresponding to lines and variables to fields in the file.
train = read.delim(file = 'C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\cleantrain.csv', header = TRUE,
                    sep = ',', dec = '.')

View(train)

# B: test dataset 
test = read.delim(file = 'C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\cltest.csv', header = TRUE,
                    sep = ',', dec = '.')
View(test)

# Build Decision Tree Models
tree1 <- tree(Survived ~ Pclass + Age + SibSp + Parch + male, data = train)

summary(tree1)
plot(tree1)
text(tree1)

# Make prediction to apply to new model
Pred1 <- predict(tree1, test)

model <- data.frame(PassengerId = test$PassengerId, Survived = Pred1, 
                    gender = test$male)
summary(model$Survived)

# Using text(tree1), looks like male < 0.5

# Applying predictions
model$final[model$Survived <= 0.5] <- 0 # did not survive 
model$final[model$Survive > 0.5] <- 1 # did survive 

# Create submission file 
submit <- data.frame(PassengerId = model$PassengerId, Survived = model$final)
View(submit)

# Export as CSV file 
write.csv()