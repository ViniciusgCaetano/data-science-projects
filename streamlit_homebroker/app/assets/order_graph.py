import plotly.graph_objects as go
from plotly.colors import n_colors
import numpy as np
import pandas as pd

def order_book(orders_json):

    colors = n_colors('rgb(255, 200, 200)', 'rgb(200, 0, 0)', 9, colortype='rgb')
    a = [float(x[0]) for x in orders_json["bids"]]
    b = [float(x[1]) for x in orders_json["bids"]]
    c = [round((x * y), 2) for x, y in zip(a, b)]

    fig = go.Figure(data=[go.Table(
    header=dict(
        values=['<b>Price</b>', '<b>Amount</b>', '<b>Total</b>'],
        line_color='gray', fill_color='gray',
        align='center',font=dict(color='black', size=15)
    ),
    cells=dict(
        values=[a, b, c],
        line_color='gray',
        fill_color='gray',
        height=25,
        align=['left', 'right', 'right'],
        font=dict(color=['lightgreen', 'lightgray', 'lightgray'],
                size=14)
            )
        )
    ])
    fig['layout'].update(margin=dict(l=0,r=0,b=0,t=0))

    return fig