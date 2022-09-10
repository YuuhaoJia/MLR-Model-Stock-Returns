# MLR-Model-Stock-Returns
Pulls historical data for a user specified stock ticker and models returns as the response of a number of key financial instruments. Also includes a time series component for modelling returns

### Built using
* Python
* R

### Key themes/tags
* Multiple linear regression
  * Model selection (adjusted r-squared, Mallows' C_p
  * ANOVA
  * Outlier analysis (studentized residuals)
  * Leverage
  * Influential points (Cook's Distance)
  * Confidence/prediction intervals
* Time series regression
  * Durbin-Watson test
  * Predicted values

# Demo

Note: Demo done using NASDAQ: TSLA (Tesla) stock ticker

Determining whether a transformation (log, sqrt) of the response data is appropriate (in this case, neither improves the fit of the model (or the satisfaction of model assumptions), as seen below)

![mlrp1](https://user-images.githubusercontent.com/112993711/189502384-83e47b88-43d6-4799-b2b3-547df0b65c81.png)
![mlrp2](https://user-images.githubusercontent.com/112993711/189502390-9e68553f-37b1-4334-a5a7-14cb33398b6d.png)
![mlrp3](https://user-images.githubusercontent.com/112993711/189502394-ee9b3335-65c3-48db-b99c-c323d3532b48.png)
![mlrp4](https://user-images.githubusercontent.com/112993711/189502395-670ebb2e-1492-4e92-a95a-7ed728a02da2.png)








