#Step 1 Import the data

Churndata=read.csv("C:/Users/Kaushik/OneDrive/Datasets/Telechurn.csv",na.strings =c("",NA,NULL)  
                              ,stringsAsFactors = TRUE)



View(Churndata)                           
summary(Churndata)

#Step 2 Drop the unwanted columns
# We can drop customer ID as it is not useful w.r.t business perspective
Churndata$customerID=NULL

#Step 3
#Convert all the categorical columns as factor
churn_cat_cols=c("gender","SeniorCitizen","Partner","Dependents","PhoneService"
                 ,"MultipleLines","InternetService","OnlineSecurity","OnlineBackup","DeviceProtection"
                 ,"TechSupport","StreamingTV","StreamingMovies","Contract","PaperlessBilling"
                 ,"PaymentMethod","Churn")
#Automation of factor conversion 
for (cat_cols in churn_cat_cols){
  Churndata[,cat_cols]=as.factor(Churndata[,cat_cols])
}

#Step 4
#Identifying the NULL values
colSums(is.na(Churndata))
#Missing values are treated in the below step
Churndata=na.omit(Churndata)

#Step 5 
#Finding the mean,median,sd, var and range 
churn_cont_cols=c("tenure","MonthlyCharges","TotalCharges")

#Finding measures of central tendency 
sapply(Churndata[,churn_cont_cols], mean)
sapply(Churndata[,churn_cont_cols],median)

#Finding measures of dispersion
sapply(Churndata[,churn_cont_cols],var)
sapply(Churndata[,churn_cont_cols],sd)
sapply(Churndata[,churn_cont_cols],range)

#Finding measures of location
sapply(Churndata[,churn_cont_cols],quantile)



#Step 6
#Finding out the mode for all the categorical columns 
mode=function(inpData){
  ModeValue=names(table(inpData)[table(inpData)==max(table(inpData))])
  return(ModeValue)
}
sapply(Churndata[,churn_cat_cols],mode)  

#Step 7 To find out whether it is a classification problem or a regression model 
#Ans. It is a classification problem because the target variable is categorical in nature 

#Step 8
#Splitting the plot window into 6 parts 
# Exploring MULTIPLE CONTINUOUS features
ColsForHist=c("tenure","MonthlyCharges","TotalCharges")
#Splitting the plot window into two parts
par(mfrow=c(2,3))

# library to generate professional colors
library(RColorBrewer) 

# loop to create the histograms for each column
for (ColumnName in ColsForHist){
  hist(Churndata[,c(ColumnName)], main=paste('Histogram of:', ColumnName), 
       col=brewer.pal(8,"Paired"))
}
###########################################################
# Exploring MULTIPLE CATEGORICAL features
ColsForBar=c("gender","SeniorCitizen","Partner","Dependents","PhoneService"
              ,"MultipleLines","InternetService","OnlineSecurity","OnlineBackup","DeviceProtection"
              ,"TechSupport","StreamingTV","StreamingMovies","Contract","PaperlessBilling"
              ,"PaymentMethod","Churn")

#Splitting the plot window into four parts
par(mfrow=c(2,4))

# looping to create the Bar-Plots for each column
for (ColumnName in ColsForBar){
  barplot(table(Churndata[,c(ColumnName)]), main=paste('Barplot of:', ColumnName), 
          col=brewer.pal(8,"Paired"))
}
#Step 9
##bi-variate analysis
# Visual Relationship between target variable and predictors

##for classification- dependent:categorical and predictor: categorical/continuous
# Categorical Vs Continuous --- Box Plot
# Categorical Vs Categorical -- Grouped Bar chart

############################################################
# Categorical Vs Continuous Visual analysis: Boxplot

##Age: continuous, Survived: Categorical
par(mfrow=c(1,1))
boxplot(Age~Survived, data = TitanicData, col=brewer.pal(8,"Paired"))

boxplot(Fare~Survived, data = TitanicData, col=brewer.pal(8,"Paired"))

############################################################
############################################################
# Bargraphs for categorical variables 
install.packages("plotly")
library(plotly)
plot1=ggplot(Churndata, aes(x=gender)) + ggtitle("Gender") + xlab("Gender") +
geom_bar(aes(y = 100*(count)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot1
plot2=ggplot(Churndata, aes(x=SeniorCitizen)) + ggtitle("SeniorCitizen") + xlab("SeniorCitizen") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot2
plot3=ggplot(Churndata, aes(x=Partner)) + ggtitle("Partner") + xlab("Partner") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot3
plot4=ggplot(Churndata, aes(x=Dependents)) + ggtitle("Dependents") + xlab("Dependents") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot4
plot5=ggplot(Churndata, aes(x=PhoneService)) + ggtitle("PhoneService") + xlab("PhoneService") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot5
plot6=ggplot(Churndata, aes(x=MultipleLines)) + ggtitle("MultipleLines") + xlab("MultipleLines") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot6
plot7=ggplot(Churndata, aes(x=InternetService)) + ggtitle2("InternetService") + xlab("InternetService") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot7
plot8=ggplot(Churndata, aes(x=OnlineSecurity)) + ggtitle("OnlineSecurity") + xlab("OnlineSecurity") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot8
plot9=ggplot(Churndata, aes(x=OnlineBackup)) + ggtitle("OnlineBackup") + xlab("OnlineBackup") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot9
plot10=ggplot(Churndata, aes(x=DeviceProtection)) + ggtitle("DeviceProtection") + xlab("DeviceProtection") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot10
plot11=ggplot(Churndata, aes(x=TechSupport)) + ggtitle("TechSupport") + xlab("TechSupport") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot11
plot12=ggplot(Churndata, aes(x=StreamingTV)) + ggtitle("StreamingTV") + xlab("StreamingTV") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot12
plot13=ggplot(Churndata, aes(x=StreamingMovies)) + ggtitle("StreamingMovies") + xlab("StreamingMovies") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot13
plot14=ggplot(Churndata, aes(x=Contract)) + ggtitle("Contract") + xlab("Contract") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot14
plot15=ggplot(Churndata, aes(x=PaperlessBilling)) + ggtitle("PaperlessBilling") + xlab("PaperlessBilling") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot15
plot16=ggplot(Churndata, aes(x=PaymentMethod)) + ggtitle("PaymentMethod") + xlab("PaymentMethod") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()
plot16

# Step-10
# Statistical Relationship between target variable (Categorical) and predictors

# Categorical Vs Continuous --- ANOVA
# Categorical Vs Categorical -- Chi-square test

#Since 

#ANOVA test- ANOVA stands for analysis of variance
#The below line of code is to convert from sci notation
options(scipen = 999)
#Since there are only 3 continuous columns in the dataset, no automation is done 
summary(aov(tenure~Churn, data = Churndata))
summary(aov(MonthlyCharges~Churn,data = Churndata))
summary(aov(TotalCharges~Churn,data = Churndata))
#As per ANOVA test all the continuous variables are found to be significant/important w.r.t business perspective

#Chi square test- Chi square test is done for cat vs cat variable


# Chi square test for each categorical variable
CrossTabResult=table(Churndata[ , c("gender","Churn")])
CrossTabResult
chisq.test(CrossTabResult)#NS
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("SeniorCitizen","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("Partner","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("Dependents","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("PhoneService","Churn")])
CrossTabResult#NS
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("MultipleLines","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("InternetService","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("OnlineSecurity","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("OnlineBackup","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("DeviceProtection","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("TechSupport","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("StreamingTV","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("StreamingMovies","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("PaperlessBilling","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))
CrossTabResult=table(Churndata[ , c("PaymentMethod","Churn")])
CrossTabResult
chisq.test(CrossTabResult)
barplot(CrossTabResult, beside=T, col=c('Red','Green'))

#as per the chi square test we eliminate gender and phone service and all the other variables are 
#significant w.r.t business perspective



#Step 11 
#Preparing the data for ML 
TargVar_Churn="Churn"
PredVar_Churn=c("tenure","MonthlyCharges","TotalCharges","SeniorCitizen","Partner","Dependents",
                "MultipleLines","InternetService","OnlineSecurity","OnlineBackup","DeviceProtection"
                ,"TechSupport","StreamingTV","StreamingMovies","Contract","PaperlessBilling"
                ,"PaymentMethod")
InpData_Churn=Churndata
Bestpred_Churn=InpData_Churn[,c(PredVar_Churn)]
TargetVar_Churn=InpData_Churn[,c(TargVar_Churn)]
Churn_DataforML=data.frame(TargetVar_Churn,Bestpred_Churn)
Churn_DataforML
#To check no.of rows and columns for the newly created dataframe to be used for ML
dim(Churn_DataforML)
dim(Churndata)

#Step 12 
#70% of the data is used for training and the remaining 30% is used for testing 

Train_index_Churn=sample(1:nrow(Churn_DataforML),size=0.7*nrow(Churn_DataforML))
Train_data_Churn=Churn_DataforML[Train_index_Churn,]
Test_data_Churn=Churn_DataforML[-Train_index_Churn,]
dim(Train_data_Churn)
dim(Test_data_Churn)

#Step 13 Generating the models

LR_Model=glm(TargetVar_Churn ~ . , data=Train_data_Churn, family='binomial')
summary(LR_Model)
PredictionProb=predict(LR_Model,Test_data_Churn,type = "response")
PredictionProb

#Decision tree
library(party)
Model_CTREE=ctree(TargetVar_Churn~.,data = Train_data_Churn)
summary(Model_CTREE)
plot(Model_CTREE)
#Confusion matrix for a decision tree 
pred_tree=predict(Model_CTREE, Test_data_Churn)
print("Confusion Matrix for Decision Tree"); 
table(Predicted = pred_tree, Actual = Test_data_Churn$TargetVar_Churn)
#Accuracy
p1=predict(Model_CTREE, Train_data_Churn)
table1=table(Predicted = p1, Actual = Train_data_Churn$TargetVar_Churn)
table2=table(Predicted = pred_tree, Actual = Test_data_Churn$TargetVar_Churn)
print(paste('Decision Tree Accuracy',sum(diag(table2))/sum(table2)))
#The accuracy of decision tree is 0.79

#Random Forest
install.packages("randomForest")
library(randomForest)
randforModel=randomForest(TargetVar_Churn ~., data = Train_data_Churn)
summary(randforModel)
#Confusion matrix for a decision tree 
pred_tree=predict(randforModel, Test_data_Churn)
print("Confusion Matrix for Decision Tree"); 
table(Predicted = pred_tree, Actual = Test_data_Churn$TargetVar_Churn)
#Accuracy for RandomForest 
p1=predict(randforModel, Train_data_Churn)
table1=table(Predicted = p1, Actual = Train_data_Churn$TargetVar_Churn)
table2=table(Predicted = pred_tree, Actual = Test_data_Churn$TargetVar_Churn)
print(paste('RandomForest Accuracy',sum(diag(table2))/sum(table2)))

#Top 10 important attributes
par(mfrow=c(1,1))
varImpPlot(randforModel, sort=T, n.var = 10, main = 'Important attributes w.r.t business')




