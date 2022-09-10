# Setup

# install.packages('readxl')
# install.packages('MASS')
# install.packages('leaps')
library(readxl)
library(MASS)
library(leaps)

setwd('C:/Users/User/Documents') #Sets working directory to documents 

file <- 'Raw TSLA data for MLR.xlsx' #Change to file with appropriate ticker
dataset <- read_excel(file)
dataset$...1 <- NULL
dataset <- na.omit(dataset)

ml_model <- function(dataset,transform) {
  Open <- dataset$Open
  High <- dataset$High
  Low <- dataset$Low
  AdjClose <- dataset$'Adj Close'
  Volume <- dataset$Volume
  S_and_P_Close <- dataset$'S&P 500 Close'
  S_and_P_Five_Day <- dataset$'S&P 500 5-Day Relative Difference'
  S_and_P_Fifty_Day_EMA <- dataset$'S&P 500 50 Day Exponential Moving Average'
  T_bill_Rate <- dataset$'13 mo T-Bill Rate'
  
  if(transform == 'log'){
    adjclose.lm <- lm(log(AdjClose) ~ Open + High + Low + Volume + S_and_P_Close +
                     S_and_P_Five_Day + S_and_P_Fifty_Day_EMA + T_bill_Rate)
  }
  
  else if(transform == 'sqrt'){
    adjclose.lm <- lm(sqrt(AdjClose) ~ Open + High + Low + Volume + S_and_P_Close +
                     S_and_P_Five_Day + S_and_P_Fifty_Day_EMA + T_bill_Rate)
  }
  
  else{
    adjclose.lm <- lm(AdjClose ~ Open + High + Low + Volume + S_and_P_Close +
                     S_and_P_Five_Day + S_and_P_Fifty_Day_EMA + T_bill_Rate)
  }
  
  return (adjclose.lm)
}

model_adequacy <- function(llm) {
  for (x in llm){
    print(summary(x))
    readline(prompt='Press [enter] to view Studentized Residuals vs Fitted plot')
    
    plot(studres(x),xlab = 'Fitted Values',ylab = 'Studentized Residuals', 
         main = 'Studentized Residuals vs Fitted Values', pch = 19)
    readline(prompt='Press [enter] to view QQplot')
    
    qqnorm(residuals(x),ylab = 'Residuals',
           main = 'QQPlot of Model', pch = 19)
    qqline(residuals(x))
  }
}

transformations <- function(dataset) {
  default.lm <- ml_model(dataset, 'none')
  log.lm <- ml_model(dataset, 'log')
  sqrt.lm <- ml_model(dataset, 'sqrt')
  m <- list(default.lm, log.lm, sqrt.lm)
  return (m)
}

models <- transformations(dataset)
model_adequacy(models)

best_transform <- readline(prompt='Enter the transformation yielding best model (none, log or sqrt): ')
adjclose.lm <- ml_model(dataset, best_transform)

# OPTIONAL: Best model selection using Adjusted R-Squared and Mallows' Cp 
#   (if on RStudio, highlight and use Ctrl/Cmd + Shift + C to uncomment)

# Delete adjclose.lm above and manually redefine using the best model as determined
#   by the outputs (ie. after [adjclose.lm <-] below )

# explanatory_dataset <- dataset
# explanatory_dataset$'Adj Close' <- NULL
# best_model <- function(dataset, transformation) {
#   if (transformation == 'log'){
#     print(leaps(explanatory_dataset, log(dataset$'Adj Close'), method=c('adjr'),nbest=2, names= names(explanatory_dataset)))
#     readline(prompt="Press [enter] to view models using Mallows' CP criteria)")
# 
#     leaps(explanatory_dataset, log(dataset$'Adj Close'), method=c('Cp'),nbest=2, names= names(explanatory_dataset))
#   }
# 
#   else if (transformation == 'sqrt'){
#     print(leaps(explanatory_dataset, sqrt(dataset$'Adj Close'), method=c('adjr'),nbest=2, names= names(explanatory_dataset)))
#     readline(prompt="Press [enter] to view models using Mallows' CP criteria)")
# 
#     leaps(explanatory_dataset, sqrt(dataset$'Adj Close'), method=c('Cp'),nbest=2, names= names(explanatory_dataset))
#   }
# 
#   else {
#     print(leaps(explanatory_dataset, dataset$'Adj Close', method=c('adjr'),nbest=2, names= names(explanatory_dataset)))
#     readline(prompt="Press [enter] to view models using Mallows' CP criteria)")
# 
#     leaps(explanatory_dataset, dataset$'Adj Close', method=c('Cp'),nbest=2, names= names(explanatory_dataset))
#   }
# }
# 
# best_model(dataset, best_transform)
#
# adjclose.lm <-


outliers_leverage_influential <- function(lm) {
  #To identify outliers (|di| > 2.5)
  
  plot(studres(adjclose.lm),xlab = 'Fitted Values',ylab = 'Studentized Residuals', 
       main = 'Plot of Studentized Residuals vs Fitted Values', pch = 19)
  abline(h = 2.5) 
  abline(h = -2.5)
  readline(prompt='Press [enter] for leverage analysis')
  
  #To identify high leverage points (h_ii > 2h = (2(p+1))/n)
  
  p_plus_one <- readline(prompt='p + 1 =: ')
  n <- length(dataset$'Adj Close') 
  two_times_h <- (2 * strtoi(p_plus_one))/n
  plot(hatvalues(lm), ylab = 'Hat Values', pch = 19)
  abline(h = two_times_h) 
  readline(prompt='Press [enter] for analysis on influential points')
  
  # To identify influential points (Cook's Distance = D_i >= 1)
  plot(cooks.distance(lm), ylab = "Cook's Distance", pch=19)
}

outliers_leverage_influential(adjclose.lm)

# Confidence and Prediction Intervals for A Given Set of Values (ie. Date)
# Populate the following vector (a skeleton is provided), delete parameters not in model
new_c <- data.frame(Open = '', High = '', Low = '', Volume = '', 
                    'S&P 500 Close' = '', 'S&P 500 5-Day Relative Difference' = '',
                    'S&P 500 50 Day Exponential Moving Average' = '',
                    '13 mo T-Bill Rate' = '')

# Confidence Interval (set the desired value of level parameter - ie. for 95% input 0.95)
predict(adjclose.lm, new_c, interval = 'confidence', level = )

# Prediction Interval (set the desired level of level parameter - ie. for 95% input 0.95)
predict(adjclose.lm, new_c, interval = 'prediction', level = )
