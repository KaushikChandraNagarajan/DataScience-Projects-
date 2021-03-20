##Step 1 
##Computer Price Prediction

Computer_Price_Data=read.csv("C:/Users/Kaushik/OneDrive/Ivy Data Science Notes/R and Stats/R datasets/ComputerPricesData.csv",stringsAsFactors = TRUE)
Computer_Price_Data
View(Computer_Price_Data)


#Step 2
#Cont-Price,speed,hd,ads
#Cat-Ram,screen,cd,multi,premium
summary(Computer_Price_Data)

#Step 3
#Doing the necessary  conversions
as.factor(Computer_Price_Data$ram)
as.factor(Computer_Price_Data$premium)
as.factor(Computer_Price_Data$multi)
as.factor(Computer_Price_Data$cd)
as.factor(Computer_Price_Data$screen)



#Automation of the conversion 
Comp_cat_col=c("ram","screen","cd","multi","premium")

for (cat_cols in Comp_cat_col){
 Computer_Price_Data[ , cat_cols]=as.factor(Computer_Price_Data[ , cat_cols])
}






#Step 4 
#Identifying the NULL values
colSums(is.na(Computer_Price_Data))

#Step 5
#Grouping all continuous cols
Comp_cont_col=c("price","speed","hd","ads")

#measures of central tendency 
sapply(Computer_Price_Data[,Comp_cont_col],mean)
sapply(Computer_Price_Data[,Comp_cont_col],median)
#measures of dispersion
sapply(Computer_Price_Data[,Comp_cont_col],sd)
sapply(Computer_Price_Data[,Comp_cont_col],var)
sapply(Computer_Price_Data[,Comp_cont_col],range)
#measures of location
sapply(Computer_Price_Data[,Comp_cont_col],quantile)

#Step 6 
#Grouping all cat cols
Comp_cat_col=c("ram","screen","cd","multi","premium")

#mode
FunctionMode=function(inpData){
  ModeValue=names(table(inpData)[table(inpData)==max(table(inpData))])
  return(ModeValue)
}
FunctionMode(Computer_Price_Data$ram)
sapply(Computer_Price_Data[,Comp_cat_col],mode)

#Step 7
#Splitting the plot window into six parts
#2 rows and 3 columns
par(mfrow=c(2,3))

# library to generate professional colors
install.packages("RColorBrewer")
library(RColorBrewer) 
#?RColorBrewer

##### looping to create the histograms for each column

##hist_cols:an iterator- takes each value in the vector at a time
#Continuous_cols: vector of column names which we have identified
#for each of the columns, we are plotting the histogram
##in the first loop/iteration, column=Price
#in the first loop/iteration, column=Age ... and so on
#2 agruements: 
#whatever column is in the current iteration, hist() function is applied on that column
#main(title- string and the variable name which is being plotted)
#col/color- Paired is the color palette name, supports upto 12 professional colors

for (hist_cols in Comp_cont_col){
  hist(Computer_Price_Data[,c(hist_cols)], main=paste('Histogram of:',hist_cols), 
       col=brewer.pal(8,"Paired"))
}

#Step 8 Forming a bar graph 
for (bar_cols in Comp_cat_col){
  barplot(table(Computer_Price_Data[,c(bar_cols)]), main=paste('Barplot of:',bar_cols), 
          col=brewer.pal(8,"Paired"))
}


#Step 9 Bivariate analysis




#Step 10 
#Correlation Test 
CorrData_Comp=cor(Computer_Price_Data[,Comp_cont_col])
CorrData_Comp
#As per correlation Test we can take speed and hd
Comp_cat_col
#ANOVA Test 
aov(price~Computer_Price_Data$ram,data = Computer_Price_Data)
summary(aov(price~Computer_Price_Data$ram,data = Computer_Price_Data))
options(scipen=999)
aov(price~Computer_Price_Data$screen,data = Computer_Price_Data)
summary(aov(price~Computer_Price_Data$screen,data = Computer_Price_Data))
aov(price~Computer_Price_Data$cd,data = Computer_Price_Data)
summary(aov(price~Computer_Price_Data$cd,data = Computer_Price_Data))
aov(price~Computer_Price_Data$multi,data = Computer_Price_Data)
summary(aov(price~Computer_Price_Data$multi,data = Computer_Price_Data))
aov(price~Computer_Price_Data$premium,data = Computer_Price_Data)
summary(aov(price~Computer_Price_Data$premium,data = Computer_Price_Data))

#Automation of ANOVA test 
for (bar_cols in Comp_cat_col){
  test_summary=summary(aov(price~ Computer_Price_Data[,c(bar_cols)], data = Computer_Price_Data))
  print(paste("The Anova test with",bar_cols))
  print(test_summary)
}

#All the categorical variables are significant w.r.t business perspective

#Step 11
#Preparing the data for ML 
TargVar_Comp="price"
PredVar_Comp=c("speed","hd","ram","screen","cd","multi","premium")
InpData_Comp=Computer_Price_Data
Bestpred_Comp=InpData_Comp[,c(PredVar_Comp)]
TargetVar_Comp=InpData_Comp[,c(TargVar_Comp)]
Comp_Price_DataforML=data.frame(TargetVar_Comp,Bestpred_Comp)
Comp_Price_DataforML
dim(Comp_Price_DataforML)
dim(Computer_Price_Data)


#Step 12 
#Sampling the data into 70-30 Ratio
Train_index_Comp=sample(1:nrow(Comp_Price_DataforML),size=0.7*nrow(Comp_Price_DataforML))
Train_data_Comp=Comp_Price_DataforML[Train_index_Comp,]
Test_data_Comp=Comp_Price_DataforML[-Train_index_Comp,]
dim(Train_data_Comp)
dim(Test_data_Comp)

#Step 13 
#Generating the linear regression model 
Model_Reg_Comp=lm(TargetVar_Comp~.,Train_data_Comp)
Model_Reg_Comp
summary(Model_Reg_Comp)
Test_data_Comp$pred_value=predict(Model_Reg_Comp,newdata = Test_data_Comp)
head(Test_data_Comp)
Test_data_Comp$APE=100 *(abs(Test_data_Comp$TargetVar_Comp-Test_data_Comp$pred_value)/Test_data_Comp$TargetVar_Comp)
head(Test_data_Comp)
MeanAPE=mean(Test_data_Comp$APE)
MedianAPE=median(Test_data_Comp$APE)
print(paste('### Mean Accuracy of Linear Regression Model is: ', 100 - MeanAPE))
print(paste('### Median Accuracy of Linear Regression Model is: ', 100 - MedianAPE))

#2nd Regression Model 
Model_Reg_Comp2=lm(TargetVar_Comp~speed+hd+ram+(screen==14)+(screen==15)+(screen==17)+premium+cd+multi,data = Train_data_Comp)
summary(Model_Reg_Comp2)
Test_data_Comp$pred_value2=predict(Model_Reg_Comp2,newdata = Test_data_Comp)
head(Test_data_Comp)
Test_data_Comp$APE2=100 *(abs(Test_data_Comp$TargetVar_Comp-Test_data_Comp$pred_value2)/Test_data_Comp$TargetVar_Comp)
head(Test_data_Comp)
MeanAPE=mean(Test_data_Comp$APE2)
MedianAPE=median(Test_data_Comp$APE2)
print(paste('### Mean Accuracy of Linear Regression Model is: ', 100 - MeanAPE))
print(paste('### Median Accuracy of Linear Regression Model is: ', 100 - MedianAPE))

plot(Model_Reg_Comp2,2)

#3rd Regression Model
Model_Reg_Comp3=lm(TargetVar_Comp~speed+hd+ram+screen+(premium=="yes")+(premium=="no")+cd+multi,data = Train_data_Comp)
summary(Model_Reg_Comp3)
Test_data_Comp$pred_value3=predict(Model_Reg_Comp3,newdata = Test_data_Comp)
head(Test_data_Comp)
Test_data_Comp$APE3=100 *(abs(Test_data_Comp$TargetVar_Comp-Test_data_Comp$pred_value3)/Test_data_Comp$TargetVar_Comp)
head(Test_data_Comp)
MeanAPE=mean(Test_data_Comp$APE3)
MedianAPE=median(Test_data_Comp$APE3)
print(paste('### Mean Accuracy of Linear Regression Model is: ', 100 - MeanAPE))
print(paste('### Median Accuracy of Linear Regression Model is: ', 100 - MedianAPE))


library(party)
Model_CTREE_Comp=ctree(TargetVar_Comp~.,data = Train_data_Comp)
Model_CTREE_Comp
summary(Model_CTREE_Comp)
Test_data_Comp$CTREE_pred=as.numeric(predict(Model_CTREE_Comp,newdata=Test_data_Comp))
head(Test_data_Comp)
Test_data_Comp$APE4=100*(abs(Test_data_Comp$TargetVar_Comp-Test_data_Comp$CTREE_pred)/Test_data_Comp$TargetVar_Comp)
head(Test_data_Comp)
MeanAPE=mean(Test_data_Comp$APE4)
MedianAPE=median(Test_data_Comp$APE4)
print(paste('### Mean Accuracy of Decision Tree Model is: ', 100 - MeanAPE))
print(paste('### Median Accuracy of Decision Model is: ', 100 - MedianAPE))

