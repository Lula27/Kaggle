# Open the CSV file exported through Jupytr Notebook
# Export files to csv 
browseURL("http://www.instantr.com/2012/12/11/exporting-a-dataset-from-r/")

# Read datasets 
myData = read.csv("C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\submit.csv", header = TRUE)
myData

# submission should be in CSV format with 418 prediction rows + header row 

# Get structure 
str(myData) # there are 891 obs and 10 variables - reduce variables to 2 (ID & survived)
dataTwo = myData[ ,2:3]
View(dataTwo) 
rm(dataTwo)

Tsurvival = dataTwo[1:418, ]
View(Tsurvival)
rm(Fdata)


# Export final dataset as csv
write.csv(Tsurvival, "C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\laTitanic.csv")

# Don't forget to remove extra added column on the far left
write.csv(Tsurvival, "C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\LA_Titanic.csv", row.names=FALSE)

# Clear workspace
rm(list = ls())

