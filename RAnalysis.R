# Titanic Data Set Analysis 
  
# Open datasets 
  
survival <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\survival.csv', header = TRUE)
test <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\test.csv', header = TRUE)
train <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\train.csv', header = TRUE)
final <- read.csv('C:\\Users\\loret\\Desktop\\DataSciencePrep\\Kaggle\\Titanic\\gender_submission.csv', header = TRUE)

# Gender_submission = survival
# Essentially, this is a prediction of someone surviving based on them being a female. (survival | female)


View(final)
str(final)

