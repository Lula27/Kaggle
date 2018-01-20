# Open the CSV file exported through Jupytr Notebook
myData = read.csv("C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\submit.csv", header = TRUE)
myData

# submission should be in CSV format with 418 prediction rows + header row 

# Get structure 
str(myData) # there are 891 obs and 10 variables - reduce variables to 2 (ID & survived)
dataTwo = myData[ ,2:3]
View(dataTwo) 
rm(dataTwo)

Fdata = dataTwo[1:418, ]
View(Fdata)
