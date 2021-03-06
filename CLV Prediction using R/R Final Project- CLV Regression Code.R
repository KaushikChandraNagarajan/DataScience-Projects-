##Step 1 
##CLV Prediction

Auto_cust_val_anal=read.csv("C:/Users/Kaushik/OneDrive/Ivy Data Science Notes/R and Stats/R Main Project/Cust val anal.csv",na.strings =c("",NA,NULL)  
                              ,stringsAsFactors = TRUE)
Auto_cust_val_anal
View(Auto_cust_val_anal)
#Step 2
#Cont col-Customer LifeTime Value
#Cat col-State,Response,Coverage, Education, Employment Status, Gender, Location Code
#,Marital Status, Policy Type, Policy, Renew Offer Type, Sales Chanel, Vehicle Class,Vehicle Size 
summary(Auto_cust_val_anal)
View(Auto_cust_val_anal)
dim(Auto_cust_val_anal)
#Step 3
#Automation of the conversion 
Auto_cust_cat_col=c("State","Response","Coverage","Education",
                    "Employment_Status","Gender","Location_Code","Marital_Status","Type_of_Open_Complaints",
                    "Type_of_Policies","Policy_Type","Policy","Renew_Offer_Type",
                    "Sales_Channel","Vehicle_Class","Vehicle_Size")

Auto_cust_cat_col
for (cat_cols in Auto_cust_cat_col){
  Auto_cust_val_anal[ , cat_cols]=as.factor(Auto_cust_val_anal[ , cat_cols])
}

#Step 4 
#Identifying the NULL values
colSums(is.na(Auto_cust_val_anal))

#Step 5
#Grouping all continuous cols
Auto_cust_cont_col=c("Customer_Lifetime_Value",
                     "Income","Monthly_Premium_Auto","Months_Since_Last_Claim",
                     "Months_Since_Policy_Inception","Total_Claim_Amount")

#measures of central tendency 
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],mean)
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],median)

#measures of dispersion
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],sd)
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],var)
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],range)
#measures of location
sapply(Auto_cust_val_anal[,Auto_cust_cont_col],quantile)
#Step 6 
#Grouping all cat cols
Auto_cust_cat_col=c("State","Response","Coverage","Education",
                    "Employment_Status","Gender","Location_Code","Marital_Status","Type_of_Open_Complaints",
                    "Type_of_Policies","Policy_Type","Policy","Renew_Offer_Type",
                    "Sales_Channel","Vehicle_Class","Vehicle_Size")

#mode
FunctionMode=function(inpData){
  ModeValue=names(table(inpData)[table(inpData)==max(table(inpData))])
  return(ModeValue)
}
sapply(Auto_cust_val_anal[,Auto_cust_cat_col],FunctionMode)

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

for (hist_cols in Auto_cust_cont_col){
  hist(Auto_cust_val_anal[,c(hist_cols)], main=paste('Histogram of:',hist_cols), 
       col=brewer.pal(8,"Paired"))
}

#Step 8 Forming a bar graph 
for (bar_cols in Auto_cust_cat_col){
  barplot(table(Auto_cust_val_anal[,c(bar_cols)]), main=paste('Barplot of:',bar_cols), 
          col=brewer.pal(8,"Paired"))
}


#Step 9 Bi-Variate analysis

#Boxplot
for (cat_cols in Auto_cust_cat_col){ 
  boxplot(Auto_cust_val_anal$Customer_Lifetime_Value~Auto_cust_val_anal[,c(cat_cols)], main=paste('BoxPlot of:',cat_cols), 
          col=brewer.pal(8,"Paired"))
}
par(mfrow=c(2,6))

#Scatter Plot
plot(Auto_cust_val_anal[,Auto_cust_cont_col],col='blue')




#Step 10 
#Correlation Test 
CorrData_Auto_cust=cor(Auto_cust_val_anal[,Auto_cust_cont_col])
CorrData_Auto_cust
#As per correlation Test we can take Monthly_Premium_Auto and Total_Claim_Amount
#ANOVA Test 

#Automation of ANOVA test 
for (bar_cols in Auto_cust_cat_col){
  test_summary=summary(aov(Customer_Lifetime_Value~ Auto_cust_val_anal[,c(bar_cols)], data = Auto_cust_val_anal))
  print(paste("The Anova test with",bar_cols))
  print(test_summary)
}
options(scipen = 999)
#As per ANOVA test we can take Coverage, Education, Employment_Status, Marital_Status, Type_of_Open_Complaints,
#Type_of_Policies, Renew_Offer_Type, Vehicle_Class

#Step 11
#Preparing the data for ML 
TargVar_Auto_cust="Customer_Lifetime_Value"
PredVar_Auto_cust=c("Monthly_Premium_Auto","Total_Claim_Amount","Coverage",
                    "Education","Employment_Status","Marital_Status","Type_of_Open_Complaints"
                    ,"Type_of_Policies","Renew_Offer_Type","Vehicle_Class")

PredVar_Auto_cust
InpData_Auto_cust[,c(PredVar_Auto_cust)]
InpData_Auto_cust[,c(TargVar_Auto_cust)]
InpData_Auto_cust=Auto_cust_val_anal
Bestpred_Auto_cust_ins=InpData_Auto_cust[,PredVar_Auto_cust]
TargetVar_Auto_cust_ins=InpData_Auto_cust[,TargVar_Auto_cust]
Auto_cust_DataforML=data.frame(TargetVar_Auto_cust_ins,Bestpred_Auto_cust_ins)
Auto_cust_DataforML
head(Auto_cust_DataforML)
dim(Auto_cust_DataforML)
dim(Auto_cust_val_anal)


#Step 12 
#Sampling the data into 70-30 Ratio
Train_index_Auto_ins=sample(1:nrow(Auto_cust_DataforML),size=0.7*nrow(Auto_cust_DataforML))
Train_data_Auto_cust=Auto_cust_DataforML[Train_index_Auto_ins,]
Test_data_Auto_cust=Auto_cust_DataforML[-Train_index_Auto_ins,]
dim(Train_data_Auto_cust)
dim(Test_data_Auto_cust )

#Linear Regression Models
Model_Reg_Auto_ins=lm(TargetVar_Auto_cust_ins~.,Train_data_Auto_cust)
summary(Model_Reg_Auto_ins)

Model_Reg_Auto_ins1=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+Total_Claim_Amount+Coverage+Education
                       +Employment_Status+Type_of_Policies+Type_of_Open_Complaints+Renew_Offer_Type
                       +Vehicle_Class,data = Train_data_Auto_cust)
summary(Model_Reg_Auto_ins1)

Model_Reg_Auto_ins2=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+Coverage+Education
                       +Employment_Status+Type_of_Policies+Type_of_Open_Complaints+Renew_Offer_Type
                       +Vehicle_Class,data = Train_data_Auto_cust)
summary(Model_Reg_Auto_ins2)


Model_Reg_Auto_ins3=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+Education
                       +Employment_Status+Type_of_Policies+Type_of_Open_Complaints+Renew_Offer_Type
                       +Vehicle_Class,data = Train_data_Auto_cust)
summary(Model_Reg_Auto_ins3)








Model_Reg_Auto_ins4=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Extended")
                       +I(Coverage=="Premium")+I(Education=="College")
                       +I(Education=="Doctor")+I(Education=="High School or Below")+I(Education=="Master")
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+I(Employment_Status=="Unemployed")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)



summary(Model_Reg_Auto_ins4)

Model_Reg_Auto_ins5=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto
                       +I(Coverage=="Premium")+I(Education=="College")
                       +I(Education=="High School or Below")+I(Education=="Master")
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+I(Employment_Status=="Unemployed")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins5)

Model_Reg_Auto_ins6=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                       +I(Education=="College")
                       +I(Education=="High School or Below")+I(Education=="Master")
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+I(Employment_Status=="Unemployed")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins6)

Model_Reg_Auto_ins7=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                       +I(Education=="College")
                       +I(Education=="Master")
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+I(Employment_Status=="Unemployed")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins7)

Model_Reg_Auto_ins8=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                       +I(Education=="College")
                       
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+I(Employment_Status=="Unemployed")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins8)

Model_Reg_Auto_ins9=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                      
                       
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +I(Employment_Status=="Retired")+Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins9)

Model_Reg_Auto_ins10=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                       
                       
                       +I(Employment_Status=="Employed")+I(Employment_Status=="Medical Leave")
                       +Type_of_Policies+I(Type_of_Open_Complaints==1)+I(Type_of_Open_Complaints==2)+
                         I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                         +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                         +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins10)


Model_Reg_Auto_ins11=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                        +Type_of_Policies+I(Type_of_Open_Complaints==2)+
                          I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                          +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins11)

Model_Reg_Auto_ins12=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          I(Type_of_Open_Complaints==3)+I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                          +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins12)

Model_Reg_Auto_ins13=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer3")+I(Renew_Offer_Type=="Offer4")+
                          +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins13)

Model_Reg_Auto_ins14=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Renew_Offer_Type=="Offer2")+I(Renew_Offer_Type=="Offer4")+
                          +I(Vehicle_Class=="Luxury Car")+I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins14)

Model_Reg_Auto_ins15=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Renew_Offer_Type=="Offer2")+
                          +I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins15)

Model_Reg_Auto_ins16=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Vehicle_Class=="Luxury SUV")+I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins16)

Model_Reg_Auto_ins17=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Vehicle_Class=="Sports Car")+I(Vehicle_Class=="Two-Door Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins17)

Model_Reg_Auto_ins18=lm(TargetVar_Auto_cust_ins~Monthly_Premium_Auto+I(Coverage=="Premium")
                        
                        
                        +I(Employment_Status=="Employed")+
                          +Type_of_Policies+
                          +I(Type_of_Open_Complaints==4)+I(Type_of_Open_Complaints==5)+
                          +I(Vehicle_Class=="Sports Car"),data = Train_data_Auto_cust)

summary(Model_Reg_Auto_ins18)
Test_data_Auto_cust$pred_value18=predict(Model_Reg_Auto_ins18,newdata = Test_data_Auto_cust)
head(Test_data_Auto_cust)
Test_data_Auto_cust$APE18=100 *(abs(Test_data_Auto_cust$TargetVar_Auto_cust_ins-Test_data_Auto_cust$pred_value18)/Test_data_Auto_cust$TargetVar_Auto_cust_ins)
head(Test_data_Auto_cust)
MeanAPE=mean(Test_data_Auto_cust$APE18)
MedianAPE=median(Test_data_Auto_cust$APE18)
print(paste('### Mean Accuracy of Linear Regression Model is: ', 100 - MeanAPE))
print(paste('### Median Accuracy of Linear Regression Model is: ', 100 - MedianAPE))



#Tests for the model
##test for homoskedasticity:
#HO: there exists homoskedasticity : error variances are equal
install.packages("lmtest")
library(lmtest)
summary(Model_Reg_Auto_ins18)
bptest(Model_Reg_Auto_ins18)
#############test for normality################
#HO: errors is normally distributed
install.packages("nortest")
library(nortest)
resid=Model_Reg_Auto_ins18$residuals
options(scipen = 999)
ad.test(resid)

#Auto correlation occurs when the residuals are not independent from each other
#HO: No auto correlation
library(lmtest)
options(scipen = 999)
dwtest(Model_Reg_Auto_ins18)
#p-vlaue>0.05 means HO is accepted

#CTREE Model 
library(party)
Model_CTREE_Auto_cust=ctree(TargetVar_Auto_cust_ins~.,data = Train_data_Auto_cust)
Model_CTREE_Auto_cust
summary(Model_CTREE_Auto_cust)
Test_data_Auto_cust$CTREE_pred=as.numeric(predict(Model_CTREE_Auto_cust,newdata=Test_data_Auto_cust))
head(Test_data_Auto_cust)
Test_data_Auto_cust$CTREE_APE=100*(abs(Test_data_Auto_cust$TargetVar_Auto_cust_ins-Test_data_Auto_cust$CTREE_pred)/Test_data_Comp$TargetVar_Comp)
MeanAPECTREE=mean(Test_data_Auto_cust$APE20)
MedianAPECTREE=median(Test_data_Auto_cust$APE20)
print(paste('### Mean Accuracy of Desc TRee is: ', 100-MeanAPE))
print(paste('### Median Accuracy of Desc Tree Model is: ', 100-MedianAPE))

#******************************************************************************************#








