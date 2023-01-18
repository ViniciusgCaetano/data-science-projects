import requests
import json

def get_orders(pair, depth):
    response = requests.get(f'https://data.binance.com/api/v3/depth?symbol={pair}&limit={depth}')
    byte_json = response.content
    orders_json = json.loads(byte_json)
    return orders_json

