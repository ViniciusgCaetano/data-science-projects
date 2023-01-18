import requests
import json

def get_market_metrics(pair):  
    response = requests.get(f'https://data.binance.com/api/v3/ticker/24hr?symbol={pair}')
    byte_json = response.content
    metrics_json = json.loads(byte_json)

    return metrics_json