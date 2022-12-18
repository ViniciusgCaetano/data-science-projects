import plotly.graph_objects as go
from plotly.subplots import make_subplots
import numpy as np
import pandas as pd

def order_book(orders_json):

    price_bids = [float(x[0]) for x in orders_json["bids"]]
    amount_bids = [float(x[1]) for x in orders_json["bids"]]
    total_bids = [round((x * y), 2) for x, y in zip(price_bids, amount_bids)]

    trace1 = go.Table(
        header=dict(
            values=['<b>Price</b>', '<b>Amount</b>', '<b>Total</b>'],
            line_color='gray', fill_color='gray',
            align='center',font=dict(color='black', size=15)
        ),
        cells=dict(
            values=[price_bids, amount_bids, total_bids],
            line_color='gray',
            fill_color='gray',
            height=25,
            align=['left', 'right', 'right'],
            font=dict(color=['lightgreen', 'lightgray', 'lightgray'],
                    size=14)
            )
        )

    price_asks = [float(x[0]) for x in orders_json["asks"]]
    amount_asks = [float(x[1]) for x in orders_json["asks"]]
    price_asks.reverse()
    amount_asks.reverse
    total_asks = [round((x * y), 2) for x, y in zip(price_asks, amount_asks)]

    trace2 = go.Table(
        header=dict(
            values=['<b>Price</b>', '<b>Amount</b>', '<b>Total</b>'],
            line_color='gray', fill_color='gray',
            align='center',font=dict(color='black', size=15)
        ),
        cells=dict(
            values=[price_asks, amount_asks, total_asks],
            line_color='gray',
            fill_color='gray',
            height=25,
            align=['left', 'right', 'right'],
            font=dict(color=['red', 'lightgray', 'lightgray'],
                    size=14)
            )
        )



    
    fig = make_subplots(
        rows=2, cols=1,
        specs=[[{"type": "table"}],
            [{"type": "table"}]],
            vertical_spacing=0,

            
        )

    fig.add_trace(trace2, row=1, col=1)
    fig.add_trace(trace1, row=2, col=1)
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))
    fig['layout'].update(height=850)


    return fig