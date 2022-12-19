import requests
import json
import pandas as pd
import streamlit as st

def get_last_trades(pair):  
    response = requests.get(f'https://api.binance.com/api/v3/trades?symbol={pair}&limit=30')
    byte_json = response.content
    orders_json = json.loads(byte_json)
    
    df = pd.DataFrame(orders_json)
    df['time'] = pd.to_datetime(df['time'],unit='ms')
    df['time'] = df['time'].dt.strftime('%H:%M:%S')

    return df