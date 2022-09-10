# MLR-Model-Stock-Returns
Pulls historical data for a user specified stock ticker and models returns as the response of a number of key financial instruments. Also includes a time series component for modelling returns

### Built using
* Python
* R

### Key themes/tags
* Multiple linear regression
  * Model selection (adjusted r-squared, Mallows' C_p)
  * ANOVA
  * Outlier analysis (studentized residuals)
  * Leverage
  * Influential points (Cook's Distance)
  * Confidence/prediction intervals
* Time series regression
  * Durbin-Watson test
  * Predicted values

# Demo of Multiple Linear Regression Model

Note: Demo done using NASDAQ: TSLA (Tesla) stock ticker

#### Determining whether a transformation (log, sqrt) of the response data is appropriate (in this case, neither improves the fit of the model (or the satisfaction of model assumptions), as seen below)

![mlrp1](https://user-images.githubusercontent.com/112993711/189502384-83e47b88-43d6-4799-b2b3-547df0b65c81.png)
![mlrp2](https://user-images.githubusercontent.com/112993711/189502390-9e68553f-37b1-4334-a5a7-14cb33398b6d.png)
![mlrp3](https://user-images.githubusercontent.com/112993711/189502394-ee9b3335-65c3-48db-b99c-c323d3532b48.png)
![mlrp4](https://user-images.githubusercontent.com/112993711/189502395-670ebb2e-1492-4e92-a95a-7ed728a02da2.png)

#### Model selection using adjusted r-squared criteria (in this case, models 9 and 11 are the best fitting)

![image](https://user-images.githubusercontent.com/112993711/189502755-dbbd0eab-15a9-42fb-94f9-1c928cd9dace.png)

#### Model selection using Mallows' C_p criteria (in this case, model 9 is the best fitting, and thus it is utilized for the remaining analysis)

![image](https://user-images.githubusercontent.com/112993711/189502803-363c50be-2c2e-430a-b037-6627f87ae4fb.png)

#### Identifying outliers (|studentized residual| > 2.5)

![mlrp5](https://user-images.githubusercontent.com/112993711/189503867-70c8c227-37f5-475e-b577-0840d7406dd7.png)

#### Identifying high leverage points 

![mlrp6](https://user-images.githubusercontent.com/112993711/189503920-f28b1eef-2468-4026-b1dc-8dc04b75fa96.png)

#### Identifying influential points (Cook's distance >= 1)

![mlrp7](https://user-images.githubusercontent.com/112993711/189503960-b8f1a1ed-6657-4445-b7d0-3559f92dbf79.png)

# Demo of Time Series Model

Note: Demo done using NASDAQ: TSLA (Tesla) stock ticker

#### Time series plot of average quarterly price

#### Checking fit + validility of model assumptions (normal errors, independence, constant variance)

![image](https://user-images.githubusercontent.com/112993711/189504277-598f7ffb-4415-4a5e-9ed7-9abe1fa107d5.png)

![mlrp9](https://user-images.githubusercontent.com/112993711/189504323-ab1835a7-0d63-4b3e-a2e0-3972522d0269.png)

![mlrp10](https://user-images.githubusercontent.com/112993711/189504325-43bb9305-d6a5-4fbf-8612-a1b0e7133957.png)

![mlrp11](https://user-images.githubusercontent.com/112993711/189504328-8d438d91-a8c4-4115-9fff-8dc08d715c43.png)

![mlrp12](https://user-images.githubusercontent.com/112993711/189504330-e8e6d556-dc86-44ec-91ff-af9d0f1682f5.png)

#### Determining addition of trend component (none vs linear vs **quadratic**)

![image](https://user-images.githubusercontent.com/112993711/189504403-048a94d1-a775-4452-8a57-cc810517e817.png)

![mlrp13](https://user-images.githubusercontent.com/112993711/189504444-d5e48fef-5618-4205-a42a-a3b0b1a1039f.png)

![mlrp14](https://user-images.githubusercontent.com/112993711/189504445-0f9af48a-a010-4c12-9722-aa2abf0260c1.png)

![mlrp15](https://user-images.githubusercontent.com/112993711/189504448-1f52b460-0696-4994-af42-725dd67f7d5e.png)

#### Durbin-Watson Test for Positive Lag-1 Autocorrelation

![image](https://user-images.githubusercontent.com/112993711/189504535-b58fccdc-e191-4174-adc1-536bd6951ff7.png)

#### 4-year forecast using model variables

![mlrp16](https://user-images.githubusercontent.com/112993711/189504497-af0e4f64-d458-4eaf-b194-24b41cd68528.png)

# Contact

Yuhao Jia - yuhaoj10@gmail.com

Double Degree BMath & BBA 2025 Candidate

University of Waterloo 
