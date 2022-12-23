import requests
import json
import pandas as pd
import streamlit as st

def get_market_metrics(pair):  
    response = requests.get(f'https://api.binance.com/api/v3/ticker/24hr?symbol={pair}')
    byte_json = response.content
    orders_json = json.loads(byte_json)

    return orders_json