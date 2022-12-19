import requests
import json

def get_candles(pair, interval):
    response = requests.get(f'https://api.binance.com/api/v3/klines?symbol={pair}&interval={interval}')
    byte_json = response.content
    orders_json = json.loads(byte_json)
    return orders_json