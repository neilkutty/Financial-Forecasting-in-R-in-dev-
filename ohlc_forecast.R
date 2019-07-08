library(tidyverse)
library(quantmod)
library(caret)
library(xgboost)


symbols <- c('TER','SPOT','TWTR')

getSymbols(Symbols = symbols, from = '2010-01-01', auto.assign = TRUE)


# .. . Test functionalization elements . ..
#____________________________________________________________
# d = as.data.frame(TER)
# l = paste0(as.character(deparse(substitute(TER))),".Open")
# l    
# d[1,names(d) == 'TER.Open']
# TER[1,names(TER) == l]    
#____________________________________________________________

d[1,names(d) != l]


TER_df[1:(nrow(TER_df)-(.5*nrow(TER_df))),]

# # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Functionalize train test sets
maketraintestdfs = function(xts_object){
    set.seed(18081)
    df = as.data.frame(xts_object)
    c = paste0(as.character(deparse(substitute(xts_object))),".Close")
    #inTrain <- createDataPartition(y = df[,names(df) == c], p=0.8, list=F)
    
    training = df[1:(nrow(df)-(.3*nrow(df))),]
    testing <- df[-(1:(nrow(df)-(.3*nrow(df)))),]
    X_train = xgb.DMatrix(as.matrix(training[,names(training) != c]))
    y_train = training[,names(training)==c]
    X_test = xgb.DMatrix(as.matrix(testing[,names(testing) != c]))
    y_test = testing[,names(testing)==c]
    return(list(training,testing,X_train,y_train,X_test,y_test))
}
# # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

the_list = maketraintestdfs(TER)

tr = the_list[[1]]
te = the_list[[2]]

X_train = the_list[[3]]
y_train = the_list[[4]]
X_test = the_list[[5]]
y_test = the_list[[6]]


# # # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# 
# # Manual method
# TER_df = as.data.frame(TER)
# set.seed(100)  # For reproducibility
# # Create index for testing and training data
# inTrain <- createDataPartition(y = TER_df$TER.Close, p = 0.8, list = FALSE)
# # subset data to training
# training <- TER_df[inTrain,]
# # subset the rest to test
# testing <- TER_df[-inTrain,]
# 
# #Convert to DMatrix
# X_train = xgb.DMatrix(as.matrix(training %>% select(-TER.Close)))
# y_train = training$TER.Close
# X_test = xgb.DMatrix(as.matrix(testing %>% select(-TER.Close)))
# y_test = testing$TER.Close


#Specify cross-validation and folds
xgb_trcontrol = trainControl(
    method = "cv",
    number = 3,  
    allowParallel = TRUE,
    verboseIter = FALSE,
    returnData = FALSE
)


#Grid space for hyperparameters
#I am specifing the same parameters with the same values as I did for Python above. 
#The hyperparameters to optimize are found in the website.
xgbGrid <- expand.grid(nrounds = c(100,200),  # this is n_estimators in the python code above
                       max_depth = c(10, 15, 20, 25),
                       colsample_bytree = seq(0.5, 0.9, length.out = 5),
                       ## The values below are default values in the sklearn-api. 
                       eta = 0.1,
                       gamma=0,
                       min_child_weight = 1,
                       subsample = 1
)


set.seed(0) 
xgb_model = train(
    X_train, y_train,  
    trControl = xgb_trcontrol,
    tuneGrid = xgbGrid,
    method = "xgbTree"
)


predicted = predict(xgb_model, X_test)
residuals = y_test - predicted
RMSE = sqrt(mean(residuals^2))
cat('The root mean square error of the test data is ', round(RMSE,3),'\n')

# ^ ^ ^ --------------------------------------------------------------------- ^ ^ ^

# Gradient boosting method  

# below from -- https://datascienceplus.com/gradient-boosting-in-r/
library(gbm)

# below from -- https://datascienceplus.com/gradient-boosting-in-r/___________________________|
Boston.boost=gbm(medv ~ . ,data = Boston[train,],distribution = "gaussian",
                 n.trees = 10000, shrinkage = 0.01, interaction.depth = 4)
Boston.boost

summary(Boston.boost) #Summary gives a table of Variable Importance and a plot of Variable Importance


n.trees = seq(from=100 ,to=10000, by=100) #no of trees-a vector of 100 values 

#Generating a Prediction matrix for each Tree
predmatrix<-predict(Boston.boost,Boston[-train,],n.trees = n.trees)
dim(predmatrix) #dimentions of the Prediction Matrix

#Calculating The Mean squared Test Error
test.error<-with(Boston[-train,],apply( (predmatrix-medv)^2,2,mean))
head(test.error) #contains the Mean squared test error for each of the 100 trees averaged

#Plotting the test error vs number of trees

plot(n.trees , test.error , pch=19,col="blue",xlab="Number of Trees",ylab="Test Error", main = "Perfomance of Boosting on Test Set")

#adding the RandomForests Minimum Error line trained on same data and similar parameters
abline(h = min(test.err),col="red") #test.err is the test error of a Random forest fitted on same data
legend("topright",c("Minimum Test error Line for Random Forests"),col="red",lty=1,lwd=1)

#_______________________________________________________________________________________________|

library(forecast)

fit = ets(y_train)
fit
plot(fit)

pred = predict(fit, n.ahead = 800)
plot(pred)

