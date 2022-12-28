import requests
import json
import pandas as pd
import streamlit as st
import datetime

def get_candles(pair, interval):
    response = requests.get(f'https://data.binance.com/api/v3/klines?symbol={pair}&interval={interval}&limit=120')
    byte_json = response.content
    orders_json = json.loads(byte_json)  
    df = pd.DataFrame(orders_json, columns=['open_time', 'open_price', 'high_price', 'low_price', 'close_price',
                                            'volume', 'close_time', 'volume_quote', 'number_of_trades', 'taker_buy_base',
                                            'taker_buy_quote', 'unused_field'])
    df.volume = pd.to_numeric(df.volume)
   
    df.open_time = [pd.to_datetime(x, unit='ms').strftime('%Y-%m-%d %H:%M:%S') for x in df.open_time]
    
    return df