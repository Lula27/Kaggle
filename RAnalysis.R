# Titanic Data Set Analysis - Logistic Regression Example 
# Goal: Use Logit Regression Analysis to determine Titanic survival 
# Predict probability someone will survive Titanic based on certain factors 
# Logit model response variable is log odds: ln(odds) = ln(p/(1-p)) = a*xl + b*x2 +...+ z*xn
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
install.packages("Amelia")
?Amelia
missmap(training.data.raw, main = "Missing values vs observed") # hmmm...still not working

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

# Use contrasts() to understand how R is going to deal w/ categorical variables
# Contrasts() function shows how variables have been dummyfied in R & how to interpret them in model
contrasts(rawData$Sex) # female dummyfied as 0; male = 1

# Embarked = port of embarkation 
# C = Cherbourg, Q = Queenstown, S = Southampton 
contrasts(rawData$Embarked)
# As for the missing values in Embarked, since there are only two
# we will discard those two rows (we could also have
# replaced the missing values with the mode and keep the datapoints).
myData <- rawData[!is.na(rawData$Embarked),]
myData
rownames(myData) <- NULL

# Step 3 - Model Fitting
# 3A: split model into two chunks (training & testing set)
train <- myData[1:800,]  # used to fit model which we will be testing over testing set
train

test <- myData[801:889,]
test

# 3B: Fit the model 
# Specify parameter family=binomial in glm() function
?glm  # used to fit generalized linear models by giving symbolic description of linear predictor & description of error distribution 
model <- glm(Survived
~., family=binomial(link='logit'), data=myData)

model # print model output 
summary(model) 
# Interpretations: 
# 1. Significant variables = Pclass, Sexmale, Age, SibSp
# 2. Sexmale has lowest p-value suggesting a strong association of sex of passenger & propability the survived
# 2 con't: since Sexmale = -2.272, male passenger less likely to have survived 
# Since male is a dummy variable, being male reduces the log odds by 2.72
# A unit increase in age reduces log odds by 0.039 
# Curiosity - why are my values larger than the liturature I'm reading? 

# Step 4: Interpret Results of Logistic Regression Model
# 4b: Run anova() function to analyze table of deviance 
anova(model, test = "Chisq") # I guess...chisq refers to chi squared 
# Again, why do these values differ from r-bloggers example
# Difference between the null deviance and the residual deviance = how model is doing against null model
# Null model = model with only intercept
# Wider gap, the better 
# Notice that adding Pclass, Sex & Age significantly reduces the residual deviance

#4c: use McFadden R2 index to assess model fit b/c there is no exact equivalent to the R2 of linear regression
?pscl
install.packages("pscl")
library(pscl) 
pR2(model) #  McFadden =  0.3370165; r2ML =   0.3613519; What does this mean?


# Step 5: Assessing the predictive ability of the model
fitted.results <- predict(model, myData=subset(test, select = c(2,3,4,5,6,7,8)),
                  type='response')
                  fitted.results <- ifelse(fitted.results > 0.5,1,0)
fitted.results <- ifelse(fitted.results > 0.5, 1, 0)
fitted.results

misClasificError <- mean(fitted.results != test$Survived)
print(paste('Accuracy', 1-misClasificError)) # Hmmm...my accuracy is much lower :/ 
# on website: "Accuracy 0.842696629213483"
# 0.84 accuracy on the test set is quite a good result
# keep in mind that this result is somewhat dependent on the manual split of the data
# For more precision, use k-fold cross validation or another cross validation

# 5b: use performcance measurment for binary classifier  - nothing is working :( 
browseURL("http://gim.unmc.edu/dxtests/roc3.htm") # background info on Area Under an ROC Curve
# plot ROC curve and calculate the AUC (area under curve)
# Interpretation: .09 - 1 = excellent (A); .80-.90 = good(B); .70-.80 = fair(C); .60-.70=poor(D); .50-.60 = fail(F)
install.packages("ROCR")
require(ROCR)

p <- predict(model, 
             myData = subset(test, select = c(2,3,4,5,6,7,8)),
             type="response")
pr <- prediction(p, test$Survived) # got an error :/
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

# Clean up
rm(list = ls())
detach("package:ROCR", unload=TRUE)