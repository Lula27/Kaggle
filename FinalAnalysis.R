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
library(tree)
library(ISLR)
library(rpart)
library(MASS)

# y_train: dependent variable 
# x_train: independent variable 
# x : training data 


?cbind


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
