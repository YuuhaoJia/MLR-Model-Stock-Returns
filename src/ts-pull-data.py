'''
Author: Yuhao Jia 
Created: 08/24/2022

coding: utf-8 
'''
import datetime as dt
import numpy as np
import os
import pandas as pd
import yfinance as yf

ticker = 'TSLA' #Change to desired stock ticker
sdate = dt.datetime(2010, 1, 1)
df = yf.download(ticker, start = sdate)
df = df.resample('QS').mean()

path = 'C:\\Users\\User\\Documents' #Change to desired destination (a similar path is recommended)

df.to_excel(os.path.join(path,f'Raw {ticker} data for MLRTS.xlsx'))
