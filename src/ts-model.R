# Setup

# install.packages('TSStudio')
# install.packages('lmtest')
# install.packages('glue')
library(readxl)
library(TSstudio)
library(lmtest)
library(glue)

setwd('C:/Users/User/Documents') #Sets working directory to documents 

file <- 'Raw AAPL data for MLRTS.xlsx' #Change to file with appropriate ticker
dataset <- read_excel(file)
dataset <- na.omit(dataset)

avg_quarterly_price <- dataset$'Adj Close'
dates <- seq(as.Date('2010-01-01'), as.Date('2022-07-01'), by = '3 month') - 1 #Generates series of dates from Beg. of Q1 2010 to End of Q2 2022

plot_timeseries <- function(dataset, dates){
  ts_data <- data.frame(dataset, dates)
  TSstudio::ts_plot(ts_data,
          title = 'Average Quarterly Price - Q1 2010 to Q2 2022') 
}

plot_timeseries(avg_quarterly_price, dates)

Q <- c(rep(c('1','2','3','4'), length = 51))

seasonal_component_analysis <- function(slm){
  print(summary(slm))
  readline(prompt='Press [enter] to view Plot of Residuals vs Time')
  
  plot(residuals(slm),xlab = 't',ylab = 'Residuals', 
       main = 'Plot of Residuals vs Time for Seasonal Model', pch = 19)
  readline(prompt='Press [enter] to view QQPlot')
  
  qqnorm(residuals(slm), ylab = 'Residuals', 
         main = 'QQPlot of Seasonal Model', pch = 19)
  readline(prompt='Press [enter] to view Correlogram')
  
  acf(residuals(slm), xlab = 'lag', main = 'Correlogram of Seasonal Model')
  readline(prompt='Press [enter] to view Boxplot')
  
  boxplot(avg_quarterly_price ~ Q, 
          xlab = 'Quarter', ylab = 'Average Quarterly Price',
          main = 'Boxplot of Avg Price by Quarter')
}

adj_close_seasonal.lm <- lm(avg_quarterly_price ~ Q)
seasonal_component_analysis(adj_close_seasonal.lm)

trend_component <- function(dataset){
  t <- c(1:50)
  adj_close_linear.lm <- lm(dataset ~ Q + t)
  
  print(summary(adj_close_linear.lm))
  readline(prompt='Press [enter] to view Plot of Residuals vs Time')
  
  plot(residuals(adj_close_linear.lm),xlab = 't',ylab = 'Residuals', 
       main = 'Plot of Residuals vs Time for Seasonal + Linear Trend Model', pch = 19)
  readline(prompt='Press [enter] to view QQPlot')
  
  qqnorm(residuals(adj_close_linear.lm), ylab = 'Residuals',
         main = 'QQPlot of Seasonal + Linear Trend Model', pch = 19)
  readline(prompt='Press [enter] to view Correlogram')
  
  acf(residuals(adj_close_linear.lm), 
      main = 'Correlogram of Seasonal + Linear Trend Model')
  
  t_squared <- t^2
  adj_close_quadratic.lm <- lm(dataset ~ Q + t + t_squared)
  
  print(summary(adj_close_quadratic.lm))
  readline(prompt='Press [enter] to view Plot of Residuals vs Time')
  
  plot(residuals(adj_close_quadratic.lm),xlab = 't',ylab = 'Residuals', 
       main = 'Plot of Residuals vs Time for Seasonal + Quadratic Trend Model', pch = 19)
  readline(prompt='Press [enter] to view QQPlot')
  
  qqnorm(residuals(adj_close_quadratic.lm), ylab = 'Residuals',
         main = 'QQPlot of Seasonal + Quadratic Trend Model', pch = 19)
  readline(prompt='Press [enter] to view Correlogram')
  
  acf(residuals(adj_close_quadratic.lm),
      main = 'Correlogram of Seasonal + Quadratic Trend Model')
  
  best_model <- readline(prompt='Enter the best model (just_seasonal, linear, quadratic): ')
  
  if (best_model == 'just_seasonal'){
    return(adj_close_seasonal.lm)
  }
  
  else if (best_model == 'linear'){
    return(adj_close_linear.lm)
  }
  
  else{
    return(adj_close_quadratic.lm)
  }
}

time_series.lm <- trend_component(avg_quarterly_price)

dwtest(time_series.lm) # Durbin-Watson Test for Positive Lag-1 Autocorrelation

# Compare with results of auto.arima function

# install.packages('forecast')
library(forecast)
auto_model.lm <- auto.arima(avg_quarterly_price)

n_year_forecast <- function(n, ti){
  title <- glue('{toString(n)} year forecast')
  plot(forecast(auto_model.lm, level = c(95), h = n * ti), 
       main = title)
}

n_year_forecast(4, 1) # Change to desired years (n) and appropriate seasonal value for auto-generated ARIMA (ti) model
