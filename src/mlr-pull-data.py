'''
Author: Yuhao Jia 
Created: 07/13/2022

coding: utf-8 
'''
import datetime
import numpy as np
import os
import pandas as pd
import yfinance as yf

def n_day_difference(n, loc):
	differences = []
	for i in loc:
		if loc.index(i) <= 3:
			None
		else:
			fdg = (i - (loc[loc.index(i) - 5]))/(loc[loc.index(i) - 5])*100
			differences.append(fdg)
	return(differences)

ticker = 'TSLA' #Change to desired stock ticker
sdate = datetime.datetime.now() - datetime.timedelta(days=5*365)

df = yf.download(ticker, start = sdate)
df = df.drop(['Close'],axis=1)
df.reset_index(drop=True, inplace=True)

df2 = yf.download('SPY', start = sdate - datetime.timedelta(days = 5))
lo_adjclosing = df2['Adj Close'].tolist()
df2 = df2.drop(['Open','High', 'Low', 'Volume', 'Close'],axis=1)
df2 = df2.drop([df2.index[0], df2.index[1], df2.index[2], df2.index[3], df2.index[4]])
df2 = df2.rename(columns = {'Adj Close':'S&P 500 Close'})
print(df2)
df2.reset_index(drop=True, inplace=True)

df3 = yf.download('SPY', start = sdate - datetime.timedelta(days = 50))
df3 = df3.rename(columns = {'Adj Close':'S&P 500 50 Day Exponential Moving Average'})
df4 = df3['S&P 500 50 Day Exponential Moving Average'].ewm(span=10).mean()
df4 = df4.iloc[34:]
df4 = df4.drop([df4.index[0], df4.index[1]])
df4.reset_index(drop=True, inplace=True)

df5 = yf.download('^IRX',start = sdate)
df5 = df5.drop(['Open','High', 'Low', 'Volume', 'Close'],axis=1)
df5 = df5.rename(columns = {'Adj Close':'13 mo T-Bill Rate'})
df5.reset_index(drop=True, inplace=True)

df6 = pd.DataFrame(n_day_difference(5, lo_adjclosing), columns=['S&P 500 5-Day Relative Difference'])

df_final = pd.concat([df,df2,df6,df4,df5], axis = 1)

path = 'C:\\Users\\User\\Documents' #Change to desired destination (a similar path is recommended)

df_final.to_excel(os.path.join(path,f'Raw {ticker} data for MLR.xlsx'))
